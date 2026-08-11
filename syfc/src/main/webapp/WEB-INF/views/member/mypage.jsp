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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/member/mypage.css" />
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
						마이페이지
					</div>

					<!-- 대분류 1 -->
					<div class="list-group-item bg-light fw-bold">내 프로필</div>
					<a href="#" class="list-group-item list-group-item-action ps-4 active">프로필 수정</a> 
					<a href="#" class="list-group-item list-group-item-action ps-4">내 평점 조회</a>

					<!-- 대분류 2 -->
					<div class="list-group-item bg-light fw-bold">경기정보</div>
					<a href="#" class="list-group-item list-group-item-action ps-4">내 경기 참가 이력</a>

					<!-- 대분류 3 -->
					<div class="list-group-item bg-light fw-bold">내 구단정보</div>
					<a href="#" class="list-group-item list-group-item-action ps-4">내 구단팀 조회</a> 
					<a href="#" class="list-group-item list-group-item-action ps-4">입단 신청/결과조회</a>
				</div>
			</div>

			<!-- 2. 오른쪽 메인 콘텐츠 영역 -->
			<div class="col-md-9">
				<div class="card p-4">
					<h4 class="border-bottom pb-2 mb-4">프로필 수정</h4>

					<!-- 여기에 실제 해당 메뉴의 Form이나 Table 표가 들어갑니다 -->
					<div>콘텐츠 영역 (프로필 수정 폼 등)</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 하단 푸터 조립 -->
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

	<!-- 3. 마이페이지 전용 JS 연결 (dist/js/member/mypage.js) -->
	<script src="${pageContext.request.contextPath}/dist/js/member/mypage.js"></script>
</body>
</html>