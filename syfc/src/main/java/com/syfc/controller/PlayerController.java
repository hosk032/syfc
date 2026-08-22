package com.syfc.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.BallDTO;
import com.syfc.dto.ClubInfoDTO;
import com.syfc.dto.ClubInfoPlyDTO;
import com.syfc.dto.ClubJoinDTO;
import com.syfc.dto.ClubOwnerHistoryDTO;
import com.syfc.dto.ClubOwnerRequestDTO;
import com.syfc.dto.MatchHistoryDTO;
import com.syfc.dto.MatchRecordDTO;
import com.syfc.dto.MemberBallmainDTO;
import com.syfc.dto.MemberBallpickDTO;
import com.syfc.dto.MemberDTO;
import com.syfc.dto.PlayerMypageDTO;
import com.syfc.dto.PlayerProfileDTO;
import com.syfc.dto.SessionInfo;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.BallService;
import com.syfc.service.BallServiceImpl;
import com.syfc.service.ClubInfoPlyservice;
import com.syfc.service.ClubInfoPlyserviceImpl;
import com.syfc.service.ClubOwnerHistoryService;
import com.syfc.service.ClubOwnerHistoryServiceImpl;
import com.syfc.service.ClubOwnerRequestService;
import com.syfc.service.ClubOwnerRequestServiceImpl;
import com.syfc.service.MatchHistoryImpl;
import com.syfc.service.MatchHistoryService;
import com.syfc.service.MatchRecordService;
import com.syfc.service.MatchRecordServiceImpl;
import com.syfc.service.MemberBallpickService;
import com.syfc.service.MemberBallpickServiceImpl;
import com.syfc.service.MemberService;
import com.syfc.service.MemberServiceImpl;
import com.syfc.service.MyClubInfoService;
import com.syfc.service.MyClubInfoServiceImpl;
import com.syfc.service.PlayerProfileService;
import com.syfc.service.PlayerProfileServiceImpl;
import com.syfc.service.PlayerService;
import com.syfc.service.PlayerServiceImpl;
import com.syfc.util.FileManager;
import com.syfc.util.MyMultipartFile;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
@RequestMapping("/player/*")
public class PlayerController {
	private PlayerProfileService service = new PlayerProfileServiceImpl();
	private PlayerService playerService = new PlayerServiceImpl();
	private MatchHistoryService matchHistoryService = new MatchHistoryImpl();	
	private MatchRecordService matchRecordService = new MatchRecordServiceImpl();
	private MemberService memberService = new MemberServiceImpl();
	private MyClubInfoService myClubInfoService = new MyClubInfoServiceImpl();
	private ClubOwnerHistoryService historyService = new ClubOwnerHistoryServiceImpl();
	private ClubOwnerRequestService clubOwnerRequestService = new ClubOwnerRequestServiceImpl();
	private BallService ballService = new BallServiceImpl();
	private MemberBallpickService memberBallPickService = new MemberBallpickServiceImpl();
	private ClubInfoPlyservice clubInfoPlyService = new ClubInfoPlyserviceImpl();
	
	private FileManager fileManager = new FileManager();
	
