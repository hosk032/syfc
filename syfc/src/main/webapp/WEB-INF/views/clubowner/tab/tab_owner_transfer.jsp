<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="tab-pane fade" id="owner-transfer">
	<div class="card border-0 shadow-sm rounded-4 p-4">
		<div class="d-flex justify-content-between align-items-center pb-3 mb-4 border-bottom">
			<div>
				<h5 class="fw-bold text-danger mb-1"><i class="bi bi-arrow-left-right me-2"></i>구단주 권한 위임 / 변경 신청</h5>
				<p class="text-muted small mb-0">팀 관리 권한을 소속 팀원(선수)에게 안전하게 이양합니다.</p>
			</div>
			<span class="badge bg-danger-subtle text-danger border border-danger-subtle px-3 py-2 rounded-pill fw-bold">중요 변경</span>
		</div>

		<div class="alert alert-warning border-0 p-3 rounded-4 mb-4 small text-secondary d-flex align-items-start gap-2 shadow-sm">
			<!-- <i class="bi bi-exclamation-triangle-fill fs-5 text-warning flex-shrink-0 mt-1"></i> -->
			<div>
				<strong class="d-block text-dark mb-1">⚠️ 구단주 권한 양도 시 주의사항</strong>
				1. 권한 양도가 완료되면 현재 계정은 즉시 <strong>일반 소속 선수</strong> 등급으로 변경됩니다.<br>
				2. 양도 처리 후에는 구단주 권한을 직접 취소하거나 되돌릴 수 없으니 신중하게 선택해 주세요.
			</div>
		</div>

		<div class="bg-light p-4 rounded-4 border mx-auto w-100 transfer-form-max-width">
			<form id="ownerTransferForm">
				<div class="mb-3">
					<label class="form-label small fw-bold text-dark mb-1">차기 구단주 선택 <span class="text-danger">*</span></label>
					<select class="form-select form-select-sm fw-bold" name="nextOwnerId" id="nextOwnerSelect">
						<option value="" selected disabled>위임받을 선수를 선택하세요</option>
						<option value="user02" data-name="박지성">박지성 (FW | 가입 2025-03-10 | 010-1234-****)</option>
						<option value="user03" data-name="손흥민">손흥민 (FW | 가입 2025-01-20 | 010-9876-****)</option>
						<option value="user04" data-name="김민재">김민재 (DF | 가입 2025-05-12 | 010-5555-****)</option>
					</select>
				</div>
				<div class="mb-3">
					<label class="form-label small fw-bold text-dark mb-1">양도 사유</label>
					<textarea class="form-control form-control-sm" name="transferReason" id="transferReason" rows="3" placeholder="차기 구단주 지정 사유나 전달 메시지를 작성해 주세요. (예: 개인 사정으로 인한 리더십 이양)"></textarea>
				</div>
				<div class="mb-3">
					<label class="form-label small fw-bold text-dark mb-1">현재 비밀번호 재확인 <span class="text-danger">*</span></label>
					<input type="password" class="form-control form-control-sm" name="currentPassword" id="transferPassword" placeholder="현재 계정의 비밀번호를 입력하세요">
				</div>
				<div class="form-check mb-4 p-2 bg-white rounded border ps-4">
					<input class="form-check-input ms-0 me-2" type="checkbox" id="transferAgree">
					<label class="form-check-label extra-small text-dark fw-bold cursor-pointer" for="transferAgree">
						위 주의사항을 모두 확인하였으며, 구단주 권한 위임에 동의합니다.
					</label>
				</div>
				<button type="button" class="btn btn-danger w-100 fw-bold py-2 shadow-sm" onclick="submitOwnerTransfer()">
					<i class="bi bi-shield-lock-fill me-1"></i> 구단주 변경 신청 확정
				</button>
			</form>
		</div>
	</div>
</div>