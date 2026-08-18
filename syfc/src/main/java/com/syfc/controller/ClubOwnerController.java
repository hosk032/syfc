package com.syfc.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.syfc.dto.ClubDTO;
import com.syfc.dto.ClubOwnerMatchDTO;
import com.syfc.dto.SessionInfo;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.ClubOwnerMatchService;
import com.syfc.service.ClubOwnerMatchServiceImpl;
import com.syfc.service.ClubOwnerService;
import com.syfc.service.ClubOwnerServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
@RequestMapping("/clubowner/*")
public class ClubOwnerController {

	private ClubOwnerService service = new ClubOwnerServiceImpl();
	private ClubOwnerMatchService matchService = new ClubOwnerMatchServiceImpl();

	// 구단주 메인 페이지
	@GetMapping("ownerpage")
	public ModelAndView ownerPage(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException {

	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo) session.getAttribute("member");

	    if (info == null) {
	        return new ModelAndView("redirect:/member/login");
	    }

	    try {
	        ClubDTO clubDto = service.selectClubInfoByMemberIdx(info.getMemberIdx());
	        req.setAttribute("club", clubDto);

	        if (clubDto != null) {
	            List<ClubOwnerMatchDTO> matchList = matchService.getClubMatchList(clubDto.getClubOwner_key());
	            req.setAttribute("matchList", matchList);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return new ModelAndView("clubowner/ownerpage");
	}

	// 경기 이력 검색 (AJAX)
	@GetMapping("searchMatchHistory")
	public ModelAndView searchMatchHistory(HttpServletRequest req, HttpServletResponse resp) 
	        throws ServletException, IOException {

	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo) session.getAttribute("member");

	    if (info == null) {
	        return new ModelAndView("redirect:/member/login");
	    }

	    try {
	        ClubDTO clubDto = service.selectClubInfoByMemberIdx(info.getMemberIdx());
	        
	        if (clubDto != null) {
	            String year = req.getParameter("year");
	            String month = req.getParameter("month");
	            String result = req.getParameter("result");

	            Map<String, Object> map = new HashMap<>();
	            map.put("clubOwnerKey", clubDto.getClubOwner_key());
	            map.put("year", year);
	            map.put("month", month);
	            map.put("result", result);

	            List<ClubOwnerMatchDTO> matchList = matchService.getClubMatchListByMap(map);
	            req.setAttribute("matchList", matchList);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return new ModelAndView("clubowner/tab/matchHistoryTable");
	}

	// 구단 정보 수정
	@PostMapping("update")
	public ModelAndView updateClubInfo(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			return new ModelAndView("redirect:/member/login");
		}

		try {
			ClubDTO dto = new ClubDTO();
			dto.setClubOwner_key(Long.parseLong(req.getParameter("clubOwner_key")));
			dto.setClub_name(req.getParameter("club_name"));
			dto.setClub_region(req.getParameter("club_region"));
			dto.setClub_created(req.getParameter("club_created"));
			dto.setClub_content(req.getParameter("club_content"));

			Part filePart = req.getPart("uploadLogo");
			if (filePart != null && filePart.getSize() > 0) {
				String originalFilename = getOriginalFilename(filePart);
				
				if (originalFilename != null && !originalFilename.isEmpty()) {
					String root = session.getServletContext().getRealPath("/");
					String pathname = root + "uploads" + File.separator + "club";
					
					File dir = new File(pathname);
					if (!dir.exists()) {
						dir.mkdirs();
					}

					String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
					String saveFilename = UUID.randomUUID().toString() + ext;

					filePart.write(pathname + File.separator + saveFilename);

					dto.setClub_logo(saveFilename);
				}
			}

			service.updateClubInfo(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/clubowner/ownerpage");
	}

	private String getOriginalFilename(Part part) {
		String contentDisp = part.getHeader("content-disposition");
		for (String token : contentDisp.split(";")) {
			if (token.trim().startsWith("filename")) {
				return token.substring(token.indexOf("=") + 2, token.length() - 1);
			}
		}
		return null;
	}
}