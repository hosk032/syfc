<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- 1. 공통 CSS/CDN/폰트 리소스 조립 -->
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

	<!-- 2. 구단주 마이페이지 전용 CSS 연결 (dist/css/clubowner/ownerpage.css) -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/clubowner/ownerpage.css" />
</head>
<body>

	<!-- 상단 헤더/네비게이션 조립 -->
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<div class="container my-4">

		<!-- 1. 구단 및 구단주 요약 프로필 바 -->
		<div class="card border-0 shadow-sm mb-4">
			<div class="card-body p-4 d-flex align-items-center justify-content-between">
				<div class="d-flex align-items-center">
					<div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 60px; height: 60px; font-size: 24px;">⚽</div>
					<div>
						<h4 class="mb-1 fw-bold">
							FC 쌍용 <span class="badge bg-warning text-dark fs-6 ms-2">구단주</span>
						</h4>
						<p class="text-muted mb-0 small">
							구단주: <strong>홍길동</strong> | 연고지: 서울 마포구 | 창단일: 2024-01-15
						</p>
					</div>
				</div>
				<div class="d-none d-md-flex gap-4 text-center border-start ps-4">
					<div>
						<div class="fs-4 fw-bold text-primary">18명</div>
						<div class="small text-muted">소속 선수</div>
					</div>
					<div>
						<div class="fs-4 fw-bold text-success">12승 4패</div>
						<div class="small text-muted">최근 전적</div>
					</div>
					<div>
						<div class="fs-4 fw-bold text-warning">4.8</div>
						<div class="small text-muted">구단 평점</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 2. 메인 대시보드 레이아웃 -->
		<div class="row">

			<!-- 왼쪽: 구단주 전용 사이드바 (LNB) -->
			<div class="col-lg-3 mb-4">
				<div class="card border-0 shadow-sm p-2 owner-sidebar">
					<div class="list-group list-group-flush">

						<div class="sidebar-category">개인 프로필 관리</div>
						<a href="#profile-edit" class="list-group-item list-group-item-action" data-bs-toggle="list"> 
							<i class="bi bi-person-gear me-2"></i>프로필 수정
						</a>

						<div class="sidebar-category">구단 관리</div>
						<a href="#team-edit" class="list-group-item list-group-item-action" data-bs-toggle="list"> 
							<i class="bi bi-shield-shaded me-2"></i>구단 등록 / 수정
						</a> 
						<a href="#team-history" class="list-group-item list-group-item-action" data-bs-toggle="list"> 
							<i class="bi bi-journal-text me-2"></i>구단 경기 이력 / 성적
						</a>

						<div class="sidebar-category">구단 선수 관리</div>
						<a href="#player-approval" class="list-group-item list-group-item-action active d-flex justify-content-between align-items-center" data-bs-toggle="list"> 
							<span><i class="bi bi-person-plus me-2"></i>입단 승인 관리</span> 
							<span class="badge bg-danger rounded-pill">2</span>
						</a> 
						<a href="#player-list" class="list-group-item list-group-item-action" data-bs-toggle="list"> 
							<i class="bi bi-people me-2"></i>구단 선수 조회 / 제적
						</a> 
						<a href="#player-rating" class="list-group-item list-group-item-action" data-bs-toggle="list"> 
							<i class="bi bi-star me-2"></i>선수 평점 등록·관리
						</a>

						<div class="sidebar-category">경기 관리</div>
						<a href="#match-apply" class="list-group-item list-group-item-action" data-bs-toggle="list"> 
							<i class="bi bi-calendar-check me-2"></i>경기장 일정 신청
						</a> 
						<a href="#match-history-input" class="list-group-item list-group-item-action" data-bs-toggle="list"> 
							<i class="bi bi-pencil-square me-2"></i>경기 이력 입력
						</a>

						<div class="sidebar-category">구단 설정</div>
						<a href="#owner-transfer" class="list-group-item list-group-item-action text-danger" data-bs-toggle="list"> 
							<i class="bi bi-arrow-left-right me-2"></i>구단주 변경 신청
						</a>

					</div>
				</div>
			</div>

			<!-- 오른쪽: 콘텐츠 영역 (탭 패널 연동) -->
			<div class="col-lg-9">
				<div class="tab-content">

					<!-- [탭 1] 입단 승인 관리 (기본 활성화) -->
					<div class="tab-pane fade show active" id="player-approval">
						<div class="card border-0 shadow-sm p-4">
							<div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
								<h5 class="fw-bold mb-0">
									<i class="bi bi-person-plus-fill text-primary me-2"></i>입단 신청 관리
								</h5>
								<span class="text-muted small">대기 중인 신청: <strong>2건</strong></span>
							</div>

							<div class="table-responsive">
								<table class="table table-hover align-middle">
									<thead class="table-light">
										<tr>
											<th>신청자</th>
											<th>선호 포지션</th>
											<th>신청일자</th>
											<th>자기소개/프로필</th>
											<th class="text-center">승인 여부</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="fw-bold">김철수 (26세)</td>
											<td><span class="badge bg-secondary">MF</span></td>
											<td>2026-08-03</td>
											<td><button class="btn btn-sm btn-outline-dark" onclick="viewProfile('김철수')">프로필 보기</button></td>
											<td class="text-center">
												<button class="btn btn-sm btn-primary me-1" onclick="approvePlayer('김철수')">승인</button>
												<button class="btn btn-sm btn-outline-danger" onclick="rejectPlayer('김철수')">거절</button>
											</td>
										</tr>
										<tr>
											<td class="fw-bold">이영희 (24세)</td>
											<td><span class="badge bg-secondary">FW</span></td>
											<td>2026-08-02</td>
											<td><button class="btn btn-sm btn-outline-dark" onclick="viewProfile('이영희')">프로필 보기</button></td>
											<td class="text-center">
												<button class="btn btn-sm btn-primary me-1" onclick="approvePlayer('이영희')">승인</button>
												<button class="btn btn-sm btn-outline-danger" onclick="rejectPlayer('이영희')">거절</button>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>

					<!-- [탭 2] 구단 선수 조회/제적 -->
					<div class="tab-pane fade" id="player-list">
						<div class="card border-0 shadow-sm p-4">
							<h5 class="fw-bold border-bottom pb-2 mb-3">
								<i class="bi bi-people-fill text-primary me-2"></i>소속 선수 목록
							</h5>
							<div class="table-responsive">
								<table class="table table-hover align-middle">
									<thead class="table-light">
										<tr>
											<th>이름</th>
											<th>포지션</th>
											<th>가입일</th>
											<th>평점</th>
											<th class="text-center">관리</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>박지성</td>
											<td><span class="badge bg-danger">FW</span></td>
											<td>2025-03-10</td>
											<td>⭐ 4.9</td>
											<td class="text-center">
												<button class="btn btn-sm btn-outline-danger" onclick="removePlayer('박지성')">제적(강퇴)</button>
											</td>
										</tr>
										<tr>
											<td>손흥민</td>
											<td><span class="badge bg-danger">FW</span></td>
											<td>2025-01-20</td>
											<td>⭐ 5.0</td>
											<td class="text-center">
												<button class="btn btn-sm btn-outline-danger" onclick="removePlayer('손흥민')">제적(강퇴)</button>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>

					<!-- [탭 3] 경기장 일정 신청 -->
					<div class="tab-pane fade" id="match-apply">
						<div class="card border-0 shadow-sm p-4">
							<h5 class="fw-bold border-bottom pb-2 mb-3">
								<i class="bi bi-calendar-plus text-primary me-2"></i>경기장 예약 신청
							</h5>
							<form id="matchApplyForm">
								<div class="mb-3">
									<label class="form-label fw-medium">경기장 선택</label> 
									<select class="form-select">
										<option>쌍용 주 경기장 (인조잔디)</option>
										<option>마포 구민 체육센터</option>
									</select>
								</div>
								<div class="row g-2 mb-3">
									<div class="col-md-6">
										<label class="form-label fw-medium">경기 날짜</label> 
										<input type="date" class="form-control">
									</div>
									<div class="col-md-6">
										<label class="form-label fw-medium">경기 시간</label> 
										<select class="form-select">
											<option>18:00 ~ 20:00</option>
											<option>20:00 ~ 22:00</option>
										</select>
									</div>
								</div>
								<button type="button" class="btn btn-primary w-100" onclick="alert('경기장 매칭/예약 신청이 완료되었습니다.')">예약 신청하기</button>
							</form>
						</div>
					</div>

					<!-- 기타 탭 영역 확장 가능 -->

				</div>
			</div>

		</div>
	</div>

	<!-- 하단 푸터 조립 -->
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

	<!-- 3. 구단주 마이페이지 전용 JS 연결 (dist/js/clubowner/ownerpage.js) -->
	<script src="${pageContext.request.contextPath}/dist/js/clubowner/ownerpage.js"></script>
</body>
</html>