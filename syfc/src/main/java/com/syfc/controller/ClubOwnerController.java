package com.syfc.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import com.syfc.dto.ClubDTO;
import com.syfc.dto.SessionInfo;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
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

	// 1. 구단주 마이페이지 이동 (GET: /clubowner/ownerpage)
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
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("clubowner/ownerpage");
	}

	// 2. 구단 정보 수정 처리 (POST: /clubowner/update)
	@PostMapping("update")
	public ModelAndView updateClubInfo(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			return new ModelAndView("redirect:/member/login");
		}

		try {
			// request에서 텍스트 파라미터 수집 (Servlet 표준 Part 방식 처리 시 general parameter 사용 가능)
			ClubDTO dto = new ClubDTO();
			dto.setClubOwner_key(Long.parseLong(req.getParameter("clubOwner_key")));
			dto.setClub_name(req.getParameter("club_name"));
			dto.setClub_region(req.getParameter("club_region"));
			dto.setClub_created(req.getParameter("club_created"));
			dto.setClub_content(req.getParameter("club_content"));

			// 파일 업로드 처리 (Part 객체 추출)
			Part filePart = req.getPart("uploadLogo");
			if (filePart != null && filePart.getSize() > 0) {
				// 원본 파일명 추출
				String originalFilename = getOriginalFilename(filePart);
				
				if (originalFilename != null && !originalFilename.isEmpty()) {
					// 저장 폴더 생성 (webapp/uploads/club)
					String root = session.getServletContext().getRealPath("/");
					String pathname = root + "uploads" + File.separator + "club";
					
					File dir = new File(pathname);
					if (!dir.exists()) {
						dir.mkdirs();
					}

					// 파일명 중복 방지 (UUID 적용)
					String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
					String saveFilename = UUID.randomUUID().toString() + ext;

					// 파일 저장
					filePart.write(pathname + File.separator + saveFilename);

					// DTO에 파일명 세팅
					dto.setClub_logo(saveFilename);
				}
			}

			// DB 수정 처리
			service.updateClubInfo(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/clubowner/ownerpage");
	}

	// Part에서 원본 파일명을 추출하는 헬퍼 메서드
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