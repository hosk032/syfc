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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/player/miniGame.css" />
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
					<a href="${pageContext.request.contextPath}/player/mypage"  class="list-group-item list-group-item-action ps-4">프로필 등록/수정</a> 
					<a href="${pageContext.request.contextPath}/player/miniGame" class="list-group-item list-group-item-action ps-4 active">미니게임</a>

					<!-- 경기 참가신청 조회 항목에서 신청한 경기 수정/취소 -->
					<div class="list-group-item bg-light fw-bold">경기</div>
					<a href="${pageContext.request.contextPath}/player/matchHistory" class="list-group-item list-group-item-action ps-4">내 경기 참가 이력</a>
					<a href="${pageContext.request.contextPath}/player/playerProfile" class="list-group-item list-group-item-action ps-4">내 선수 프로필</a>
					<a href="${pageContext.request.contextPath}/player/rating" class="list-group-item list-group-item-action ps-4">내 경기 성적</a>

					<!-- 대분류 3 -->
					<div class="list-group-item bg-light fw-bold">내 구단정보</div>
					<a href="${pageContext.request.contextPath}/player/club" class="list-group-item list-group-item-action ps-4">내 구단팀 조회</a> 
					<a href="${pageContext.request.contextPath}/player/clubJoin" class="list-group-item list-group-item-action ps-4">입단 신청/결과조회</a>
					<a href="${pageContext.request.contextPath}/player/clubOwnerRequest" class="list-group-item list-group-item-action ps-4">구단주 신청</a> 
					<a href="${pageContext.request.contextPath}/player/clubOwnerRequestHistory" class="list-group-item list-group-item-action ps-4">구단주 신청 결과 조회/취소</a>

					<!-- 대분류 4 -->
					<div class="list-group-item bg-light fw-bold">경기 신청</div>
					<a href="#" class="list-group-item list-group-item-action ps-4">경기 참가 신청</a> 
					<a href="#" class="list-group-item list-group-item-action ps-4">신청 경기 조회</a>
					<a href="#" class="list-group-item list-group-item-action ps-4">경기 신청 수정/취소</a> 
				</div>
			</div>
		
		<!-- 2. 오른쪽 메인 콘텐츠 영역 -->
		<div class="col-md-9 mb-4">
			<div class="mini-game-page">
				
				<div class="mini-game-header">
					<div class="mini-game-title">
						<span class="daily-label">DAILY LUCKY DRAW</span>
						<h2>⚽ 오늘의 랜덤 축구공 뽑기 ⚽</h2>
						<p>🥳하루에 단 한번! 축구공을 뽑아보세요!🥳</p>
					</div>
					
					<button type="button" id="ballCollectionBtn" class="ball-collection-btn" data-bs-toggle="modal" data-bs-target="#ballCollectionModal">
						⚽ 축구공 도감 ⚽
					</button>
				</div>
					
				<div class="game-notice">
					<p>⚽ 축구공을 뽑아서 내 프로필을 꾸며보자! ⚽</p>
					<p>🎉경기 참가 횟수가 3회 이상이면 히든 축구공 획득 확률UP!🎉</p>
				</div>	
				
				<c:url value="/dist/images/minigame/football-lucky-draw-celebration.png" var="drawImage"/>
				<c:url value="/dist/images/minigame/football-neon-rotating.png" var="rotatingBallImage"/>
					<div class="draw-stage">
						<img alt="축구공 뽑기 배경" src="${drawImage}" class="draw-background">
						
						<div class="confetti-layer" aria-hidden="true">
							<div class="confetti-layer" aria-hidden="true">
							    <span class="confetti" style="--x: 5%;  --delay: -1s;   --duration: 4s;   --color: #8c4dff;"></span>
							    <span class="confetti" style="--x: 14%; --delay: -3s;   --duration: 5s;   --color: #1bbcff;"></span>
							    <span class="confetti" style="--x: 23%; --delay: -2s;   --duration: 3.8s; --color: #ffcf42;"></span>
							    <span class="confetti" style="--x: 34%; --delay: -4s;   --duration: 4.6s; --color: #ff5c9a;"></span>
							    <span class="confetti" style="--x: 46%; --delay: -1.5s; --duration: 3.6s; --color: #8c4dff;"></span>
							    <span class="confetti" style="--x: 57%; --delay: -2.5s; --duration: 5.2s; --color: #1bbcff;"></span>
							    <span class="confetti" style="--x: 68%; --delay: -3.5s; --duration: 4.2s; --color: #ffcf42;"></span>
							    <span class="confetti" style="--x: 79%; --delay: -0.5s; --duration: 4.8s; --color: #ff5c9a;"></span>
							    <span class="confetti" style="--x: 90%; --delay: -4.5s; --duration: 3.9s; --color: #8c4dff;"></span>
							</div>
						</div>
						<img alt="회전하는 축구공" src="${rotatingBallImage}" class="rotating-ball">
						
						<button type="button" id="drawBallBtn" class="draw-ball-btn">⚽공 뽑기</button>
					</div>
			</div>
			
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>
