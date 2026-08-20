package com.syfc.controller.admin;

import java.io.IOException;
import java.util.List;

import com.syfc.dto.AdminStadiumIssueDTO;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.AdminStadiumIssueService;
import com.syfc.service.AdminStadiumIssueServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/admin/stadiumIssue/*")
public class AdminStadiumIssueController {
	
	private AdminStadiumIssueService service = new AdminStadiumIssueServiceImpl();
	
	// =========================================================
	// 경기장 이슈 등록 화면
	// =========================================================
	@GetMapping("write")
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/stadiumIssue/write");

		// 경기장 선택 목록
		List<AdminStadiumIssueDTO> stadiumList = service.listStadiumOption();

		// 기존에 등록된 경기장 이슈 목록
		List<AdminStadiumIssueDTO> issueList = service.listIssue();

		mav.addObject("stadiumList", stadiumList);
		mav.addObject("issueList", issueList);

		return mav;
	}
	
	// =========================================================
	// 경기장 이슈 등록
	// =========================================================
	@PostMapping("write")
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			AdminStadiumIssueDTO dto = new AdminStadiumIssueDTO();
			
			// JSP에서 넘어온 값 DTO에 저장
			dto.setStadiumId(Long.parseLong(req.getParameter("stadiumId")));
			dto.setStartDate(req.getParameter("startDate"));
			dto.setEndDate(req.getParameter("endDate"));
			dto.setIssueType(req.getParameter("issueType"));
			dto.setReason(req.getParameter("reason"));
			
			// 시작일 또는 종료일이 비어 있는 경우
			if(dto.getStartDate() == null || dto.getStartDate().isBlank()
					|| dto.getEndDate() == null || dto.getEndDate().isBlank()) {
				throw new Exception("시작일과 종료일을 입력하세요.");
			}
			
			// 종료일이 시작일보다 빠른 경우
			if(dto.getStartDate().compareTo(dto.getEndDate()) > 0) {
				throw new Exception("종료일은 시작일보다 빠를 수 없습니다.");
			}
			
			// Stadium_Issue 등록
			service.insertIssue(dto);
			
			// 등록 후 영향받는 경기 목록으로 이동
			return new ModelAndView("redirect:/admin/stadiumIssue/result?issueId=" + dto.getIssueId());
			
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("redirect:/admin/stadiumIssue/write");
		}
	}
	
	// =========================================================
	// 등록한 이슈 + 영향받는 경기 목록
	// =========================================================
	@GetMapping("result")
	public ModelAndView result(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/stadiumIssue/result");
		
		try {
			long issueId = Long.parseLong(req.getParameter("issueId"));
			
			// 등록한 경기장 이슈 정보
			AdminStadiumIssueDTO issue = service.findIssue(issueId);
			
			if(issue == null) {
				return new ModelAndView("redirect:/admin/stadiumIssue/write");
			}
			
			// 해당 경기장과 이슈 기간에 영향받는 경기 목록
			List<AdminStadiumIssueDTO> matchList = service.listAffectedMatch(issueId);
			
			mav.addObject("issue", issue);
			mav.addObject("matchList", matchList);
			
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("redirect:/admin/stadiumIssue/write");
		}
		
		return mav;
	}
	
	// =========================================================
	// 영향받는 경기 반려
	// Match_Apply.status = 4
	// =========================================================
	@PostMapping("reject")
	public ModelAndView reject(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		long issueId = 0;
		
		try {
			long applyId = Long.parseLong(req.getParameter("applyId"));
			issueId = Long.parseLong(req.getParameter("issueId"));
			
			service.rejectMatch(applyId);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 반려 처리 후 현재 이슈 결과 페이지 다시 표시
		return new ModelAndView("redirect:/admin/stadiumIssue/result?issueId=" + issueId);
	}
	
	// =========================================================
	// 경기장 이슈 수정 화면
	// =========================================================
	@GetMapping("update")
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			long issueId = Long.parseLong(req.getParameter("issueId"));

			// 기존 이슈 정보 조회
			AdminStadiumIssueDTO dto = service.findIssue(issueId);

			if(dto == null) {
				return new ModelAndView("redirect:/admin/stadiumIssue/write");
			}

			ModelAndView mav = new ModelAndView("admin/stadiumIssue/update");
			mav.addObject("dto", dto);

			return mav;

		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("redirect:/admin/stadiumIssue/write");
		}
	}
	
	// =========================================================
	// 경기장 이슈 수정
	// =========================================================
	@PostMapping("update")
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		long issueId = 0;

		try {
			AdminStadiumIssueDTO dto = new AdminStadiumIssueDTO();

			issueId = Long.parseLong(req.getParameter("issueId"));

			dto.setIssueId(issueId);
			dto.setStartDate(req.getParameter("startDate"));
			dto.setEndDate(req.getParameter("endDate"));
			dto.setIssueType(req.getParameter("issueType"));
			dto.setReason(req.getParameter("reason"));

			// 시작일 또는 종료일이 비어 있는 경우
			if(dto.getStartDate() == null || dto.getStartDate().isBlank()
					|| dto.getEndDate() == null || dto.getEndDate().isBlank()) {
				throw new Exception("시작일과 종료일을 입력하세요.");
			}

			// 종료일이 시작일보다 빠른 경우
			if(dto.getStartDate().compareTo(dto.getEndDate()) > 0) {
				throw new Exception("종료일은 시작일보다 빠를 수 없습니다.");
			}

			service.updateIssue(dto);

			// 수정 완료 후 해당 이슈 결과 화면
			return new ModelAndView("redirect:/admin/stadiumIssue/result?issueId=" + issueId);

		} catch (Exception e) {
			e.printStackTrace();

			if(issueId > 0) {
				return new ModelAndView("redirect:/admin/stadiumIssue/update?issueId=" + issueId);
			}

			return new ModelAndView("redirect:/admin/stadiumIssue/write");
		}
	}
}
