<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>쌍용축구예약 - 공지사항</title>

	<!-- 1. 공통 CSS/CDN/폰트 리소스 조립 -->
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

	<!-- 2. 공지사항 전용 CSS 연결 (dist/css/community/noticeList.css) -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/community/noticeList.css" />
</head>
<body>

	<!-- 상단 헤더/네비게이션 조립 -->
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<div class="notice-container my-4">
		<!-- 왼쪽 서브 메뉴 (사이드바) -->
		<aside class="community-side-menu">
			<div class="side-menu-title">커뮤니티</div>
			<a href="${pageContext.request.contextPath}/community/noticeList" class="active">공지사항</a> 
			<a href="${pageContext.request.contextPath}/community/boardList">게시판</a> 
			<a href="${pageContext.request.contextPath}/community/qnaList">문의/신고 게시판</a>
		</aside>

		<!-- 오른쪽 목록 본문 영역 -->
		<section class="board-list-area">
			<div class="board-top">
				<h3>공지사항</h3>

				<div class="board-category">
					<span>전체</span> 
					<span>공지글</span> 
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
				<span>안녕하세요</span> 
				<span>관리자</span> 
				<span>2026-08-04</span> 
				<span>15</span>
			</div>
			
			<div class="memo-row" onclick="location.href='${pageContext.request.contextPath}/community/boardDetail';">
				<span>공지</span> 
				<span>공지드립니다</span> 
				<span>관리자</span> 
				<span>2026-08-04</span> 
				<span>18</span>
			</div>
			
			<div class="memo-row" onclick="location.href='${pageContext.request.contextPath}/community/boardDetail';">
				<span>공지</span> 
				<span>^^</span> 
				<span>바나나</span> 
				<span>2026-08-04</span> 
				<span>22</span>
			</div>
			
			<div class="board-number">
				<span>1 2 3</span>
			</div>
		</section>
	</div>

	<!-- 하단 푸터 조립 -->
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

	<!-- 3. 공지사항 전용 JS 연결 (dist/js/community/noticeList.js) -->
	<script src="${pageContext.request.contextPath}/dist/js/community/noticeList.js"></script>
</body>
</html>