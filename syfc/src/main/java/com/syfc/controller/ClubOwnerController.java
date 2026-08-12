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
@RequestMapping("/clubowner/*")
public class ClubOwnerController {

    // 구단주 마이페이지 이동 (GET: /clubowner/ownerpage)
    @GetMapping("ownerpage")
    public ModelAndView ownerPage(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
    	
    	
        // WEB-INF/views/clubowner/ownerpage.jsp 로 포워딩
        return new ModelAndView("clubowner/ownerpage");
    }
    
    
    
}
