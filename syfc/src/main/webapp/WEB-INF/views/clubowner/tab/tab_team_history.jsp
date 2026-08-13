<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="tab-pane fade" id="team-history">
	<div class="card border-0 shadow-sm rounded-4 p-4">
		<div
			class="d-flex justify-content-between align-items-center pb-3 mb-4 border-bottom">
			<div>
				<h5 class="fw-bold mb-1">경기 이력 및 전적</h5>
				<p class="text-muted small mb-0">우리 팀의 누적 매치 통계 및 경기 결과 조회</p>
			</div>
		</div>

		<div class="row g-3 mb-4">
			<div class="col-6 col-md-3">
				<div class="p-3 bg-light rounded-3 text-center">
					<div class="text-muted extra-small fw-bold">전체 경기</div>
					<div class="fs-4 fw-bold text-dark mt-1" id="summaryTotal">16전</div>
				</div>
			</div>
			<div class="col-6 col-md-3">
				<div class="p-3 bg-light rounded-3 text-center">
					<div class="text-muted extra-small fw-bold">전적</div>
					<div class="fs-4 fw-bold text-primary mt-1" id="summaryRecord">12승
						4패</div>
				</div>
			</div>
			<div class="col-6 col-md-3">
				<div class="p-3 bg-light rounded-3 text-center">
					<div class="text-muted extra-small fw-bold">승률</div>
					<div class="fs-4 fw-bold text-success mt-1" id="summaryWinRate">75.0%</div>
				</div>
			</div>
			<div class="col-6 col-md-3">
				<div class="p-3 bg-light rounded-3 text-center">
					<div class="text-muted extra-small fw-bold">득/실점</div>
					<div class="fs-4 fw-bold text-dark mt-1" id="summaryGoals">42
						/ 18</div>
				</div>
			</div>
		</div>


		<div
			class="d-flex flex-wrap gap-2 mb-3 align-items-center justify-content-between">
			<div class="d-flex align-items-center gap-2">
				<select class="form-select form-select-sm fw-bold select-year-width"
					id="searchYear" style="width: 110px;">
					<option value="2026" selected>2026년</option>
					<option value="2025">2025년</option>
					<option value="2024">2024년</option>
				</select> <select
					class="form-select form-select-sm fw-bold select-month-width"
					id="searchMonth" style="width: 100px;">
					<option value="">전체 월</option>
					<option value="08" selected>8월</option>
					<option value="07">7월</option>
					<option value="06">6월</option>
				</select> <select
					class="form-select form-select-sm fw-bold select-result-width"
					id="searchResult" style="width: 110px;">
					<option value="">전체 결과</option>
					<option value="WIN">승리</option>
					<option value="DRAW">무승부</option>
					<option value="LOSE">패배</option>
				</select>
				<!-- flex-shrink-0 및 text-nowrap 추가로 버튼 찌그러짐 방지 -->
				<button
					class="btn btn-sm btn-dark px-3 fw-bold flex-shrink-0 text-nowrap"
					onclick="loadTeamHistory()">조회</button>
			</div>
			<span class="text-muted small">총 <strong id="searchTotalCount"
				class="text-primary">16</strong>건
			</span>
		</div>

		<div class="table-responsive">
			<table
				class="table table-hover align-middle text-center border-top mb-0">
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
					<tr>
						<td class="text-muted">2026-08-01 20:00</td>
						<td class="fw-semibold">쌍용 주 경기장</td>
						<td><span class="badge bg-light text-dark border me-1">홈</span><strong
							class="text-dark">FC 쌍용</strong> vs 드림 FC</td>
						<td class="fw-bold fs-6 text-primary">4 : 2</td>
						<td><span class="badge bg-primary px-3 py-1">승리</span></td>
					</tr>
					<tr>
						<td class="text-muted">2026-07-25 18:00</td>
						<td class="fw-semibold">마포 구민 체육센터</td>
						<td><span class="badge bg-light text-dark border me-1">홈</span><strong
							class="text-dark">FC 쌍용</strong> vs 마포 풋살 클럽</td>
						<td class="fw-bold fs-6 text-secondary">2 : 2</td>
						<td><span class="badge bg-secondary px-3 py-1">무승부</span></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>