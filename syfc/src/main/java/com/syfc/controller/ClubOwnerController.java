package com.syfc.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubApprovalDTO;
import com.syfc.dto.ClubDTO;
import com.syfc.dto.ClubOwnerMatchDTO;
import com.syfc.dto.SessionInfo;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.ClubApprovalService;
import com.syfc.service.ClubApprovalServiceImpl;
import com.syfc.service.ClubOwnerMatchService;
import com.syfc.service.ClubOwnerMatchServiceImpl;
import com.syfc.service.ClubOwnerService;
import com.syfc.service.ClubOwnerServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/clubowner/*")
public class ClubOwnerController {

    private ClubOwnerService service = new ClubOwnerServiceImpl();
    private ClubOwnerMatchService matchService = new ClubOwnerMatchServiceImpl();
    private ClubApprovalService approvalService = new ClubApprovalServiceImpl(); // 추가된 입단 승인 서비스

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
                // 경기 목록 조회
                List<ClubOwnerMatchDTO> matchList = matchService.getClubMatchList(clubDto.getClubOwner_key());
                req.setAttribute("matchList", matchList);

                // [추가] 입단 신청 대기 목록 조회 (status = 2)
                List<ClubApprovalDTO> approvalList = approvalService.getPendingApprovalList(clubDto.getClubOwner_key());
                req.setAttribute("approvalList", approvalList);
                req.setAttribute("pendingCount", approvalList != null ? approvalList.size() : 0);
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
                matchService.updateMatchScore(map);
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
                matchService.deleteMatchScore(Long.parseLong(matchNum));
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

    // 7. [추가] 입단 신청 승인 처리 (POST - AJAX)
    @PostMapping("approvePlayer")
    public ModelAndView approvePlayer(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        if (info == null) return new ModelAndView("redirect:/member/login");

        try {
            String applyNumStr = req.getParameter("applyNum");
            if (applyNumStr != null) {
                Long applyNum = Long.parseLong(applyNumStr);
                approvalService.approvePlayer(applyNum);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("redirect:/clubowner/ownerpage");
    }

    // 8. [추가] 입단 신청 거절 처리 (POST - AJAX)
    @PostMapping("rejectPlayer")
    public ModelAndView rejectPlayer(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        if (info == null) return new ModelAndView("redirect:/member/login");

        try {
            String applyNumStr = req.getParameter("applyNum");
            String rejectReason = req.getParameter("rejectReason");
            if (applyNumStr != null) {
                Long applyNum = Long.parseLong(applyNumStr);
                approvalService.rejectPlayer(applyNum, rejectReason);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("redirect:/clubowner/ownerpage");
    }
}