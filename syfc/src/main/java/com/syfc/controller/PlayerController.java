package com.syfc.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import com.syfc.dto.BallDTO;
import com.syfc.dto.ClubInfoDTO;
import com.syfc.dto.ClubOwnerHistoryDTO;
import com.syfc.dto.ClubOwnerRequestDTO;
import com.syfc.dto.MatchHistoryDTO;
import com.syfc.dto.MatchRecordDTO;
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
	
	private FileManager fileManager = new FileManager();
	
	@PostMapping("profile")
	public ModelAndView profile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info == null) {
			return new ModelAndView("redirect:/member/login");
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
		
		mav.addObject("playerUpdateVerified", playerUpdateVerified);
		mav.addObject("passwordError", passwordError);
		mav.addObject("dto", dto);
		mav.addObject("profileUpdateSuccess", profileUpdateSuccess);
		
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
		
		BallDTO dto = ballService.findMainBall(memberIdx);
		// 사용자 화면에 보여줄 컬럼: 공 이름, 공 이미지, 공 등급
		//	ball_name, ball_image, ball_grade(NORMAL or RARE)
		
		// DB 에 저장된 공 정보를 조회하는 곳
		ModelAndView mav = new ModelAndView("player/miniGame");
		
		// POST 세션에 넣어둔 뽑은 공 정보를 가져온다
		BallDTO pickedBall = (BallDTO) session.getAttribute("pickedBall");
		// 세션에서 그 정보를 바로 삭제한다
		// 삭제하지 않으면 사용자가 새로고침할때마다 모달 계속 열림
		session.removeAttribute("pickedBall");
		
		// 공 뽑은 이력 여부 확인
		Boolean alreadyPicked = (Boolean)session.getAttribute("alreadyPicked");
		session.removeAttribute("alreadyPicked");
		
		// 뽑은 공 도감 목록 확인
		List<BallDTO> memberBallCollection = memberBallPickService.findMemberBallCollection(memberIdx);

		mav.addObject("pickedBall", pickedBall);
		mav.addObject("alreadyPicked", alreadyPicked);
		mav.addObject("memberBallCollection", memberBallCollection);
		
		mav.addObject("ball", dto);
		
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
		
		MemberBallpickDTO dto = new MemberBallpickDTO();
		
		dto.setMemberIdx(memberIdx);
		
		// 테스트용 블루공번호
		dto.setBall_idx(5);
		
		// 오늘 뽑기 횟수 확인하기
		int todayPickCount = memberBallPickService.countTodayPick(memberIdx);
		
		if(todayPickCount > 0) {
			session.setAttribute("alreadyPicked", true);
			return new ModelAndView("redirect:/player/miniGame");
		}

		memberBallPickService.insertMemberBallPick(dto);
		
		// 뽑은 공 조회하기
		BallDTO pickedBall = ballService.findBallByIdx(dto.getBall_idx());
		
		session.setAttribute("pickedBall", pickedBall);
		
		return new ModelAndView("redirect:/player/miniGame");
	}
	
	// 내 선수 프로필 조회
	@GetMapping("playerProfile")
	public ModelAndView playerProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		List<PlayerProfileDTO> players = playerService.findPlayer(info.getMemberIdx());
		
		ModelAndView mav = new ModelAndView("player/playerProfile");
		mav.addObject("players", players);
		
		return mav;
	}
	
	// 내 경기성적 조회
	@GetMapping("rating")
	public ModelAndView rating(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		List<MatchRecordDTO> list = matchRecordService.listMatchRecord(info.getMemberIdx());
		
		ModelAndView mav = new ModelAndView("player/rating");
		mav.addObject("list", list);
		
		return mav;
	}
	
	// 내 경기 참가 이력
	@GetMapping("matchHistory")
	public ModelAndView matchHistory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		List<MatchHistoryDTO> list = matchHistoryService.listMatchHistory(info.getMemberIdx());
	
		ModelAndView mav = new ModelAndView("player/matchHistory");
		
		mav.addObject("list", list);
		
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
	    
	    ClubInfoDTO dto = myClubInfoService.MyClubInfo(info.getMemberIdx());
	    
	    ModelAndView mav = new ModelAndView("player/club");
	    
	    mav.addObject("dto", dto);
		
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
	    
	    List<ClubOwnerHistoryDTO> list = historyService.clubOwnerRequestHistory(info.getMemberIdx());
		
		ModelAndView mav = new ModelAndView("player/clubJoin");
		
		mav.addObject("list", list);
		
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
	    
	    // 신청 값 전달한 뒤 바로 제거해야 함
	    // 그래야 새로고침 했을때 신청이 완료되었습니다 같은 문구 재로딩x
	    boolean clubOwnerRequestSuccess = Boolean.TRUE.equals(session.getAttribute("clubOwnerRequestSuccess"));
	    
	    // 전달 후 바로 제거
	    session.removeAttribute("clubOwnerRequestSuccess");
	 
	    ModelAndView mav = new ModelAndView("player/clubOwnerRequest");
	    mav.addObject("clubOwnerRequestSuccess", clubOwnerRequestSuccess);
		mav.addObject("today", new Date());
	    
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
		
		List<ClubOwnerRequestDTO> list = clubOwnerRequestService.listClubOwnerRequest(info.getMemberIdx());
		
		ModelAndView mav = new ModelAndView("player/clubOwnerRequestHistory");
		
		mav.addObject("list", list);
		
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
