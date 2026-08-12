package com.syfc.controller;

import java.io.IOException;

import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class AdminController {

    // 관리자 게시판 관리 페이지 매핑
    @GetMapping("/admin/adminBoard")
    public ModelAndView adminBoard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // WEB-INF/views/admin/adminBoard.jsp 파일로 이동
        return new ModelAndView("admin/adminBoard");
    }
}