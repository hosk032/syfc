package com.syfc.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.BoardDTO;
import com.syfc.dto.SessionInfo;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.annotation.ResponseBody;
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
@RequestMapping("/community/notify/*")
public class NoticeController {
	private BoardService service = new BoardServiceImpl();
	private MyUtil util = new MyUtil();
	private PaginateUtil paginateUtil = new PaginateUtil();

	// 게시판
	@GetMapping("noticeList")
	public ModelAndView noticeList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ModelAndView mav = new ModelAndView("community/notify/noticeList");
		
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
			map.put("b_type", 1);
			
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
			String listUrl = cp + "/community/notify/noticeList";
			String noticeDetailUrl = cp + "/community/notify/noticeDetail?page=" + current_page;
			
			if(! kwd.isBlank()) {
				query = "schType=" + schType + "&kwd=" +
						util.encodeUrl(kwd);
				listUrl += "?" + query;
				noticeDetailUrl += "&" + query;
			}
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			mav.addObject("list", list);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("page", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("noticeDetailUrl", noticeDetailUrl);
			mav.addObject("paging", paging);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;

	}
	
	@GetMapping("noticeDetail")
	public ModelAndView noticeDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
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
				return new ModelAndView("redirect:/community/notify/noticeList?" + query);
			}
			dto.setB_content(util.htmlSymbols(dto.getB_content()));
			
			// 이전글 / 다음글
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("bnum", bnum);
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("b_type", 1);
			
			BoardDTO prevDto = service.findByPrev(map);
			BoardDTO nextDto = service.findByNext(map);
			
			// 로그인 유저의 게시글 공감 여부
			map.put("memberIdx", info.getMemberIdx());
			boolean isUserLiked = service.isUserBoardLiked(map);
			
			ModelAndView mav = new ModelAndView("community/notify/noticeDetail");
			
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
			return new ModelAndView("redirect:/community/notify/noticeList?" + query);
	}
	
		
	// 게시글 공감 저장 - AJAX : JSON
		@ResponseBody // Map 타입의 리턴값을 JSON 형식으로 변환하여 반환
		@PostMapping("insertBoardLike")
		public Map<String, Object> insertBoardLike(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			Map<String, Object> model = new HashMap<>();
			
			// 넘어온 파라미터 : 글번호, 공감/공감취소여부
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			
			String state = "false";
			int boardLikeCount = 0;
			
			try {
				long bnum = Long.parseLong(req.getParameter("bnum"));
				String userLiked = req.getParameter("userLiked");
				
				Map<String, Object> map = new HashMap<>();
				map.put("bnum", bnum);
				map.put("memberIdx", info.getMemberIdx()); // 회원 번호 사용
				
				if(userLiked.equals("true")) {
					service.deleteBoardLike(map); // 공감 취소
				} else {
					service.insertBoardLike(map); // 공감
				}
				
				boardLikeCount = service.boardLikeCount(bnum);
				
				state = "true";
				
			} catch (SQLException e) {
				// 중복 공감 등으로 에러가 발생할 경우 'liked' 상태 반환
				state = "liked";
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			model.put("state", state);
			model.put("boardLikeCount", boardLikeCount);
			
			return model;
		}
	
}
