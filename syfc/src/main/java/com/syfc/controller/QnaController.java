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
@RequestMapping("/community/qna/*")
public class QnaController {
	
	@GetMapping("qnaList")
	public ModelAndView qnaList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		return new ModelAndView("community/qna/qnaList");
	}
	
}
