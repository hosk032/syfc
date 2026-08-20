package com.syfc.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubInfoPlyDTO;
import com.syfc.dto.SessionInfo;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.ClubInfoPlyservice;
import com.syfc.service.ClubInfoPlyserviceImpl;
import com.syfc.util.MyUtil;
import com.syfc.util.PaginateUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/clubinfoply/*")
public class ClubInfoPlyController {
	private ClubInfoPlyservice service = new ClubInfoPlyserviceImpl();
	private MyUtil util = new MyUtil();
	private PaginateUtil paginateUtil = new PaginateUtil();

	// 구단 리스트
	@GetMapping("clubList")
	public ModelAndView clubList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ModelAndView mav = new ModelAndView("clubinfoply/clubList");
		
		try {
			// 페이지
			String page =req.getParameter("page");
			int current_page = 1;
			
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			// 검색
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			
			// 디코딩
			kwd = util.decodeUrl(kwd);
			
			int size = 5;
			int total_page = 0;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			// 전체 데이터 개수
			dataCount = service.dataCount(map);
			
			total_page = paginateUtil.pageCount(dataCount, size);
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0)offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<ClubInfoPlyDTO> list = service.listClubInfoPly(map);
			
			String query;
			String cp = req.getContextPath();
			String listUrl = cp + "/clubinfoply/clubList";
			String clubInfoUrl = cp + "/clubinfoply/clubInfo?page=" + current_page;
			
			if(! kwd.isBlank()) {
				query = "schType=" + schType + "&kwd=" +
						util.encodeUrl(kwd);
				listUrl += "?" + query;
				clubInfoUrl += "&" + query;
			}
			
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			mav.addObject("list", list);
			mav.addObject("dataCount", dataCount);
			mav.addObject("size", size);
			mav.addObject("page", current_page);
			mav.addObject("total_page", total_page);
			mav.addObject("clubInfoUrl", clubInfoUrl);
			mav.addObject("paging", paging);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	@GetMapping("clubInfo")
	public ModelAndView clubInfo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ModelAndView mav = new ModelAndView("clubinfoply/clubInfo");
		
		String page = req.getParameter("page");
		if(page == null || page.isBlank()) {
	        page = "1";
	    }
		String query = "page=" + page;
		
		try {
			long clubowner_key = Long.parseLong(req.getParameter("clubowner_key"));
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);
			
			if(! kwd.isBlank()) {
				query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
			}
			
			ClubInfoPlyDTO dto = service.findById(clubowner_key);
			if(dto == null) {
				return new ModelAndView("redirect:/clubinfoply/clubList?" + query);
			}
			
			List<ClubInfoPlyDTO> playerList = service.listPlayer(clubowner_key);
			String ownerName = service.findClubOwner(clubowner_key);
			
			mav.addObject("dto", dto);
			mav.addObject("playerList", playerList);
			mav.addObject("ownerName", ownerName);
	        mav.addObject("page", page);
	        mav.addObject("clubowner_key", clubowner_key);
	        mav.addObject("schType", schType);
	        mav.addObject("kwd", kwd);

			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		 return new ModelAndView("redirect:/clubinfoply/clubList");
	}
	
	@GetMapping("playerInfo")
	public ModelAndView playerInfo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if (info == null) {
	        return new ModelAndView("redirect:/member/login");
	    }
		
		ModelAndView mav = new ModelAndView("clubinfoply/playerInfo");
		
		try {
			Long clubowner_key = service.getclubowner(info.getMemberIdx());
			
			if (clubowner_key != null && clubowner_key > 0L) {
				List<ClubInfoPlyDTO> list = service.listPlayerInfo(clubowner_key);
				
				int fwCount = 0, mfCount = 0, dfCount = 0, gkCount = 0;
				if(list != null) {
					for(ClubInfoPlyDTO dto : list) {
						if("FW".equalsIgnoreCase(dto.getPosition())) fwCount++;
						else if("MF".equalsIgnoreCase(dto.getPosition())) mfCount++;
						else if("DF".equalsIgnoreCase(dto.getPosition())) dfCount++;
						else if("GK".equalsIgnoreCase(dto.getPosition())) gkCount++;
					}
				}
		        
		        mav.addObject("list", list);
		        mav.addObject("fwCount", fwCount);
		        mav.addObject("mfCount", mfCount);
		        mav.addObject("dfCount", dfCount);
		        mav.addObject("gkCount", gkCount);
		        mav.addObject("clubowner_key", clubowner_key);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	   
		return mav;
    }
	
	@GetMapping("playerList")
    public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
        return new ModelAndView("clubinfoply/playerList");
    }
	
	
	
}
