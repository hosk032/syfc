package com.syfc.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminMemberDTO;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.AdminMemberService;
import com.syfc.service.AdminMemberServiceImpl;
import com.syfc.util.MyUtil;
import com.syfc.util.PaginateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/*
 * =========================================================
 * 관리자 - 회원 관리 Controller
 * =========================================================
 *
 * 회원 목록 조회, 회원 등급 변경,
 * 회원 정지 및 정지 해제를 처리한다.
 */
@Controller
@RequestMapping("/admin/member/*")
public class MemberManageController {
	private AdminMemberService service = new AdminMemberServiceImpl();
	private MyUtil util = new MyUtil();
	private PaginateUtil paginateUtil = new PaginateUtil();

	// 회원 목록
	@GetMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/member/list");

		try {
			// 현재 페이지
			String page = req.getParameter("page");
			int currentPage = page == null ? 1 : Integer.parseInt(page);

			// 검색조건
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");

			if (schType == null) {
				schType = "all";
				kwd = "";
			}

			if (kwd == null) {
				kwd = "";
			}

			kwd = util.decodeUrl(kwd);

			// 한 페이지에 출력할 회원 수
			int size = 10;

			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);

			// 전체 회원 수와 페이지 수
			int dataCount = service.dataCount(map);
			int totalPage = paginateUtil.pageCount(dataCount, size);

			if (totalPage > 0) {
				currentPage = Math.min(currentPage, totalPage);
			} else {
				currentPage = 1;
			}

			// DB에서 가져올 시작 위치
			int offset = (currentPage - 1) * size;
			if (offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			// 회원 목록
			List<AdminMemberDTO> list = service.listMember(map);

			// 페이징
			String cp = req.getContextPath();
			String listUrl = cp + "/admin/member/list";
			String query = "";

			if (!kwd.isBlank()) {
				query = "schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
				listUrl += "?" + query;
			}

			String paging = paginateUtil.paging(currentPage, totalPage, listUrl);

			// JSP에 전달
			mav.addObject("list", list);
			mav.addObject("dataCount", dataCount);
			mav.addObject("page", currentPage);
			mav.addObject("totalPage", totalPage);
			mav.addObject("paging", paging);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	/*
	 * 회원 등급 변경
	 *
	 * 1   : 일반회원
	 * 10  : 선수
	 * 50  : 구단주
	 * 100 : 관리자
	 *
	 * 관리자 화면에서는 일반회원(1)과 구단주(50)만 변경한다.
	 */
	@PostMapping("level")
	public ModelAndView updateLevel(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String page = req.getParameter("page");

		try {
			long memberIdx = Long.parseLong(req.getParameter("memberIdx"));
			int userLevel = Integer.parseInt(req.getParameter("userLevel"));

			// 일반회원 또는 구단주만 변경 가능
			if (userLevel != 1 && userLevel != 50) {
				return new ModelAndView("redirect:/admin/member/list");
			}

			Map<String, Object> map = new HashMap<>();
			map.put("memberIdx", memberIdx);
			map.put("userLevel", userLevel);

			service.updateMemberLevel(map);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/member/list?page=" + (page == null ? "1" : page));
	}

	/*
	 * 회원 상태 변경
	 *
	 * status = 1 : 이용가능
	 * status = 2 : 정지
	 * status = 0 : 탈퇴
	 *
	 * 관리자 화면에서는 1과 2 사이에서만 변경한다.
	 */
	@PostMapping("status")
	public ModelAndView updateStatus(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String page = req.getParameter("page");

		try {
			long memberIdx = Long.parseLong(req.getParameter("memberIdx"));
			int status = Integer.parseInt(req.getParameter("status"));

			if (status != 1 && status != 2) {
				return new ModelAndView("redirect:/admin/member/list");
			}

			Map<String, Object> map = new HashMap<>();
			map.put("memberIdx", memberIdx);
			map.put("status", status);

			service.updateMemberStatus(map);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/member/list?page=" + (page == null ? "1" : page));
	}
}