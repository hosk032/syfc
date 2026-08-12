package com.syfc.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.BoardDTO;
import com.syfc.dto.SessionInfo;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.BoardService;
import com.syfc.service.BoardServiceImpl;
import com.syfc.util.MyUtil;
import com.syfc.util.PaginateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/community/board/*")
public class BoardController {
	private BoardService service = new BoardServiceImpl();
	private MyUtil util = new MyUtil();
	private PaginateUtil paginateUtil = new PaginateUtil();

/*
	@GetMapping("boardDetail")
	public ModelAndView boardDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ModelAndView mav = new ModelAndView("community/notices/noticeList");
		String page = req.getParameter("page");
		int current_page = 1;
		
		if(page != null) {
			current_page = Integer.parseInt(page);
		}
		
		String schType = req.getParameter("schType");
		String kwd = req.getParameter("kwd");
		if(schType == null) {
			schType = "all";
			kwd = "";
		}
		 
		kwd = util.decodeUrl(kwd);
		
		int size = 10;
		int total_page = 0;
		int dataCount = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("schType", schType);
		map.put("kwd", kwd);
		
		dataCount = service.dataCount(map);
		
		total_page = paginateUtil.pageCount(dataCount, size);
		current_page = Math.min(current_page, total_page);
		
		int offset = (current_page - 1) * 10;
		if(offset < 0)offset = 0;
		
		map.put("offset", offset);
		map.put("size", size);
		
		// List<BoardDTO> list = service.listBoard(map);
		
		return mav;
	}
*/
	@GetMapping("boardList")
	public ModelAndView boardList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ModelAndView mav = new ModelAndView("community/board/boardList");
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			
			kwd = util.decodeUrl(kwd);
			
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			dataCount = service.dataCount(map);
			
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * 10;
			if(offset < 0)offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<BoardDTO> list = service.listBoard(map);
			
			String query;
			String cp = req.getContextPath();
			String listUrl = cp + "/community/board/boardList";
			String boardDetailUrl = cp + "/community/board/boardDetail"; // 확인할것
			
			if(! kwd.isBlank()) {
				query = "schType=" + schType + "&kwd=" +
						util.encodeUrl(kwd);
				listUrl += "?" + query;
				boardDetailUrl += "&" + query;
			}
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			mav.addObject("list", list);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("page", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("boardDetailUrl", boardDetailUrl);
			mav.addObject("paging", paging);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;

	}
	
	@GetMapping("write")
	public ModelAndView write(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		
		
		return new ModelAndView("community/board/write");
	}
	
	@PostMapping("write")
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			BoardDTO dto = new BoardDTO();
			
			dto.setMemberIdx(info.getMemberIdx());
			
			dto.setB_Subject(req.getParameter("b_subject"));
			dto.setB_Content(req.getParameter("b_content"));
			
			service.insertboard(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return new ModelAndView("redirect:/community/board/boardList");
	}
	
}
