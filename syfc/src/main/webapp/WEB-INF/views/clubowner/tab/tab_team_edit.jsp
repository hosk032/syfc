<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="tab-pane fade show active" id="team-edit" role="tabpanel">
	<div class="card shadow-sm border-0 rounded-4">
		<div class="card-body p-4">

			<div class="d-flex justify-content-between align-items-center mb-3">
				<div>
					<h5 class="fw-bold mb-1">구단 정보 등록 및 수정</h5>
					<p class="text-muted small mb-0">우리 구단의 대표 이미지와 연고지, 상세 정보를 관리합니다.</p>
				</div>
				<span class="badge ${club.club_status == 1 ? 'bg-success-subtle text-success border border-success-subtle' : 'bg-secondary-subtle text-secondary'} px-3 py-2 rounded-pill">
					${club.club_status == 1 ? '활동 중' : '휴면 상태'}
				</span>
			</div>

			<hr class="my-3">

			<!-- 구단 정보 수정 Form -->
			<form name="clubForm" action="${pageContext.request.contextPath}/clubowner/update" method="post" enctype="multipart/form-data">

				<!-- 구단주 PK (hidden) -->
				<input type="hidden" name="clubOwner_key" value="${club.clubOwner_key}">

				<!-- 구단 엠블럼 (로고) -->
				<div class="bg-light p-3 rounded-3 mb-4 d-flex align-items-center gap-3">
					<div class="position-relative">
						<c:choose>
							<c:when test="${not empty club.club_logo}">
								<img id="previewEmblem" src="${pageContext.request.contextPath}/uploads/club/${club.club_logo}"
									 class="rounded-circle border border-2 border-white shadow-sm"
									 style="width: 80px; height: 80px; object-fit: cover;" alt="구단 로고">
							</c:when>
							<c:otherwise>
								<div id="defaultEmblemIcon" class="bg-primary bg-opacity-10 text-primary rounded-circle d-flex align-items-center justify-content-center"
									 style="width: 80px; height: 80px; font-size: 2rem;">⚽</div>
								<img id="previewEmblem" src="" class="rounded-circle border border-2 border-white shadow-sm d-none"
									 style="width: 80px; height: 80px; object-fit: cover;" alt="구단 로고 미리보기">
							</c:otherwise>
						</c:choose>
					</div>
					<div>
						<label class="form-label fw-semibold small mb-1">구단 엠블럼 (로고)</label>
						<input type="file" name="uploadLogo" id="uploadLogoInput" class="form-control form-control-sm" accept="image/*">
						<span class="text-muted small" style="font-size: 0.75rem;">이미지를 등록하거나 새로운 파일로 변경하세요. (권장 규격: 300x300px)</span>
					</div>
				</div>

				<h6 class="fw-bold border-bottom pb-2 mb-3">
					<i class="bi bi-info-circle me-1"></i>기본 정보
				</h6>

				<div class="row g-3 mb-3">
					<!-- 구단명 -->
					<div class="col-md-6">
						<label class="form-label small fw-semibold">구단명 <span class="text-danger">*</span></label>
						<input type="text" name="club_name" class="form-control" value="${club.club_name}" placeholder="구단명을 입력하세요" required>
					</div>

					<!-- 창단일 -->
					<div class="col-md-6">
						<label class="form-label small fw-semibold">창단일</label>
						<input type="date" name="club_created" class="form-control" value="${club.club_created}">
					</div>
				</div>

				<div class="row g-3 mb-4">
					<!-- 연고지 -->
					<div class="col-md-12">
						<label class="form-label small fw-semibold">연고지 <span class="text-danger">*</span></label>
						<input type="text" name="club_region" class="form-control" value="${club.club_region}" placeholder="예: 서울 마포구, 전북 전주시, 경기 고양시" required>
					</div>
				</div>

				<h6 class="fw-bold border-bottom pb-2 mb-3">
					<i class="bi bi-file-text me-1"></i>구단 소개 및 회칙
				</h6>

				<!-- 상세 소개글 -->
				<div class="mb-4">
					<label class="form-label small fw-semibold">구단 소개 및 회칙</label>
					<textarea name="club_content" class="form-control" rows="6" placeholder="구단 소개, 활동 시간대, 회원 모집 가입 조건 및 회칙을 자유롭게 작성해 주세요.">${club.club_content}</textarea>
				</div>

				<!-- 버튼 영역 -->
				<div class="d-flex justify-content-end gap-2">
					<button type="reset" class="btn btn-light border btn-sm px-3">취소</button>
					<button type="submit" class="btn btn-primary btn-sm px-4 fw-bold">
						<i class="bi bi-check-circle me-1"></i>저장하기
					</button>
				</div>

			</form>

		</div>
	</div>
</div>