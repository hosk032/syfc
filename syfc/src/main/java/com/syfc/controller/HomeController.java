package com.syfc.controller;

import java.io.IOException;

import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class HomeController {

    @GetMapping("/main")
    public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        return new ModelAndView("main/index");
    }
}