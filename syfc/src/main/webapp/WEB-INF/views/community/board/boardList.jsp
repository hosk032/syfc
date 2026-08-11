<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>쌍용축구예약 - 커뮤니티 게시판</title>

	<!-- 1. 공통 CSS/CDN/폰트 리소스 조립 -->
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

	<!-- 2. 게시판 목록 전용 CSS 연결 (dist/css/community/boardList.css) -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/community/boardList.css" />
</head>
<body>

	<!-- 상단 헤더/네비게이션 조립 -->
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<div class="board-container my-4">
		<!-- 왼쪽 서브 메뉴 (사이드바) -->
		<aside class="community-side-menu">
			<div class="side-menu-title">커뮤니티</div>
			<a href="${pageContext.request.contextPath}/community/noticeList">공지사항</a> 
			<a href="${pageContext.request.contextPath}/community/boardList" class="active">게시판</a> 
			<a href="${pageContext.request.contextPath}/community/qnaList">문의/신고 게시판</a>
		</aside>

		<!-- 오른쪽 목록 본문 영역 -->
		<section class="board-list-area">
			<div class="board-top">
				<h3>게시판</h3>

				<div class="board-category">
					<span>전체</span> 
					<span>자유글</span> 
					<span>경기후기</span>
				</div>
			</div>

			<div class="board-header">
				<span>번호</span> 
				<span>제목</span> 
				<span>작성자</span> 
				<span>작성일</span> 
				<span>조회수</span>
			</div>
			
			<div class="memo-row" onclick="location.href='${pageContext.request.contextPath}/community/boardDetail';">
				<span>공지</span> 
				<span>축구장 예약 이용 안내</span> 
				<span>관리자</span> 
				<span>2026-08-04</span> 
				<span>80</span>
			</div>
			
			<div class="memo-row" onclick="location.href='${pageContext.request.contextPath}/community/boardDetail';">
				<span>공지</span> 
				<span>축구장 이용시 주의사항 안내</span> 
				<span>관리자</span> 
				<span>2026-08-04</span> 
				<span>70</span>
			</div>
			
			<div class="memo-row" onclick="location.href='${pageContext.request.contextPath}/community/boardDetail';">
				<span>공지</span> 
				<span>더운 여름! 음료한잔 이벤트</span> 
				<span>관리자</span> 
				<span>2026-08-04</span> 
				<span>100</span>
			</div>
			
			<div class="board-number">
				<span>1 2 3</span>
			</div>
		</section>
	</div>

	<!-- 하단 푸터 조립 -->
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

	<!-- 3. 게시판 목록 전용 JS 연결 (dist/js/community/boardList.js) -->
	<script src="${pageContext.request.contextPath}/dist/js/community/boardList.js"></script>
</body>
</html>