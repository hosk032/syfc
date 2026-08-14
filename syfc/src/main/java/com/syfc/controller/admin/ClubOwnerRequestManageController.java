package com.syfc.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminClubOwnerRequestDTO;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.AdminClubOwnerRequestService;
import com.syfc.service.AdminClubOwnerRequestServiceImpl;
import com.syfc.util.MyUtil;
import com.syfc.util.PaginateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/*
 * =========================================================
 * 관리자 - 구단주 신청 관리 Controller
 * =========================================================
 *
 * /admin/clubowner/* 주소로 들어오는 요청을 처리한다.
 *
 * list    : 구단주 신청 목록
 * approve : 구단주 신청 승인
 * reject  : 구단주 신청 반려
 */
@Controller
@RequestMapping("/admin/clubowner/*")
public class ClubOwnerRequestManageController {
	private AdminClubOwnerRequestService service = new AdminClubOwnerRequestServiceImpl();
	private MyUtil util = new MyUtil();
	private PaginateUtil paginateUtil = new PaginateUtil();

	// 구단주 신청 목록
	@GetMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/clubowner/list");

		try {
			// 현재 페이지
			String page = req.getParameter("page");
			int currentPage = page == null ? 1 : Integer.parseInt(page);

			// 검색조건 / 검색어 / 신청상태
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			String status = req.getParameter("status");

			if (schType == null) schType = "all";
			if (kwd == null) kwd = "";
			if (status == null) status = "all";

			kwd = util.decodeUrl(kwd);

			/*
			 * 신청상태
			 * 2 : 대기
			 * 1 : 승인
			 * 0 : 반려
			 * null : 전체
			 */
			Integer requestStatus = null;

			if ("0".equals(status) || "1".equals(status) || "2".equals(status)) {
				requestStatus = Integer.parseInt(status);
			}

			// 한 페이지에 출력할 신청 수
			int size = 10;

			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("requestStatus", requestStatus);

			// 전체 신청 개수와 페이지 수
			int dataCount = service.dataCount(map);
			int totalPage = paginateUtil.pageCount(dataCount, size);

			if (totalPage > 0) {
				currentPage = Math.min(currentPage, totalPage);
			} else {
				currentPage = 1;
			}

			int offset = (currentPage - 1) * size;
			if (offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			// ★ 조건에 맞는 구단주 신청 목록
			List<AdminClubOwnerRequestDTO> list = service.listRequest(map);

			// 페이징
			String cp = req.getContextPath();
			String listUrl = cp + "/admin/clubowner/list";
			String query = "status=" + status;

			if (!kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}

			listUrl += "?" + query;

			String paging = paginateUtil.paging(currentPage, totalPage, listUrl);

			mav.addObject("list", list);
			mav.addObject("dataCount", dataCount);
			mav.addObject("page", currentPage);
			mav.addObject("totalPage", totalPage);
			mav.addObject("paging", paging);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);
			mav.addObject("status", status);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	// 구단주 신청 승인
	@PostMapping("approve")
	public ModelAndView approve(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String page = req.getParameter("page");

		try {
			long requestNum = Long.parseLong(req.getParameter("requestNum"));

			// ★ 승인 + 회원등급 변경 + 구단주 등록
			service.approveRequest(requestNum);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/clubowner/list?page=" + (page == null ? "1" : page));
	}

	// 구단주 신청 반려
	@PostMapping("reject")
	public ModelAndView reject(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String page = req.getParameter("page");

		try {
			long requestNum = Long.parseLong(req.getParameter("requestNum"));

			// ★ 신청 상태를 반려(0)로 변경
			service.rejectRequest(requestNum);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/clubowner/list?page=" + (page == null ? "1" : page));
	}
}