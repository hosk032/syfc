package com.syfc.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.syfc.dto.ClubDTO;
import com.syfc.dto.ClubOwnerMatchDTO;
import com.syfc.dto.SessionInfo;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.ClubOwnerMatchService;
import com.syfc.service.ClubOwnerMatchServiceImpl;
import com.syfc.service.ClubOwnerService;
import com.syfc.service.ClubOwnerServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
@RequestMapping("/clubowner/*")
public class ClubOwnerController {

    private ClubOwnerService service = new ClubOwnerServiceImpl();
    private ClubOwnerMatchService matchService = new ClubOwnerMatchServiceImpl();

    // 1. 구단주 메인 페이지
    @GetMapping("ownerpage")
    public ModelAndView ownerPage(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");

        if (info == null) {
            return new ModelAndView("redirect:/member/login");
        }

        try {
            ClubDTO clubDto = service.selectClubInfoByMemberIdx(info.getMemberIdx());
            req.setAttribute("club", clubDto);

            if (clubDto != null) {
                List<ClubOwnerMatchDTO> matchList = matchService.getClubMatchList(clubDto.getClubOwner_key());
                req.setAttribute("matchList", matchList);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ModelAndView("clubowner/ownerpage");
    }

    // 2. 경기 이력 검색 (AJAX)
    @GetMapping("searchMatchHistory")
    public ModelAndView searchMatchHistory(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        if (info == null) return new ModelAndView("redirect:/member/login");

        try {
            ClubDTO clubDto = service.selectClubInfoByMemberIdx(info.getMemberIdx());
            if (clubDto != null) {
                Map<String, Object> map = new HashMap<>();
                map.put("clubOwnerKey", clubDto.getClubOwner_key());
                map.put("year", req.getParameter("year"));
                map.put("month", req.getParameter("month"));
                map.put("result", req.getParameter("result"));

                List<ClubOwnerMatchDTO> matchList = matchService.getClubMatchListByMap(map);
                req.setAttribute("matchList", matchList);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("clubowner/tab/matchHistoryTable");
    }

    // 3. 구단 정보 수정
    @PostMapping("update")
    public ModelAndView updateClubInfo(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // ... 기존 구단 정보 수정 로직 동일 ...
        return new ModelAndView("redirect:/clubowner/ownerpage");
    }

    // 4. 구단주 성적 관리 - 완료된 매치 목록 조회
    @GetMapping("matchResultList")
    public ModelAndView getMatchResultList(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        if (info == null) return new ModelAndView("redirect:/member/login");

        try {
            ClubDTO clubDto = service.selectClubInfoByMemberIdx(info.getMemberIdx());
            if (clubDto != null) {
                List<ClubOwnerMatchDTO> matchList = matchService.getClubMatchList(clubDto.getClubOwner_key());
                req.setAttribute("club", clubDto);
                req.setAttribute("matchList", matchList);
            }
        } catch (Exception e) {}

        // 없는 파일 대신 실제 존재하는 JSP로 변경
        return new ModelAndView("clubowner/tab/tab_team_result_register");
    }

    // 5. 구단 성적 등록 및 수정 (POST - AJAX)
    @PostMapping("saveMatchScore")
    public ModelAndView saveMatchScore(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        if (info == null) return new ModelAndView("redirect:/member/login");

        try {
            String matchNum = req.getParameter("matchNum");
            String homeScore = req.getParameter("homeScore");
            String awayScore = req.getParameter("awayScore");

            if (matchNum != null && homeScore != null && awayScore != null) {
                Map<String, Object> map = new HashMap<>();
                map.put("matchNum", Long.parseLong(matchNum));
                map.put("homeScore", Integer.parseInt(homeScore));
                map.put("awayScore", Integer.parseInt(awayScore));
                matchService.updateMatchScore(map); // DB 업데이트
            }

            // 404 방지를 위해 뷰 렌더링에 필요한 데이터 재조회
            ClubDTO clubDto = service.selectClubInfoByMemberIdx(info.getMemberIdx());
            if (clubDto != null) {
                List<ClubOwnerMatchDTO> matchList = matchService.getClubMatchList(clubDto.getClubOwner_key());
                req.setAttribute("club", clubDto);
                req.setAttribute("matchList", matchList);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 에러 없는 정상 렌더링을 위해 실제 존재하는 파일 반환
        return new ModelAndView("clubowner/tab/tab_team_result_register");
    }

    // 6. 구단 성적 삭제/초기화 (POST - AJAX)
    @PostMapping("deleteMatchScore")
    public ModelAndView deleteMatchScore(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        if (info == null) return new ModelAndView("redirect:/member/login");

        try {
            String matchNum = req.getParameter("matchNum");
            if (matchNum != null) {
                matchService.deleteMatchScore(Long.parseLong(matchNum)); // DB 업데이트
            }

            ClubDTO clubDto = service.selectClubInfoByMemberIdx(info.getMemberIdx());
            if (clubDto != null) {
                List<ClubOwnerMatchDTO> matchList = matchService.getClubMatchList(clubDto.getClubOwner_key());
                req.setAttribute("club", clubDto);
                req.setAttribute("matchList", matchList);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ModelAndView("clubowner/tab/tab_team_result_register");
    }
}