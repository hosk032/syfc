package com.syfc.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminStadiumDTO;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.AdminStadiumService;
import com.syfc.service.AdminStadiumServiceImpl;
import com.syfc.util.MyUtil;
import com.syfc.util.PaginateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@Controller
@RequestMapping("/stadium/*")
public class StadiumController {
	private AdminStadiumService service = new AdminStadiumServiceImpl();
	private MyUtil util = new MyUtil();
	private PaginateUtil paginateUtil = new PaginateUtil();
	
	
	@GetMapping("stadiumInfo")
    public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("stadium/stadiumInfo");

		try {
			// 페이지 번호
			String page = req.getParameter("page");
			int currentPage = page == null ? 1 : Integer.parseInt(page);

			// 검색 파라미터 (관리자 페이지와 동일)
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");

			if (schType == null) {
				schType = "stadiumName";
			}

			if (kwd == null) {
				kwd = "";
			}

			kwd = util.decodeUrl(kwd);

			int size = 3; // 한 페이지당 경기장 수

			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);

			// 전체 개수
			int dataCount = service.dataCount(map);

			int totalPage = paginateUtil.pageCount(dataCount, size);

			if (totalPage > 0) {
				currentPage = Math.min(currentPage, totalPage);
			} else {
				currentPage = 1;
			}

			// 오프셋 계산
			int offset = (currentPage - 1) * size;
			if (offset < 0) {
				offset = 0;
			}

			map.put("offset", offset);
			map.put("size", size);

			List<AdminStadiumDTO> list = service.listStadium(map);

			// 페이징 URL 생성
			String cp = req.getContextPath();
			String query = "";

			if (!kwd.isBlank()) {
				query = "schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}

			String listUrl = cp + "/stadium/stadiumInfo";
			if (!query.isBlank()) {
				listUrl += "?" + query;
			}

			String paging = paginateUtil.paging(currentPage, totalPage, listUrl);

			// ModelAndView 객체 전달
			mav.addObject("stadiumList", list);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
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
	
	
}
