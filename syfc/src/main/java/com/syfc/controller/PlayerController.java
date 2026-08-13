package com.syfc.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import com.syfc.dto.MatchHistoryDTO;
import com.syfc.dto.PlayerMypageDTO;
import com.syfc.dto.PlayerProfileDTO;
import com.syfc.dto.SessionInfo;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.MatchHistoryImpl;
import com.syfc.service.MatchHistoryService;
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


	private FileManager fileManager = new FileManager();
	
	@PostMapping("profile")
	public ModelAndView profile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		// 프로필 수정
		try {
			PlayerMypageDTO dto = service.findProfile(info.getMemberIdx());
			
			// setMemberIdx : 로그인 세션에서 info 로 가져옴
			// memberIdx, email, birth, profile_photo, tel,
			// zip, addr1, addr2, gender, pref_position
			dto.setMemberIdx(info.getMemberIdx());
			dto.setEmail(req.getParameter("email1") + "@" + req.getParameter("email2"));
			dto.setBirth(req.getParameter("birth"));
			dto.setTel(req.getParameter("tel1") + "-" + req.getParameter("tel2") + "-" + req.getParameter("tel3"));
			dto.setZip(req.getParameter("zip"));
			dto.setAddr1(req.getParameter("addr1"));
			dto.setAddr2(req.getParameter("addr2"));
			dto.setGender(req.getParameter("gender"));
			
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
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/player/mypage");
	}
	
	@GetMapping("mypage")
	public ModelAndView mypage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		PlayerMypageDTO dto = service.findProfile(info.getMemberIdx());
		
		ModelAndView mav = new ModelAndView("player/mypage");
		mav.addObject("dto", dto);
		
		return mav;
	}
	@GetMapping("playerProfile")
	public ModelAndView playerProfile(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		PlayerProfileDTO player = playerService.findPlayer(info.getMemberIdx());
		
		ModelAndView mav = new ModelAndView("player/playerProfile");
		mav.addObject("player", player);
		
		return mav;
	}
	
	@GetMapping("rating")
	public ModelAndView rating(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		return new ModelAndView("player/rating");
	}
	
	@GetMapping("matchHistory")
	public ModelAndView matchHistory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		List<MatchHistoryDTO> list = matchHistoryService.listMatchHistory(info.getMemberIdx());
	
		ModelAndView mav = new ModelAndView("player/matchHistory");
		
		mav.addObject("list", list);
		
		return mav;
	}
	
	@GetMapping("matchApply")
	public ModelAndView matchApply(HttpServletRequest req, HttpServletResponse resp) {
	    return new ModelAndView("player/matchApply");
	}
	
	@GetMapping("club")
	public ModelAndView club(HttpServletRequest req, HttpServletResponse resp) {
	    return new ModelAndView("player/club");
	}
	
	@GetMapping("clubJoin")
	public ModelAndView clubJoin(HttpServletRequest req, HttpServletResponse resp) {
	    return new ModelAndView("player/clubJoin");
	}
	
	@GetMapping("clubOwnerRequest")
	public ModelAndView clubOwnerRequest(HttpServletRequest req, HttpServletResponse resp) {
	    return new ModelAndView("player/clubOwnerRequest");
	}
	
	@GetMapping("clubOwnerRequestHistory")
	public ModelAndView clubOwnerRequestHistory(HttpServletRequest req, HttpServletResponse resp) {
	    return new ModelAndView("player/clubOwnerRequestHistory");
	}
}
