<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="tab-pane fade" id="team-history">
	<div class="card border-0 shadow-sm rounded-4 p-4">
		
		<!-- 탭 헤더 -->
		<div class="d-flex justify-content-between align-items-center pb-3 mb-4 border-bottom">
			<div>
				<h5 class="fw-bold mb-1 text-dark">
					<i class="bi bi-journal-text text-primary me-2"></i>구단 경기 이력 조회
				</h5>
				<p class="text-muted small mb-0">우리 구단의 역대 경기 결과 및 상세 기록을 조회합니다.</p>
			</div>
			<div class="text-end">
				<span class="badge bg-primary bg-opacity-10 text-primary border border-primary px-3 py-2 rounded-pill fw-bold" id="summaryTotal">0전</span>
			</div>
		</div>

		<!-- 검색 및 필터 바 -->
		<div class="card border bg-light rounded-4 p-3 mb-4 shadow-sm">
			<div class="row g-2 align-items-center">
				<div class="col-md-3">
					<select class="form-select form-select-sm" id="searchYear" onchange="loadTeamHistory()">
						<option value="">전체 연도</option>
						<option value="2026" selected>2026년</option>
						<option value="2025">2025년</option>
					</select>
				</div>
				<div class="col-md-3">
					<select class="form-select form-select-sm" id="searchMonth" onchange="loadTeamHistory()">
						<option value="">전체 월</option>
						<option value="01">1월</option>
						<option value="02">2월</option>
						<option value="03">3월</option>
						<option value="04">4월</option>
						<option value="05">5월</option>
						<option value="06">6월</option>
						<option value="07">7월</option>
						<option value="08">8월</option>
						<option value="09">9월</option>
						<option value="10">10월</option>
						<option value="11">11월</option>
						<option value="12">12월</option>
					</select>
				</div>
				<div class="col-md-4">
					<select class="form-select form-select-sm" id="searchResult" onchange="loadTeamHistory()">
						<option value="">전체 결과 (승/무/패)</option>
						<option value="WIN">승리</option>
						<option value="DRAW">무승부</option>
						<option value="LOSE">패배</option>
					</select>
				</div>
				<div class="col-md-2 text-end">
					<span class="small text-muted">총 <strong id="searchTotalCount" class="text-dark">0</strong>건</span>
				</div>
			</div>
		</div>

		<!-- 경기 이력 목록 테이블 -->
		<div class="table-responsive">
			<table class="table table-hover align-middle text-center border-top mb-0">
				<thead class="table-light extra-small text-muted">
					<tr>
						<th>경기 일자</th>
						<th>경기장</th>
						<th>상대 구단</th>
						<th>결과 (스코어)</th>
						<th>상세 보기</th>
					</tr>
				</thead>
				<tbody class="small" id="matchHistoryList">
					<!-- AJAX를 통해 경기 이력 데이터가 동적으로 로드되는 영역입니다 -->
					<tr>
						<td colspan="5" class="py-5 text-center text-muted">
							<i class="bi bi-search fs-1 d-block mb-2 text-secondary opacity-50"></i>
							조회된 경기 이력이 없습니다.
						</td>
					</tr>
				</tbody>
			</table>
		</div>

	</div>
</div>