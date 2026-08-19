<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="tab-pane fade" id="player-approval" role="tabpanel">
	<div class="card border-0 shadow-sm rounded-4 p-4">
		<!-- Header -->
		<div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom">
			<div>
				<h5 class="fw-bold mb-1">입단 신청 관리</h5>
				<p class="text-muted small mb-0">우리 구단에 가입 신청한 선수들의 프로필을 확인하고 승인/거절합니다.</p>
			</div>
			<span class="text-muted small">
				대기 중: <strong class="text-danger fs-6" id="approvalPendingCount">${empty pendingCount ? 0 : pendingCount}</strong>건
			</span>
		</div>

		<!-- Table -->
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
					<c:forEach var="dto" items="${approvalList}">
						<tr id="approval-row-${dto.applyNum}">
							<td class="text-start ps-3 fw-bold text-dark">
								${dto.userName} <span class="text-muted extra-small fw-normal">(${dto.userAge}세)</span>
							</td>
							<td>
								<c:choose>
									<c:when test="${dto.position == 'MF'}">
										<span class="badge bg-primary-subtle text-primary border px-2.5 py-1">MF (미드필더)</span>
									</c:when>
									<c:when test="${dto.position == 'FW'}">
										<span class="badge bg-danger-subtle text-danger border px-2.5 py-1">FW (공격수)</span>
									</c:when>
									<c:when test="${dto.position == 'DF'}">
										<span class="badge bg-success-subtle text-success border px-2.5 py-1">DF (수비수)</span>
									</c:when>
									<c:otherwise>
										<span class="badge bg-warning-subtle text-warning border px-2.5 py-1">GK (골키퍼)</span>
									</c:otherwise>
								</c:choose>
							</td>
							<td class="text-muted">${dto.applyDate}</td>
							<td class="text-start text-muted text-truncate cursor-pointer msg-truncate-width" 
								data-bs-toggle="tooltip" data-bs-placement="top" title="${dto.memo}">
								${dto.memo}
							</td>
							<td class="text-end pe-3">
								<button type="button" class="btn btn-sm btn-primary px-3 py-1 me-1 fw-bold shadow-sm" 
										onclick="approvePlayerProcess('${dto.applyNum}', '${dto.userName}')">
									승인
								</button>
								<button type="button" class="btn btn-sm btn-outline-danger px-3 py-1 fw-bold" 
										onclick="openRejectModal('${dto.applyNum}', '${dto.userName}')">
									거절
								</button>
							</td>
						</tr>
					</c:forEach>

					<%-- 대기 건수가 없는 경우 --%>
					<c:if test="${empty approvalList}">
						<tr class="empty-row">
							<td colspan="5" class="py-5 text-center text-muted">
								<i class="bi bi-person-check fs-1 d-block mb-2 text-secondary opacity-50"></i>
								현재 대기 중인 입단 신청이 없습니다.
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
</div>

<!-- ========================================================================== -->
<!-- [모달] 입단 신청 거절 사유 입력 모달                                         -->
<!-- ========================================================================== -->
<div class="modal fade" id="rejectReasonModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content border-0 shadow rounded-4">
			<div class="modal-header border-bottom-0 pb-0">
				<h6 class="modal-header-title fw-bold text-dark mb-0">
					<i class="bi bi-exclamation-triangle-fill text-danger me-2"></i>입단 신청 거절
				</h6>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body p-4">
				<p class="small text-muted mb-3">
					<strong id="rejectTargetName" class="text-dark"></strong> 선수의 입단 신청을 거절합니다. 거절 사유는 신청자에게 안내됩니다.
				</p>
				<!-- AJAX 수신용 Hidden Input -->
				<input type="hidden" id="rejectApplyNum" value="">

				<div class="mb-3">
					<label class="form-label small fw-bold text-secondary">거절 사유 선택</label>
					<select class="form-select form-select-sm" id="rejectReasonSelect" onchange="changeRejectReason(this.value)">
						<option value="정원 초과">포지션 정원이 초과되었습니다.</option>
						<option value="활동 지역 불일치">주요 활동 지역이 일치하지 않습니다.</option>
						<option value="custom">직접 입력</option>
					</select>
				</div>
				<div>
					<label class="form-label small fw-bold text-secondary">상세 거절 사유</label>
					<textarea class="form-control form-control-sm" id="rejectReasonText" rows="3">포지션 정원이 초과되었습니다.</textarea>
				</div>
			</div>
			<div class="modal-footer border-top-0 pt-0">
				<button type="button" class="btn btn-sm btn-light px-3" data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-sm btn-danger px-4 fw-bold" onclick="submitRejectProcess()">거절 확정</button>
			</div>
		</div>
	</div>
</div>