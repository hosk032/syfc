<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>마이페이지 - 쌍용축구예약</title>

	<!-- 1. 공통 CSS/CDN/폰트 리소스 조립 -->
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

	<!-- 2. 마이페이지 전용 CSS 연결 (dist/css/member/mypage.css) -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/player/playerProfile.css?v=20260822-summary-profile" />
</head>
<body>

	<!-- 상단 헤더 조립 -->
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<div class="container my-4">
		<!-- 상단 간단 요약 프로필 바 -->
		<div class="card mb-4 p-3 bg-light">
			<div class="d-flex align-items-center">
				<div class="summary-profile-box me-3">
					<c:choose>
						<c:when test="${not empty dto.profile_photo}">
							<img src="${pageContext.request.contextPath}/uploads/member/${dto.profile_photo}" alt="프로필 사진" class="summary-profile-image">
						</c:when>
						<c:otherwise>
							<div class="summary-default-profile" aria-label="기본 프로필 이미지">
								<i class="bi bi-person"></i>
							</div>
						</c:otherwise>
					</c:choose>

					<c:if test="${not empty mainBall}">
						<div class="summary-main-ball">
							<img alt="대표공 이미지" src="${pageContext.request.contextPath}${mainBall.ball_image}">
						</div>
					</c:if>
				</div>	
				
				<div>
					<h5 class="mb-1">
						<strong>${sessionScope.member.userName}</strong> 님 환영합니다!
					</h5>
					<!-- 등급 표시 -->
					<c:choose>
						<c:when test="${sessionScope.member.userLevel eq 1}">
							<span class="badge bg-secondary">일반회원</span>
						</c:when>
						<c:when test="${sessionScope.member.userLevel eq 10}">
							<span class="badge bg-success">선수</span>
						</c:when>
						<c:when test="${sessionScope.member.userLevel eq 50}">
							<span class="badge bg-primary">구단주</span>
						</c:when>
						<c:when test="${sessionScope.member.userLevel eq 100}">
							<span class="badge bg-dark">관리자</span>
						</c:when>
					
					</c:choose>
				</div>
			</div>
		</div>

		<div class="row">
			<!-- 1. 왼쪽 사이드바 (LNB) -->
			<div class="col-md-3 mb-4">
				<div class="list-group">
					<div class="list-group-item bg-dark text-white fw-bold">
						마이페이지
					</div>

					<!-- 대분류 1 -->
					<div class="list-group-item bg-light fw-bold">내 프로필</div>
					<a href="${pageContext.request.contextPath}/player/mypage"  class="list-group-item list-group-item-action ps-4">프로필 등록/수정</a> 
					<a href="${pageContext.request.contextPath}/player/miniGame" class="list-group-item list-group-item-action ps-4">미니게임</a>

					<!-- 대분류 2 -->
					<!-- 경기 참가신청 조회 항목에서 신청한 경기 수정/취소 -->
					<div class="list-group-item bg-light fw-bold">경기</div>
					<a href="${pageContext.request.contextPath}/player/matchHistory" class="list-group-item list-group-item-action ps-4">내 경기 참가 이력</a>
					<a href="${pageContext.request.contextPath}/player/playerProfile" class="list-group-item list-group-item-action ps-4 active">내 선수 프로필</a>
					<a href="${pageContext.request.contextPath}/player/rating" class="list-group-item list-group-item-action ps-4">내 경기 성적</a>

					<!-- 대분류 3 -->
					<div class="list-group-item bg-light fw-bold">내 구단정보</div>
					<a href="${pageContext.request.contextPath}/player/club" class="list-group-item list-group-item-action ps-4">내 구단팀 조회</a> 
					<a href="${pageContext.request.contextPath}/player/clubJoin" class="list-group-item list-group-item-action ps-4">입단 신청/결과조회</a>
					<a href="${pageContext.request.contextPath}/player/clubOwnerRequest" class="list-group-item list-group-item-action ps-4">구단주 신청</a> 
					<a href="${pageContext.request.contextPath}/player/clubOwnerRequestHistory" class="list-group-item list-group-item-action ps-4">구단주 신청 결과 조회/취소</a>

					<!-- 대분류 4 -->
	                <div class="list-group-item bg-light fw-bold">경기 신청</div>
	                <a href="${pageContext.request.contextPath}/match2/playermatchtab" class="list-group-item list-group-item-action ps-4">경기 참가 신청/이력</a> 
				</div>
			</div>

			<!-- 2. 오른쪽 메인 콘텐츠 영역 -->
			<div class="col-md-9">
				<div class="card p-4 profile-panel">
					<h4 class="border-bottom pb-2 mb-4 profile-panel-title">선수 프로필</h4>
					<div class="player-profile-list">
						<c:forEach var="player" items="${players}">
							<div class="player-profile-card">
								<div class="player-profile-header">
									
										<div class="player-profile-image-box">
											<img src="${pageContext.request.contextPath}/uploads/member/${player.profile_photo}"
												alt="프로필 사진" class="player-profile-image">
										
											<c:if test="${not empty player.ball_image}">
												<div class="player-main-ball">
													<img src="${pageContext.request.contextPath}${player.ball_image}"
														alt="대표 공">
												</div>
											</c:if>
										</div>
									
									<div>
										<h3>${player.userName}</h3>
										<span class="player-status">${player.status}</span>
									</div>
								</div>

								<div class="player-profile-info">
									<div class="profile-item">
										<span class="profile-label">주 포지션</span>
										<span>${player.position}</span>
									</div>
									<div class="profile-item">
										<span class="profile-label">키</span>
										<span>${player.height} cm</span>
									</div>
									<div class="profile-item">
										<span class="profile-label">몸무게</span>
										<span>${player.weight} kg</span>
									</div>
									<div class="profile-item">
										<span class="profile-label">소속 구단</span>
										<span>${player.clubName}</span>
									</div>
									<div class="profile-item">
										<span class="profile-label">등번호</span>
										<span>${player.uniformNo}번</span>
									</div>
									<div class="profile-item">
										<span class="profile-label">가입일</span>
										<span>${player.joinDate}</span>
									</div>
								</div>
							</div>
						</c:forEach>
				</div>
					
					
					
					
					

				</div>
			</div>
		</div>
	</div>
