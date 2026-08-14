package com.syfc.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminBoardDTO;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.AdminBoardService;
import com.syfc.service.AdminBoardServiceImpl;
import com.syfc.util.MyUtil;
import com.syfc.util.PaginateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/*
 * =========================================================
 * 관리자 - 자유게시판 관리 Controller
 * =========================================================
 *
 * 자유게시판 목록 조회, 검색, 페이징,
 * 블라인드 / 블라인드 해제 / 삭제를 처리한다.
 */
@Controller
@RequestMapping("/admin/board/*")
public class BoardManageController {
	private AdminBoardService service = new AdminBoardServiceImpl();
	private MyUtil util = new MyUtil();
	private PaginateUtil paginateUtil = new PaginateUtil();

	// 자유게시판 목록
	@GetMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/board/adminBoard");

		try {
			// 페이지
			String page = req.getParameter("page");
			int currentPage = page == null ? 1 : Integer.parseInt(page);

			// 검색
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");

			if(schType == null) {
				schType = "all";
				kwd = "";
			}

			if(kwd == null) {
				kwd = "";
			}

			kwd = util.decodeUrl(kwd);

			int size = 10;

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);

			// 전체 자유게시판 글 개수
			int dataCount = service.dataCount(map);
			int totalPage = paginateUtil.pageCount(dataCount, size);

			if(totalPage > 0) {
				currentPage = Math.min(currentPage, totalPage);
			} else {
				currentPage = 1;
			}

			// 자유게시판 목록
			int offset = (currentPage - 1) * size;
			if(offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			List<AdminBoardDTO> list = service.listBoard(map);

			// 페이징
			String cp = req.getContextPath();
			String query = "";

			if(! kwd.isBlank()) {
				query = "schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}

			String listUrl = cp + "/admin/board/list";

			if(! query.isBlank()) {
				listUrl += "?" + query;
			}

			String paging = paginateUtil.paging(currentPage, totalPage, listUrl);

			/*
			 * 공지사항도 같은 adminBoard.jsp를 사용하므로
			 * 자유게시판 값은 board 접두어를 붙여 구분한다.
			 */
			mav.addObject("boardList", list);
			mav.addObject("boardDataCount", dataCount);
			mav.addObject("boardSize", size);
			mav.addObject("boardPage", currentPage);
			mav.addObject("boardTotalPage", totalPage);
			mav.addObject("boardPaging", paging);
			mav.addObject("boardSchType", schType);
			mav.addObject("boardKwd", kwd);
			mav.addObject("activeTab", "freeboard");

		} catch(Exception e) {
			e.printStackTrace();
		}

		return mav;
	}

	/*
	 * 블라인드 / 블라인드 해제
	 * block = 1 : 블라인드
	 * block = 0 : 정상
	 */
	@PostMapping("block")
	public ModelAndView block(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			long num = Long.parseLong(req.getParameter("num"));
			int block = Integer.parseInt(req.getParameter("block"));

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("num", num);
			map.put("block", block);

			service.updateBlock(map);

		} catch(Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/board/list");
	}

	// 자유게시판 글 실제 삭제
	@PostMapping("delete")
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			long num = Long.parseLong(req.getParameter("num"));

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("num", num);

			service.deleteBoard(map);

		} catch(Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/admin/board/list");
	}
}
