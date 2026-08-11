package com.syfc.controller;

import java.io.IOException;

import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/player/*")
public class PlayerController {
	
	@GetMapping("mypage")
	public ModelAndView mypage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		return new ModelAndView("player/mypage");
	}
	
	@GetMapping("rating")
	public ModelAndView rating(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		return new ModelAndView("player/rating");
	}
	
	@GetMapping("matchHistory")
	public ModelAndView matchHistory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		return new ModelAndView("player/matchHistory");
	}
	
	@GetMapping("matchApply")
	public ModelAndView matchApply(HttpServletRequest req, HttpServletResponse resp) {
	    return new ModelAndView("player/matchApply");
	}
	
	@GetMapping("club")
	public ModelAndView club(HttpServletRequest req, HttpServletResponse resp) {
	    return new ModelAndView("player/club");
	}
	
	@GetMapping("clubJoin")
	public ModelAndView clubJoin(HttpServletRequest req, HttpServletResponse resp) {
	    return new ModelAndView("player/clubJoin");
	}
	
	@GetMapping("clubOwnerRequest")
	public ModelAndView clubOwnerRequest(HttpServletRequest req, HttpServletResponse resp) {
	    return new ModelAndView("player/clubOwnerRequest");
	}
}
