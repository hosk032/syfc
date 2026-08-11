package com.syfc.controller.admin;

import java.io.IOException;

import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class HomeManageController {
	@GetMapping("/admin")
	public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/main");
		return mav;
	}
}
