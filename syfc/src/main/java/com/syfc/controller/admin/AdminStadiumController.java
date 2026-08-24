package com.syfc.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminStadiumDTO;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
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
@RequestMapping("/admin/stadium/*")
public class AdminStadiumController {
	private AdminStadiumService service = new AdminStadiumServiceImpl();

	private MyUtil util = new MyUtil();
	private PaginateUtil paginateUtil = new PaginateUtil();


	// =========================================================
	// 경기장 목록
	// =========================================================
	@GetMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		ModelAndView mav = new ModelAndView("admin/stadium/list");

		try {
			// 페이지
			String page = req.getParameter("page");
			int currentPage = page == null ? 1 : Integer.parseInt(page);

			// 검색
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");

			if(schType == null) {
				schType = "stadiumName";
			}

			if(kwd == null) {
				kwd = "";
			}

			kwd = util.decodeUrl(kwd);

			int size = 10;

			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);

			// 전체 개수
			int dataCount = service.dataCount(map);

			int totalPage = paginateUtil.pageCount(dataCount, size);

			if(totalPage > 0) {
				currentPage = Math.min(currentPage, totalPage);
			} else {
				currentPage = 1;
			}

			// 목록
			int offset = (currentPage - 1) * size;

			if(offset < 0) {
				offset = 0;
			}

			map.put("offset", offset);
			map.put("size", size);

			List<AdminStadiumDTO> list = service.listStadium(map);

			// 페이징
			String cp = req.getContextPath();

			String query = "";

			if(!kwd.isBlank()) {
				query = "schType=" + schType
						+ "&kwd=" + util.encodeUrl(kwd);
			}

			String listUrl = cp + "/admin/stadium/list";

			if(!query.isBlank()) {
				listUrl += "?" + query;
			}

			String paging = paginateUtil.paging(
					currentPage, totalPage, listUrl);

			// JSP 전달
			mav.addObject("stadiumList", list);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("page", currentPage);
			mav.addObject("totalPage", totalPage);
			mav.addObject("paging", paging);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);

			// 경기장 등록 및 관리 탭
			mav.addObject("activeTab", "stadium");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}


	// =========================================================
	// 경기장 상세
	// =========================================================
	@GetMapping("article")
	public ModelAndView article(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		ModelAndView mav = new ModelAndView("admin/stadium/article");

		try {
			long stadiumId =
					Long.parseLong(req.getParameter("stadiumId"));

			AdminStadiumDTO dto = service.findById(stadiumId);

			if(dto == null) {
				return new ModelAndView(
						"redirect:/admin/stadium/list");
			}

			mav.addObject("dto", dto);

		} catch (Exception e) {
			e.printStackTrace();

			return new ModelAndView(
					"redirect:/admin/stadium/list");
		}

		return mav;
	}


	// =========================================================
	// 경기장 등록 화면
	// =========================================================
	@GetMapping("write")
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		ModelAndView mav =
				new ModelAndView("admin/stadium/write");

		mav.addObject("mode", "write");

		return mav;
	}


	// =========================================================
	// 경기장 등록
	// =========================================================
	@PostMapping("write")
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		try {
			AdminStadiumDTO dto = new AdminStadiumDTO();

			dto.setStadiumName(req.getParameter("stadiumName"));
			dto.setRegion(req.getParameter("region"));

			String capacity = req.getParameter("capacity");
			String latitude = req.getParameter("latitude");
			String longitude = req.getParameter("longitude");
			String stadiumCost = req.getParameter("stadiumCost");

			if(capacity != null && !capacity.isBlank()) {
				dto.setCapacity(Long.parseLong(capacity));
			}

			if(latitude != null && !latitude.isBlank()) {
				dto.setLatitude(Double.parseDouble(latitude));
			}

			if(longitude != null && !longitude.isBlank()) {
				dto.setLongitude(Double.parseDouble(longitude));
			}

			if(stadiumCost != null && !stadiumCost.isBlank()) {
				dto.setStadiumCost(Long.parseLong(stadiumCost));
			}

			dto.setAddr1(req.getParameter("addr1"));
			dto.setAddr2(req.getParameter("addr2"));
			dto.setZip(req.getParameter("zip"));

			// 현재는 이미지 경로 문자열 저장
			dto.setStadiumImg(req.getParameter("stadiumImg"));

			service.insertStadium(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView(
				"redirect:/admin/stadium/list");
	}


	// =========================================================
	// 경기장 수정 화면
	// =========================================================
	@GetMapping("update")
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		ModelAndView mav =
				new ModelAndView("admin/stadium/write");

		try {
			long stadiumId =
					Long.parseLong(req.getParameter("stadiumId"));

			AdminStadiumDTO dto = service.findById(stadiumId);

			if(dto == null) {
				return new ModelAndView(
						"redirect:/admin/stadium/list");
			}

			mav.addObject("dto", dto);
			mav.addObject("mode", "update");

		} catch (Exception e) {
			e.printStackTrace();

			return new ModelAndView(
					"redirect:/admin/stadium/list");
		}

		return mav;
	}


	// =========================================================
	// 경기장 수정 완료
	// =========================================================
	@PostMapping("update")
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		long stadiumId = 0;

		try {
			stadiumId =
					Long.parseLong(req.getParameter("stadiumId"));

			AdminStadiumDTO dto = new AdminStadiumDTO();

			dto.setStadiumId(stadiumId);
			dto.setStadiumName(req.getParameter("stadiumName"));
			dto.setRegion(req.getParameter("region"));

			String capacity = req.getParameter("capacity");
			String status = req.getParameter("status");
			String latitude = req.getParameter("latitude");
			String longitude = req.getParameter("longitude");
			String stadiumCost = req.getParameter("stadiumCost");

			if(capacity != null && !capacity.isBlank()) {
				dto.setCapacity(Long.parseLong(capacity));
			}

			if(status != null && !status.isBlank()) {
				dto.setStatus(Integer.parseInt(status));
			}

			if(latitude != null && !latitude.isBlank()) {
				dto.setLatitude(Double.parseDouble(latitude));
			}

			if(longitude != null && !longitude.isBlank()) {
				dto.setLongitude(Double.parseDouble(longitude));
			}

			if(stadiumCost != null && !stadiumCost.isBlank()) {
				dto.setStadiumCost(Long.parseLong(stadiumCost));
			}

			dto.setAddr1(req.getParameter("addr1"));
			dto.setAddr2(req.getParameter("addr2"));
			dto.setZip(req.getParameter("zip"));

			dto.setStadiumImg(req.getParameter("stadiumImg"));

			service.updateStadium(dto);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView(
				"redirect:/admin/stadium/article?stadiumId="
				+ stadiumId);
	}
}