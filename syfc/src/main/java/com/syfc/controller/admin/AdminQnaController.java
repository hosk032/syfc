package com.syfc.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminQnaDTO;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.AdminQnaService;
import com.syfc.service.AdminQnaServiceImpl;
import com.syfc.util.MyUtil;
import com.syfc.util.PaginateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/admin/qna/*")
public class AdminQnaController {
	private AdminQnaService service = new AdminQnaServiceImpl();
	private MyUtil util = new MyUtil();
	private PaginateUtil paginateUtil = new PaginateUtil();
	
	// 문의/신고 목록
	@GetMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ModelAndView mav = new ModelAndView("admin/board/adminBoard");
		
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
			
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			
			if(kwd == null) {
				kwd = "";
			}
			
			kwd = util.decodeUrl(kwd);
			
			// 한 페이지에 출력할 글 개수
			int size = 10;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			// 전체 글 개수
			int dataCount = service.dataCount(map);
			int totalPage = paginateUtil.pageCount(dataCount, size);
			
			if(totalPage > 0) {
				currentPage = Math.min(currentPage, totalPage);
			} else {
				currentPage = 1;
			}
			
			// 문의/신고 목록
			int offset = (currentPage - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<AdminQnaDTO> list = service.listQna(map);
			
			// 페이징
			String cp = req.getContextPath();
			String query = "";
			
			if(!kwd.isBlank()) {
				query = "schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			
			String listUrl = cp + "/admin/qna/list";
			
			if(!query.isBlank()) {
				listUrl += "?" + query;
			}
			
			String paging = paginateUtil.paging(currentPage, totalPage, listUrl);
			
			// JSP로 전달
			mav.addObject("qnaList", list);
			mav.addObject("qnaDataCount", dataCount);
			mav.addObject("qnaSize", size);
			mav.addObject("qnaPage", currentPage);
			mav.addObject("qnaTotalPage", totalPage);
			mav.addObject("qnaPaging", paging);
			mav.addObject("qnaSchType", schType);
			mav.addObject("qnaKwd", kwd);
			mav.addObject("activeTab", "qna");	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	// 관리자 답변 등록
	@PostMapping("answer")
	public ModelAndView answer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			AdminQnaDTO dto = new AdminQnaDTO();
			
			dto.setQnaNum(Long.parseLong(req.getParameter("qnaNum")));
			dto.setAnswer(req.getParameter("answer"));
			
			service.updateAnswer(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/admin/qna/list");
	}
	
	// 문의/신고 글 삭제
	@PostMapping("delete")
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			long qnaNum = Long.parseLong(req.getParameter("qnaNum"));
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("qnaNum", qnaNum);
			
			service.deleteQna(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/admin/qna/list"); 
	}
}
