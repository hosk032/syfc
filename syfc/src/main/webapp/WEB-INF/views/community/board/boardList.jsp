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
			<a href="${pageContext.request.contextPath}/community/notices/noticeList">공지사항</a> 
			<a href="${pageContext.request.contextPath}/community/board/boardList" class="active">게시판</a> 
			<a href="${pageContext.request.contextPath}/community/qna/qnaList">문의/신고 게시판</a>
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
			
			<div class="row board-list-footer">
				<div class="col">
					<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/community/boardList';" title="새로고침"><i class="bi bi-arrow-counterclockwise"></i></button>
				</div>
				<div class="col-6 d-flex justify-content-center">
					<form class="row" name="searchForm">
						<div class="col-auto p-1">
							<select name="schType" class="form-select">
								<option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
								<option value="userName" ${schType=="userName"?"selected":""}>작성자</option>
								<option value="subject" ${schType=="subject"?"selected":""}>제목</option>
								<option value="content" ${schType=="content"?"selected":""}>내용</option>
							</select>
						</div>
						<div class="col-auto p-1">
							<input type="text" name="kwd" value="${kwd}" class="form-control">
						</div>
						<div class="col-auto p-1">
							<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
						</div>
					</form>
				</div>
				
				<div class="col text-end">
					<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/community/board/write';">글올리기</button>
				</div>
			</div>
			<div class="board-number">
				<span>1 2 3</span>
			</div>
		</section>
	</div>

	<!-- 하단 푸터 조립 -->
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

	<!-- 3. 게시판 목록 전용 JS 연결 (dist/js/community/boardList.js) -->
	<!-- 
	<script src="${pageContext.request.contextPath}/dist/js/community/boardList.js"></script>
	 -->
</body>
</html>