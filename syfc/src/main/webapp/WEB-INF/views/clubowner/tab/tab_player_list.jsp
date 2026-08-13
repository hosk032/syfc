<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="tab-pane fade" id="player-list">
	<div class="card border-0 shadow-sm rounded-4 p-4">
		<div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom">
			<div>
				<h5 class="fw-bold mb-1">소속 선수 목록 & 평점 관리</h5>
				<p class="text-muted small mb-0">우리 팀 선수들의 목록을 조회하고 경기 매너/실력 평점을 부여합니다.</p>
			</div>
			<span class="text-muted small">총 <strong id="totalPlayerCount" class="text-primary fs-6">18</strong>명</span>
		</div>

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

		<div class="table-responsive">
			<table class="table table-hover align-middle mb-0">
				<thead class="table-light extra-small text-muted text-center">
					<tr>
						<th class="text-start ps-3">선수명</th>
						<th>포지션</th>
						<th>가입일</th>
						<th>현재 평점</th>
						<th>평가 메모</th>
						<th class="text-end pe-3">관리</th>
					</tr>
				</thead>
				<tbody class="small text-center" id="playerListBody">
					<tr id="player-row-1" data-name="박지성" data-position="FW">
						<td class="text-start ps-3 fw-bold text-dark">박지성</td>
						<td><span class="badge bg-danger-subtle text-danger border px-2.5 py-1">FW</span></td>
						<td class="text-muted">2025-03-10</td>
						<td><span class="fw-bold text-warning rating-score">⭐ 4.9</span></td>
						<td class="text-muted text-truncate rating-comment comment-truncate-width" title="활동량 최고, 매너 우수">활동량 최고, 매너 우수</td>
						<td class="text-end pe-3">
							<button class="btn btn-sm btn-outline-primary me-1 fw-bold btn-rating-action" onclick="openRatingModal('박지성', '4.9', '활동량 최고, 매너 우수', 1)">
								<i class="bi bi-star-fill me-1"></i>평점 관리
							</button>
							<button class="btn btn-sm btn-outline-danger fw-bold" onclick="removePlayer('박지성', 1)">제적</button>
						</td>
					</tr>
					<tr id="player-row-2" data-name="손흥민" data-position="FW">
						<td class="text-start ps-3 fw-bold text-dark">손흥민</td>
						<td><span class="badge bg-danger-subtle text-danger border px-2.5 py-1">FW</span></td>
						<td class="text-muted">2025-01-20</td>
						<td><span class="fw-bold text-warning rating-score">⭐ 5.0</span></td>
						<td class="text-muted text-truncate rating-comment comment-truncate-width" title="골 결정력 탁월">골 결정력 탁월</td>
						<td class="text-end pe-3">
							<button class="btn btn-sm btn-outline-primary me-1 fw-bold btn-rating-action" onclick="openRatingModal('손흥민', '5.0', '골 결정력 탁월', 2)">
								<i class="bi bi-star-fill me-1"></i>평점 관리
							</button>
							<button class="btn btn-sm btn-outline-danger fw-bold" onclick="removePlayer('손흥민', 2)">제적</button>
						</td>
					</tr>
					<tr id="player-row-3" data-name="김민재" data-position="DF">
						<td class="text-start ps-3 fw-bold text-dark">김민재</td>
						<td><span class="badge bg-primary-subtle text-primary border px-2.5 py-1">DF</span></td>
						<td class="text-muted">2025-05-12</td>
						<td><span class="text-muted extra-small rating-score">평점 없음</span></td>
						<td class="text-muted rating-comment">-</td>
						<td class="text-end pe-3">
							<button class="btn btn-sm btn-outline-primary me-1 fw-bold btn-rating-action" onclick="openRatingModal('김민재', '0', '', 3)">
								<i class="bi bi-star me-1"></i>평점 등록
							</button>
							<button class="btn btn-sm btn-outline-danger fw-bold" onclick="removePlayer('김민재', 3)">제적</button>
						</td>
					</tr>
					<tr id="player-row-4" data-name="홍길동" data-position="MF">
						<td class="text-start ps-3 fw-bold text-dark">홍길동 <span class="badge bg-warning text-dark extra-small ms-1">구단주</span></td>
						<td><span class="badge bg-primary-subtle text-primary border px-2.5 py-1">MF</span></td>
						<td class="text-muted">2024-01-15</td>
						<td><span class="fw-bold text-warning rating-score">⭐ 5.0</span></td>
						<td class="text-muted rating-comment">팀 리더</td>
						<td class="text-end pe-3">
							<button class="btn btn-sm btn-outline-primary me-1 fw-bold btn-rating-action" onclick="openRatingModal('홍길동', '5.0', '팀 리더', 4)">
								<i class="bi bi-star-fill me-1"></i>평점 관리
							</button>
							<button class="btn btn-sm btn-secondary disabled extra-small" disabled>본인</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>