package com.syfc.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminClubRequestDTO;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.AdminClubRequestService;
import com.syfc.service.AdminClubRequestServiceImpl;
import com.syfc.util.MyUtil;
import com.syfc.util.PaginateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/admin/club/*")
public class AdminClubRequestController {
	private AdminClubRequestService service = new AdminClubRequestServiceImpl();
	private MyUtil util = new MyUtil();
	private PaginateUtil paginateUtil = new PaginateUtil();
	
	// =========================================================
	// 구단 창설 신청 목록
	// =========================================================
	@GetMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/club/list");
		
		try {
			String page = req.getParameter("page");
			int currentPage = page == null ? 1 : Integer.parseInt(page);
			
			// 검색
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			
			if(schType == null) schType = "all";
			if(kwd == null) kwd = "";
			
			kwd = util.decodeUrl(kwd);
			
			// 신청상태
			// 2 : 대기 / 1 : 승인 / 0 : 거절
			String status = req.getParameter("status");
			Integer requestStatus = 2;
			
			if(status != null && !status.isBlank()) {
				try {
					requestStatus = Integer.parseInt(status);
				} catch (Exception e) {
					requestStatus = 2;
				}
			}
			
			// 한 페이지에 10개
			int size = 10;
			
			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			map.put("requestStatus", requestStatus);
			
			// 전체 개수 / 페이지 수
			int dataCount = service.dataCount(map);
			int totalPage = paginateUtil.pageCount(dataCount, size);
			
			if(totalPage > 0) {
				currentPage = Math.min(currentPage, totalPage);
			} else {
				currentPage = 1;
			}
			
			// 목록
			int offset = (currentPage - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<AdminClubRequestDTO> list = service.listRequest(map);
			
			// 페이징
			String cp = req.getContextPath();
			String query = "status=" + requestStatus;
			
			if(!kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			
			String listUrl = cp + "/admin/club/list?" + query;
			String paging = paginateUtil.paging(currentPage, totalPage, listUrl);
			
			// JSP로 전달
			mav.addObject("requestList", list);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("page", currentPage);
			mav.addObject("totalPage", totalPage);
			mav.addObject("paging", paging);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);
			mav.addObject("requestStatus", requestStatus);
			mav.addObject("activeTab", "request");
					
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	// =========================================================
	// 구단 창설 신청 승인
	// =========================================================
	@PostMapping("approve")
	public ModelAndView approve(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			long requestId = Long.parseLong(req.getParameter("requestId"));
			
			service.approveRequest(requestId);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/admin/club/list");
	}
	
	// =========================================================
	// 구단 창설 신청 거절
	// =========================================================
	@PostMapping("reject")
	public ModelAndView reject(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			long requestId = Long.parseLong(req.getParameter("requestId"));
			
			service.rejectRequest(requestId);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/admin/club/list");
	}
}
