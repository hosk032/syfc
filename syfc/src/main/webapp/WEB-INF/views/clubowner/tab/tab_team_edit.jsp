<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="tab-pane fade" id="team-edit">
	<div class="card border-0 shadow-sm rounded-4 p-4">
		<div
			class="d-flex justify-content-between align-items-center pb-3 mb-4 border-bottom">
			<div>
				<h5 class="fw-bold mb-1">구단 정보 등록 및 수정</h5>
				<p class="text-muted small mb-0">우리 구단의 대표 이미지와 회칙, 연고지를 관리합니다.</p>
			</div>
			<span
				class="badge bg-success-subtle text-success px-3 py-2 rounded-pill">활동
				중</span>
		</div>

		<form id="teamEditForm" method="post" enctype="multipart/form-data">
			<input type="hidden" name="clubNo" value="${clubDto.clubNo}">
			<input type="hidden" name="originalLogo" value="${clubDto.clubLogo}">

			<div
				class="p-3 bg-light rounded-4 mb-4 d-flex align-items-center gap-3">
				<div
					class="position-relative flex-shrink-0 emblem-wrapper cursor-pointer"
					style="width: 80px; height: 80px;"
					onclick="document.getElementById('clubEmblem').click();">
					<div
						class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center shadow-sm w-100 h-100 overflow-hidden emblem-icon fs-2"
						id="emblemPreview">⚽</div>
					<span
						class="position-absolute bottom-0 end-0 bg-dark text-white rounded-circle p-1 d-flex align-items-center justify-content-center shadow-sm emblem-camera-btn"
						style="width: 26px; height: 26px; font-size: 12px;"> <i
						class="bi bi-camera-fill"></i>
					</span>
				</div>
				<div>
					<label class="form-label fw-bold small text-dark mb-1">구단
						엠블럼 (로고)</label>
					<p class="text-muted extra-small mb-2">이미지를 클릭하거나 아래 버튼으로
						변경하세요. (권장 규격: 300x300px)</p>
					<input type="file" class="form-control form-control-sm"
						id="clubEmblem" name="clubEmblemFile" accept="image/*"
						onchange="previewImage(this)">
				</div>
			</div>

			<h6 class="fw-bold text-dark mb-3">
				<i class="bi bi-info-circle text-primary me-1"></i> 기본 정보
			</h6>
			<div class="row g-3 mb-4">
				<div class="col-md-6">
					<label class="form-label small text-muted">구단명 <span
						class="text-danger ms-1">*</span></label> <input type="text"
						class="form-control" name="teamName" value="FC 쌍용" required>
				</div>
				<div class="col-md-6">
					<label class="form-label small text-muted">창단일</label> <input
						type="date" class="form-control" name="foundedDate"
						value="2024-01-15">
				</div>
				<div class="col-md-6">
					<label class="form-label small text-muted">연고지 <span
						class="text-danger ms-1">*</span></label> <select class="form-select"
						name="region">
						<option value="서울 마포구" selected>서울 마포구</option>
						<option value="서울 강남구">서울 강남구</option>
						<option value="경기 고양시">경기 고양시</option>
					</select>
				</div>
				<div class="col-md-6">
					<label class="form-label small text-muted">주 활동 시간대</label> <select
						class="form-select" name="preferredTime">
						<option value="주말 야간 (18:00~22:00)" selected>주말 야간
							(18:00~22:00)</option>
						<option value="주말 주간 (10:00~14:00)">주말 주간 (10:00~14:00)</option>
					</select>
				</div>
			</div>

			<h6 class="fw-bold text-dark mb-3">
				<i class="bi bi-file-text text-primary me-1"></i> 구단 소개
			</h6>
			<div class="mb-3">
				<label class="form-label small text-muted">한 줄 소개</label> <input
					type="text" class="form-control" name="shortIntro"
					value="즐겁고 매너 있는 축구를 지향하는 마포구 풋살/축구 팀입니다!">
			</div>
			<div class="mb-3">
				<label class="form-label small text-muted">상세 소개글</label>
				<textarea class="form-control" name="fullIntro" rows="4">FC 쌍용은 2024년에 창단된 마포구 기반 아마추어 축구팀입니다. 매주 토요일 저녁 정기 매치를 진행하며, 매너와 친목을 최우선으로 합니다!</textarea>
			</div>
			<div class="mb-4">
				<div class="d-flex justify-content-between align-items-center mb-1">
					<label class="form-label small text-muted mb-0">회칙 및 가입 조건</label>
					<span class="extra-small text-muted">줄바꿈(Enter)으로 항목을 구분하세요.</span>
				</div>
				<textarea class="form-control" name="rules" rows="4">1. 매너 플레이 필수 (지각/무단불참 금지)&#10;2. 연령대: 20대 ~ 30대&#10;3. 유니폼 착용 필수</textarea>
			</div>

			<div class="d-flex justify-content-end gap-2 pt-3 border-top">
				<button type="button"
					class="btn btn-light border px-4 fw-bold text-secondary">취소</button>
				<button type="button" class="btn btn-primary px-4 fw-bold shadow-sm"
					onclick="saveTeamInfo()">
					<i class="bi bi-check-circle-fill me-1"></i> 저장하기
				</button>
			</div>
		</form>
	</div>
</div>