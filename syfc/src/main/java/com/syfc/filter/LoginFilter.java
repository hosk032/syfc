package com.syfc.filter;

import java.io.IOException;

import com.syfc.dto.SessionInfo;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*")
public class LoginFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		//request 필터 (서블릿 실행 전 할 일)

		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		HttpSession session = req.getSession();
		
		String uri = req.getRequestURI();
		String cp = req.getContextPath();
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
			//MemberController에서 로그인 후 member 속성에 담아준 내용 확인
		if(info == null && isExcludeUri(req) == false ) {
			//로그인이 안 되어있고 로그인검사가 필요한 uri일때
			if(isAjaxRequest(req)) {
				//AJAX 요청에서 로그인이 안 된 경우 403 에러코드
				resp.sendError(403); //앞단에서 에러코드 받고 js로 처리해야함
			} else {
				//로그인 전 주소가 존재하는 경우 전 주소로 이동하기 위해 세션에 전 주소 저장
				
				//uri에서 ContextPath 제거
				if(uri.indexOf(req.getContextPath()) == 0) {
					uri = uri.substring(req.getContextPath().length());
				}
				
				uri = "redirect:" + uri;
				
				String queryString = req.getQueryString();
					// .getQueryString() : get방식으로 넘어온 파라미터들
				if(queryString != null) {
					uri += "?" + queryString;
				}
				session.setAttribute("preLoginURI", uri);
				
				//로그인 페이지로 이동
				resp.sendRedirect(cp + "/member/login");
			}
			
			return;
			
		} else if (info != null && uri.indexOf("admin") != -1) {
			//userLevel이 51미만인 유저가 관리자 메뉴에 접근한 경우
			if(info.getUserLevel() < 51) {
				resp.sendRedirect(cp + "/member/noAuthorized");
				return;
			}
		}
		
		//다음 필터 또는 마지막 필터이면 end-pointer(서블릿, jsp등)를 실행. 즉 서블릿 불러오기
		chain.doFilter(request, response);
		
		//response 필터
	}
	
	//요청이 AJAX인지를 확인하는 매소드
	private boolean isAjaxRequest(HttpServletRequest req) {
		String h = req.getHeader("AJAX"); //요청에 담긴 헤더 AJAX의 값을 꺼냄
		
		return h != null && h.equals("true"); //AJAX헤더의 값이 있고 true일 경우 true 반환
	}
	
	//로그인 체크가 필요하지 않은지의 여부 판단
	private boolean isExcludeUri(HttpServletRequest req) {
		String uri = req.getRequestURI();
		String cp = req.getContextPath();
		uri = uri.substring(cp.length());
		
		String []uris = {
				"/index.jsp", "/main",
				"/member/login", "/member/logout",
				"/member/account", "/member/userIdCheck", "/member/complete",
				"/member/pwdFind", "/member/idFind",
				"/uploads/photo/**", "/uploads/club/**",
				"/dist/**"
		}; //로그인하지 않아도 들어올 수 있는 주소들
		
		if(uri.length() <= 1) { // ContextPath를 빼면 추가경로가 없을 때, 즉 첫화면일때
			return true;
		}
		
		for(String s : uris) { // /** 하위주소들 다 통과시킬 때 (css, 이미지 등 로딩에 필요)
			if(s.lastIndexOf("**") != -1) {
				s = s.substring(0, s.lastIndexOf("**"));
					if(uri.indexOf(s) == 0) {
						return true;
					}
			} else if(uri.equals(s)) {
				return true;
			}
		}
		
		return false;		
	}
}