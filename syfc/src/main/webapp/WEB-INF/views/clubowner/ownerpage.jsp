<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/clubowner/ownerpage.css?v=2.4" />
<script>
	const contextPath = "${pageContext.request.contextPath}";
</script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body class="bg-light">

	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp" />
	</header>

	<div class="container py-4">

		<!-- 구단 및 구단주 요약 프로필 바 -->
		<div class="card border-0 shadow-sm rounded-4 mb-4 bg-white">
			<div
				class="card-body p-4 d-flex flex-wrap align-items-center justify-content-between gap-3">
				<div class="d-flex align-items-center">
					<!-- 구단 로고 -->
					<div class="me-3">
						<c:choose>
							<c:when test="${not empty club.club_logo}">
								<img
									src="${pageContext.request.contextPath}/uploads/club/${club.club_logo}"
									class="rounded-circle border border-2 border-white shadow-sm"
									style="width: 65px; height: 65px; object-fit: cover;"
									alt="구단 로고">
							</c:when>
							<c:otherwise>
								<div
									class="bg-primary bg-opacity-10 text-primary rounded-circle d-flex align-items-center justify-content-center owner-profile-icon">⚽</div>
							</c:otherwise>
						</c:choose>
					</div>
					<div>
						<div class="d-flex align-items-center gap-2 mb-1">
							<h4 class="mb-0 fw-bold text-dark">${empty club.club_name ? '구단 미등록' : club.club_name}</h4>
							<span class="badge bg-warning text-dark px-2 py-1 fs-7">구단주</span>
						</div>
						<p class="text-secondary mb-0 small">
							구단주 <strong>${sessionScope.member.userName}</strong>
							&nbsp;|&nbsp; 연고지 <strong>${empty club.club_region ? '미설정' : club.club_region}</strong>
							&nbsp;|&nbsp; 창단일 <strong>${empty club.club_created ? '-' : club.club_created}</strong>
						</p>
					</div>
				</div>
				<div class="d-none d-md-flex gap-4 text-center border-start ps-4">
					<div>
						<div class="fs-4 fw-bold text-dark">${empty record.totalPlayers ? 0 : record.totalPlayers}명</div>
						<div class="extra-small text-muted">소속 선수</div>
					</div>
					<div>
						<div class="fs-4 fw-bold">
							<span class="text-primary">${empty record.wins ? 0 : record.wins}승</span>
							<span class="text-danger">${empty record.losses ? 0 : record.losses}패</span>
						</div>
						<div class="extra-small text-muted">최근 전적</div>
					</div>
					<div>
						<div class="fs-4 fw-bold text-warning">⭐ ${empty record.avgRating ? '0.0' : record.avgRating}</div>
						<div class="extra-small text-muted">구단 평점</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 메인 대시보드 레이아웃 -->
		<div class="row g-4">

			<!-- 왼쪽 사이드바 (LNB) -->
			<div class="col-lg-3">
				<div
					class="card border-0 shadow-sm rounded-4 p-3 sticky-top owner-sidebar-card">
					<div class="list-group list-group-flush border-0 owner-sidebar">
						<div class="sidebar-category">개인 프로필</div>
						<a href="#profile-edit"
							class="list-group-item list-group-item-action rounded-3 mb-1"
							data-bs-toggle="list"> <i class="bi bi-person-gear me-2"></i>프로필
							수정
						</a>

						<div class="sidebar-category">구단 관리</div>
						<a href="#team-edit"
							class="list-group-item list-group-item-action rounded-3 mb-1 active"
							data-bs-toggle="list"> <i class="bi bi-shield-shaded me-2"></i>구단
							등록 / 수정
						</a>
						<!-- [수정] 구단 경기 이력 -->
						<a href="#team-history"
							class="list-group-item list-group-item-action rounded-3 mb-1"
							data-bs-toggle="list"> <i class="bi bi-journal-text me-2"></i>구단
							경기 이력
						</a>
						<!-- [신규] 구단 성적 등록 / 조회 -->
						<a href="#team-result-register"
							class="list-group-item list-group-item-action rounded-3 mb-1"
							data-bs-toggle="list"> <i class="bi bi-pencil-square me-2"></i>구단
							성적 등록 / 조회
						</a>

						<div class="sidebar-category">선수 관리</div>
						<a href="#player-approval"
							class="list-group-item list-group-item-action rounded-3 mb-1 d-flex justify-content-between align-items-center"
							data-bs-toggle="list"> <span><i
								class="bi bi-person-plus me-2"></i>입단 승인 관리</span> <span
							class="badge bg-danger rounded-pill" id="approvalPendingBadge">2</span>
						</a> <a href="#player-list"
							class="list-group-item list-group-item-action rounded-3 mb-1"
							data-bs-toggle="list"> <i class="bi bi-people me-2"></i>소속 선수
							조회 / 제적
						</a> <a href="#player-rating-manage"
							class="list-group-item list-group-item-action rounded-3 mb-1"
							data-bs-toggle="list"> <i class="bi bi-star-half me-2"></i>선수
							평점 / 성적 관리
						</a>

						<div class="sidebar-category">경기 및 매칭</div>
						<a href="#match-apply"
							class="list-group-item list-group-item-action rounded-3 mb-1"
							data-bs-toggle="list"> <i class="bi bi-calendar-check me-2"></i>경기장
							예약 & 매칭
						</a>

						<div class="sidebar-category">설정</div>
						<a href="#owner-transfer"
							class="list-group-item list-group-item-action rounded-3 text-danger"
							data-bs-toggle="list"> <i class="bi bi-arrow-left-right me-2"></i>구단주
							변경 신청
						</a>
					</div>
				</div>
			</div>

			<!-- 오른쪽 콘텐츠 영역 (서브 JSP Include) -->
			<div class="col-lg-9">
				<div class="tab-content">
					<jsp:include page="/WEB-INF/views/clubowner/tab/tab_team_edit.jsp" />
					<jsp:include
						page="/WEB-INF/views/clubowner/tab/tab_team_history.jsp" />
					<!-- [신규] 구단 성적 등록/조회 탭 Include 추가 -->
					<jsp:include
						page="/WEB-INF/views/clubowner/tab/tab_team_result_register.jsp" />
					<jsp:include page="/WEB-INF/views/clubowner/tab/tab_approval.jsp" />
					<jsp:include
						page="/WEB-INF/views/clubowner/tab/tab_player_list.jsp" />
					<jsp:include
						page="/WEB-INF/views/clubowner/tab/tab_player_rating.jsp" />
					<jsp:include
						page="/WEB-INF/views/clubowner/tab/tab_match_apply.jsp" />
					<jsp:include
						page="/WEB-INF/views/clubowner/tab/tab_owner_transfer.jsp" />
				</div>
			</div>

		</div>
	</div>

	<!-- 입단 거절 모달 생략 (동일) -->
	<div class="modal fade" id="rejectReasonModal" tabindex="-1"
		aria-hidden="true">...</div>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<!-- 기존 v=2.4 또는 v=2.5 에서 v=3.0 으로 변경 -->
<script src="${pageContext.request.contextPath}/dist/js/clubowner/ownerpage.js?v=3.0"></script>
</body>
</html>