	@PostMapping("profile")
	public ModelAndView profile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info == null) {
			return new ModelAndView("redirect:/member/login");
		}
		
		long memberIdx = info.getMemberIdx();
		
		// 유효성 검사
		
		// 이름은 null 이 아니고 한글 2~10자
		String name = req.getParameter("name");
		String tel2 = req.getParameter("tel2");
		String tel3 = req.getParameter("tel3");
		
		if(name == null || !name.matches("^[가-힣]{2,10}$")) {
			session.setAttribute("profileValidationError", "이름은 한글 2~10자로 입력해주세요.");
			return new ModelAndView("redirect:/player/mypage");
			// tel2, tel3 는 null 이 아니고 숫자 3~4자리
		} else if(tel2 == null || !tel2.matches("^[0-9]{3,4}$")) {
			session.setAttribute("profileValidationError", "전화번호는 숫자 3~4자리로 입력해주세요.");
			return new ModelAndView("redirect:/player/mypage");
		} else if(tel3 == null || !tel3.matches("^[0-9]{3,4}$")) {
			session.setAttribute("profileValidationError", "전화번호는 숫자 3~4자리로 입력해주세요.");
			return new ModelAndView("redirect:/player/mypage");
		}
		
		if(!Boolean.TRUE.equals(session.getAttribute("playerUpdateVerified"))) {
			return new ModelAndView("redirect:/player/mypage");
		}
		
		// 프로필 수정
		try {
			PlayerMypageDTO dto = service.findProfile(info.getMemberIdx());
			
			// setMemberIdx : 로그인 세션에서 info 로 가져옴
			// memberIdx, email, birth, profile_photo, tel,
			// zip, addr1, addr2, gender, pref_position
			dto.setMemberIdx(info.getMemberIdx());
			dto.setName(req.getParameter("name"));
			dto.setEmail(req.getParameter("email1") + "@" + req.getParameter("email2"));
			dto.setBirth(req.getParameter("birth"));
			dto.setTel(req.getParameter("tel1") + "-" + req.getParameter("tel2") + "-" + req.getParameter("tel3"));
			dto.setZip(req.getParameter("zip"));
			dto.setAddr1(req.getParameter("addr1"));
			dto.setAddr2(req.getParameter("addr2"));
			dto.setGender(req.getParameter("gender"));
			dto.setUniform_no(Integer.parseInt(req.getParameter("uniform_no")));
			dto.setWeight(Integer.parseInt(req.getParameter("weight")));
			dto.setHeight(Integer.parseInt(req.getParameter("height")));
			dto.setClubJoin_num(Long.parseLong(req.getParameter("clubJoin_num")));
			
			// 사진 파일처리
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "member";
			
			Part part = req.getPart("profilePhoto");
			MyMultipartFile multiPart = fileManager.doFileUpload(part, pathname);
			
			// 새 사진 파일을 선택했을 경우에
			if(multiPart != null) {
				String oldFilename = dto.getProfile_photo();
				
				// DB에 새 파일명을 저장하고
				dto.setProfile_photo(multiPart.getSaveFilename());
			
				// 기존 사진 파일이 있으면 삭제
				if(oldFilename != null && !oldFilename.isEmpty()) {
					fileManager.doFiledelete(pathname, oldFilename);
				}
			}
			
			
			service.updateProfile(dto);
			
			if(dto.getClubJoin_num() != 0) {
				service.updateSelectProfile(dto);
			}
			
			// DB 수정 성공 후 이름도 변경 적용 
			info.setUserName(dto.getName());
			session.setAttribute("profileUpdateSuccess", true);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/player/mypage");
	}
	
	// 마이페이지 수정 전 모달창 비밀번호 확인
	@PostMapping("checkPassword")
	public ModelAndView checkPassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		// info 에 로그인 정보가 없으면 다시 로그인창으로 돌아가게
		if(info == null) {
			return new ModelAndView("redirect:/member/login");
		}
		
		// 패스워드 가져오기
		String userPwd = req.getParameter("userPwd");
		
		// 데이터 박스 DTO 회원정보 받아오기
		MemberDTO dto = memberService.findById(info.getUserId());
		
		// null 또는 pwd 안맞을때
		if(dto == null || userPwd == null || !userPwd.equals(dto.getUserPwd())) {
			session.removeAttribute("playerUpdateVerified");
			return new ModelAndView("redirect:/player/mypage?passwordError=true");
		}
		
		// 회원이 비밀번호 확인을 통과했음. 
		// playerUpdateVerified : 세션이름
		// true : 저장값
		session.setAttribute("playerUpdateVerified", true);
		// 마이페이지 주소로 다시 이동
		return new ModelAndView("redirect:/player/mypage");
	}
	
	// 회원정보 조회
	@GetMapping("mypage")
	public ModelAndView mypage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info == null) {
			return new ModelAndView("redirect:/member/login");
		}
		
		PlayerMypageDTO dto = service.findProfile(info.getMemberIdx());
		PlayerMypageDTO tmp = service.selectProfile(info.getMemberIdx());
		BallDTO mainBall = ballService.findMainBall(info.getMemberIdx());
		
		if(tmp != null) {
			dto.setUniform_no(tmp.getUniform_no());
			dto.setHeight(tmp.getHeight());
			dto.setWeight(tmp.getWeight());
			dto.setClubJoin_num(tmp.getClubJoin_num());
		}
		
		boolean playerUpdateVerified = Boolean.TRUE.equals(session.getAttribute("playerUpdateVerified"));
		boolean passwordError = "true".equals(req.getParameter("passwordError"));
		boolean profileUpdateSuccess = Boolean.TRUE.equals(session.getAttribute("profileUpdateSuccess"));

		session.removeAttribute("profileUpdateSuccess");
		
		ModelAndView mav = new ModelAndView("player/mypage");
		
		// 유효성 검사에서 에러 문구를 담아
		String profileValidationError = (String)session.getAttribute("profileValidationError");
		
		// 오류문구 새로고침 했을때 한번만 보여주기 위해서 remove 해준다
		session.removeAttribute("profileValidationError");
		// jsp 에 쏴주기 
		mav.addObject("profileValidationError", profileValidationError);
		mav.addObject("playerUpdateVerified", playerUpdateVerified);
		mav.addObject("passwordError", passwordError);
		mav.addObject("dto", dto);
		mav.addObject("profileUpdateSuccess", profileUpdateSuccess);
		mav.addObject("mainBall", mainBall);
		
		return mav;
	}
	
	
	// 미니게임 실행 + 대표 공 1개 조회
	@GetMapping("miniGame")
	public ModelAndView todo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info == null) {
			return new ModelAndView("redirect:/member/login");
		}
		
		// 회원정보 info 에서 가져오기
		long memberIdx = info.getMemberIdx();
		
		BallDTO mainBall = ballService.findMainBall(memberIdx);
		// 사용자 화면에 보여줄 컬럼: 공 이름, 공 이미지, 공 등급
		//	ball_name, ball_image, ball_grade(NORMAL or RARE)
		
		// DB 에 저장된 공 정보를 조회하는 곳
		ModelAndView mav = new ModelAndView("player/miniGame");
		
		PlayerMypageDTO dto = service.findProfile(memberIdx);
		
		// POST 세션에 넣어둔 뽑은 공 정보를 가져온다
		BallDTO pickedBall = (BallDTO) session.getAttribute("pickedBall");
		// 세션에서 그 정보를 바로 삭제한다
		// 삭제하지 않으면 사용자가 새로고침할때마다 모달 계속 열림
		session.removeAttribute("pickedBall");
		
		// 공 뽑은 이력 여부 확인
		Boolean alreadyPicked = (Boolean)session.getAttribute("alreadyPicked");
		session.removeAttribute("alreadyPicked");
		
		// 프로필 공 변경 업데이트 
		Boolean mainBallUpdated = (Boolean)session.getAttribute("mainBallUpdated");
		session.removeAttribute("mainBallUpdated");
		
		// 뽑은 공 도감 목록 확인
		List<BallDTO> memberBallCollection = memberBallPickService.findMemberBallCollection(memberIdx);

		mav.addObject("pickedBall", pickedBall);
		mav.addObject("alreadyPicked", alreadyPicked);
		mav.addObject("mainBallUpdated", mainBallUpdated);
		mav.addObject("memberBallCollection", memberBallCollection);
		mav.addObject("mainBall", mainBall);
		mav.addObject("dto", dto);
		
		return mav;
	}
	
	// 미니게임 실행 + 공 뽑기
	@PostMapping("miniGame")
	public ModelAndView pickBall(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info == null) {
			return new ModelAndView("redirect:/member/login");
		}
		
		// 회원 정보 가져오기
		long memberIdx = info.getMemberIdx();
		
		// 오늘 뽑기 횟수 확인하기
		int todayPickCount = memberBallPickService.countTodayPick(memberIdx);
		
		// 이미 뽑은 공이 있으면 리다이렉트
		if(todayPickCount > 0) {
			session.setAttribute("alreadyPicked", true);
			return new ModelAndView("redirect:/player/miniGame");
		}
		
		MemberBallpickDTO dto = new MemberBallpickDTO();
		dto.setMemberIdx(memberIdx);
		
		// 회원경기 횟수 - 미니게임: 경기 3회 이상시 레어공 확률 배분
		int playedMatchCount = matchHistoryService.countPlayedMatches(memberIdx);
		
		// 테스트용 블루공번호
		// dto.setBall_idx(5);
		
		
		// 경기 참여 횟수 조회
		// 뽑기에 나올 후보 공 목록들 
		// 경기 횟수에 따라서 뽑을 수 있는 공 경우의 수가 달라진다 
		// 테스트용 findEligibleBalls(10);
		List<BallDTO> eligibleBalls = ballService.findEligibleBalls(playedMatchCount);

		// 조회된 후보 공 목록이 비어 있는지 확인
		// 비어 있다면 활성화된 공 데이터가 없는 상황
		if(eligibleBalls == null || eligibleBalls.isEmpty()) {
			
			return new ModelAndView("redirect:/player/miniGame");
		}
		//-----------------------------------------
