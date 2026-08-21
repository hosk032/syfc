package com.syfc.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubApprovalDTO;
import com.syfc.dto.ClubDTO;
import com.syfc.dto.ClubOwnerMatchDTO;
import com.syfc.dto.ClubOwnerPlayerDTO;
import com.syfc.dto.ClubOwnerPlayerRecordDTO;
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
import com.syfc.service.ClubOwnerPlayerRecordService;
import com.syfc.service.ClubOwnerPlayerRecordServiceImpl;
import com.syfc.service.ClubOwnerPlayerService;
import com.syfc.service.ClubOwnerPlayerServiceImpl;
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
	private ClubApprovalService approvalService = new ClubApprovalServiceImpl();
	private ClubOwnerPlayerService playerService = new ClubOwnerPlayerServiceImpl();
	private ClubOwnerPlayerRecordService recordService = new ClubOwnerPlayerRecordServiceImpl();

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
				Long clubOwnerKey = clubDto.getClubOwner_key();

				// 경기 목록 조회
				List<ClubOwnerMatchDTO> matchList = matchService.getClubMatchList(clubOwnerKey);
				req.setAttribute("matchList", matchList);
				
				// 승 / 무 / 패 전적 자동 집계 로직
				int wins = 0;
				int losses = 0;
				int draws = 0;
				if (matchList != null) {
					for (ClubOwnerMatchDTO match : matchList) {
						if (match.getHomeScore() != null && match.getAwayScore() != null) {
							int myScore = match.getHomeScore(); 
							int opScore = match.getAwayScore(); 

							if (myScore > opScore) {
								wins++;
							} else if (myScore < opScore) {
								losses++;
							} else {
								draws++;
							}
						}
					}
				}

				req.setAttribute("wins", wins);
				req.setAttribute("draws", draws);
				req.setAttribute("losses", losses);

				// 입단 신청 대기 목록 조회
				List<ClubApprovalDTO> approvalList = approvalService.getPendingApprovalList(clubOwnerKey);
				req.setAttribute("approvalList", approvalList);
				req.setAttribute("pendingCount", approvalList != null ? approvalList.size() : 0);

				// 구단 소속 선수 목록 조회
				ClubOwnerPlayerDTO playerParams = new ClubOwnerPlayerDTO();
				playerParams.setClubOwner_key(clubOwnerKey);
				List<ClubOwnerPlayerDTO> playerList = playerService.getClubPlayerList(playerParams);
				req.setAttribute("playerList", playerList);
				req.setAttribute("playerCount", playerList != null ? playerList.size() : 0);

				// 구단 평균 평점 실제 DB 조회 연동
				Double avgRating = playerService.getClubAverageRating(clubOwnerKey);
				req.setAttribute("avgRating", avgRating != null ? avgRating : 0.0);
				
				// 선수 성적 목록 조회 연동
				List<ClubOwnerPlayerRecordDTO> recordList = recordService.getPlayerRecordList(clubOwnerKey);
				req.setAttribute("recordList", recordList);
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
		if (info == null)
			return new ModelAndView("redirect:/member/login");

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

	// 2-1. 경기 상세 기록 모달 내용 조회 (원본 디자인 100% 유지 + 실제 DB 선수 기록 연동)
	@GetMapping("matchDetailModal")
	public void matchDetailModal(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null) {
			resp.sendError(HttpServletResponse.SC_UNAUTHORIZED);
			return;
		}

		resp.setContentType("text/html; charset=UTF-8");

		try {
			String matchNumStr = req.getParameter("matchNum");
			if (matchNumStr != null) {
				Long matchNum = Long.parseLong(matchNumStr);

				ClubDTO clubDto = service.selectClubInfoByMemberIdx(info.getMemberIdx());
				ClubOwnerMatchDTO targetMatch = null;
				List<ClubOwnerPlayerRecordDTO> matchRecords = new java.util.ArrayList<>();

				if (clubDto != null) {
					// 1. 해당 경기의 기본 정보 조회
					List<ClubOwnerMatchDTO> matchList = matchService.getClubMatchList(clubDto.getClubOwner_key());
					if (matchList != null) {
						for (ClubOwnerMatchDTO m : matchList) {
							if (m.getMatchNum().equals(matchNum)) {
								targetMatch = m;
								break;
							}
						}
					}

					// 2. 해당 경기에 등록된 선수들의 성적 기록만 필터링
					List<ClubOwnerPlayerRecordDTO> allRecords = recordService.getPlayerRecordList(clubDto.getClubOwner_key());
					if (allRecords != null) {
						for (ClubOwnerPlayerRecordDTO r : allRecords) {
							if (r.getMatchNum() != null && r.getMatchNum().equals(matchNum)) {
								matchRecords.add(r);
							}
						}
					}
				}

				String matchDateStr = "";
				String stadiumStr = "";
				String homeName = "울산 HD FC";
				String awayName = "상대팀";
				String scoreStr = "- : -";

				if (targetMatch != null) {
					matchDateStr = targetMatch.getMatchDate() != null ? targetMatch.getMatchDate().substring(0, 10) : "";
					stadiumStr = targetMatch.getStadiumName() != null ? targetMatch.getStadiumName() : "";
					if (targetMatch.getHomeClubName() != null) homeName = targetMatch.getHomeClubName();
					if (targetMatch.getAwayClubName() != null) awayName = targetMatch.getAwayClubName();
					if (targetMatch.getHomeScore() != null && targetMatch.getAwayScore() != null) {
						scoreStr = targetMatch.getHomeScore() + " : " + targetMatch.getAwayScore();
					}
				}

				StringBuilder html = new StringBuilder();
				
				// 원본 디자인과 CSS 클래스를 그대로 유지한 HTML 템플릿
				html.append("<div class='p-2'>");
				html.append("  <div class='bg-light p-3 rounded-3 text-center mb-4 border'>");
				html.append("    <div class='text-muted small fw-bold mb-1'>").append(matchDateStr).append(" · ").append(stadiumStr).append("</div>");
				html.append("    <div class='d-flex align-items-center justify-content-center gap-3 fs-5 fw-bold text-dark'>");
				html.append("      <span>").append(homeName).append("</span>");
				html.append("      <span class='text-primary fs-4 px-2'>").append(scoreStr).append("</span>");
				html.append("      <span>").append(awayName).append("</span>");
				html.append("    </div>");
				html.append("  </div>");

				html.append("  <div class='d-flex justify-content-between align-items-center mb-2'>");
				html.append("    <h6 class='fw-bold mb-0 text-dark'><i class='bi bi-people-fill me-1 text-primary'></i> 출전 선수 평점 및 기록</h6>");
				html.append("    <span class='text-muted small'>매치 ID: ").append(matchNum).append("</span>");
				html.append("  </div>");

				html.append("  <div class='table-responsive'>");
				html.append("    <table class='table table-hover align-middle text-center small border mb-0' style='width: 100%; table-layout: fixed;'>");
				html.append("      <thead class='table-light text-muted'>");
				html.append("        <tr>");
				html.append("          <th style='width: 12%'>포지션</th>");
				html.append("          <th style='width: 15%'>선수명</th>");
				html.append("          <th style='width: 13%'>평점</th>");
				html.append("          <th style='width: 20%'>득점/도움</th>");
				html.append("          <th style='width: 15%'>카드</th>");
				html.append("          <th style='width: 25%' class='text-start ps-3'>평가 코멘트</th>");
				html.append("        </tr>");
				html.append("      </thead>");
				html.append("      <tbody>");

				if (matchRecords != null && !matchRecords.isEmpty()) {
					for (ClubOwnerPlayerRecordDTO rec : matchRecords) {
						String cardBadge = "-";
						if (rec.getRed() != null && rec.getRed() > 0) {
							cardBadge = "<span class='badge bg-danger text-white'>퇴장</span>";
						} else if (rec.getYellow() != null && rec.getYellow() > 0) {
							cardBadge = "<span class='badge bg-warning text-dark'>경고</span>";
						}

						double ratingVal = rec.getRating() != null ? rec.getRating() : 0.0;
						int goalVal = rec.getGoal() != null ? rec.getGoal() : 0;
						int assistVal = rec.getAssist() != null ? rec.getAssist() : 0;
						String posVal = rec.getPosition() != null ? rec.getPosition() : "-";
						String nameVal = rec.getUserName() != null ? rec.getUserName() : "";
						String memoVal = rec.getMemo() != null ? rec.getMemo() : "";

						html.append("        <tr>");
						html.append("          <td><span class='badge bg-secondary-subtle text-secondary border'>").append(posVal).append("</span></td>");
						html.append("          <td class='fw-semibold'>").append(nameVal).append("</td>");
						html.append("          <td class='text-warning fw-bold'>⭐ ").append(String.format("%.1f", ratingVal)).append("</td>");
						html.append("          <td><span class='text-danger fw-bold'>").append(goalVal).append("득점</span> / ").append(assistVal).append("도움</td>");
						html.append("          <td>").append(cardBadge).append("</td>");
						html.append("          <td class='text-muted text-start text-truncate ps-3'>").append(memoVal).append("</td>");
						html.append("        </tr>");
					}
				} else {
					html.append("        <tr>");
					html.append("          <td colspan='6' class='py-4 text-muted text-center'>해당 경기에 등록된 선수 상세 기록이 없습니다.</td>");
					html.append("        </tr>");
				}

				html.append("      </tbody>");
				html.append("    </table>");
				html.append("  </div>");
				html.append("</div>");

				resp.getWriter().write(html.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.getWriter().write("<p class='text-danger text-center'>데이터를 불러오는 중 오류가 발생했습니다.</p>");
		}
	}

	// 3. 구단 정보 수정 (POST)
	@PostMapping("update")
	public ModelAndView updateClubInfo(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		return new ModelAndView("redirect:/clubowner/ownerpage");
	}

	// 4. 구단 성적 관리 목록 조회
	@GetMapping("matchResultList")
	public ModelAndView getMatchResultList(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null)
			return new ModelAndView("redirect:/member/login");

		try {
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

	// 5. 성적 등록/수정 (POST-AJAX)
	@PostMapping("saveMatchScore")
	public ModelAndView saveMatchScore(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null)
			return new ModelAndView("redirect:/member/login");

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

	// 6. 성적 삭제 (POST-AJAX)
	@PostMapping("deleteMatchScore")
	public ModelAndView deleteMatchScore(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null)
			return new ModelAndView("redirect:/member/login");

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

	// 7. 입단 승인 (POST-AJAX)
	@PostMapping("approvePlayer")
	public ModelAndView approvePlayer(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			String applyNum = req.getParameter("applyNum");
			if (applyNum != null)
				approvalService.approvePlayer(Long.parseLong(applyNum));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/clubowner/ownerpage");
	}

	// 8. 입단 거절 (POST-AJAX)
	@PostMapping("rejectPlayer")
	public ModelAndView rejectPlayer(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			String applyNum = req.getParameter("applyNum");
			String reason = req.getParameter("rejectReason");
			if (applyNum != null)
				approvalService.rejectPlayer(Long.parseLong(applyNum), reason);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/clubowner/ownerpage");
	}

	// 9. 소속 선수 조회 (AJAX)
	@GetMapping("playerList")
	public ModelAndView getPlayerList(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null)
			return new ModelAndView("redirect:/member/login");

		try {
			ClubDTO clubDto = service.selectClubInfoByMemberIdx(info.getMemberIdx());
			if (clubDto != null) {
				ClubOwnerPlayerDTO params = new ClubOwnerPlayerDTO();
				params.setClubOwner_key(clubDto.getClubOwner_key());
				params.setUserName(req.getParameter("userName"));
				params.setPosition(req.getParameter("position"));

				List<ClubOwnerPlayerDTO> playerList = playerService.getClubPlayerList(params);
				req.setAttribute("playerList", playerList);
				req.setAttribute("playerCount", playerList != null ? playerList.size() : 0);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("clubowner/tab/tab_player_list");
	}

	// 10. 소속 선수 제적 (POST-AJAX)
	@PostMapping("removePlayer")
	public ModelAndView removePlayer(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			String num = req.getParameter("clubJoinNum");
			if (num != null)
				playerService.removePlayer(Long.parseLong(num));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/clubowner/ownerpage");
	}

	// 11. 선수 경기 성적 기록 삭제 (POST-AJAX) - 404 에러 해결용 추가
	@PostMapping("deletePlayerRecord")
	public ModelAndView deletePlayerRecord(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		if (info == null)
			return new ModelAndView("redirect:/member/login");

		try {
			String recordId = req.getParameter("recordId");
			if (recordId != null) {
				recordService.deletePlayerRecord(Long.parseLong(recordId));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/clubowner/ownerpage");
	}
}