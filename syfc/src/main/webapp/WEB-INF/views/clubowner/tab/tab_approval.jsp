<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="tab-pane fade show active" id="player-approval">
	<div class="card border-0 shadow-sm rounded-4 p-4">
		<div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom">
			<div>
				<h5 class="fw-bold mb-1">입단 신청 관리</h5>
				<p class="text-muted small mb-0">우리 구단에 가입 신청한 선수들의 프로필을 확인하고 승인/거절합니다.</p>
			</div>
			<span class="text-muted small">대기 중: <strong class="text-danger fs-6" id="approvalPendingCount">2</strong>건</span>
		</div>

		<div class="table-responsive">
			<table class="table table-hover align-middle mb-0">
				<thead class="table-light extra-small text-muted text-center">
					<tr>
						<th class="text-start ps-3">신청자</th>
						<th>포지션</th>
						<th>신청일자</th>
						<th>자기소개 / 메시지</th>
						<th class="text-end pe-3">승인 / 거절</th>
					</tr>
				</thead>
				<tbody class="small text-center" id="approvalListBody">
					<tr id="approval-row-1">
						<td class="text-start ps-3 fw-bold text-dark">김철수 <span class="text-muted extra-small fw-normal">(26세)</span></td>
						<td><span class="badge bg-primary-subtle text-primary border px-2.5 py-1">MF (미드필더)</span></td>
						<td class="text-muted">2026-08-03</td>
						<td class="text-start text-muted text-truncate cursor-pointer msg-truncate-width" data-bs-toggle="tooltip" data-bs-placement="top" title="매너 있게 주말 정기전 적극 참여하겠습니다!">
							매너 있게 주말 정기전 적극 참여하겠습니다!
						</td>
						<td class="text-end pe-3">
							<button class="btn btn-sm btn-primary px-3 py-1 me-1 fw-bold shadow-sm" onclick="approvePlayer('김철수', 1)">승인</button>
							<button class="btn btn-sm btn-outline-danger px-3 py-1 fw-bold" onclick="openRejectModal('김철수', 1)">거절</button>
						</td>
					</tr>
					<tr id="approval-row-2">
						<td class="text-start ps-3 fw-bold text-dark">이영희 <span class="text-muted extra-small fw-normal">(24세)</span></td>
						<td><span class="badge bg-danger-subtle text-danger border px-2.5 py-1">FW (공격수)</span></td>
						<td class="text-muted">2026-08-02</td>
						<td class="text-start text-muted text-truncate cursor-pointer msg-truncate-width" data-bs-toggle="tooltip" data-bs-placement="top" title="즐겁게 운동하고 싶습니다! 열정 넘칩니다.">
							즐겁게 운동하고 싶습니다! 열정 넘칩니다.
						</td>
						<td class="text-end pe-3">
							<button class="btn btn-sm btn-primary px-3 py-1 me-1 fw-bold shadow-sm" onclick="approvePlayer('이영희', 2)">승인</button>
							<button class="btn btn-sm btn-outline-danger px-3 py-1 fw-bold" onclick="openRejectModal('이영희', 2)">거절</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>