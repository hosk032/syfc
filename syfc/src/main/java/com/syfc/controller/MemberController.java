package com.syfc.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.syfc.dto.MemberDTO;
import com.syfc.dto.SessionInfo;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.annotation.ResponseBody;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.MemberService;
import com.syfc.service.MemberServiceImpl;
import com.syfc.util.FileManager;
import com.syfc.util.MyMultipartFile;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
@RequestMapping("/member/*")//흐름 예:로그인 완료 - 정보수정 - 패스워드 입력창 - 패스워드 확인 - 정보수정 후 완료 
public class MemberController {
	private MemberService service = new MemberServiceImpl();
	private FileManager fileManager = new FileManager();
	
	// @RequestMapping(value = "login", method = RequestMethod.GET)
	@GetMapping("login")
	public ModelAndView loginForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 폼
		return new ModelAndView("member/login");
	}

	// @RequestMapping(value = "login", method = RequestMethod.POST)
	@PostMapping("login")
	public ModelAndView loginSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 처리
		// 세션객체. 세션 정보는 서버에 저장(로그인 정보, 권한등을 저장)
		HttpSession session = req.getSession();
		
		try {
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd");

			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);
			map.put("userPwd", userPwd);
			
			MemberDTO dto = service.loginMember(map);
			
			if(dto == null) {
				// 로그인 실패인 경우
				ModelAndView mav = new ModelAndView("member/login");
				
				String msg = "아이디 또는 패스워드가 일치하지 않거나, 탈퇴/정지회원입니다.";
				mav.addObject("message", msg);

				return mav;
			}
			
			// 로그인 성공 : 로그인정보를 서버에 저장
			// 세션의 유지시간을 20분설정(기본 30분)
			session.setMaxInactiveInterval(20 * 60);

			// 세션에 저장할 내용
			SessionInfo info = new SessionInfo();
			info.setMemberIdx(dto.getMemberIdx());
			info.setUserId(dto.getUserId());
			info.setUserName(dto.getUserName());
			info.setAvatar(dto.getProfile_photo() == null || 
			dto.getProfile_photo().isEmpty() ? "/images/avatar.png" : dto.getProfile_photo());
			
			info.setUserLevel(dto.getUserLevel());

			// 세션에 member이라는 이름으로 로그인 정보를 저장
			session.setAttribute("member", info);

			String preLoginURI = (String)session.getAttribute("preLoginURI");
			session.removeAttribute("preLoginURI");
			if(preLoginURI != null) {
				// 로그인 전페이지가 있다면 해당 주소로 리다이렉트
				return new ModelAndView(preLoginURI);
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 메인 화면으로 리다이렉트
		return new ModelAndView("redirect:/");
	}
	
	@GetMapping("logout")
	public ModelAndView logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그아웃
		HttpSession session = req.getSession();

		// 세션에 저장된 정보를 지운다.
		session.removeAttribute("member");

		// 세션에 저장된 모든 정보를 지우고 세션을 초기화 한다.
		session.invalidate();
		
		return new ModelAndView("redirect:/");
	}
	
	@GetMapping("noAuthorized")
	public ModelAndView noAuthorized(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 권한이 없는 경우
		return new ModelAndView("member/noAuthorized"); //권한없음을 알리는 페이지로 이동
	}


	@GetMapping("account")
	public ModelAndView accountForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 회원가입 폼 띄워주기
		ModelAndView mav = new ModelAndView("member/member");
		
		mav.addObject("mode", "account");
		
		return mav;
	}
	
	@PostMapping("account")
	public ModelAndView accountSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 실제로 회원 가입 폼에 입력된 정보를 받아와 db에 저장
		HttpSession session = req.getSession(); //세션 객체 생성
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/"); //서버 저장장치에 있는 진짜 경로
		String pathname = root + "uploads" + File.separator + "member"; //진짜경로/member 경로에 저장
		
		String message = "";
		
		try {
			MemberDTO dto = new MemberDTO();
			dto.setUserId(req.getParameter("userId"));
			dto.setUserPwd(req.getParameter("userPwd"));
			dto.setUserName(req.getParameter("userName"));
			
			dto.setBirth(req.getParameter("birth"));
			
			dto.setEmail(req.getParameter("email")); 

			// 이미지 파일
			Part p = req.getPart("selectFile");
			MyMultipartFile multiPart = fileManager.doFileUpload(p, pathname);
			if(multiPart != null) {
				dto.setProfile_photo(multiPart.getSaveFilename());
			}
			
			dto.setTel(req.getParameter("tel"));

			dto.setZip(req.getParameter("zip"));
			dto.setAddr1(req.getParameter("addr1"));
			dto.setAddr2(req.getParameter("addr2"));
			dto.setGender(req.getParameter("gender"));
			dto.setPref_position(Integer.parseInt(req.getParameter("pref_position")));

			service.insertMember(dto);
			
			session.setAttribute("mode", "account");
			session.setAttribute("userName", dto.getUserName());
				//세션은 브라우저를 종료할때까지 또는 만료전까지 정보가 남으므로 redirect에도 사라지지 않음
			return new ModelAndView("redirect:/member/complete"); //가입정보 입력에 성공하면 완료페이지로 이동
		} catch (SQLException e) {
			if (e.getErrorCode() == 1) {
				message = "아이디 중복으로 회원 가입이 실패 했습니다.";
			} else if (e.getErrorCode() == 1400) {
				message = "필수 사항을 입력하지 않았습니다.";
			} else if (e.getErrorCode() == 1840 || e.getErrorCode() == 1861) {
				message = "날짜 형식이 일치하지 않습니다.";
			} else {
				message = "회원 가입이 실패 했습니다.";
				// 기타 - 2291:참조키 위반, 12899:폭보다 문자열 입력 값이 큰경우
			}
		} catch (Exception e) {
			message = "회원 가입이 실패 했습니다.";
			e.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView("member/member"); //가입실패 시 다시 회원가입 폼으로
		
		mav.addObject("mode", "account");
		mav.addObject("message", message);
		
		return mav;
	}
	
	@GetMapping("pwd") //메인에서 회원정보 수정을 눌렀을 때 들어오는 경로
	public ModelAndView pwdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 패스워드 확인 폼으로
		ModelAndView mav = new ModelAndView("member/pwd");
		
		String mode = req.getParameter("mode");
		mav.addObject("mode", mode);

		return mav;
	}

	@PostMapping("pwd") //패스워드 맞게 입력한 후 들어가는 곳
	public ModelAndView pwdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 패스워드 확인
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		try {
			MemberDTO dto = service.findById(info.getUserId());
			if (dto == null) {
				session.invalidate();
				return new ModelAndView("redirect:/");
			}

			String userPwd = req.getParameter("userPwd");
			String mode = req.getParameter("mode");
			if (! dto.getUserPwd().equals(userPwd)) {
				ModelAndView mav = new ModelAndView("member/pwd");
				
				mav.addObject("mode", mode);
				mav.addObject("message", "패스워드가 일치하지 않습니다.");
				
				return mav;
			}

			if (mode.equals("delete")) {
				// 회원탈퇴
				
				// profile_photo 삭제
				String root = session.getServletContext().getRealPath("/");
				String pathname = root + "uploads" + File.separator + "member";
				if(info.getAvatar() != null && info.getAvatar().length() != 0) {
					fileManager.doFiledelete(pathname, info.getAvatar());
				}

				// table 정보 변경 및 삭제
				Map<String, Object> map = new HashMap<>();
				map.put("userId", info.getUserId());
				map.put("memberIdx", info.getMemberIdx());
				service.deleteMember(map);

				session.removeAttribute("member");
				session.invalidate();

			} else if(mode.equals("update")) {
				// 회원정보수정 - 회원수정폼으로 이동
				ModelAndView mav = new ModelAndView("member/member");
				
				mav.addObject("dto", dto);
				mav.addObject("mode", "update"); //모드를 담아 보내 앞단에서 모드에 따라 따라 다르게 표시되게
				
				return mav;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/");
	}

	@PostMapping("update")
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 회원정보 수정 완료
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		// 파일 저장 경로
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "member";
		
		try {
			MemberDTO dto = new MemberDTO();

			dto.setUserId(info.getUserId()); //세션에서 가져옴
			dto.setMemberIdx(info.getMemberIdx());
			dto.setUserPwd(req.getParameter("userPwd"));
			dto.setUserName(req.getParameter("userName"));
			
			dto.setBirth(req.getParameter("birth"));
			
			dto.setEmail(req.getParameter("email")); 

			// 이미지 파일
			dto.setProfile_photo(req.getParameter("profile_photo"));
			Part p = req.getPart("selectFile"); //새로운 그림이 올라오면 새 사진으로 교체
			MyMultipartFile multiPart = fileManager.doFileUpload(p, pathname);
			if(multiPart != null) {
				// 기존 이미지 지우기
				if(dto.getProfile_photo().length() != 0) {
					fileManager.doFiledelete(pathname, dto.getProfile_photo());
				}
				
				//새로운 이미지
				String filename = multiPart.getSaveFilename();
				dto.setProfile_photo(filename);
			}
			
			dto.setTel(req.getParameter("tel"));

			dto.setZip(req.getParameter("zip"));
			dto.setAddr1(req.getParameter("addr1"));
			dto.setAddr2(req.getParameter("addr2"));
			dto.setGender(req.getParameter("gender"));
			dto.setPref_position(Integer.parseInt(req.getParameter("pref_position")));

			service.updateMember(dto);
				//세션에서 바로 이미지 정보 변경. 재로그인하지않아도 바로 적용
			info.setAvatar(dto.getProfile_photo()); 
			
			session.setAttribute("mode", "update");
			session.setAttribute("userName", dto.getUserName());
			
			return new ModelAndView("redirect:/member/complete");			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/");
	}
	
	
	@GetMapping("complete") //ModelAndView: 컨트롤러가 처리한 데이터(model)와 보여줄 부분(view)을 담아 반환
	public ModelAndView complete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		String mode = (String)session.getAttribute("mode");
		String userName = (String)session.getAttribute("userName");
			//세션으로 전달되어온 정보 저장 (회원가입 완료 후 redirect하여 왔지만 ㅇㅇ님 가입축하합니다 메세지를 띄우기위해)
		session.removeAttribute("mode");
		session.removeAttribute("userName");
			//이제 세션이 필요없으므로 해당 속성 삭제
		if(mode == null) {
			return new ModelAndView("redirect:/");
		}
		
		String title;
		String message = "<b>" + userName + "</b>님 ";
		if(mode.equals("account")) {
			title = "회원가입";
			message += "회원가입이 완료 되었습니다.<br>로그인 하시면 정보를 이용하실수 있습니다.";
		} else {
			title = "정보수정";
			message += "회원정보가 수정 되었습니다.<br>메인 화면으로 이동하시기 바랍니다.";
		}

		ModelAndView mav = new ModelAndView("member/complete");

		mav.addObject("title", title);
		mav.addObject("message", message);
		
		return mav;
	}
	//AJAX : JSON
	@ResponseBody //map 의 리턴 타입을 json으로 변환하여 반환(스프링과 동일)
	@PostMapping("userIdCheck") //아이디 중복 체크
	public Map<String, Object> userIdCheck(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> map = new HashMap<String, Object>();
		
		String userId = req.getParameter("userId");
		MemberDTO dto = service.findById(userId);
		
		String passed = "false";
		if(dto == null) { //일치하는 아이디가 없어 db에서 가져온 레코드가 없어 dto가 null일 때
			passed = "true";
		} //즉 해당 아이디를 사용할 수 있다는 것.
		
		map.put("passed", passed);
		
		return map;
	}
	
	@ResponseBody 
	@PostMapping("deleteProfile")
	public Map<String, Object> deleteProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> model = new HashMap<String, Object>();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "member";
		
		String state = "false";
		
		try {
			String profile_photo = req.getParameter("profile_photo");
			
			if(profile_photo != null && profile_photo.length() != 0) {
				fileManager.doFiledelete(pathname, profile_photo);
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("userId", info.getUserId());
				service.deleteProfilePhoto(map);
				
				//세선 정보 변경
				info.setAvatar("");
				state = "true";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.put("state", state);		
		
		return model;
	}
}