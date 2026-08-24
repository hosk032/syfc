package com.syfc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.NoticeDTO;
import com.syfc.dto.SessionInfo;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.ResponseBody;
import com.syfc.service.NoticeService;
import com.syfc.service.NoticeServiceImpl;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ModalNoticeController {
	    private NoticeService service = new NoticeServiceImpl();

	    // 알림 목록
	    @ResponseBody
	    @GetMapping("/notice/list")
	    public Map<String, Object> listNotice(
	            HttpServletRequest req, HttpServletResponse resp) {

	        Map<String, Object> map = new HashMap<String, Object>();

	        HttpSession session = req.getSession();
	        SessionInfo member = (SessionInfo) session.getAttribute("member");

	        if (member == null) {
	            map.put("success", false);
	            map.put("message", "로그인이 필요합니다."
	            );
	            return map;
	        }

	        int memberIdx = member.getMemberIdx();

	        List<NoticeDTO> list = service.listNotice(memberIdx);

	        map.put("success", true);
	        map.put("list", list);

	        return map;
	    }


	    // 알림 읽음 처리
	    @ResponseBody
	    @PostMapping("/notice/read")
	    public Map<String, Object> updateRead(
	    		HttpServletRequest req, HttpServletResponse resp) {

	        Map<String, Object> map = new HashMap<String, Object>();

	        HttpSession session = req.getSession();
	        SessionInfo member = (SessionInfo) session.getAttribute("member");

	        if (member == null) {
	            map.put("success", false);
	            map.put("message", "로그인이 필요합니다.");
	            return map;
	        }

	        String noticeIdParam = req.getParameter("notice_id");

	        if (noticeIdParam == null || noticeIdParam.equals("")) {

	            map.put("success", false);
	            map.put("message", "알림 번호가 없습니다."
	            );

	            return map;
	        }

	        long notice_id;

	        try {
	            notice_id = Long.parseLong(noticeIdParam);

	        } catch (NumberFormatException e) {

	            map.put("success", false);
	            map.put("message", "잘못된 알림 번호입니다."
	            );
	            return map;
	        }

	        int memberIdx = member.getMemberIdx();
	        NoticeDTO dto = new NoticeDTO();
	        dto.setMemberIdx(memberIdx);
	        dto.setNotice_id(notice_id);

	        int result = service.updateRead(dto);

	        map.put("success", result > 0);

	        return map;
	    }
	}