//		for(int i = 0; i <= 100; i++) { // 테스트용

		// 모든 후보 공의 rating 총 합 계산
		// 전체 경우의 수를 담아놓은 박스 
		int totalRating = 0;
		
		// 후보 공들의 ball_rating 값을 이용해 확률 랜덤 선택
		// eligibleBalls : 뽑기 가능한 후보 공 목록
		// 전체확률 += 공 추첨확률
		for(BallDTO ball : eligibleBalls) {
			totalRating += ball.getBall_rating();
		}
		// NORMAL or RARE 중 하나이니까
		// 두가지 경우의 수를 더해줘서 확률을 높여줌 
		
		// 랜덤 돌리기
		// 확률이 10, 2 같은 정수라서 int 로 돌린다
		int randomNumber = (int)(Math.random() * totalRating) + 1;
		
		// cumulativeRating : 반복하면서 누적하는 확률 범위
		// randomNumber가 cumulativeRating를 어떤 공이냐 골라야 한다
		int cumulativeRating = 0; 
		// 랜덤 숫자에 해당하는 볼
		BallDTO selectedBall = null;
		
		// 후보 공들을 다시 한번 반복
		// 랜덤 숫자에 해당하는 selectBall을 찾는용
		for(BallDTO ball : eligibleBalls) {
			// 전체 공에서 몇점짜리냐 
			cumulativeRating += ball.getBall_rating();
			
			// 만약에 랜덤 번호가 누적하는 확률 범위보다
			// 작거나 같으면
			// 5점 10점 공을 넣었을때 8번 을 뽑은 상황이라고 가정
			// cumulativeRating 가 5가 되고 8은 5보다 작지 않으니
			// 다시 for 로 돌아가서 다음 공의 점수를 더하고
			// 작은 경우의 수가 되면 selectedBall가 되어서 뽑힌다.
			if(randomNumber <= cumulativeRating) {
				// 현재 반복중인 공
				selectedBall = ball;
				break;
			}
		}
		System.out.println("뽑은공 : " + selectedBall.getBall_name() + " 확률 : " + selectedBall.getBall_rating());
		
