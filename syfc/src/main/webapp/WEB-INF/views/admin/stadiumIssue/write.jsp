<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/stadium-issue.css">

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="issueContainer">

	<div class="issueHeader">
		<h2 class="issueTitle">경기장 이슈 관리</h2>
		<p class="issueDesc">날씨, 공사 등의 사유로 경기장을 한시적으로 이용할 수 없는 기간을 등록합니다.</p>
	</div>

	<form id="issueForm" class="issueForm" action="${pageContext.request.contextPath}/admin/stadiumIssue/write" method="post">

		<div class="formGrid">

			<div class="formGroup wide">
				<label for="stadiumId" class="formLabel">경기장 <span class="required">*</span></label>

				<select id="stadiumId" name="stadiumId" class="formControl" required>
					<option value="">경기장 선택</option>

					<c:forEach var="stadium" items="${stadiumList}">
						<option value="${stadium.stadiumId}">
							<c:out value="${stadium.stadiumName}"/>
							<c:if test="${not empty stadium.region}">
								- <c:out value="${stadium.region}"/>
							</c:if>
						</option>
					</c:forEach>
				</select>
			</div>

			<div class="formGroup">
				<label for="startDate" class="formLabel">시작일 <span class="required">*</span></label>
				<input type="date" id="startDate" name="startDate" class="formControl" required>
			</div>

			<div class="formGroup">
				<label for="endDate" class="formLabel">종료일 <span class="required">*</span></label>
				<input type="date" id="endDate" name="endDate" class="formControl" required>
			</div>

			<div class="formGroup wide">
				<label for="issueType" class="formLabel">이슈 유형</label>

				<select id="issueType" name="issueType" class="formControl">
					<option value="">유형 선택</option>
					<option value="공사">공사</option>
					<option value="날씨">날씨</option>
					<option value="행사">행사</option>
					<option value="시설점검">시설점검</option>
					<option value="기타">기타</option>
				</select>
			</div>

			<div class="formGroup wide">
				<label for="reason" class="formLabel">사유</label>
				<textarea id="reason" name="reason" class="formControl textArea" maxlength="4000"
					placeholder="경기장 이용이 불가능한 사유를 입력하세요."></textarea>
			</div>

		</div>

		<div class="formActions">
			<button type="button" class="btn btnCancel"
				onclick="location.href='${pageContext.request.contextPath}/admin/main';">취소</button>

			<button type="submit" class="btn btnSubmit">이슈 등록</button>
		</div>

	</form>
	
	<div class="issueListArea">

	<div class="resultTitleArea">
		<h3>등록된 경기장 이슈</h3>
		<span>총 <strong>${empty issueList ? 0 : issueList.size()}</strong>건</span>
	</div>

	<div class="tableWrap">
		<table class="issueTable">

			<colgroup>
				<col style="width: 10%;">
				<col style="width: 24%;">
				<col style="width: 18%;">
				<col style="width: 18%;">
				<col style="width: 15%;">
				<col style="width: 15%;">
			</colgroup>

			<thead>
				<tr>
					<th>번호</th>
					<th>경기장</th>
					<th>시작일</th>
					<th>종료일</th>
					<th>유형</th>
					<th>영향 경기</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach var="dto" items="${issueList}">
					<tr>
						<td class="center">${dto.issueId}</td>

						<td>
							<c:out value="${dto.stadiumName}"/>
						</td>

						<td class="center">
							<c:out value="${dto.startDate}"/>
						</td>

						<td class="center">
							<c:out value="${dto.endDate}"/>
						</td>

						<td class="center">
							<c:out value="${empty dto.issueType ? '-' : dto.issueType}"/>
						</td>

						<td class="center">
							<button type="button" class="btnResult"
								onclick="location.href='${pageContext.request.contextPath}/admin/stadiumIssue/result?issueId=${dto.issueId}';">
								결과 보기
							</button>
						</td>
					</tr>
				</c:forEach>

				<c:if test="${empty issueList}">
					<tr>
						<td colspan="6" class="emptyRow">등록된 경기장 이슈가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>

		</table>
	</div>

</div>

</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

<script>
document.querySelector('#issueForm').addEventListener('submit', function(e) {
	const stadiumId = document.querySelector('#stadiumId').value;
	const startDate = document.querySelector('#startDate').value;
	const endDate = document.querySelector('#endDate').value;

	if(!stadiumId) {
		alert('경기장을 선택하세요.');
		document.querySelector('#stadiumId').focus();
		e.preventDefault();
		return;
	}

	if(!startDate || !endDate) {
		alert('시작일과 종료일을 입력하세요.');
		e.preventDefault();
		return;
	}

	if(startDate > endDate) {
		alert('종료일은 시작일보다 빠를 수 없습니다.');
		document.querySelector('#endDate').focus();
		e.preventDefault();
	}
});
</script>