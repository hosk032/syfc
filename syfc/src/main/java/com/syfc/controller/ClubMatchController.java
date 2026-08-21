package com.syfc.controller;

import java.io.IOException;
import java.security.Provider.Service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubOwnerMatchDTO;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.ClubMatchService;
import com.syfc.service.ClubMatchServiceImpl;
import com.syfc.service.MatchService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/clubmatch/*")
public class ClubMatchController {
	private ClubMatchService service = new ClubMatchServiceImpl();
	
    @GetMapping("matchInfo")
    public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	ModelAndView mav = new ModelAndView("clubmatch/matchInfo");

		try {
			// Mapper의 parameterType="map" 규격에 맞춘 Map 객체 생성
			Map<String, Object> map = new HashMap<>();

			// DB 전체 경기 목록 조회
			List<ClubOwnerMatchDTO> matchList = service.selectAllMatchList(map);

			// JSP 로 데이터 전달 (${matchList})
			mav.addObject("matchList", matchList);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	
	
}
