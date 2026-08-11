<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/admin-main.css">

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="adminContainer">

	<div class="adminHeader">
		<h2 class="adminTitle">관리자 페이지</h2>
		<p class="adminDesc">회원, 게시판, 구단 및 경기장 정보를 관리할 수 있습니다.</p>
	</div>

	<div class="adminMenuGrid">

		<div class="adminCard">
			<div class="cardIcon">
				<i class="bi bi-megaphone"></i>
			</div>

			<div class="cardContent">
				<h3>공지사항 관리</h3>
				<p>공지사항을 등록하고 수정·삭제할 수 있습니다.</p>
			</div>

			<button type="button" class="cardButton"
				onclick="location.href='${pageContext.request.contextPath}/admin/notice/list';">
				관리하기
			</button>
		</div>


		<div class="adminCard">
			<div class="cardIcon">
				<i class="bi bi-people"></i>
			</div>

			<div class="cardContent">
				<h3>회원 관리</h3>
				<p>회원 등급과 이용 상태를 관리할 수 있습니다.</p>
			</div>

			<button type="button" class="cardButton"
				onclick="location.href='${pageContext.request.contextPath}/admin/member/list';">
				관리하기
			</button>
		</div>


		<div class="adminCard">
			<div class="cardIcon">
				<i class="bi bi-person-badge"></i>
			</div>

			<div class="cardContent">
				<h3>구단주 신청 관리</h3>
				<p>구단주 신청 내용을 확인하고 승인 또는 반려합니다.</p>
			</div>

			<button type="button" class="cardButton"
				onclick="location.href='${pageContext.request.contextPath}/admin/clubowner/list';">
				관리하기
			</button>
		</div>


		<div class="adminCard disabledCard">
			<div class="cardIcon">
				<i class="bi bi-shield"></i>
			</div>

			<div class="cardContent">
				<h3>구단 관리</h3>
				<p>구단 승인과 구단 상태를 관리합니다.</p>
			</div>

			<button type="button" class="cardButton disabledButton" disabled>
				준비중
			</button>
		</div>


		<div class="adminCard disabledCard">
			<div class="cardIcon">
				<i class="bi bi-geo-alt"></i>
			</div>

			<div class="cardContent">
				<h3>경기장 관리</h3>
				<p>경기장 정보와 이용 가능 상태를 관리합니다.</p>
			</div>

			<button type="button" class="cardButton disabledButton" disabled>
				준비중
			</button>
		</div>


		<div class="adminCard disabledCard">
			<div class="cardIcon">
				<i class="bi bi-chat-left-text"></i>
			</div>

			<div class="cardContent">
				<h3>문의 / 신고 관리</h3>
				<p>문의와 신고 내용을 확인하고 처리합니다.</p>
			</div>

			<button type="button" class="cardButton disabledButton" disabled>
				준비중
			</button>
		</div>

	</div>

</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />