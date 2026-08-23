package com.syfc.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.MatchApplyDTO;
import com.syfc.dto.SessionInfo;
import com.syfc.mvc.annotation.Controller;
import com.syfc.mvc.annotation.GetMapping;
import com.syfc.mvc.annotation.PostMapping;
import com.syfc.mvc.annotation.RequestMapping;
import com.syfc.mvc.annotation.RequestMethod;
import com.syfc.mvc.annotation.ResponseBody;
import com.syfc.mvc.view.ModelAndView;
import com.syfc.service.MatchService;
import com.syfc.service.MatchServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/match2/*")
public class MatchController2 {
	private MatchService service = new MatchServiceImpl();

    @ResponseBody
    @RequestMapping("history")//경기 신청 이력 조회 //안 쓰는 컨트롤러. 아래 myMatchApply 씀
    public Map<String, Object> history(HttpServletRequest req, HttpServletResponse resp) {
        Map<String, Object> result = new HashMap<String, Object>();

        try {
            HttpSession session = req.getSession();
            SessionInfo info =(SessionInfo) session.getAttribute("member");

            if (info == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }

            int memberIdx = info.getMemberIdx();
            	// 구단주/선수 구분
            Long clubOwnerKey = service.findOwnerKeyByMemberIdx(memberIdx);

            if (clubOwnerKey == null) {  //구단주 명단에 memberIdx가 없어서 null반환되면
                clubOwnerKey = service.findClubOwnerKeyByMemberIdx(memberIdx);
            }		//clubjoin 테이블에서 구단주번호를 가져온다. 즉 선수의 경우.


            if (clubOwnerKey == null) {
                result.put("success", false);
                result.put("message", "소속 구단 정보를 찾을 수 없습니다.");
                return result;
            }	// 구단주명단과 클럽가입명단 둘 다에서 못 찾았다면 소속구단 정보가 없는 것.

            Map<String, Object> param = new HashMap<String, Object>();

            param.put("clubOwnerKey", clubOwnerKey);
            
            List<MatchApplyDTO> list = service.listMatchHistory(param);

            result.put("success", true);
            result.put("list", list);
            result.put("clubOwnerKey", clubOwnerKey);

            //구단주 여부: clubOwner 테이블에서 memberIdx로 직접 찾았는지 여부를 별도로 판단
            Long ownerKey = service.findOwnerKeyByMemberIdx(memberIdx);
            result.put("isOwner", ownerKey != null);

        } catch (Exception e) {
            e.printStackTrace();

            result.put("success", false);
            result.put("message","경기 신청 이력을 불러오는 중 오류가 발생했습니다.");
        }

        return result;
    }

    @ResponseBody //상대팀 수락
    @RequestMapping(value = "acceptOpponent", method = RequestMethod.POST)
    public Map<String, Object> acceptOpponent(HttpServletRequest req, HttpServletResponse resp) {
        Map<String, Object> result = new HashMap<>();

        try {
            HttpSession session = req.getSession();
            SessionInfo info = (SessionInfo) session.getAttribute("member");
            if (info == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }

            //현재 로그인한 사람이 구단주인지 
            Long homeOwnerKey = service.findOwnerKeyByMemberIdx(info.getMemberIdx());
            if (homeOwnerKey == null) {
                result.put("success", false);
                result.put("message", "구단주만 상대팀을 수락할 수 있습니다.");
                return result;
            }

            String applyIdParam = req.getParameter("apply_id");
            if (applyIdParam == null || applyIdParam.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "경기 신청번호가 없습니다.");
                return result;
            }

            Long applyId = Long.valueOf(applyIdParam);


            //apply_id를 기준으로 DB에서 실제 경기 정보를 조회
            // homeOwnerKey opponentOwnerKey cmbNum status
            MatchApplyDTO match = service.findMatchForDecision(applyId);

            if (match == null) {
                result.put("success", false);
                result.put("message", "해당 경기 신청 정보를 찾을 수 없습니다.");
                return result;
            }

            // 현재 로그인한 구단이 실제 홈팀인지
            if (match.getClubOwner_key() == null ||
                !match.getClubOwner_key().equals(homeOwnerKey)) {

                result.put("success", false);
                result.put("message","해당 경기의 홈 구단주만 상대팀을 수락할 수 있습니다.");

                return result;
            }

            // 상대팀이 실제로 존재하는지
            if (match.getClubOwner_key2() == null) {
                result.put("success", false);
                result.put("message", "신청한 상대팀이 없습니다.");
                return result;
            }

            // 현재 상태가 상대팀 신청 상태(2)인지 확인
            if (match.getStatus() == null || match.getStatus() != 2) {

                result.put("success", false);
                result.put("message", "현재 수락할 수 있는 상대팀 신청 상태가 아닙니다.");

                return result;
            }

            Map<String, Object> param = new HashMap<>();

            param.put("applyId", applyId);
            param.put("homeOwnerKey", homeOwnerKey);
            param.put("opponentOwnerKey", match.getClubOwner_key2());
            param.put("cmbNum", match.getCmb_num());

            int updateCount = service.acceptOpponent(param);
            		//다른 신청팀과 최초의 레코드 status 6 으로 set
            if (updateCount > 0) {
                result.put("success", true);
                result.put("message", "상대팀이 수락되어 매칭이 확정되었습니다.");

            } else {
                result.put("success", false);
                result.put("message", "상대팀 수락에 실패했습니다.");
            }

        } catch (Exception e) {

            e.printStackTrace();

            result.put("success", false);
            result.put("message","상대팀 수락 중 오류가 발생했습니다.");
        }

        return result;
    }

    @ResponseBody //상대팀 거절
    @RequestMapping(value = "rejectOpponent", method = RequestMethod.POST)
    public Map<String, Object> rejectOpponent(HttpServletRequest req, HttpServletResponse resp) {

        Map<String, Object> result = new HashMap<>();

        try {
            HttpSession session = req.getSession();
            SessionInfo info = (SessionInfo) session.getAttribute("member");

            if (info == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }

            Long homeOwnerKey = service.findOwnerKeyByMemberIdx(info.getMemberIdx());

            if (homeOwnerKey == null) {
                result.put("success", false);
                result.put("message", "구단주만 상대팀을 거절할 수 있습니다.");
                return result;
            }

            String applyIdParam = req.getParameter("apply_id");

            if (applyIdParam == null || applyIdParam.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "경기 신청번호가 없습니다.");

                return result;
            }

            Long applyId = Long.valueOf(applyIdParam);

            // DB에서 실제 Match_Apply 조회
            MatchApplyDTO match = service.findMatchForDecision(applyId);

            if (match == null) {
                result.put("success", false);
                result.put("message", "해당 경기 신청 정보를 찾을 수 없습니다.");
                return result;
            }

            // 현재 로그인한 구단이 홈팀인지 확인
            if (match.getClubOwner_key() == null ||
                !match.getClubOwner_key().equals(homeOwnerKey)) {
                result.put("success", false);
                result.put("message", "해당 경기의 홈 구단주만 상대팀을 거절할 수 있습니다.");

                return result;
            }

            if (match.getClubOwner_key2() == null) {
                result.put("success", false);
                result.put("message", "신청한 상대팀이 없습니다.");
                return result;
            }
            		//상대팀 신청한 레코드 status 가 2인지
            if (match.getStatus() == null || match.getStatus() != 2) {
                result.put("success", false);
                result.put("message", "현재 거절할 수 있는 상태가 아닙니다.");

                return result;
            }

            Map<String, Object> param = new HashMap<>();

            param.put("applyId", applyId);
            param.put("homeOwnerKey", homeOwnerKey);
            param.put("opponentOwnerKey", match.getClubOwner_key2());

            int updateCount = service.rejectOpponent(param);

            if (updateCount > 0) {
                result.put("success", true);
                result.put("message","상대팀 신청을 거절했습니다.");

            } else {
                result.put("success", false);
                result.put("message", "상대팀 거절에 실패했습니다.");
            }

        } catch (Exception e) {

            e.printStackTrace();

            result.put("success", false);
            result.put("message","상대팀 거절 중 오류가 발생했습니다.");
        }

        return result;
    }


    @ResponseBody // 4. 탭3 경기이력에서 매칭 취소
    @RequestMapping(value = "cancelMatch", method = RequestMethod.POST)
    public Map<String, Object> cancelMatch(HttpServletRequest req, HttpServletResponse resp) {
    	
        Map<String, Object> result = new HashMap<String, Object>();

        try {
            HttpSession session = req.getSession();
            SessionInfo info = (SessionInfo) session.getAttribute("member");

            if (info == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");

                return result;
            }
            
            int memberIdx = info.getMemberIdx();
            Long ownerKey = service.findOwnerKeyByMemberIdx(memberIdx);

            if (ownerKey == null) {
                result.put("success", false);
                result.put("message", "구단주만 매칭을 취소할 수 있습니다.");
                return result;
            }

            String applyIdParam = req.getParameter("apply_id");
            String cancelReason = req.getParameter("cancel_reason");

            if (applyIdParam == null ||
                cancelReason == null ||
                cancelReason.trim().isEmpty()) {

                result.put("success", false);
                result.put("message", "취소사유를 입력해주세요.");

                return result;
            }

            Long applyId = Long.valueOf(applyIdParam);
            		//현재 매칭의 홈, 원정 구단 확인
            Long homeOwnerKey = service.findHomeOwnerKey(applyId);
            Long awayOwnerKey = service.findAwayOwnerKey(applyId);
            		//로그인한 구단이 현재 홈인지 원정인지
            boolean isHome = ownerKey.equals(homeOwnerKey);
            boolean isAway = awayOwnerKey != null && ownerKey.equals(awayOwnerKey);

            if (!isHome && !isAway) {
                result.put("success", false);
                result.put("message","해당 경기의 구단주가 아닙니다.");
                return result;
            }
            		//취소한 구단명 조회
            String clubName = service.findClubName(ownerKey);

            if (clubName == null || clubName.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "취소한 구단명을 확인할 수 없습니다.");
                return result;
            }
            		//db에 구단명 : 취소사유 형태로 cancel_reason에 저장하기
            String finalCancelReason = clubName + " : " + cancelReason.trim();

            Map<String, Object> param = new HashMap<String, Object>();

            param.put("applyId", applyId);
            param.put("cancelReason", finalCancelReason);

            int updateCount = service.cancelMatch(param);

            if (updateCount > 0) {
                result.put("success", true);
                result.put("message", "경기 매칭이 취소되었습니다.");
                result.put("cancelReason", finalCancelReason);
            } else {
                result.put("success", false);
                result.put("message", "경기 매칭 취소에 실패했습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();

            result.put("success", false);
            result.put("message", "경기 매칭 취소 중 오류가 발생했습니다.");
        }
        return result;
    }
    
    @ResponseBody
    @PostMapping("awayApply") //원정팀 매칭 신청
    public Map<String, Object> awayApply(HttpServletRequest req, HttpServletResponse resp) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            //1. 세션 확인
            HttpSession session = req.getSession();
            SessionInfo info = (SessionInfo) session.getAttribute("member");
            if (info == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            //2. 요청 파라미터
            String applyIdStr = req.getParameter("apply_id");
            if (applyIdStr == null || applyIdStr.isBlank()) {
                result.put("success", false);
                result.put("message", "매칭 정보가 없습니다.");
                return result;
            }

            Long apply_id = Long.parseLong(applyIdStr);
            // 3. 서비스로 전달할 map
            Map<String, Object> map = new HashMap<>();
            map.put("memberIdx", info.getMemberIdx());
            map.put("apply_id", apply_id);

            // 4. 서비스 호출
            service.applyAwayMatch(map);
            // 5. 성공
            result.put("success",true);
            result.put("message","원정팀 매칭 신청이 완료되었습니다.");

        } catch (IllegalStateException e) {
            result.put("success",false);
            result.put("message",e.getMessage());

        } catch (Exception e) {
            e.printStackTrace();

            result.put("success", false);
            result.put("message","원정팀 매칭 신청 중 오류가 발생했습니다.");
        }

        return result;
    }

    @ResponseBody
    @RequestMapping("myMatchApply")
    public Map<String, Object> myMatchApply(HttpServletRequest req, HttpServletResponse resp) {

        Map<String, Object> result = new HashMap<>();

        try {
            HttpSession session = req.getSession();
            SessionInfo info = (SessionInfo) session.getAttribute("member");

            if (info == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }

            int memberIdx = info.getMemberIdx();
            		// 1순위: 구단주인지
            Long clubOwnerKey = service.findOwnerKeyByMemberIdx(memberIdx);

            // 2순위 : 선수라면 clubJoin에서 소속 구단주 번호 조회
            if (clubOwnerKey == null) {
                clubOwnerKey = service.findClubOwnerKeyByMemberIdx(memberIdx);
            }

            if (clubOwnerKey == null) {
                result.put("success", false);
                result.put("message", "소속 구단 정보를 찾을 수 없습니다.");
                return result;
            }

            Map<String, Object> param = new HashMap<>();
            param.put("clubOwner_key",clubOwnerKey);

            // 홈 + 원정 통합 조회
            List<MatchApplyDTO> list = service.listMyMatchApply(param);

            // 구단주인지 여부
            Long ownerKey = service.findOwnerKeyByMemberIdx(memberIdx);

            boolean isOwner = ownerKey != null;

            result.put("success", true);
            result.put("list", list);
            result.put("count", list.size());
            result.put("clubOwnerKey",clubOwnerKey);
            result.put("isOwner",isOwner);

        } catch (Exception e) {

            e.printStackTrace();
            result.put("success", false);
            result.put("message","경기신청 이력을 불러오는 중 오류가 발생했습니다.");
        }

        return result;
    }
    
    
	@GetMapping("playermatchtab")
	public ModelAndView loginForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 선수의 경기신청/이력 페이지로 이동
		return new ModelAndView("match/fragment/player/tab_match_apply_player");
	}

}
