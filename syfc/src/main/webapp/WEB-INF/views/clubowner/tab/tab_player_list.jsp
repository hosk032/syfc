<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="tab-pane fade" id="player-list">
	<div class="card border-0 shadow-sm rounded-4 p-4">
		<!-- 헤더 영역 -->
		<div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom">
			<div>
				<h5 class="fw-bold mb-1">소속 선수 목록 & 제적 관리</h5>
				<p class="text-muted small mb-0">우리 팀 소속 선수 목록을 조회하고 필요 시 제적(강퇴) 처리를 진행합니다.</p>
			</div>
			<span class="text-muted small">총 <strong id="totalPlayerCount" class="text-primary fs-6">4</strong>명</span>
		</div>

		<!-- 검색 및 필터 영역 -->
		<div class="row g-2 mb-3 justify-content-between align-items-center">
			<div class="col-md-4">
				<div class="input-group input-group-sm">
					<span class="input-group-text bg-light text-muted border-end-0"><i class="bi bi-search"></i></span>
					<input type="text" class="form-control form-control-sm border-start-0 bg-light" id="searchPlayerKeyword" placeholder="선수명 검색..." onkeyup="filterPlayerList()">
				</div>
			</div>
			<div class="col-md-3 text-md-end">
				<select class="form-select form-select-sm fw-bold" id="filterPosition" onchange="filterPlayerList()">
					<option value="" selected>전체 포지션</option>
					<option value="FW">FW (공격수)</option>
					<option value="MF">MF (미드필더)</option>
					<option value="DF">DF (수비수)</option>
					<option value="GK">GK (골키퍼)</option>
				</select>
			</div>
		</div>

		<!-- 선수 목록 테이블 -->
		<div class="table-responsive">
			<table class="table table-hover align-middle mb-0">
				<thead class="table-light extra-small text-muted text-center">
					<tr>
						<th class="text-start ps-4" style="width: 30%;">선수명</th>
						<th style="width: 20%;">포지션</th>
						<th style="width: 30%;">가입일</th>
						<th class="text-end pe-4" style="width: 20%;">관리</th>
					</tr>
				</thead>
				<tbody class="small text-center" id="playerListBody">
					<tr id="player-row-1" data-name="박지성" data-position="FW">
						<td class="text-start ps-4 fw-bold text-dark">박지성</td>
						<td><span class="badge bg-danger-subtle text-danger border px-2.5 py-1">FW</span></td>
						<td class="text-muted">2025-03-10</td>
						<td class="text-end pe-4">
							<button class="btn btn-sm btn-outline-danger fw-bold" onclick="removePlayer('박지성', 1)">제적</button>
						</td>
					</tr>
					<tr id="player-row-2" data-name="손흥민" data-position="FW">
						<td class="text-start ps-4 fw-bold text-dark">손흥민</td>
						<td><span class="badge bg-danger-subtle text-danger border px-2.5 py-1">FW</span></td>
						<td class="text-muted">2025-01-20</td>
						<td class="text-end pe-4">
							<button class="btn btn-sm btn-outline-danger fw-bold" onclick="removePlayer('손흥민', 2)">제적</button>
						</td>
					</tr>
					<tr id="player-row-3" data-name="김민재" data-position="DF">
						<td class="text-start ps-4 fw-bold text-dark">김민재</td>
						<td><span class="badge bg-primary-subtle text-primary border px-2.5 py-1">DF</span></td>
						<td class="text-muted">2025-05-12</td>
						<td class="text-end pe-4">
							<button class="btn btn-sm btn-outline-danger fw-bold" onclick="removePlayer('김민재', 3)">제적</button>
						</td>
					</tr>
					<tr id="player-row-4" data-name="홍길동" data-position="MF">
						<td class="text-start ps-4 fw-bold text-dark">홍길동 <span class="badge bg-warning text-dark extra-small ms-1">구단주</span></td>
						<td><span class="badge bg-primary-subtle text-primary border px-2.5 py-1">MF</span></td>
						<td class="text-muted">2024-01-15</td>
						<td class="text-end pe-4">
							<button class="btn btn-sm btn-secondary disabled extra-small" disabled>본인</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>