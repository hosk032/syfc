package com.syfc.controller;

import java.io.IOException;
import java.util.List;

import com.syfc.dto.HomeDTO;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.HomeService;
import com.syfc.service.HomeServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class HomeController {
	private HomeService service = new HomeServiceImpl();
	 
    @GetMapping("/main")
    public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	try {
    		List<HomeDTO> matchList = service.selectHomeMatchList();
        	
        	ModelAndView mav = new ModelAndView("main/index");
        	
        	mav.addObject("matchList", matchList);
        	
        	return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
        return new ModelAndView("main/index");
    }
}