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

	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/player/club.css" />
</head>
<body>

	<!-- 상단 헤더 조립 -->
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<div class="container my-4">
		<!-- 상단 간단 요약 프로필 바 -->
		<div class="card mb-4 p-3 bg-light">
			<div class="d-flex align-items-center">
				<img src="${pageContext.request.contextPath}/dist/images/user.png" class="rounded-circle me-3" style="width: 60px; height: 60px" alt="프로필 이미지" />
				<div>
					<h5 class="mb-1">
						<strong>홍길동</strong> 님 환영합니다!
					</h5>
					<span class="badge bg-primary">구단주</span>
					<!-- 등급 표시 -->
				</div>
			</div>
		</div>

		<div class="row">
			<!-- 1. 왼쪽 사이드바 (LNB) -->
			<div class="col-md-3 mb-4">
				<div class="list-group">
					<div class="list-group-item bg-dark text-white fw-bold">
						마이페이지</div>

					<!-- 대분류 1 -->
					<div class="list-group-item bg-light fw-bold">내 프로필</div>
					<a href="${pageContext.request.contextPath}/player/mypage" class="list-group-item list-group-item-action ps-4 active">프로필 등록/수정</a> 
					<a href="${pageContext.request.contextPath}/player/todo" class="list-group-item list-group-item-action ps-4">투두리스트</a>

					<!-- 경기 참가신청 조회 항목에서 신청한 경기 수정/취소 -->
					<div class="list-group-item bg-light fw-bold">경기</div>
					<a href="${pageContext.request.contextPath}/player/matchHistory" class="list-group-item list-group-item-action ps-4">내 경기 참가 이력</a>
					<a href="${pageContext.request.contextPath}/player/playerProfile" class="list-group-item list-group-item-action ps-4">내 선수 프로필</a>
					<a href="${pageContext.request.contextPath}/player/rating" class="list-group-item list-group-item-action ps-4">내 경기 성적</a>


					<!-- 대분류 3 -->
					<div class="list-group-item bg-light fw-bold">내 구단정보</div>
					<a href="${pageContext.request.contextPath}/player/club" class="list-group-item list-group-item-action ps-4">내 구단팀 조회</a> 
					<a href="${pageContext.request.contextPath}/player/clubJoin" class="list-group-item list-group-item-action ps-4">입단신청/결과조회</a> 
					<a href="${pageContext.request.contextPath}/player/clubOwnerRequest" class="list-group-item list-group-item-action ps-4">구단주 신청</a> 
					<a href="${pageContext.request.contextPath}/player/clubOwnerRequestHistory" class="list-group-item list-group-item-action ps-4">구단주신청 결과 조회/취소</a>

					<!-- 대분류 4 -->
					<div class="list-group-item bg-light fw-bold">경기 신청</div>
					<a href="#" class="list-group-item list-group-item-action ps-4">경기 참가 신청</a> 
					<a href="#" class="list-group-item list-group-item-action ps-4">신청 경기 조회</a>
					<a href="#" class="list-group-item list-group-item-action ps-4">경기 신청 수정/취소</a> 
				</div>
			</div>

			<!-- 2. 오른쪽 메인 콘텐츠 영역 -->
			<div class="col-md-9">
				<div class="card p-4">
					<h4 class="border-bottom pb-2 mb-4">내 구단팀 조회</h4>
						<div class="club-profile">
						</div>
					<div class="club-logo-box">
						<i class="bi bi-shield-fill"></i>
					</div>

					<div class="club-info">
						<div class="club-title-row">
							<h4>${dto.club_name}</h4>
							
							<c:choose>
								<c:when test="${dto.club_status eq 1}">
									<span id="club-status" class="club-status">운영중</span>
								</c:when>
								<c:when test="${dto.club_status eq 0}">
									<span id="club-status" class="club-status">해체</span>
								</c:when>
							</c:choose>
							
						</div>
						<div>
							<div class="club-grid">
								<span>${dto.club_region}</span>
							</div>

							<div class="club-date">
								<span>창단일</span> 
								<span>${dto.club_created}</span>
							</div>

							<div class="club-introduction">
								<span>구단소개</span> 
								<span>${dto.club_content}</span>
							</div>

						</div>

					</div>

				</div>


			</div>
		</div>
</div>
