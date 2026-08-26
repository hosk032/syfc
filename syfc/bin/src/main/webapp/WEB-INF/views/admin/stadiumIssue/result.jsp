<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/stadium-issue.css">

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="issueContainer">

	<div class="issueHeader">
		<h2 class="issueTitle">경기장 이슈 관리</h2>
		<p class="issueDesc">입력하신 경기장 이슈로 영향 받는 경기 예약 목록입니다. 반려 여부를 확인하세요.</p>
	</div>

	<!-- 등록한 경기장 이슈 정보 -->
	<div class="issueInfo">

		<div class="infoItem">
			<span class="infoLabel">경기장</span>
			<strong><c:out value="${issue.stadiumName}"/></strong>
		</div>

		<div class="infoItem">
			<span class="infoLabel">기간</span>
			<strong><c:out value="${issue.startDate}"/> ~ <c:out value="${issue.endDate}"/></strong>
		</div>

		<div class="infoItem">
			<span class="infoLabel">유형</span>
			<strong><c:out value="${empty issue.issueType ? '-' : issue.issueType}"/></strong>
		</div>

		<div class="infoItem wide">
			<span class="infoLabel">사유</span>
			<strong><c:out value="${empty issue.reason ? '-' : issue.reason}"/></strong>
		</div>

	</div>

	<!-- 영향 받는 경기 목록 -->
	<div class="resultTitleArea">
		<h3>영향 받는 경기 예약</h3>
		<span>총 <strong>${empty matchList ? 0 : matchList.size()}</strong>건</span>
	</div>

	<div class="tableWrap">
		<table class="issueTable">

			<colgroup>
				<col style="width: 10%;">
				<col style="width: 20%;">
				<col style="width: 22%;">
				<col style="width: 22%;">
				<col style="width: 14%;">
				<col style="width: 12%;">
			</colgroup>

			<thead>
				<tr>
					<th>신청번호</th>
					<th>신청일</th>
					<th>홈구단</th>
					<th>원정구단</th>
					<th>신청상태</th>
					<th>처리</th>
				</tr>
			</thead>

			<tbody>

				<c:forEach var="dto" items="${matchList}">
					<tr>

						<td class="center">${dto.applyId}</td>

						<td class="center">
							<c:out value="${dto.applyDate}"/>
						</td>

						<td>
							<c:out value="${empty dto.homeClubName ? '-' : dto.homeClubName}"/>
						</td>

						<td>
							<c:out value="${empty dto.awayClubName ? '-' : dto.awayClubName}"/>
						</td>

						<td class="center">
							<c:choose>
								<c:when test="${dto.applyStatus == 4}">
									<span class="matchStatus rejected">반려</span>
								</c:when>

								<c:when test="${dto.applyStatus == 3}">
									<span class="matchStatus failed">매칭대기</span>
								</c:when>

								<c:when test="${dto.applyStatus == 2}">
									<span class="matchStatus waiting">매칭신청</span>
								</c:when>

								<c:when test="${dto.applyStatus == 1}">
									<span class="matchStatus matched">매칭</span>
								</c:when>

								<c:otherwise>
									<span class="matchStatus canceled">취소</span>
								</c:otherwise>
							</c:choose>
						</td>

						<td class="center">
							<c:choose>

								<c:when test="${dto.applyStatus == 4}">
									<button type="button" class="btnReject disabled" disabled>반려완료</button>
								</c:when>

								<c:otherwise>
									<form class="rejectForm" action="${pageContext.request.contextPath}/admin/stadiumIssue/reject" method="post">
										<input type="hidden" name="applyId" value="${dto.applyId}">
										<input type="hidden" name="issueId" value="${issue.issueId}">
										<button type="submit" class="btnReject">반려</button>
									</form>
								</c:otherwise>

							</c:choose>
						</td>

					</tr>
				</c:forEach>

				<c:if test="${empty matchList}">
					<tr>
						<td colspan="6" class="emptyRow">해당 기간에 영향 받는 경기 예약이 없습니다.</td>
					</tr>
				</c:if>

			</tbody>

		</table>
	</div>

	<div class="bottomActions">
		<button type="button" class="btn btnCancel"
			onclick="location.href='${pageContext.request.contextPath}/admin/main';">관리자 메인</button>

		<button type="button" class="btn btnSubmit"
			onclick="location.href='${pageContext.request.contextPath}/admin/stadiumIssue/write';">새 이슈 등록</button>
	</div>

</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

<script>
document.querySelectorAll('.rejectForm').forEach(function(form) {
	form.addEventListener('submit', function(e) {
		if(!confirm('해당 경기 신청을 반려하시겠습니까?')) {
			e.preventDefault();
		}
	});
});
</script>