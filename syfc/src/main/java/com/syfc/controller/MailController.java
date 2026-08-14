package com.syfc.controller;

import java.io.IOException;

import com.syfc.dto.SessionInfo;
import com.syfc.mail.Mail;
import com.syfc.mail.MailSender;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/mail/*")
public class MailController {
	@GetMapping("send")
	public ModelAndView sendForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		return new ModelAndView("mail/write");
	}
	
	@PostMapping("send")
	public ModelAndView sendSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MailSender mailSender = new MailSender();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String url = "redirect:/mail/complete";
		
		try {
			Mail dto = new Mail();
			
			dto.setSenderName(info.getUserName());
			dto.setSenderEmail("zvvcxxz@gmail.com"); //MailSender.java에서 입력한 아이디, 도메인과 일치해야함
			
			dto.setReceiverEmail(req.getParameter("receiverEmail"));
			dto.setSubject(req.getParameter("subject"));
			dto.setContent(req.getParameter("content"));
			dto.setContent(dto.getContent().replaceAll("\n", "<br>")); //엔터를 <br>로 치환해 웹페이지에서 제대로 엔터 보이게
			
			session.setAttribute("receiver", dto.getReceiverEmail());
			
			boolean b = mailSender.mailSend(dto);
			
			if(! b) {
				url += "?fail";
			}
		} catch (Exception e) {
			url += "?fail";
		}
		
		return new ModelAndView(url);
	}
	
	@GetMapping("complete")
	public ModelAndView complete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("mail/complete");
		HttpSession session = req.getSession();
		
		try {
			String fail = req.getParameter("fail");
			
			String receiver = (String)session.getAttribute("receiver");
			session.removeAttribute("receiver");
			if(receiver == null) {
				return new ModelAndView("redirect:/");
			}
			
			String msg = "<span style='color:mediumblue;'>" + receiver + "</span> 님에게 <br>";
			if(fail == null) {
				msg += "메일을 성공적으로 보냈습니다.";
			} else {
				msg += "메일을 전송하는데 실패했습니다.";
			}
			
			mav.addObject("message", msg);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
}