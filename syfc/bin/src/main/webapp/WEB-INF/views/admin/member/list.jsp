<%@ page language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
	uri="jakarta.tags.core"%>

<jsp:include
	page="/WEB-INF/views/layout/headerResources.jsp" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin/member.css">

<jsp:include
	page="/WEB-INF/views/layout/header.jsp" />

<div class="memberContainer">

	<div class="memberHeader">

		<h2 class="memberTitle">
			회원 관리
		</h2>

		<p class="memberDesc">
			회원의 등급과 이용 상태를 관리할 수 있습니다.
		</p>

	</div>

	<div class="memberCount">

		전체 회원
		<strong>${dataCount}</strong>명

	</div>

	<div class="tableWrap">

		<table class="memberTable">

			<colgroup>

				<col style="width: 9%;">

				<col style="width: 19%;">

				<col style="width: 17%;">

				<col style="width: 15%;">

				<col style="width: 12%;">

				<col style="width: 28%;">

			</colgroup>

			<thead>

				<tr>

					<th>번호</th>

					<th>아이디</th>

					<th>이름</th>

					<th>회원등급</th>

					<th>상태</th>

					<th>관리</th>

				</tr>

			</thead>

			<tbody>

				<c:forEach
					var="dto"
					items="${list}"
					varStatus="status">

					<tr>

						<!-- 화면용 번호 -->
						<td class="center">

							${dataCount - (page - 1) * 10 - status.index}

						</td>

						<!-- 아이디 -->
						<td class="center">

							${dto.userId}

						</td>

						<!-- 이름 -->
						<td class="center">

							${dto.userName}

						</td>

						<!-- 회원 등급 -->
						<td class="center">

							<c:choose>

								<c:when test="${dto.userLevel == 1}">

									<span class="levelNormal">
										일반회원
									</span>

								</c:when>

								<c:when test="${dto.userLevel == 10}">

									<span class="levelPlayer">
										선수
									</span>

								</c:when>

								<c:when test="${dto.userLevel == 50}">

									<span class="levelOwner">
										구단주
									</span>

								</c:when>

								<c:when test="${dto.userLevel == 100}">

									<span class="levelAdmin">
										관리자
									</span>

								</c:when>

								<c:otherwise>

									${dto.userLevel}

								</c:otherwise>

							</c:choose>

						</td>

						<!-- 회원 상태 -->
						<td class="center">

							<c:choose>

								<c:when test="${dto.status == 1}">

									<span class="statusNormal">
										정상
									</span>

								</c:when>

								<c:when test="${dto.status == 2}">

									<span class="statusStop">
										정지
									</span>

								</c:when>

								<c:when test="${dto.status == 0}">

									<span class="statusStop">
										탈퇴
									</span>

								</c:when>

								<c:otherwise>

									${dto.status}

								</c:otherwise>

							</c:choose>

						</td>

						<!-- 관리 -->
						<td class="center manageCell">

							<!-- =================================================
							     일반회원 → 구단주
							     ================================================= -->
							<c:if test="${dto.userLevel == 1 && dto.status != 0}">

								<form
									class="inlineForm"
									action="${pageContext.request.contextPath}/admin/member/level"
									method="post">

									<input type="hidden"
										name="memberIdx"
										value="${dto.memberIdx}">

									<input type="hidden"
										name="userLevel"
										value="50">

									<input type="hidden"
										name="page"
										value="${page}">

									<button type="submit"
										class="btnSmall btnLevel"
										onclick="return confirm('구단주로 변경하시겠습니까?');">

										구단주 변경

									</button>

								</form>

							</c:if>

							<!-- =================================================
							     구단주 → 일반회원
							     ================================================= -->
							<c:if test="${dto.userLevel == 50 && dto.status != 0}">

								<form
									class="inlineForm"
									action="${pageContext.request.contextPath}/admin/member/level"
									method="post">

									<input type="hidden"
										name="memberIdx"
										value="${dto.memberIdx}">

									<input type="hidden"
										name="userLevel"
										value="1">

									<input type="hidden"
										name="page"
										value="${page}">

									<button type="submit"
										class="btnSmall btnLevel"
										onclick="return confirm('일반회원으로 변경하시겠습니까?');">

										일반회원 변경

									</button>

								</form>

							</c:if>

							<!-- 선수 -->
							<c:if test="${dto.userLevel == 10 && dto.status != 0}">

								<span class="noManage">
									선수
								</span>

							</c:if>

							<!-- 관리자 -->
							<c:if test="${dto.userLevel == 100}">

								<span class="noManage">
									관리자
								</span>

							</c:if>

							<!-- =================================================
							     정상 회원 → 정지

							     ★ status = 2로 변경
							     ================================================= -->
							<c:if test="${dto.userLevel != 100 && dto.status == 1}">

								<form
									class="inlineForm"
									action="${pageContext.request.contextPath}/admin/member/status"
									method="post">

									<input type="hidden"
										name="memberIdx"
										value="${dto.memberIdx}">

									<input type="hidden"
										name="status"
										value="2">

									<input type="hidden"
										name="page"
										value="${page}">

									<button type="submit"
										class="btnSmall btnStop"
										onclick="return confirm('해당 회원을 정지하시겠습니까?');">

										정지

									</button>

								</form>

							</c:if>

							<!-- =================================================
							     정지 회원 → 정상

							     status = 1로 변경
							     ================================================= -->
							<c:if test="${dto.userLevel != 100 && dto.status == 2}">

								<form
									class="inlineForm"
									action="${pageContext.request.contextPath}/admin/member/status"
									method="post">

									<input type="hidden"
										name="memberIdx"
										value="${dto.memberIdx}">

									<input type="hidden"
										name="status"
										value="1">

									<input type="hidden"
										name="page"
										value="${page}">

									<button type="submit"
										class="btnSmall btnRelease"
										onclick="return confirm('회원 정지를 해제하시겠습니까?');">

										정지해제

									</button>

								</form>

							</c:if>

							<!-- =================================================
							     탈퇴 회원

							     탈퇴회원은 정지/해제하지 않음
							     ================================================= -->
							<c:if test="${dto.userLevel != 100 && dto.status == 0}">

								<span class="noManage">
									탈퇴회원
								</span>

							</c:if>

						</td>

					</tr>

				</c:forEach>

				<c:if test="${empty list}">

					<tr>

						<td colspan="6"
							class="emptyMember">

							등록된 회원이 없습니다.

						</td>

					</tr>

				</c:if>

			</tbody>

		</table>

	</div>

	<!-- 페이징 -->
	<div class="pagingArea">

		${paging}

	</div>

	<!-- 하단 -->
	<div class="memberFooter">

		<!-- 왼쪽 : 전체 목록 -->
		<div class="footerLeft">

			<button type="button"
				class="btnRefresh"
				onclick="location.href='${pageContext.request.contextPath}/admin/member/list';"
				title="새로고침">

				↻

			</button>

		</div>

		<!-- 가운데 : 검색 -->
		<div class="footerSearch">

			<form class="searchArea"
				action="${pageContext.request.contextPath}/admin/member/list"
				method="get">

				<select
					name="schType"
					class="searchSelect">

					<option value="all"
						${schType == 'all' ? 'selected' : ''}>

						아이디 + 이름

					</option>

					<option value="userId"
						${schType == 'userId' ? 'selected' : ''}>

						아이디

					</option>

					<option value="userName"
						${schType == 'userName' ? 'selected' : ''}>

						이름

					</option>

				</select>

				<input type="text"
					name="kwd"
					value="${kwd}"
					class="searchInput"
					placeholder="검색어를 입력하세요">

				<button type="submit"
					class="btnSearch">

					검색

				</button>

			</form>

		</div>

		<div class="footerRight">
		</div>

	</div>

</div>

<jsp:include
	page="/WEB-INF/views/layout/footer.jsp" />