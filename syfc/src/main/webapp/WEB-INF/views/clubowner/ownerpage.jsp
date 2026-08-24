<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/clubowner/ownerpage.css?v=2.4" />
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
						<div class="fs-4 fw-bold text-dark">${empty playerCount ? 0 : playerCount}명</div>
						<div class="extra-small text-muted">소속 선수</div>
					</div>
					<div>
						<div class="fs-4 fw-bold">
							<span class="text-primary">${empty wins ? 0 : wins}승</span> <span
								class="text-success">${empty draws ? 0 : draws}무</span> <span
								class="text-danger">${empty losses ? 0 : losses}패</span>
						</div>
						<div class="extra-small text-muted">최근 전적</div>
					</div>
					<div>
						<div class="fs-4 fw-bold text-warning">⭐ ${empty avgRating ? '0.0' : avgRating}</div>
						<div class="extra-small text-muted">구단 평점</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 메인 대시보드 레이아웃 -->
		<div class="row g-4">

			<!-- 왼쪽 사이드바 탭 -->
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
						</a> <a href="#team-history"
							class="list-group-item list-group-item-action rounded-3 mb-1"
							data-bs-toggle="list"> <i class="bi bi-journal-text me-2"></i>구단
							경기 이력
						</a> <a href="#team-result-register"
							class="list-group-item list-group-item-action rounded-3 mb-1"
							data-bs-toggle="list"> <i class="bi bi-pencil-square me-2"></i>구단
							성적 등록 / 조회
						</a>

						<div class="sidebar-category">선수 관리</div>
						<a href="#player-approval"
							class="list-group-item list-group-item-action rounded-3 mb-1 d-flex justify-content-between align-items-center"
							data-bs-toggle="list"> <span><i
								class="bi bi-person-plus me-2"></i>입단 승인 관리</span> <span
							class="badge bg-danger rounded-pill" id="approvalPendingBadge">${empty pendingCount ? 0 : pendingCount}</span>
						</a><a href="#player-list"
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

			<!-- 오른쪽 콘텐츠 영역 () -->
			<div class="col-lg-9">
				<div class="tab-content">
					<jsp:include page="/WEB-INF/views/clubowner/tab/tab_team_edit.jsp" />
					<jsp:include
						page="/WEB-INF/views/clubowner/tab/tab_team_history.jsp" />
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

	<!-- 입단 거절 모달 -->
	<div class="modal fade" id="rejectReasonModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content border-0 shadow rounded-4">
				<div class="modal-header border-bottom-0 pb-0">
					<h6 class="modal-header-title fw-bold text-dark mb-0">
						<i class="bi bi-exclamation-triangle-fill text-danger me-2"></i>입단
						신청 거절
					</h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body p-4">
					<p class="small text-muted mb-3">
						<strong id="rejectTargetName" class="text-dark"></strong> 선수의 입단
						신청을 거절합니다. 거절 사유는 신청자에게 안내됩니다.
					</p>
					<input type="hidden" id="rejectApplyNum" value="">

					<div class="mb-3">
						<label class="form-label small fw-bold text-secondary">거절
							사유 선택</label> <select class="form-select form-select-sm"
							id="rejectReasonSelect" onchange="changeRejectReason(this.value)">
							<option value="정원 초과">포지션 정원이 초과되었습니다.</option>
							<option value="활동 지역 불일치">주요 활동 지역이 일치하지 않습니다.</option>
							<option value="custom">직접 입력</option>
						</select>
					</div>
					<div>
						<label class="form-label small fw-bold text-secondary">상세
							거절 사유</label>
						<textarea class="form-control form-control-sm"
							id="rejectReasonText" rows="3">포지션 정원이 초과되었습니다.</textarea>
					</div>
				</div>
				<div class="modal-footer border-top-0 pt-0">
					<button type="button" class="btn btn-sm btn-light px-3"
						data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-sm btn-danger px-4 fw-bold"
						onclick="submitRejectProcess()">거절 확정</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 경기 상세 이력 조회 모달 -->
	<div class="modal fade" id="matchDetailModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content border-0 shadow rounded-4">
				<div class="modal-header border-bottom pb-3">
					<h6 class="modal-title fw-bold text-dark">
						<i class="bi bi-journal-richtext text-primary me-2"></i>경기 상세 선수 기록
					</h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body p-4" id="matchDetailContent">
					
				</div>
			</div>
		</div>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	</footer>

	<script src="${pageContext.request.contextPath}/dist/js/clubowner/ownerpage.js?v=9.9"></script>
</body>
</html>