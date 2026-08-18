<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="tab-pane fade" id="team-history">
	<div class="card border-0 shadow-sm rounded-4 p-4">
		<div class="d-flex justify-content-between align-items-center pb-3 mb-4 border-bottom">
			<div>
				<h5 class="fw-bold mb-1">경기 이력 및 전적</h5>
				<p class="text-muted small mb-0">우리 팀의 누적 매치 통계 및 경기 결과 조회</p>
			</div>
		</div>

		<!-- 상단 요약 카드 -->
		<div class="row g-3 mb-4">
			<div class="col-6 col-md-3">
				<div class="p-3 bg-light rounded-3 text-center">
					<div class="text-muted extra-small fw-bold">전체 경기</div>
					<div class="fs-4 fw-bold text-dark mt-1" id="summaryTotal">${empty matchList ? 0 : matchList.size()}전</div>
				</div>
			</div>
			<div class="col-6 col-md-3">
				<div class="p-3 bg-light rounded-3 text-center">
					<div class="text-muted extra-small fw-bold">전적</div>
					<div class="fs-4 fw-bold text-primary mt-1" id="summaryRecord">-</div>
				</div>
			</div>
			<div class="col-6 col-md-3">
				<div class="p-3 bg-light rounded-3 text-center">
					<div class="text-muted extra-small fw-bold">승률</div>
					<div class="fs-4 fw-bold text-success mt-1" id="summaryWinRate">-</div>
				</div>
			</div>
			<div class="col-6 col-md-3">
				<div class="p-3 bg-light rounded-3 text-center">
					<div class="text-muted extra-small fw-bold">득/실점</div>
					<div class="fs-4 fw-bold text-dark mt-1" id="summaryGoals">-</div>
				</div>
			</div>
		</div>

		<!-- 검색 필터 영역 -->
		<div class="d-flex flex-wrap gap-2 mb-3 align-items-center justify-content-between">
			<div class="d-flex align-items-center gap-2">
				<select class="form-select form-select-sm fw-bold select-year-width" id="searchYear" style="width: 110px;">
					<option value="" selected>전체 년도</option>
					<option value="2026">2026년</option>
					<option value="2025">2025년</option>
					<option value="2024">2024년</option>
				</select> 
				<select class="form-select form-select-sm fw-bold select-month-width" id="searchMonth" style="width: 100px;">
					<option value="" selected>전체 월</option>
					<option value="08">8월</option>
					<option value="07">7월</option>
					<option value="06">6월</option>
				</select> 
				<select class="form-select form-select-sm fw-bold select-result-width" id="searchResult" style="width: 110px;">
					<option value="" selected>전체 결과</option>
					<option value="WIN">승리</option>
					<option value="DRAW">무승부</option>
					<option value="LOSE">패배</option>
				</select>
				<button type="button" class="btn btn-sm btn-dark px-3 fw-bold flex-shrink-0 text-nowrap" onclick="loadTeamHistory()">조회</button>
			</div>
			<span class="text-muted small">총 <strong id="searchTotalCount" class="text-primary">${empty matchList ? 0 : matchList.size()}</strong>건</span>
		</div>

		<!-- 테이블 영역 -->
		<div class="table-responsive">
			<table class="table table-hover align-middle text-center border-top mb-0">
				<thead class="table-light extra-small text-muted">
					<tr>
						<th class="th-date-width">일시</th>
						<th>경기장</th>
						<th>대진 (홈 vs 원정)</th>
						<th class="th-score-width">스코어</th>
						<th class="th-result-width">결과</th>
					</tr>
				</thead>
				<tbody class="small" id="matchHistoryList">
					<!-- include 제거 후 직접 JSTL 루프 처리 -->
					<c:forEach var="dto" items="${matchList}">
						<tr>
							<td class="text-muted">
								<c:set var="mDate" value="${dto.matchDate}" />
								${mDate.substring(0, 10)} 
								<c:choose>
									<c:when test="${dto.matchTime == 1}">
										<span class="badge bg-light text-dark border ms-1">오전 (09:00 ~ 12:00)</span>
									</c:when>
									<c:when test="${dto.matchTime == 2}">
										<span class="badge bg-light text-dark border ms-1">오후 (14:00 ~ 17:00)</span>
									</c:when>
									<c:otherwise>
										<span class="badge bg-light text-dark border ms-1">야간 (18:00 ~ 21:00)</span>
									</c:otherwise>
								</c:choose>
							</td>
							<td class="fw-semibold">${dto.stadiumName}</td>
							<td>
								<strong class="text-dark">${dto.homeClubName}</strong> vs ${dto.awayClubName}
							</td>
							<td class="fw-bold fs-6 text-primary">${dto.homeScore} : ${dto.awayScore}</td>
							<td>
								<c:choose>
									<c:when test="${dto.homeScore > dto.awayScore}">
										<span class="badge bg-primary px-3 py-1">승리</span>
									</c:when>
									<c:when test="${dto.homeScore == dto.awayScore}">
										<span class="badge bg-secondary px-3 py-1">무승부</span>
									</c:when>
									<c:otherwise>
										<span class="badge bg-danger px-3 py-1">패배</span>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>

					<!-- 경기 이력이 없을 경우 처리 -->
					<c:if test="${empty matchList}">
						<tr>
							<td colspan="5" class="py-5 text-center text-muted">
								<i class="bi bi-journal-x fs-1 d-block mb-2 text-secondary opacity-50"></i>
								조회된 경기 이력이 없습니다.
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
</div>