//	} // 테스트용
		//-----------------------------------------------
		// selectBall 의 ball_idx를 dto 에 저장
		dto.setBall_idx(selectedBall.getBall_idx());

		memberBallPickService.insertMemberBallPick(dto);
		
		// 뽑은 공 조회하기
		BallDTO pickedBall = ballService.findBallByIdx(dto.getBall_idx());
		
		session.setAttribute("pickedBall", pickedBall);
		
		return new ModelAndView("redirect:/player/miniGame");
	}
	
	// 프로필 대표 공 설정
	@PostMapping("mainBall")
	public ModelAndView mainBall(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info == null) {
			return new ModelAndView("redirect:/member/login");
		}
		
		long memberIdx = info.getMemberIdx();
		long ball_idx = Long.parseLong(req.getParameter("ball_idx"));
		
		// MemberBallmainDTO 에서 회원번호랑 ball_idx 가져오기
		MemberBallmainDTO dto = new MemberBallmainDTO();
		// 위에서 이미 info 로 가져왔기 때문에 여기서는 바로 memberIdx 해도 됌
		dto.setMemberIdx(memberIdx);
		dto.setBall_idx(ball_idx);
		
		// 대표공 존재여부
		BallDTO mainBall = ballService.findMainBall(memberIdx);
		
		if(mainBall == null) {
			// 대표공이 없으면 최초 지정
			ballService.insertProfileBall(dto);
		} else {
			// 대표공이 있으면 변경
			ballService.updateProfileBall(dto);
		}
		
		session.setAttribute("mainBallUpdated", true);
		
		return new ModelAndView("redirect:/player/miniGame");
	}
	
	
	// 내 선수 프로필 조회
	@GetMapping("playerProfile")
	public ModelAndView playerProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		List<PlayerProfileDTO> players = playerService.findPlayer(info.getMemberIdx());
		PlayerMypageDTO dto = service.findProfile(info.getMemberIdx());
		BallDTO mainBall = ballService.findMainBall(info.getMemberIdx());
		
		ModelAndView mav = new ModelAndView("player/playerProfile");
		mav.addObject("players", players);
		mav.addObject("dto", dto);
		mav.addObject("mainBall", mainBall);
		
		return mav;
	}
	
	// 내 경기성적 조회
	@GetMapping("rating")
	public ModelAndView rating(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		long memberIdx = info.getMemberIdx();
		
		List<MatchRecordDTO> list = matchRecordService.listMatchRecord(info.getMemberIdx());
		
		PlayerMypageDTO dto = service.findProfile(memberIdx);
		BallDTO mainBall = ballService.findMainBall(memberIdx);
		
		ModelAndView mav = new ModelAndView("player/rating");
		mav.addObject("list", list);
		mav.addObject("dto", dto);
		mav.addObject("mainBall", mainBall);
		
		return mav;
	}
	
	// 내 경기 참가 이력
	@GetMapping("matchHistory")
	public ModelAndView matchHistory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		long memberIdx = info.getMemberIdx();
		
		List<MatchHistoryDTO> list = matchHistoryService.listMatchHistory(info.getMemberIdx());
		
		PlayerMypageDTO dto = service.findProfile(memberIdx);
		BallDTO mainBall = ballService.findMainBall(memberIdx);
		
		ModelAndView mav = new ModelAndView("player/matchHistory");
		
		mav.addObject("list", list);
		mav.addObject("dto", dto);
		mav.addObject("mainBall", mainBall);
		
		return mav;
	}
	
	//
	@GetMapping("matchApply")
	public ModelAndView matchApply(HttpServletRequest req, HttpServletResponse resp) {
	    return new ModelAndView("player/matchApply");
	}
	
	// 내 구단팀 조회
	@GetMapping("club")
	public ModelAndView club(HttpServletRequest req, HttpServletResponse resp) {
	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo)session.getAttribute("member");
	    
	    long memberIdx = info.getMemberIdx();
	    
	    ClubInfoDTO dto = myClubInfoService.MyClubInfo(memberIdx);
	    PlayerMypageDTO profileDto = service.findProfile(memberIdx);
		BallDTO mainBall = ballService.findMainBall(memberIdx);
	    
	    ModelAndView mav = new ModelAndView("player/club");
	    
	    mav.addObject("dto", dto);
	    mav.addObject("profileDto", profileDto);
	    mav.addObject("mainBall", mainBall);
		
		return mav;
	}
	
	// 입단 신청 + 신청 결과 조회
	@GetMapping("clubJoin")
	public ModelAndView clubJoin(HttpServletRequest req, HttpServletResponse resp) {
	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo)session.getAttribute("member");
	    
	    // 로그인 하지 않은 사용자는 로그인 페이지로 이동
	    if(info == null) {
	    		return new ModelAndView("redirect:/member/login");
	    }
	    
	    long memberIdx = info.getMemberIdx();
	    
	    List<ClubOwnerHistoryDTO> list = historyService.clubOwnerRequestHistory(info.getMemberIdx());
		PlayerMypageDTO profileDto = service.findProfile(memberIdx);
		BallDTO mainBall = ballService.findMainBall(memberIdx);
		ClubJoinDTO dto = new ClubJoinDTO();
		
		// 입단신청 목록 가져오기
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("schType", "all");
		map.put("kwd", "");
		map.put("size", 3);
		map.put("offset", 0);
		
		List<ClubInfoPlyDTO> clubList = clubInfoPlyService.listClubInfoPly(map);
		
		// 입단신청 하단 SELECT 보기 리스트
		// 상단에는 3개만 보여주고 하단에는 모든 구단 리스트가 나오게 
		Map<String, Object> allClubMap = new HashMap<String, Object>();
		
		allClubMap.put("schType", "all");
		allClubMap.put("kwd", "");
		allClubMap.put("offset", 0);

		int allCount = clubInfoPlyService.dataCount(allClubMap);
		allClubMap.put("size", allCount);
		
		List<ClubInfoPlyDTO> allClubList = clubInfoPlyService.listClubInfoPly(allClubMap);
		
		ModelAndView mav = new ModelAndView("player/clubJoin");
		
		mav.addObject("list", list);
		mav.addObject("profileDto", profileDto);
		mav.addObject("mainBall", mainBall);
		mav.addObject("dto", dto);
		mav.addObject("clubList", clubList);
		mav.addObject("allClubList", allClubList);
		
		return mav;
	}
	
	// 구단주 신청
	@GetMapping("clubOwnerRequest")
	public ModelAndView clubOwnerRequest(HttpServletRequest req, HttpServletResponse resp) {
	    HttpSession session = req.getSession(); 
	    SessionInfo info = (SessionInfo)session.getAttribute("member");
	    
	    if(info == null) {
	    		return new ModelAndView("redirect:/member/login");
	    }
	    
	    long memberIdx = info.getMemberIdx();
	    
	    // 신청 값 전달한 뒤 바로 제거해야 함
	    // 그래야 새로고침 했을때 신청이 완료되었습니다 같은 문구 재로딩x
	    boolean clubOwnerRequestSuccess = Boolean.TRUE.equals(session.getAttribute("clubOwnerRequestSuccess"));
	    
	    // 전달 후 바로 제거
	    session.removeAttribute("clubOwnerRequestSuccess");
	 
		PlayerMypageDTO profileDto = service.findProfile(memberIdx);
		BallDTO mainBall = ballService.findMainBall(memberIdx);
	    
	    ModelAndView mav = new ModelAndView("player/clubOwnerRequest");
	    mav.addObject("clubOwnerRequestSuccess", clubOwnerRequestSuccess);
		mav.addObject("today", new Date());
		mav.addObject("profileDto", profileDto);
		mav.addObject("mainBall", mainBall);
	    
		return mav;
	}
	// 구단주 신청 저장
	@PostMapping("clubOwnerRequest")
	public ModelAndView clubOwnerRequestSubmit(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info == null) {
    			return new ModelAndView("redirect:/member/login");
		}
		
		// 사용자가 요청값을 바꿔서 다른 사람 회원번호로 신청할 수 있으니
		// 로그인 세션값의 아이디로 사용
		long memberIdx = info.getMemberIdx();
		
		// 신청일, 신청사유
		// 초기 설정상태 = 신청 시 대기 
		String cor_content = req.getParameter("cor_content");
		
		ClubOwnerRequestDTO dto = new ClubOwnerRequestDTO();
		dto.setMemberIdx(memberIdx);
		dto.setCor_content(cor_content);
		dto.setCor_status(2);
		
		// dto 다 보여주고, 신청 완료 실행해야 함
		int result = clubOwnerRequestService.insertClubOwnerRequest(dto);
		
		// result 가 0보다 크면
		if(result > 0) {
			session.setAttribute("clubOwnerRequestSuccess", true);
		}
		
		return new ModelAndView("redirect:/player/clubOwnerRequest");
	}
	
	// 구단주 신청 취소
	@PostMapping("deleteClubOwnerRequest")
	public ModelAndView deleteClubOwnerRequest(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info == null) {
			return new ModelAndView("redirect:/member/login");
		}
		
		long cor_request_num = Long.parseLong(req.getParameter("cor_request_num"));
		
		// dto 에 있는 구단주 신청번호, 회원번호
		ClubOwnerRequestDTO dto = new ClubOwnerRequestDTO();
		
		dto.setCor_request_num(cor_request_num);
		dto.setMemberIdx(info.getMemberIdx());
		
		int result = clubOwnerRequestService.deleteClubOwnerRequest(dto);
		
		return new ModelAndView("redirect:/player/clubOwnerRequestHistory");
	}
	
	// 입단신청 결과조회
	@GetMapping("clubOwnerRequestHistory")
	public ModelAndView clubOwnerRequestHistory(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info == null) {
			return new ModelAndView("redirect:/member/login");
		}
		
		long memberIdx = info.getMemberIdx();
		
		List<ClubOwnerRequestDTO> list = clubOwnerRequestService.listClubOwnerRequest(info.getMemberIdx());
		PlayerMypageDTO profileDto = service.findProfile(memberIdx);
		BallDTO mainBall = ballService.findMainBall(memberIdx);
		
		ModelAndView mav = new ModelAndView("player/clubOwnerRequestHistory");
		
		mav.addObject("list", list);
		mav.addObject("profileDto", profileDto);
		mav.addObject("mainBall", mainBall);
		
		return mav;

	}
	
	// 입단신청 취소
	@PostMapping("cancelClubOwnerRequest")
	public ModelAndView cancelClubOwnerRequest(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		// 로그인 정보가 없으면
		if(info == null) {
			return new ModelAndView("redirect:/member/login");
		}
		
		Long clubJoin_Num = Long.parseLong(req.getParameter("clubJoin_Num"));
		
		int result = historyService.cancelClubOwnerRequest(clubJoin_Num, info.getMemberIdx());
		
		return new ModelAndView("redirect:/player/clubJoin");

	}
}
