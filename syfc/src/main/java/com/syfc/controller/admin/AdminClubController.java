package com.syfc.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminClubDTO;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.AdminClubService;
import com.syfc.service.AdminClubServiceImpl;
import com.syfc.util.MyUtil;
import com.syfc.util.PaginateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/admin/clubstatus/*")
public class AdminClubController {
	private AdminClubService service = new AdminClubServiceImpl();
	private MyUtil util = new MyUtil();
	private PaginateUtil paginateUtil = new PaginateUtil();

	// =========================================================
	// 구단 정지 관리 목록
	// =========================================================
	@GetMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		ModelAndView mav = new ModelAndView("admin/club/list");

		try {
			// 페이지
			String page = req.getParameter("page");
			int currentPage = 1;

			if(page != null) {
				currentPage = Integer.parseInt(page);
			}

			// 검색
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			String status = req.getParameter("status");

			if(schType == null) {
				schType = "all";
			}

			if(kwd == null) {
				kwd = "";
			}

			if(status == null) {
				status = "all";
			}

			kwd = util.decodeUrl(kwd);

			/*
			 * 구단 상태
			 * 1 : 운영
			 * 0 : 정지
			 * null : 전체
			 */
			Integer clubStatus = null;

			if("0".equals(status) || "1".equals(status)) {
				clubStatus = Integer.parseInt(status);
			}

			// 한 페이지에 10개
			int size = 10;

			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("clubStatus", clubStatus);

			// 전체 구단 수
			int dataCount = service.dataCount(map);
			int totalPage = paginateUtil.pageCount(dataCount, size);

			if(totalPage > 0) {
				currentPage = Math.min(currentPage, totalPage);
			} else {
				currentPage = 1;
			}

			// 목록
			int offset = (currentPage - 1) * size;

			if(offset < 0) {
				offset = 0;
			}

			map.put("offset", offset);
			map.put("size", size);

			List<AdminClubDTO> list = service.listClub(map);

			// 페이징
			String cp = req.getContextPath();
			String listUrl = cp + "/admin/clubstatus/list";
			String query = "status=" + status;

			if(!kwd.isBlank()) {
				query += "&schType=" + schType
						+ "&kwd=" + util.encodeUrl(kwd);
			}

			listUrl += "?" + query;

			String paging = paginateUtil.paging(
					currentPage, totalPage, listUrl);

			// JSP에 전달
			mav.addObject("clubList", list);
			mav.addObject("clubDataCount", dataCount);
			mav.addObject("clubSize", size);
			mav.addObject("clubPage", currentPage);
			mav.addObject("clubTotalPage", totalPage);
			mav.addObject("clubPaging", paging);
			mav.addObject("clubSchType", schType);
			mav.addObject("clubKwd", kwd);
			mav.addObject("clubStatus", status);

			// 구단 정지 관리 탭 활성화
			mav.addObject("activeTab", "status");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}


	// =========================================================
	// 구단 정지 / 활성화
	// =========================================================
	@PostMapping("update")
	public ModelAndView updateStatus(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		try {
			long clubOwnerKey =
					Long.parseLong(req.getParameter("clubOwnerKey"));

			int clubStatus =
					Integer.parseInt(req.getParameter("clubStatus"));

			service.updateClubStatus(clubOwnerKey, clubStatus);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView(
				"redirect:/admin/clubstatus/list");
	}
}