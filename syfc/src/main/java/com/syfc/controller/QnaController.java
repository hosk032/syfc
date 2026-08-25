package com.syfc.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.QnaDTO;
import com.syfc.dto.SessionInfo;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.QnaService;
import com.syfc.service.QnaServiceImpl;
import com.syfc.util.MyUtil;
import com.syfc.util.PaginateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/community/qna/*")
public class QnaController {
	private QnaService service = new QnaServiceImpl();
	private MyUtil util = new MyUtil();
	private PaginateUtil paginateUtil = new PaginateUtil();
	
	// 문의/신고 게시판
	@GetMapping("qnaList")
	public ModelAndView qnaList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ModelAndView mav = new ModelAndView("community/qna/qnaList");
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			// 페이지
			String page = req.getParameter("page");
			int current_page = 1;
			
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			// 검색
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			
			// 디코딩
			kwd = util.decodeUrl(kwd);
			
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("memberIdx", info.getMemberIdx());
			map.put("userLevel", info.getUserLevel());
			
			dataCount = service.dataCount(map);
			
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0)offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<QnaDTO> list = service.listQna(map);
			
			String query = "";
			String cp = req.getContextPath();
			String listUrl = cp + "/community/qna/qnaList";
			String qnaDetailUrl = cp + "/community/qna/qnaDetail?page=" + current_page;
			
			if(! kwd.isBlank()) {
				query = "schType=" + schType + "&kwd=" +
						util.encodeUrl(kwd);
				listUrl += "?" + query;
				qnaDetailUrl += "&" + query;
			}
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			mav.addObject("list", list);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("page", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("qnaDetailUrl", qnaDetailUrl);
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
		
		ModelAndView mav = new ModelAndView("community/qna/write");
		 
		mav.addObject("mode", "write"); 
		 
		return mav;
		
		
	}
	
	@PostMapping("write")
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
	
		try {
			QnaDTO dto = new QnaDTO();
			
			dto.setMemberIdx(info.getMemberIdx());
			
			dto.setQ_title(req.getParameter("q_title"));
			dto.setQ_question(req.getParameter("q_question"));
			dto.setQ_type(Integer.parseInt(req.getParameter("q_type")));
			
			service.insertQna(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/community/qna/qnaList");
		
	}
	
	@GetMapping("qnaDetail")
	public ModelAndView qnaDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			long qna_num = Long.parseLong(req.getParameter("qna_num"));
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);
			
			if(! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			
			QnaDTO dto = service.findById(qna_num);
			if(dto == null) {
				return new ModelAndView("redirect:/community/qna/qnaList?" + query);
			}
			
			ModelAndView mav = new ModelAndView("community/qna/qnaDetail");
			
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("query", query);
			
			return mav;
			
			} catch (Exception e) {
				e.printStackTrace();
			}
		
			return new ModelAndView("redirect:/community/qna/qnaList?" + page);
		}
	
	@GetMapping("update")
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String page = req.getParameter("page");
		
		try {
			long qna_num = Long.parseLong(req.getParameter("qna_num"));
			QnaDTO dto =service.findById(qna_num);
			
			// 게시글이 없으면
			if(dto == null) {
				return new ModelAndView("redirect:/community/qna/qnaList=" + page);
			}
			
			// 게시글을 올린 사람이 아닌 경우
			if(dto.getMemberIdx() != info.getMemberIdx()) {
				return new ModelAndView("redirect:/community/qna/qnaList=" + page);
			}
			
			ModelAndView mav = new ModelAndView("community/qna/write");
			
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("mode", "update");
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/community/qna/qnaList?page=" + page);
	}
	
	
	
	@PostMapping("update")
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String page = req.getParameter("page");
		try {
			QnaDTO dto = new QnaDTO();
			
			dto.setQna_num(Long.parseLong(req.getParameter("qna_num")));
			dto.setQ_title(req.getParameter("q_title"));
			dto.setQ_question(req.getParameter("q_question"));
			dto.setQ_type(Integer.parseInt(req.getParameter("q_type")));
			
			// 개발자 도구에서 수정하지 못하게 회원번호 막기
			dto.setMemberIdx(info.getMemberIdx());
			
			service.updateQna(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return new ModelAndView("redirect:/community/qna/qnaList?page=" + page);
	}
	
	// 글 삭제
	@GetMapping("delete")
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			long qna_num = Long.parseLong(req.getParameter("qna_num"));
			
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			
			kwd = util.decodeUrl(kwd);
			
			if(! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" 
						+ util.encodeUrl(kwd);
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("qna_num", qna_num);
			map.put("memberIdx", info.getMemberIdx());
			map.put("userLevel", info.getUserLevel());
			
			service.deleteQna(map);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/community/qna/qnaList?" + query);
	}
	
}
