package com.syfc.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubMatchBoardDTO;
import com.syfc.dto.MatchApplyDTO;
import com.syfc.dto.NoticeDTO;
import com.syfc.dto.SessionInfo;
import com.syfc.dto.StadiumDTO;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.annotation.ResponseBody;
import com.syfc.service.MatchService;
import com.syfc.service.MatchServiceImpl;
import com.syfc.service.NoticeService;
import com.syfc.service.NoticeServiceImpl;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/match/*")
public class MatchController {

    private MatchService service = new MatchServiceImpl();
    private NoticeService service2 = new NoticeServiceImpl();

    @ResponseBody
    @GetMapping("region") //지역 목록 조회 GET /match/region
    public Map<String, Object> selectRegions(HttpServletRequest req, HttpServletResponse resp) {

        Map<String, Object> map = new HashMap<>();

        try {
            List<String> list = service.selectRegions();

            map.put("list", list);
            map.put("success", true);

        } catch (Exception e) {

            e.printStackTrace();

            map.put("success", false);
            map.put("message", "지역 목록을 불러오지 못했습니다.");
        }

        return map;
    }


    @ResponseBody
    @GetMapping("searchStadiums")
    public Map<String, Object> searchStadiums(HttpServletRequest req, HttpServletResponse resp) {

        Map<String, Object> map = new HashMap<>();

        try {
            String applyDate = req.getParameter("applyDate");
            String region = req.getParameter("region");
            String applyTimeStr = req.getParameter("applyTime");

            if (applyDate == null || region == null || applyTimeStr == null) {
                map.put("success", false);
                map.put("message", "경기장 검색 조건이 부족합니다.");
                return map;
            }

            Integer applyTime = Integer.parseInt(applyTimeStr);

            Map<String, Object> param = new HashMap<>();

            param.put("applyDate", applyDate);
            param.put("region", region);
            param.put("applyTime", applyTime);

            List<StadiumDTO> list = service.selectAvailableStadiums(param);

            map.put("success", true);
            map.put("list", list);

        } catch (Exception e) {

            e.printStackTrace();

            map.put("success", false);
            map.put("message", "이용 가능한 경기장을 불러오지 못했습니다.");
        }

        return map;
    }
    
    
    @ResponseBody
    @PostMapping("createMatchPost") // 경기 참가 선수 모집글 등록
    public Map<String, Object> createMatchPost(HttpServletRequest req, HttpServletResponse resp) {
        Map<String, Object> map = new HashMap<>();
        ClubMatchBoardDTO dto = new ClubMatchBoardDTO();
        NoticeDTO dto2 = new NoticeDTO();
        
        dto.setCmb_Subject(req.getParameter("cmb_Subject"));
        dto.setCmb_Content(req.getParameter("cmb_Content"));
        dto.setApply_date(LocalDate.parse(req.getParameter("apply_date")));
        dto.setApply_time(Integer.parseInt(req.getParameter("apply_time")));
        dto.setStadium_id(Long.parseLong(req.getParameter("stadium_id")));
        dto.setMatch_type1(req.getParameter("match_type1"));
        dto.setMatch_type2(req.getParameter("match_type2"));
        dto.setStadium_cost(null);

        try {
            HttpSession session = req.getSession();
            SessionInfo info = (SessionInfo) session.getAttribute("member");

            if (info == null) {
                map.put("success",false);
                map.put("message", "로그인이 필요합니다.");

                return map;
            } //filter해놔서.. 생략가능.

            dto.setMemberIdx(info.getMemberIdx());

            service.insertMatchPost(dto);

            map.put("success",true);
            map.put("cmb_num", dto.getCmb_num());
            map.put("message", "경기 참가 선수 모집글이 등록되었습니다.");
            
            dto2.setMemberIdx(info.getMemberIdx());
            dto2.setNotice_content(dto.getCmb_Subject() + ": 선수 모집글이 등록되었습니다.");
            service2.insertNotice(dto2);

        } catch (Exception e) {

            e.printStackTrace();

            map.put("success", false);
            map.put("message", e.getMessage());
        }

        return map;
    }
    
    @GetMapping("boardList")
    @ResponseBody
    public Map<String, Object> boardList(HttpServletRequest req, HttpServletResponse resp) {

        Map<String, Object> result =new HashMap<>();

        try {
            HttpSession session = req.getSession();
            SessionInfo info =(SessionInfo) session.getAttribute("member");
            if (info == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }

            int memberIdx = info.getMemberIdx();
            	// 1순위 : 구단주 본인
            Long clubOwnerKey = service.findOwnerKeyByMemberIdx(memberIdx);

            // 2순위 : 선수 → 소속 구단
            if (clubOwnerKey == null) {
                clubOwnerKey = service.findClubOwnerKeyByMemberIdx(memberIdx);
            }

            if (clubOwnerKey == null) {
                result.put("success", false);
                result.put("message", "소속 구단 정보를 찾을 수 없습니다.");

                return result;
            }

            Map<String, Object> param = new HashMap<>();

            param.put("clubOwnerKey", clubOwnerKey);

            List<ClubMatchBoardDTO> list = service.listMatchBoard(param);

            result.put("success", true);
            result.put("list", list);

        } catch (Exception e) {

            e.printStackTrace();

            result.put("success", false);
            result.put("message", "게시글을 불러오지 못했습니다.");
        }

        return result;
    }


    @GetMapping("detail")
    @ResponseBody // 2. 게시글 상세 (+신청자 목록, 신청인원, 로그인 선수 자신의 신청상태)
    public Map<String, Object> detail(HttpServletRequest req, HttpServletResponse resp) {
    	Long cmb_num = Long.parseLong(req.getParameter("cmb_num"));

        Map<String, Object> result = new HashMap<>();

        // 게시글 + 경기정보
        ClubMatchBoardDTO board = service.findMatchBoardDetail(cmb_num);

        if (board == null) {
            result.put("success", false);
            result.put("message", "게시글이 존재하지 않습니다.");

            return result;
        }

        // 조회수 증가
        service.updateHitCount(cmb_num);
        // 신청자 목록
        List<ClubMatchBoardDTO> applicants = service.listApplicants(cmb_num);
        // 신청 인원
        int applicantCount = service.countApplicants(cmb_num);

        // 로그인 사용자
        HttpSession session = req.getSession();
        SessionInfo info =(SessionInfo) session.getAttribute("member");

        ClubMatchBoardDTO myRequest = null;
        boolean isOwner = false;

        if (info != null) {
            Map<String, Object> param = new HashMap<>();

            param.put("memberIdx", info.getMemberIdx());
            param.put("cmb_num",cmb_num);

            myRequest = service.findMyRequest(param);
            Long loginOwnerKey =service.findOwnerKeyByMemberIdx(info.getMemberIdx());
            Long boardOwnerKey =service.findBoardOwner(cmb_num);
            if (loginOwnerKey != null &&
                    boardOwnerKey != null &&
                    loginOwnerKey.equals(boardOwnerKey)) {

                    isOwner = true;
                }

        }
        // DTO → Map //현재 커스텀 mvc라 json - map 으로만 응답을 보낼 수 있네요

        Map<String, Object> boardMap = new HashMap<>();

        boardMap.put("cmb_num", board.getCmb_num());
        boardMap.put("cmb_Subject", board.getCmb_Subject());
        boardMap.put("cmb_Content", board.getCmb_Content());
        boardMap.put("cmb_HitCount", board.getCmb_HitCount());
        boardMap.put("cmb_Reg_date", board.getCmb_Reg_date());

        boardMap.put("clubOwner_key", board.getClubOwner_key());

        // Match_Apply
        boardMap.put("apply_id", board.getApply_id());
        boardMap.put("apply_date", board.getApply_date());
        boardMap.put("apply_time", board.getApply_time());
        boardMap.put("match_status", board.getMatch_status());
        boardMap.put("cancel_reason", board.getCancel_reason());

        // Stadium
        boardMap.put("stadium_id", board.getStadium_id());
        boardMap.put("stadium_name", board.getStadium_name());
        boardMap.put("region", board.getRegion());
        boardMap.put("addr1", board.getAddr1());
        boardMap.put("addr2", board.getAddr2());
        boardMap.put("zip", board.getZip());
        boardMap.put("latitude", board.getLatitude());
        boardMap.put("longitude", board.getLongitude());
        boardMap.put("capacity", board.getCapacity());
        boardMap.put("stadium_cost", board.getStadium_cost());
        boardMap.put("stadium_img", board.getStadium_img());

        // 경기 종류
        boardMap.put("match_type1", board.getMatch_type1());
        boardMap.put("match_type2", board.getMatch_type2());

        // 홈 / 원정
        boardMap.put("home_clubOwner_key", board.getHome_clubOwner_key());
        boardMap.put("home_clubName", board.getHome_clubName());
        boardMap.put("away_clubOwner_key", board.getAway_clubOwner_key());
        boardMap.put("away_clubName", board.getAway_clubName());


        result.put("success", true);
        result.put("board", boardMap);
        result.put("applicantCount", applicantCount);
        result.put("isOwner", isOwner);

        // 현재는 null이어도 됨
        if (myRequest != null) {

            Map<String, Object> myRequestMap = new HashMap<>();

            myRequestMap.put("clubJoin_num", myRequest.getClubJoin_num());
            myRequestMap.put("request_date", myRequest.getRequest_date());
            myRequestMap.put("request_state", myRequest.getRequest_state());
            myRequestMap.put("request_intro", myRequest.getRequest_intro());
            myRequestMap.put("reject_reason", myRequest.getReject_reason());
            myRequestMap.put("request_cancel", myRequest.getRequest_cancel());

            result.put("myRequest", myRequestMap);

        } else {

            result.put("myRequest", null);
        }
        
        result.put("applicants", applicants);

        return result;
    }

    @PostMapping("request")
    @ResponseBody // 3. 선수 참가신청
    public Map<String, Object> request(HttpServletRequest req, HttpServletResponse resp) {

        Map<String, Object> result = new HashMap<>();
        NoticeDTO dto2 = new NoticeDTO();

        HttpSession session = req.getSession();
        SessionInfo info =(SessionInfo) session.getAttribute("member");
        
        String request_intro = req.getParameter("request_intro");
        Long cmb_num = Long.parseLong(req.getParameter("cmb_num"));

        if (info == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            
            return result;
        }

        int memberIdx = info.getMemberIdx();

        Map<String, Object> param = new HashMap<>();
        param.put("memberIdx", memberIdx);

        Long clubJoin_num =
                service.findClubJoinNumByMemberIdx(memberIdx);

        if (clubJoin_num == null) {
            result.put("success", false);
            result.put("message", "구단 소속 선수 정보를 찾을 수 없습니다.");
            return result;
        }

        param.put("cmb_num", cmb_num);
        param.put("clubJoin_num", clubJoin_num);
        param.put("request_intro", request_intro);

        // 중복 신청 확인
        ClubMatchBoardDTO myRequest = service.findMyRequest(param);

        if (myRequest != null) {
            result.put("success", false);
            result.put("message", "이미 참가 신청한 게시글입니다.");

            return result;
        }

        // INSERT       
        int resultCount = service.insertMatchRequest(param);

        result.put("success", resultCount > 0);
        result.put("message", resultCount > 0
                    ? "참가 신청되었습니다." : "참가 신청에 실패했습니다.");
        
        if(resultCount > 0) {
        	ClubMatchBoardDTO dto = service.findMatchBoardDetail(cmb_num);
            
            dto2.setMemberIdx(info.getMemberIdx());
            dto2.setNotice_content(dto.getCmb_Subject() + ": 참가 신청을 완료하였습니다.");
            service2.insertNotice(dto2);
        }

        return result;
    }
    	
    @PostMapping("requestCancel")
    @ResponseBody // 4. 선수 참가신청 취소
    public Map<String, Object> requestCancel(HttpServletRequest req, HttpServletResponse resp) {

        Map<String, Object> result = new HashMap<>();
        
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        String request_cancel = req.getParameter("request_cancel");
        Long cmb_num = Long.parseLong(req.getParameter("cmb_num"));

        if (info == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");

            return result;
        }
        
        int memberIdx = info.getMemberIdx();
        Long clubJoin_num = service.findClubJoinNumByMemberIdx(memberIdx);

        if (clubJoin_num == null) {
            result.put("success", false);
            result.put("message", "선수 정보를 찾을 수 없습니다.");

            return result;
        }

        Map<String, Object> param = new HashMap<>();

        param.put("cmb_num", cmb_num);
        param.put("clubJoin_num", clubJoin_num);
        param.put("request_cancel", request_cancel);

        int resultCount = service.deleteMatchRequest(param);

        result.put("success", resultCount > 0);
        result.put("message", resultCount > 0
                    ? "참가 신청이 취소되었습니다." : "취소할 신청 정보가 없습니다.");
        
        NoticeDTO dto2 = new NoticeDTO();
        if(resultCount > 0) {
        	ClubMatchBoardDTO dto = service.findMatchBoardDetail(cmb_num);
            
            dto2.setMemberIdx(info.getMemberIdx());
            dto2.setNotice_content(dto.getCmb_Subject() + ": 참가 신청을 취소하였습니다.");
            service2.insertNotice(dto2);
        }

        return result;
    }
    
    @PostMapping("approveRequest")
    @ResponseBody // 5. 구단주 - 선수 승인
    public Map<String, Object> approveRequest(HttpServletRequest req, HttpServletResponse resp) {

        Map<String, Object> result = new HashMap<>();

        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        Long cmb_num = Long.parseLong(req.getParameter("cmb_num"));
        Long clubJoin_num = Long.parseLong(req.getParameter("clubJoin_num"));

        if (info == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");

            return result;
        }

        Map<String, Object> param = new HashMap<>();

        param.put("cmb_num", cmb_num);
        param.put("clubJoin_num", clubJoin_num);
        param.put("memberIdx", info.getMemberIdx());

        int resultCount = service.approveMatchRequest(param);

        result.put("success",resultCount > 0);
        result.put("message", resultCount > 0
                    ? "선수 참가 신청을 승인했습니다." : "승인 처리할 신청이 없습니다.");

        return result;
    }

    
    @PostMapping("rejectRequest")
    @ResponseBody // 6. 구단주 - 선수 반려
    public Map<String, Object> rejectRequest(HttpServletRequest req, HttpServletResponse resp) {

        Map<String, Object> result = new HashMap<>();

        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        String reject_reason = req.getParameter("reject_reason");
        Long cmb_num = Long.parseLong(req.getParameter("cmb_num"));
        Long clubJoin_num = Long.parseLong(req.getParameter("clubJoin_num"));

        if (info == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");

            return result;
        }

        Map<String, Object> param = new HashMap<>();

        param.put("cmb_num", cmb_num);
        param.put("clubJoin_num", clubJoin_num);
        param.put("reject_reason", reject_reason);
        param.put("memberIdx", info.getMemberIdx()
        );

        int resultCount = service.rejectMatchRequest(param);

        result.put("success",resultCount > 0);
        result.put("message", resultCount > 0
                    ? "선수 참가 신청을 반려했습니다." : "반려 처리할 신청이 없습니다.");

        return result;
    }

    @PostMapping("cancelMatch")
    @ResponseBody  // 7. 구단주 - 모집글에서 매칭 취소
    public Map<String, Object> cancelMatch(
    		HttpServletRequest req, HttpServletResponse resp) {
    
        Map<String, Object> result = new HashMap<>();

        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
           
        

        if (info == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");

            return result;
        }
        int memberidx = info.getMemberIdx();
        Long clubownerkey = service.findOwnerKeyByMemberIdx(memberidx);
        String clubname = service.findClubName(clubownerkey);
        
        String cancel_reason = req.getParameter("cancel_reason");
        Long cmb_num = Long.parseLong(req.getParameter("cmb_num"));

        Map<String, Object> param = new HashMap<>();

        param.put("cmb_num", cmb_num);
        param.put("cancel_reason", clubname + " : " + cancel_reason);
        param.put("memberIdx", info.getMemberIdx());

        int resultCount = service.cancelMatchByOwner(param);

        result.put("success", resultCount > 0);
        result.put("message", resultCount > 0
                    ? "경기가 취소되었습니다." : "경기 취소에 실패했습니다.");

        return result;
    }
    
    @ResponseBody
    @RequestMapping("myParticipation") //탭1. 선수 개인의 구단 출전 신청 이력
    public Map<String, Object> myParticipation(HttpServletRequest req, HttpServletResponse resp) {

       Map<String, Object> map = new HashMap<>();

       try {
          HttpSession session =req.getSession();
          SessionInfo info =(SessionInfo) session.getAttribute("member");

          if(info == null) {
             map.put("success", false);
             map.put("message", "로그인이 필요합니다.");
             return map;
          }

          int memberIdx = info.getMemberIdx();
          Long clubJoin_num = service.findClubJoinNumByMemberIdx(memberIdx);

          if(clubJoin_num == null) {
             map.put("success", false);
             map.put("message","선수 가입 정보를 찾을 수 없습니다.");
             return map;
          }

          Map<String, Object> param = new HashMap<>(); //조회조건
          param.put("clubJoin_num", clubJoin_num);

          	//본인의 출전 신청 이력 조회
          List<ClubMatchBoardDTO> list = service.listMyMatchRequest(param);

          map.put("success", true);
          map.put("list", list);
          map.put("count", list.size());

       } catch(Exception e) {

          e.printStackTrace();

          map.put("success", false);
          map.put("message","출전신청 이력을 불러오는 중 오류가 발생했습니다.");
       }
       
       return map;
    }
    
    @ResponseBody
    @GetMapping("waitingMatches")
    public Map<String, Object> waitingMatches(HttpServletRequest req, HttpServletResponse resp) {

        Map<String, Object> result = new HashMap<>();
        String applyDate = req.getParameter("applyDate");
        String region = req.getParameter("region");
        String applyTime = req.getParameter("applyTime");
        String matchType1 = req.getParameter("matchType1");
        String matchType2 = req.getParameter("matchType2");

        try {

            if (applyDate == null || applyDate.isBlank()
                    || region == null || region.isBlank()
                    || applyTime == null
                    || matchType1 == null || matchType1.isBlank()
                    || matchType2 == null || matchType2.isBlank()) {

                result.put("success", false);
                result.put("message", "검색 조건을 모두 선택해주세요.");

                return result;
            }

            Map<String, Object> param = new HashMap<>();

            param.put("applyDate", applyDate);
            param.put("region", region);
            param.put("applyTime", applyTime);
            param.put("matchType1", matchType1);
            param.put("matchType2", matchType2);

            List<MatchApplyDTO> list = service.listWaitingMatches(param);

            result.put("success", true);
            result.put("list", list);

        } catch (Exception e) {

            e.printStackTrace();

            result.put("success", false);
            result.put("message",
                    "매칭 대기 경기를 불러오지 못했습니다.");
        }

        return result;
    }

}

