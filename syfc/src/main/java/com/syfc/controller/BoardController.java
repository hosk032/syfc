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

	// 게시판
	@GetMapping("boardList")
	public ModelAndView boardList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ModelAndView mav = new ModelAndView("community/board/boardList");
		
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
			
			// 전체 데이터 개수
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
			String boardDetailUrl = cp + "/community/board/boardDetail?page=" + current_page;
			
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
	
	// 글 작성 보기
	@GetMapping("write")
	public ModelAndView write(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ModelAndView mav = new ModelAndView("community/board/write");
		 
		mav.addObject("mode", "write"); 
		 
		return mav;
		
		
	}
	
	// 글 작성완료
	@PostMapping("write")
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			BoardDTO dto = new BoardDTO();
			
			dto.setMemberIdx(info.getMemberIdx());
			
			dto.setB_subject(req.getParameter("b_subject"));
			dto.setB_content(req.getParameter("b_content"));
			
			service.insertboard(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return new ModelAndView("redirect:/community/board/boardList");
	}
	
	@GetMapping("boardDetail")
	public ModelAndView boardDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String page = req.getParameter("page");
	
		String query = "page=" + page;
		
		try {
			long bnum = Long.parseLong(req.getParameter("bnum"));
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
			
			// 조회수 증가
			service.updateHitCount(bnum);
			
			// 게시글 가져오기
			BoardDTO dto = service.findById(bnum);
			if(dto == null) {
				return new ModelAndView("redirect:/community/board/boardList?" + query);
			}
			dto.setB_content(util.htmlSymbols(dto.getB_content()));
			
			// 이전글 / 다음글
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("bnum", bnum);
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			BoardDTO prevDto = service.findByPrev(map);
			BoardDTO nextDto = service.findByNext(map);
			
			// 로그인 유저의 게시글 공감 여부
			map.put("memberIdx", info.getMemberIdx());
			boolean isUserLiked = service.isUserBoardLiked(map);
			
			ModelAndView mav = new ModelAndView("community/board/boardDetail");
			
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("query", query);
			mav.addObject("prevDto", prevDto);
			mav.addObject("nextDto", nextDto);
			
			mav.addObject("isUserLiked", isUserLiked);
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
			return new ModelAndView("redirect:/community/board/boardList?" + query);
	}
	
	
	// 글 수정
	@GetMapping("update")
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String page = req.getParameter("page");
		
		try {
			long bnum = Long.parseLong(req.getParameter("bnum"));
			BoardDTO dto = service.findById(bnum);
			
			// 게시글이 없으면
			if(dto == null) {
				return new ModelAndView("redirect:/community/board/boardList=" + page);
			}
			
			
			// 게시글을 올린 사람이 아닌 경우
			if(dto.getMemberIdx() != info.getMemberIdx()) {
				return new ModelAndView("redirect:/community/board/boardList=" + page);
			}
			
			ModelAndView mav = new ModelAndView("community/board/write");
			
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("mode", "update");
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return new ModelAndView("redirect:/community/board/boardList?page=" + page);
	}
	
	// 글 수정완료
	@PostMapping("update")
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String page = req.getParameter("page");
		try {
			BoardDTO dto = new BoardDTO();
			
			dto.setBnum(Long.parseLong(req.getParameter("bnum")));
			dto.setB_subject(req.getParameter("b_subject"));
			dto.setB_content(req.getParameter("b_content"));
			
			// 개발자 도구에서 수정하지 못하게 회원번호 막기
			dto.setMemberIdx(info.getMemberIdx());
			
			service.upadteboard(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return new ModelAndView("redirect:/community/board/boardList?page=" + page);
	}
	
	// 글 삭제
	@GetMapping("delete")
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			long bnum = Long.parseLong(req.getParameter("bnum"));
			
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
			map.put("bnum", bnum);
			map.put("memberIdx", info.getMemberIdx());
			map.put("userLevel", info.getUserLevel());
			
			service.deleteboard(map);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/community/board/boardList?" + query);
	}
		
	
}
