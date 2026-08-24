package com.syfc.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.ReplyBoardDTO;
import com.syfc.dto.SessionInfo;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.ReplyBoardService;
import com.syfc.service.ReplyBoardServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/community/reply/*")
public class ReplyBoardController {
	private ReplyBoardService service = new ReplyBoardServiceImpl();
	int size = 5;
	
	
	// 댓글 목록
	@GetMapping("replyList")
    public ModelAndView replyList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
        	String bnum = req.getParameter("bnum");
        	
        	int offset = 0;
        	
        	if(req.getParameter("offset") != null) {
        		offset = Integer.parseInt(req.getParameter("offset"));
        	}
        	
        	Map<String, Object> map = new HashMap<String, Object>();
        	
        	map.put("bnum", bnum);
        	map.put("offset", offset);
            map.put("size", size);
        	
            List<ReplyBoardDTO> replyList = service.listReply(map);
            int replyCount = service.dataCount(map);
            
            ModelAndView mav = new ModelAndView("community/reply/reply");
            
            mav.addObject("replyList", replyList);
            mav.addObject("replyCount", replyCount);
            mav.addObject("bnum", bnum);
            mav.addObject("offset", offset);
            mav.addObject("size", size);
            
            return mav;
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ModelAndView("community/reply/reply");
    }
    
	// 댓글 등록
	@PostMapping("replyInsert")
	public ModelAndView replyInsert(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        try {
			long bnum = Long.parseLong(req.getParameter("bnum"));
			
			ReplyBoardDTO dto = new ReplyBoardDTO();
        	
			dto.setBnum(bnum);
			dto.setMemberIdx(info.getMemberIdx());
			dto.setR_content(req.getParameter("r_content"));
			
			service.insertReply(dto);
			
			// 등록 후 댓글 목록을 다시 가져옴
			Map<String, Object> countMap  = new HashMap<String, Object>();
			countMap.put("bnum", req.getParameter("bnum"));

	        int replyCount = service.dataCount(countMap);

	        // 새 댓글 작성 직후에는 전체 댓글 조회
	        Map<String, Object> listMap = new HashMap<String, Object>();
	        listMap.put("bnum", req.getParameter("bnum"));
	        listMap.put("offset", 0);
	        listMap.put("size", replyCount);
	        
            List<ReplyBoardDTO> replyList = service.listReply(listMap);
            
            ModelAndView mav = new ModelAndView("community/reply/reply");
            
            mav.addObject("replyList", replyList);
            mav.addObject("replyCount", replyCount);
            mav.addObject("offset", 0);
            mav.addObject("size", replyList.size());
            mav.addObject("bnum", req.getParameter("bnum"));
            
            return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
        return new ModelAndView("community/reply/reply");
	}
    
	@PostMapping("replyUpdate")
    public ModelAndView replyUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo)session.getAttribute("member");

        try {
            ReplyBoardDTO dto = new ReplyBoardDTO();

            dto.setReply_num(Long.parseLong(req.getParameter("reply_num")));
            dto.setR_content( req.getParameter("r_content"));
            dto.setMemberIdx( info.getMemberIdx());
            service.updateReply(dto);

            // 수정 후 댓글 목록 조회
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("bnum", req.getParameter("bnum"));
            map.put("offset", 0);
            map.put("size", 10);
            List<ReplyBoardDTO> replyList = service.listReply(map);
            int replyCount = service.dataCount(map);
            
            ModelAndView mav = new ModelAndView("community/reply/reply");

            mav.addObject("replyList", replyList);
            mav.addObject("replyCount", replyCount);
            mav.addObject("offset", 0);
            mav.addObject("size", size);
            mav.addObject("bnum", req.getParameter("bnum"));
            return mav;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ModelAndView( "community/reply/reply");
    }


    // 댓글 삭제
    @PostMapping("replyDelete")
    public ModelAndView replyDelete( HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo)session.getAttribute("member");

        try {
            Map<String, Object> map = new HashMap<String, Object>();

            map.put("reply_num", req.getParameter("reply_num"));
            map.put("memberIdx", info.getMemberIdx());
            map.put("userLevel", info.getUserLevel());

            service.deleteReply(map);

            // 삭제 후 댓글 목록 조회
            Map<String, Object> listMap = new HashMap<String, Object>();
            listMap.put("bnum", req.getParameter("bnum"));
            listMap.put("offset", 0);
            listMap.put("size", size);

            List<ReplyBoardDTO> replyList = service.listReply(listMap);
            int replyCount = service.dataCount(listMap);
            
            ModelAndView mav = new ModelAndView("community/reply/reply");
            
            mav.addObject("replyList", replyList);
            mav.addObject("replyCount", replyCount);
            mav.addObject("offset", 0);
            mav.addObject("size", size);
            mav.addObject("bnum", req.getParameter("bnum"));

            return mav;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ModelAndView("community/reply/reply");
    }
	
}
