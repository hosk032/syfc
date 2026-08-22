package com.syfc.controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubMatchDTO;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.annotation.ResponseBody;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.ClubMatchService;
import com.syfc.service.ClubMatchServiceImpl;
import com.syfc.util.MyUtil;
import com.syfc.util.PaginateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/clubmatch/*")
public class ClubMatchController {
	private ClubMatchService service = new ClubMatchServiceImpl();
	private PaginateUtil paginateUtil = new PaginateUtil();
	private MyUtil util = new MyUtil();
	
    @GetMapping("matchInfo")
    public ModelAndView matchInfo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	ModelAndView mav = new ModelAndView("clubmatch/matchInfo");

    	try {
			// 1. 페이지 파라미터 수신 및 기본값 처리
			String page = req.getParameter("page");
			int current_page = 1;
			if (page != null) {
				current_page = Integer.parseInt(page);
			}

			// 2. 검색 파라미터 수신 및 디코딩
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if (schType == null) {
				schType = "all";
				kwd = "";
			}

			kwd = util.decodeUrl(kwd);

			// 3. 페이징 처리 변수 설정
			int size = 5;
			int total_page = 0;
			int dataCount = 0;

			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);

			// 4. 전체 데이터 개수 및 전체 페이지 수 계산
			dataCount = service.dataCount(map);
			
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);

			int offset = (current_page - 1) * size;
			if (offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			// 5. 페이징 데이터 목록 조회
			List<ClubMatchDTO> matchList = service.selectAllMatchList(map);

			// 6. 페이징 URL 및 검색 쿼리스트링 생성
			String query = "";
			String cp = req.getContextPath();
			String listUrl = cp + "/clubmatch/matchInfo";

			if (!kwd.isBlank()) {
				query = "schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
				listUrl += "?" + query;
			}

			// 7. PaginateUtil을 사용한 HTML 페이징 태그 생성
			String paging = paginateUtil.paging(current_page, total_page, listUrl);

			// 8. ModelAndView 객체에 데이터 등록
			mav.addObject("matchList", matchList);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("page", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("paging", paging);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	
    @GetMapping("clubMatchRank")
    public ModelAndView clubMatchRank(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	ModelAndView mav = new ModelAndView("clubmatch/clubMatchRank");
    	
    	try {
            // 1. 페이지 파라미터 수신 및 기본값 처리
    		String page = req.getParameter("page");
            int current_page = 1;
            if (page != null) {
                current_page = Integer.parseInt(page);
            }

            // 2. 검색 파라미터 수신 및 디코딩
            String schType = req.getParameter("schType");
            String kwd = req.getParameter("kwd");
            if (schType == null) {
                schType = "all";
                kwd = "";
            }

            kwd = util.decodeUrl(kwd);

            // 3. 페이징 처리 변수 설정 (페이지당 10개 출력)
            int size = 5;
            int total_page = 0;
            int dataCount = 0;

            Map<String, Object> map = new HashMap<>();
            map.put("schType", schType);
            map.put("kwd", kwd);

            // 4. 전체 구단 수 및 전체 페이지 수 계산
            dataCount = service.clubDataCount(map);
            
            total_page = paginateUtil.pageCount(dataCount, size);
            current_page = Math.min(current_page, total_page);

            int offset = (current_page - 1) * size;
            if (offset < 0) offset = 0;

            map.put("offset", offset);
            map.put("size", size);

            // 5. 페이징 목록 조회
            List<ClubMatchDTO> rankList = service.selectAllClubList(map);

            // 6. 각 구단별 최근 3경기 결과 조회 및 DTO 세팅
            if (rankList != null) {
                for (ClubMatchDTO dto : rankList) {
                    if (dto.getTotalGames() > 0) {
                        Map<String, Object> paramMap = new HashMap<>();
                        paramMap.put("clubOwnerKey", dto.getClubOwner_key());
                        
                        List<String> recentResults = service.selectClub3Results(paramMap);
                        dto.setRecentResults(recentResults);
                    }
                }
            }

            // 7. 페이징 URL 및 검색 쿼리스트링 생성
            String query = "";
            String cp = req.getContextPath();
            String listUrl = cp + "/clubmatch/clubMatchRank";

            if (!kwd.isBlank()) {
                query = "schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
                listUrl += "?" + query;
            }

            // 8. PaginateUtil을 사용한 HTML 페이징 태그 생성
            String paging = paginateUtil.paging(current_page, total_page, listUrl);

            // 9. ModelAndView 객체에 데이터 등록
            mav.addObject("rankList", rankList);
            mav.addObject("dataCount", dataCount);
            mav.addObject("size", size);
            mav.addObject("page", current_page);
            mav.addObject("total_page", total_page);
            mav.addObject("paging", paging);
            mav.addObject("schType", schType);
            mav.addObject("kwd", kwd);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return mav;
    }
	
    
    @GetMapping("clubCalendar")
    public ModelAndView clubCalendar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("clubmatch/clubCalendar");
		try {
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if (schType == null) {
				schType = "club_name";
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);

			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	// 달력 비동기(AJAX) 경기 목록 반환 (JSON)
	@GetMapping("monthMatchList")
	@ResponseBody
	public Map<String, Object> monthMatchList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Map<String, Object> model = new HashMap<>();
		try {
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH) + 1;

			String y = req.getParameter("year");
			String m = req.getParameter("month");

			if (y != null && !y.isBlank()) year = Integer.parseInt(y);
			if (m != null && !m.isBlank()) month = Integer.parseInt(m);

			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if (schType == null) {
				schType = "club_name";
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);

			String yearMonth = String.format("%d-%02d", year, month);

			Map<String, Object> map = new HashMap<>();
			map.put("yearMonth", yearMonth);
			map.put("schType", schType);
			map.put("kwd", kwd);

			// DB 조회
			List<ClubMatchDTO> matchList = service.selectMonthMatchList(map);

			model.put("state", "true");
			model.put("matchList", matchList);
		} catch (Exception e) {
			e.printStackTrace();
			model.put("state", "false");
		}
		return model;
	}
    
    
}
