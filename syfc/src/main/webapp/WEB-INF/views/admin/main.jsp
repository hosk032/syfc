<%@ page language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
	uri="jakarta.tags.core"%>

<%-- 공통 리소스 --%>
<jsp:include
	page="/WEB-INF/views/layout/headerResources.jsp" />

<%-- 관리자 메인 전용 CSS --%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin/admin-main.css">

<%-- 공통 헤더 --%>
<jsp:include
	page="/WEB-INF/views/layout/header.jsp" />


<div class="adminContainer">

	<%-- =====================================================
	     관리자 메인
	     게시판 → 회원 관리 → 구단 관리 → 경기장 관리
	     ===================================================== --%>
	<div class="adminHeader">

		<h2 class="adminTitle">
			관리자 페이지
		</h2>

		<p class="adminDesc">
			게시판, 회원, 구단 및 경기장 관련 기능을 관리할 수 있습니다.
		</p>

	</div>


	<div class="adminMenuGrid">


		<%-- =====================================================
		     1. 게시판 관리
		     ===================================================== --%>
		<div class="adminCard">

			<div class="cardIcon">
				<i class="bi bi-chat-square-text"></i>
			</div>

			<div class="cardContent">

				<h3>
					게시판 관리
				</h3>

				<p>
					공지사항, 자유게시판 및 문의·신고 게시판을 통합 관리합니다.
				</p>

				<div class="subMenu">

					<button type="button"
						class="subMenuButton"
						onclick="location.href='${pageContext.request.contextPath}/admin/notice/list';">

						게시판 관리

					</button>

				</div>

			</div>

		</div>



		<%-- =====================================================
		     2. 회원 관리
		     ===================================================== --%>
		<div class="adminCard">

			<div class="cardIcon">
				<i class="bi bi-people"></i>
			</div>

			<div class="cardContent">

				<h3>
					회원 관리
				</h3>

				<p>
					회원 등급과 이용 상태 및 구단주 신청을 관리합니다.
				</p>

				<div class="subMenu">

					<button type="button"
						class="subMenuButton"
						onclick="location.href='${pageContext.request.contextPath}/admin/member/list';">

						회원 등급 / 상태 관리

					</button>


					<button type="button"
						class="subMenuButton"
						onclick="location.href='${pageContext.request.contextPath}/admin/clubowner/list';">

						구단주 신청 관리

					</button>

				</div>

			</div>

		</div>



		<%-- =====================================================
		     3. 구단 관리
		     ===================================================== --%>
		<div class="adminCard">

			<div class="cardIcon">
				<i class="bi bi-shield"></i>
			</div>

			<div class="cardContent">

				<h3>
					구단 관리
				</h3>

				<p>
					구단 창설 신청 승인 및 구단 운영 상태를 관리합니다.
				</p>

				<div class="subMenu">

					<button type="button"
						class="subMenuButton"
						onclick="location.href='${pageContext.request.contextPath}/admin/club/list';">
						구단 관리
					</button>

				</div>

			</div>

		</div>



		<%-- =====================================================
		     4. 경기장 관리
		     ===================================================== --%>
		<div class="adminCard">

			<div class="cardIcon">
				<i class="bi bi-geo-alt"></i>
			</div>

			<div class="cardContent">

				<h3>
					경기장 관리
				</h3>

				<p>
					경기장 상태와 경기장 이용 관련 이슈를 관리합니다.
				</p>

				<div class="subMenu">

					<button type="button"
						class="subMenuButton disabledSubButton"
						disabled>

						경기장 등록 / 상태 관리

					</button>


					<button type="button"
						class="subMenuButton disabledSubButton"
						disabled>

						경기장 이슈 관리

					</button>

				</div>

			</div>

		</div>


	</div>

</div>


<%-- 공통 푸터 --%>
<jsp:include
	page="/WEB-INF/views/layout/footer.jsp" />