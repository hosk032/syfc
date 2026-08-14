package com.syfc.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminNoticeDTO;
import com.syfc.dto.SessionInfo;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.AdminNoticeService;
import com.syfc.service.AdminNoticeServiceImpl;
import com.syfc.util.MyUtil;
import com.syfc.util.PaginateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/*
 * =========================================================
 * 관리자 - 공지사항 관리 Controller
 * =========================================================
 *
 * ★ board.b_Type
 * 0 : 자유게시판
 * 1 : 공지사항
 *
 * 관리자에서 작성하는 공지사항은 항상 b_Type = 1
 */
@Controller
@RequestMapping("/admin/notice/*")
public class NoticeManageController {

	private AdminNoticeService service = new AdminNoticeServiceImpl();
	private MyUtil util = new MyUtil();
	private PaginateUtil paginateUtil = new PaginateUtil();

	// =========================================================
	// 공지사항 목록
	// =========================================================
	@GetMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/board/adminBoard");

		try {
			String page = req.getParameter("page");
			int currentPage = page == null ? 1 : Integer.parseInt(page);

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

			int size = 10;

			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);

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

			// ★ b_Type = 1인 공지사항만 조회
			List<AdminNoticeDTO> list = service.listNotice(map);

			String cp = req.getContextPath();
			String query = "";

			if (!kwd.isBlank()) {
				query = "schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}

			String listUrl = cp + "/admin/notice/list";

			if (!query.isBlank()) {
				listUrl += "?" + query;
			}

			String paging = paginateUtil.paging(currentPage, totalPage, listUrl);

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

	// =========================================================
	// 공지사항 등록 화면
	// =========================================================
	@GetMapping("write")
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/notice/write");
		mav.addObject("mode", "write");

		return mav;
	}

	// =========================================================
	// 공지사항 등록 처리
	// =========================================================
	@PostMapping("write")
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			return new ModelAndView("redirect:/member/login");
		}

		try {
			AdminNoticeDTO dto = new AdminNoticeDTO();

			dto.setMemberIdx(info.getMemberIdx());

			/*
			 * ★ 관리자 공지사항은 항상 b_Type = 1
			 * 상단고정 체크박스와 type을 연결하지 않는다.
			 */
			dto.setType(1);

			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setHitCount(0);
			dto.setBlock(0);

			service.insertNotice(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/notice/list");
	}

	// =========================================================
	// 상세보기
	// =========================================================
	@GetMapping("article")
	public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String page = req.getParameter("page");

		try {
			long bNum = Long.parseLong(req.getParameter("num"));

			service.updateHitCount(bNum);

			AdminNoticeDTO dto = service.findById(bNum);

			if (dto == null) {
				return new ModelAndView("redirect:/admin/notice/list");
			}

			Map<String, Object> map = new HashMap<>();
			map.put("num", bNum);

			AdminNoticeDTO prevDto = service.findByPrev(map);
			AdminNoticeDTO nextDto = service.findByNext(map);

			ModelAndView mav = new ModelAndView("admin/notice/article");

			mav.addObject("dto", dto);
			mav.addObject("prevDto", prevDto);
			mav.addObject("nextDto", nextDto);
			mav.addObject("page", page);

			return mav;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/notice/list");
	}

	// =========================================================
	// 공지사항 수정 화면
	// =========================================================
	@GetMapping("update")
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String page = req.getParameter("page");

		try {
			long bNum = Long.parseLong(req.getParameter("num"));

			AdminNoticeDTO dto = service.findById(bNum);

			if (dto == null) {
				return new ModelAndView("redirect:/admin/notice/list");
			}

			ModelAndView mav = new ModelAndView("admin/notice/write");

			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("mode", "update");

			return mav;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/notice/list");
	}

	// =========================================================
	// 공지사항 수정 처리
	// =========================================================
	@PostMapping("update")
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String page = req.getParameter("page");

		try {
			AdminNoticeDTO dto = new AdminNoticeDTO();

			dto.setNum(Long.parseLong(req.getParameter("num")));

			// ★ 수정해도 계속 공지사항이므로 b_Type = 1
			dto.setType(1);

			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));

			service.updateNotice(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/notice/list?page=" + (page == null ? "1" : page));
	}

	// =========================================================
	// 공지사항 삭제
	// =========================================================
	@GetMapping("delete")
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			long bNum = Long.parseLong(req.getParameter("num"));

			// ★ 공지사항은 DB에서 실제 삭제
			service.deleteNotice(bNum);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/notice/list");
	}
}