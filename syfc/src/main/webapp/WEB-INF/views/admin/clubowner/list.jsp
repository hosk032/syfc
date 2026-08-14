<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<%-- 공통 CSS / Bootstrap 등 리소스 --%>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<%-- 구단주 신청관리 전용 CSS --%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/clubowner.css">

<%-- 공통 헤더 --%>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="clubOwnerContainer">

	<%-- =====================================================
	     구단주 신청관리 제목
	     ===================================================== --%>
	<div class="clubOwnerHeader">
		<h2 class="clubOwnerTitle">구단주 신청 관리</h2>
		<p class="clubOwnerDesc">구단주 신청 내역을 확인하고 승인 또는 반려할 수 있습니다.</p>
	</div>

	<%-- =====================================================
	     전체 신청 건수 + 상태별 조회
	     ===================================================== --%>
	<div class="topArea">
		<div class="requestCount">신청 내역 <strong>${dataCount}</strong>건</div>

		<form class="statusForm" action="${pageContext.request.contextPath}/admin/clubowner/list" method="get">
			<input type="hidden" name="schType" value="${schType}">
			<input type="hidden" name="kwd" value="${kwd}">

			<%-- 상태를 변경하면 바로 목록을 다시 조회한다. --%>
			<select name="status" class="statusSelect" onchange="this.form.submit();">
				<option value="all" ${status == 'all' ? 'selected' : ''}>전체</option>
				<option value="2" ${status == '2' ? 'selected' : ''}>대기</option>
				<option value="1" ${status == '1' ? 'selected' : ''}>승인</option>
				<option value="0" ${status == '0' ? 'selected' : ''}>반려</option>
			</select>
		</form>
	</div>

	<%-- =====================================================
	     구단주 신청 목록
	     ===================================================== --%>
	<div class="tableWrap">
		<table class="clubOwnerTable">

			<%-- 각 열의 너비 --%>
			<colgroup>
				<col style="width: 7%;">
				<col style="width: 12%;">
				<col style="width: 10%;">
				<col style="width: 13%;">
				<col style="width: 26%;">
				<col style="width: 11%;">
				<col style="width: 9%;">
				<col style="width: 12%;">
			</colgroup>

			<thead>
				<tr>
					<th>번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>연락처</th>
					<th>신청사유</th>
					<th>신청일</th>
					<th>상태</th>
					<th>관리</th>
				</tr>
			</thead>

			<tbody>

				<%-- Controller에서 전달받은 신청목록 반복 출력 --%>
				<c:forEach var="dto" items="${list}" varStatus="st">
					<tr>

						<%-- 실제 PK가 아니라 화면에 보여줄 순번 --%>
						<td class="center">${dataCount - (page - 1) * 10 - st.index}</td>

						<td class="center"><c:out value="${dto.userId}"/></td>
						<td class="center"><c:out value="${dto.userName}"/></td>

						<%-- 연락처가 없는 경우 - 표시 --%>
						<td class="center">
							<c:choose>
								<c:when test="${empty dto.tel}">-</c:when>
								<c:otherwise><c:out value="${dto.tel}"/></c:otherwise>
							</c:choose>
						</td>

						<%-- 신청사유가 길면 CSS에서 말줄임 처리 --%>
						<td class="contentCell" title="${dto.content}">
							<c:out value="${dto.content}"/>
						</td>

						<td class="center">${dto.requestDate}</td>

						<%-- =================================================
						     신청상태
						     2 = 대기 / 1 = 승인 / 0 = 반려
						     ================================================= --%>
						<td class="center">
							<c:choose>
								<c:when test="${dto.status == 2}">
									<span class="statusWait">대기</span>
								</c:when>

								<c:when test="${dto.status == 1}">
									<span class="statusApprove">승인</span>
								</c:when>

								<c:otherwise>
									<span class="statusReject">반려</span>
								</c:otherwise>
							</c:choose>
						</td>

						<%-- =================================================
						     ★ 승인 / 반려 버튼

						     아직 대기(2) 상태인 신청에만 버튼을 출력한다.
						     이미 처리된 신청에는 완료 문구만 출력한다.
						     ================================================= --%>
						<td class="center manageCell">

							<c:if test="${dto.status == 2}">
								<form class="inlineForm" action="${pageContext.request.contextPath}/admin/clubowner/approve" method="post">
									<input type="hidden" name="requestNum" value="${dto.requestNum}">
									<input type="hidden" name="page" value="${page}">
									<button type="submit" class="btnSmall btnApprove" onclick="return confirm('구단주 신청을 승인하시겠습니까?');">승인</button>
								</form>

								<form class="inlineForm" action="${pageContext.request.contextPath}/admin/clubowner/reject" method="post">
									<input type="hidden" name="requestNum" value="${dto.requestNum}">
									<input type="hidden" name="page" value="${page}">
									<button type="submit" class="btnSmall btnReject" onclick="return confirm('구단주 신청을 반려하시겠습니까?');">반려</button>
								</form>
							</c:if>

							<c:if test="${dto.status == 1}">
								<span class="completeText">승인완료</span>
							</c:if>

							<c:if test="${dto.status == 0}">
								<span class="completeText">반려완료</span>
							</c:if>

						</td>
					</tr>
				</c:forEach>

				<%-- 검색 결과 또는 신청내역이 없는 경우 --%>
				<c:if test="${empty list}">
					<tr>
						<td colspan="8" class="emptyRow">구단주 신청 내역이 없습니다.</td>
					</tr>
				</c:if>

			</tbody>
		</table>
	</div>

	<%-- 페이징 --%>
	<div class="pagingArea">${paging}</div>

	<%-- =====================================================
	     새로고침 + 검색
	     ===================================================== --%>
	<div class="bottomArea">

		<%-- 검색조건을 초기화하고 전체 목록으로 돌아간다. --%>
		<button type="button" class="btnRefresh" onclick="location.href='${pageContext.request.contextPath}/admin/clubowner/list';">↻</button>

		<form class="searchArea" action="${pageContext.request.contextPath}/admin/clubowner/list" method="get">

			<%-- 검색 후에도 현재 상태필터 유지 --%>
			<input type="hidden" name="status" value="${status}">

			<select name="schType" class="searchSelect">
				<option value="all" ${schType == 'all' ? 'selected' : ''}>아이디 + 이름 + 사유</option>
				<option value="userId" ${schType == 'userId' ? 'selected' : ''}>아이디</option>
				<option value="userName" ${schType == 'userName' ? 'selected' : ''}>이름</option>
				<option value="content" ${schType == 'content' ? 'selected' : ''}>신청사유</option>
			</select>

			<input type="text" name="kwd" value="${kwd}" class="searchInput" placeholder="검색어를 입력하세요">
			<button type="submit" class="btnSearch">검색</button>
		</form>

		<div class="bottomBlank"></div>
	</div>

</div>

<%-- 공통 푸터 --%>
<jsp:include page="/WEB-INF/views/layout/footer.jsp" />