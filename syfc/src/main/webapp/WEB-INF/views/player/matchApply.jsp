<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>마이페이지 - 경기 참가 신청 및 조회</title>

	<!-- 1. 공통 CSS/CDN/폰트 리소스 조립 -->
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/player/matchApply.css" />
	<style>
		.nav-pills .nav-link.active { background-color: #0d6efd; color: #fff; font-weight: bold; }
		.nav-pills .nav-link { color: #495057; border-radius: 8px; padding: 10px 18px; font-weight: 600; }
		.apply-status { font-weight: bold; padding: 4px 10px; border-radius: 6px; font-size: 12px; display: inline-block; white-space: nowrap; }
		.status-pending { background-color: #fff3cd; color: #856404; border: 1px solid #ffeeba; }
		.status-approved { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
		.status-rejected { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
		
		/* 테이블 가로너비 정돈 CSS */
		.match-table th, .match-table td { vertical-align: middle; }
		.text-nowrap-custom { white-space: nowrap !important; }
	</style>
</head>
<body class="bg-light">

	<!-- 상단 헤더 조립 -->
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<div class="container my-4">
		<!-- 상단 간단 요약 프로필 바 -->
		<div class="card mb-4 p-3 bg-white border-0 shadow-sm rounded-4">
			<div class="d-flex align-items-center justify-content-between">
				<div class="d-flex align-items-center">
					<img src="${pageContext.request.contextPath}/dist/images/user.png" class="rounded-circle me-3" style="width: 60px; height: 60px" alt="프로필 이미지" />
					<div>
						<h5 class="mb-1">
							<strong>손흥민</strong> 님 환영합니다!
						</h5>
						<span class="badge bg-primary">선수 (FW)</span>
						<span class="text-muted ms-2 small">소속 구단: <strong>FC 쌍용</strong> | 평점: <strong>⭐ 5.0</strong></span>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<!-- 1. 왼쪽 사이드바 (LNB) -->
			<div class="col-md-3 mb-4">
				<div class="list-group shadow-sm rounded-3">
					<div class="list-group-item bg-dark text-white fw-bold">
						마이페이지
					</div>

					<!-- 대분류 1 -->
					<div class="list-group-item bg-light fw-bold">내 프로필</div>
					<a href="${pageContext.request.contextPath}/player/mypage" class="list-group-item list-group-item-action ps-4">프로필 등록/수정</a> 
					<a href="${pageContext.request.contextPath}/player/rating" class="list-group-item list-group-item-action ps-4">내 평점 조회</a>

					<!-- 대분류 2 -->
					<div class="list-group-item bg-light fw-bold">경기</div>
					<a href="${pageContext.request.contextPath}/player/matchHistory" class="list-group-item list-group-item-action ps-4">내 경기 참가 이력</a>
					<a href="${pageContext.request.contextPath}/player/matchApply" class="list-group-item list-group-item-action ps-4 active">경기 신청 관리</a>

					<!-- 대분류 3 -->
					<div class="list-group-item bg-light fw-bold">내 구단정보</div>
					<a href="${pageContext.request.contextPath}/player/club" class="list-group-item list-group-item-action ps-4">내 구단팀 조회</a> 
					<a href="${pageContext.request.contextPath}/player/clubJoin" class="list-group-item list-group-item-action ps-4">입단 신청/결과조회</a>
					<a href="${pageContext.request.contextPath}/player/clubOwnerRequest" class="list-group-item list-group-item-action ps-4">구단주 신청</a> 
					<a href="${pageContext.request.contextPath}/player/clubOwnerRequestHistory" class="list-group-item list-group-item-action ps-4">구단주 신청 결과 조회/취소</a>

				</div>
			</div>
		
			<!-- 2. 오른쪽 메인 콘텐츠 영역 -->
			<div class="col-md-9">
				
				<!-- 상단 탭 버튼 영역 -->
				<div class="card border-0 shadow-sm rounded-4 p-2 mb-4 bg-white">
					<ul class="nav nav-pills nav-fill gap-2" id="playerTab" role="tablist">
						<li class="nav-item">
							<button class="nav-link active" id="apply-tab" data-bs-toggle="pill" data-bs-target="#apply-pane" type="button">
								⚽ 1. 경기 참가 신청 (구단주 모집글)
							</button>
						</li>
						<li class="nav-item">
							<button class="nav-link" id="my-list-tab" data-bs-toggle="pill" data-bs-target="#my-list-pane" type="button">
								📋 2. 신청 경기 조회 / 수정 / 취소
							</button>
						</li>
					</ul>
				</div>

				<!-- 탭 내부 콘텐츠 -->
				<div class="tab-content" id="playerTabContent">

					<!-- [탭 1] 경기 참가 신청 (구단주 모집글 목록) -->
					<div class="tab-pane fade show active" id="apply-pane" role="tabpanel">
						<div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
							<div class="d-flex justify-content-between align-items-center pb-3 mb-4 border-bottom">
								<div>
									<h5 class="fw-bold mb-1">구단주 경기 참가 모집글</h5>
									<p class="text-muted small mb-0">우리 팀 구단주가 올린 출전 모집글입니다. 인원이 채워져야 구단주가 경기장을 최종 신청할 수 있습니다.</p>
								</div>
							</div>

							<!-- 모집글 카드 1 (신청 가능) -->
							<div class="card border rounded-4 p-3 mb-3 hover-shadow transition-all bg-white">
								<div class="row align-items-center g-3">
									<div class="col-md-8">
										<div class="d-flex align-items-center gap-2 mb-2">
											<span class="badge bg-danger">모집 중</span>
											<span class="badge bg-secondary">11 vs 11 매치</span>
											<span class="fw-bold text-dark">[FC 쌍용] 8/20 마포 경기 출전 선수 모집합니다!</span>
										</div>
										<div class="small text-muted mb-2">
											📍 예정 경기장: <strong>쌍용 주 경기장</strong> | 📅 일시: <strong>2026-08-20 18:00</strong>
										</div>
										<div class="d-flex align-items-center gap-2">
											<span class="small text-secondary fw-bold">현재 모집 현황:</span>
											<span class="fw-bold text-primary small">8 / 11명</span>
											<div class="progress flex-grow-1" style="height: 6px; max-width: 150px;">
												<div class="progress-bar bg-primary" style="width: 72%;"></div>
											</div>
										</div>
									</div>
									<div class="col-md-4 text-md-end">
										<button type="button" class="btn btn-primary px-4 fw-bold" onclick="openApplyModal('[FC 쌍용] 8/20 마포 경기 출전 모집', '쌍용 주 경기장 (인조잔디)', '2026-08-20 18:00', '서울 마포구 월드컵북로 21')">
											참가 신청하기
										</button>
									</div>
								</div>
							</div>

							<!-- 모집글 카드 2 (인원 완료 예시) -->
							<div class="card border rounded-4 p-3 mb-3 bg-light opacity-75">
								<div class="row align-items-center g-3">
									<div class="col-md-8">
										<div class="d-flex align-items-center gap-2 mb-2">
											<span class="badge bg-success">인원 완료</span>
											<span class="badge bg-secondary">6 vs 6 풋살</span>
											<span class="fw-bold text-dark">[FC 쌍용] 8/22 풋살 파크 주말 매치 모집</span>
										</div>
										<div class="small text-muted mb-2">
											📍 예정 경기장: <strong>마포 풋살 파크</strong> | 📅 일시: <strong>2026-08-22 10:00</strong>
										</div>
										<div class="d-flex align-items-center gap-2">
											<span class="small text-secondary fw-bold">현재 모집 현황:</span>
											<span class="fw-bold text-success small">6 / 6명 (모집 완료)</span>
										</div>
									</div>
									<div class="col-md-4 text-md-end">
										<button type="button" class="btn btn-secondary px-4 fw-bold" disabled>
											모집 마감
										</button>
									</div>
								</div>
							</div>

						</div>
					</div>

					<!-- [탭 2] 신청 경기 조회 / 수정 / 취소 (테이블 비율 보정) -->
					<div class="tab-pane fade" id="my-list-pane" role="tabpanel">
						<div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
							<h5 class="fw-bold mb-3 border-bottom pb-2">내가 신청한 경기 참가 목록</h5>

							<div class="table-responsive">
								<table class="table table-hover text-center align-middle mb-0 match-table">
									<thead class="table-light extra-small text-muted">
										<tr>
											<th style="width: 105px;" class="text-nowrap-custom">신청일</th>
											<th>경기 모집 타이틀 / 경기장</th>
											<th style="width: 110px;" class="text-nowrap-custom">매치 구분</th>
											<th style="width: 120px;" class="text-nowrap-custom">희망 포지션</th>
											<th style="width: 130px;" class="text-nowrap-custom">신청 상태</th>
											<th style="width: 120px;" class="text-nowrap-custom">관리</th>
										</tr>
									</thead>
									<tbody class="small">
										<tr>
											<td class="text-nowrap-custom text-muted">2026-08-10</td>
											<td class="text-start">
												<div class="fw-bold text-dark">[FC 쌍용] 8/20 마포 경기 출전 모집</div>
												<div class="extra-small text-muted">쌍용 주 경기장 (2026-08-20 18:00)</div>
											</td>
											<td class="text-nowrap-custom fw-semibold">11vs11 축구</td>
											<td class="text-nowrap-custom"><span class="badge bg-danger-subtle text-danger border px-2 py-1">FW (공격수)</span></td>
											<td class="text-nowrap-custom"><span class="apply-status status-pending">구단주 대관 대기</span></td>
											<td class="text-nowrap-custom">
												<div class="d-flex justify-content-center gap-1">
													<button class="btn btn-sm btn-outline-primary px-2 py-1" onclick="openEditModal('FW')">수정</button>
													<button class="btn btn-sm btn-outline-danger px-2 py-1" onclick="cancelApply()">취소</button>
												</div>
											</td>
										</tr>
										<tr>
											<td class="text-nowrap-custom text-muted">2026-08-08</td>
											<td class="text-start">
												<div class="fw-bold text-dark">[FC 쌍용] 강남 친선 매치</div>
												<div class="extra-small text-muted">강남 축구장 (2026-08-15 10:00)</div>
											</td>
											<td class="text-nowrap-custom fw-semibold">11vs11 축구</td>
											<td class="text-nowrap-custom"><span class="badge bg-primary-subtle text-primary border px-2 py-1">MF (미드필더)</span></td>
											<td class="text-nowrap-custom"><span class="apply-status status-approved">대관 신청승인</span></td>
											<td class="text-nowrap-custom">
												<button class="btn btn-sm btn-secondary disabled px-2 py-1" disabled>수정 불가</button>
											</td>
										</tr>
										<tr>
											<td class="text-nowrap-custom text-muted">2026-08-05</td>
											<td class="text-start">
												<div class="fw-bold text-dark">[FC 쌍용] 역삼 야간 풋살</div>
												<div class="extra-small text-muted">역삼 풋살장 (2026-08-07 20:00)</div>
											</td>
											<td class="text-nowrap-custom fw-semibold">6vs6 풋살</td>
											<td class="text-nowrap-custom"><span class="badge bg-secondary-subtle text-dark border px-2 py-1">DF (수비수)</span></td>
											<td class="text-nowrap-custom"><span class="apply-status status-rejected">경기 취소/반려</span></td>
											<td class="text-nowrap-custom">
												<button class="btn btn-sm btn-light border text-muted px-2 py-1" disabled>종료</button>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>

	<!-- ★ [확장] 경기장 상세 & 참가 신청 통합 모달 (modal-lg) ★ -->
	<div class="modal fade" id="applyModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content border-0 rounded-4 shadow">
				<div class="modal-header border-bottom pb-3">
					<h5 class="fw-bold mb-0 text-dark" id="modalTitle">경기 참가 신청 & 경기장 상세 정보</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body py-3">
					
					<!-- 1. 경기장 이미지 & 위치 지도 영역 -->
					<div class="row g-3 mb-3">
						<div class="col-md-6">
							<div class="card border-0 rounded-3 overflow-hidden bg-light h-100 position-relative">
								<!-- 경기장 샘플 대표 이미지 -->
								<img src="https://images.unsplash.com/photo-1574629810360-7efbbe195018?auto=format&fit=crop&w=600&q=80" class="img-fluid h-100 object-fit-cover" style="min-height: 180px;" alt="경기장 전경">
								<span class="position-absolute top-0 start-0 m-2 badge bg-dark bg-opacity-75">경기장 전경</span>
							</div>
						</div>
						<div class="col-md-6">
							<!-- 지도 API 연동 위치 박스 -->
							<div class="card border rounded-3 bg-light h-100 d-flex align-items-center justify-content-center p-3 text-center" style="min-height: 180px;">
								<div class="text-muted">
									<i class="bi bi-geo-alt-fill text-danger fs-2 d-block mb-1"></i>
									<span class="fw-bold text-dark d-block mb-1" id="modalStadiumAddress">서울 마포구 월드컵북로 21</span>
									<span class="extra-small text-secondary">지도 API 연동 영역 (카카오/네이버 지도)</span>
								</div>
							</div>
						</div>
					</div>

					<!-- 2. 경기장 편의시설 & 정보 뱃지 -->
					<div class="p-3 bg-light rounded-3 mb-3 border">
						<div class="fw-bold small text-dark mb-2"><i class="bi bi-info-circle-fill text-primary me-1"></i> 경기장 편의시설 & 정보</div>
						<div class="d-flex flex-wrap gap-2">
							<span class="badge bg-white text-dark border px-2.5 py-1.5"><i class="bi bi-p-square-fill text-primary me-1"></i>무료 주차 50대 가능</span>
							<span class="badge bg-white text-dark border px-2.5 py-1.5"><i class="bi bi-droplet-fill text-info me-1"></i>샤워실/탈의실 완비</span>
							<span class="badge bg-white text-dark border px-2.5 py-1.5"><i class="bi bi-tree-fill text-success me-1"></i>최고급 인조잔디</span>
							<span class="badge bg-white text-dark border px-2.5 py-1.5"><i class="bi bi-snow text-primary me-1"></i>냉난방 대기실</span>
							<span class="badge bg-white text-dark border px-2.5 py-1.5"><i class="bi bi-dribbble text-warning me-1"></i>공/조끼 무료 대여</span>
						</div>
					</div>

					<hr class="my-3">

					<!-- 3. 참가 신청 입력 폼 -->
					<form id="applyForm">
						<div class="row g-3">
							<div class="col-md-6">
								<label class="form-label small fw-bold text-muted mb-1">희망 포지션 선택 <span class="text-danger">*</span></label>
								<select class="form-select form-select-sm fw-bold" id="selectPosition">
									<option value="FW" selected>FW (공격수)</option>
									<option value="MF">MF (미드필더)</option>
									<option value="DF">DF (수비수)</option>
									<option value="GK">GK (골키퍼)</option>
								</select>
							</div>
							<div class="col-md-6">
								<label class="form-label small fw-bold text-muted mb-1">일시 및 구분</label>
								<input type="text" class="form-control form-control-sm bg-light fw-bold" id="modalSubInfo" value="2026-08-20 18:00 (11vs11 축구)" readonly>
							</div>
							<div class="col-12">
								<label class="form-label small fw-bold text-muted mb-1">구단주 전달 메시지 (선택)</label>
								<textarea class="form-control form-control-sm" rows="2" placeholder="예: 지각없이 30분 전에 도착하겠습니다! 파이팅입니다."></textarea>
							</div>
						</div>
					</form>

				</div>
				<div class="modal-footer border-top pt-2">
					<button type="button" class="btn btn-light border btn-sm px-3" data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary btn-sm px-4 fw-bold" onclick="submitApply()">참가 신청 완료</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 참가 수정 모달 -->
	<div class="modal fade" id="editModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content border-0 rounded-4 shadow">
				<div class="modal-header border-bottom pb-3">
					<h6 class="fw-bold mb-0">신청 정보 수정</h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body py-3">
					<div class="mb-3">
						<label class="form-label small fw-bold text-muted mb-1">희망 포지션 변경</label>
						<select class="form-select form-select-sm fw-bold" id="editPosition">
							<option value="FW">FW (공격수)</option>
							<option value="MF">MF (미드필더)</option>
							<option value="DF">DF (수비수)</option>
							<option value="GK">GK (골키퍼)</option>
						</select>
					</div>
				</div>
				<div class="modal-footer border-top pt-2">
					<button type="button" class="btn btn-light border btn-sm px-3" data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary btn-sm px-4 fw-bold" onclick="submitEdit()">수정 완료</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 하단 푸터 조립 -->
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

	<script>
		function openApplyModal(title, stadium, date, address) {
			document.getElementById('modalTitle').innerText = title;
			document.getElementById('modalStadiumAddress').innerText = address;
			document.getElementById('modalSubInfo').value = `${date} | ${stadium}`;
			const modal = new bootstrap.Modal(document.getElementById('applyModal'));
			modal.show();
		}

		function submitApply() {
			alert("참가 신청이 성공적으로 완료되었습니다!");
			bootstrap.Modal.getInstance(document.getElementById('applyModal')).hide();
		}

		function openEditModal(currentPos) {
			document.getElementById('editPosition').value = currentPos;
			const modal = new bootstrap.Modal(document.getElementById('editModal'));
			modal.show();
		}

		function submitEdit() {
			alert("신청 포지션이 수정되었습니다.");
			bootstrap.Modal.getInstance(document.getElementById('editModal')).hide();
		}

		function cancelApply() {
			if(confirm("정말로 경기 참가 신청을 취소하시겠습니까?")) {
				alert("참가 신청이 취소되었습니다.");
			}
		}
	</script>
</body>
</html>