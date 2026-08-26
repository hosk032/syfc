<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/stadium-issue.css">

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="issueContainer">

	<div class="issueHeader">
		<h2 class="issueTitle">경기장 이슈 수정</h2>
		<p class="issueDesc">등록된 경기장 이용 불가 정보를 수정합니다.</p>
	</div>

	<form id="issueForm" class="issueForm"
		action="${pageContext.request.contextPath}/admin/stadiumIssue/update" method="post">

		<input type="hidden" name="issueId" value="${dto.issueId}">

		<div class="formGrid">

			<div class="formGroup wide">
				<label class="formLabel">경기장</label>

				<div class="formControl readonlyControl">
					<c:out value="${dto.stadiumName}"/>

					<c:if test="${not empty dto.region}">
						- <c:out value="${dto.region}"/>
					</c:if>
				</div>
			</div>

			<div class="formGroup">
				<label for="startDate" class="formLabel">
					시작일 <span class="required">*</span>
				</label>

				<input type="date" id="startDate" name="startDate"
					class="formControl" value="${dto.startDate}" required>
			</div>

			<div class="formGroup">
				<label for="endDate" class="formLabel">
					종료일 <span class="required">*</span>
				</label>

				<input type="date" id="endDate" name="endDate"
					class="formControl" value="${dto.endDate}" required>
			</div>

			<div class="formGroup wide">
				<label for="issueType" class="formLabel">이슈 유형</label>

				<select id="issueType" name="issueType" class="formControl">
					<option value="">유형 선택</option>
					<option value="공사" ${dto.issueType == '공사' ? 'selected' : ''}>공사</option>
					<option value="날씨" ${dto.issueType == '날씨' ? 'selected' : ''}>날씨</option>
					<option value="행사" ${dto.issueType == '행사' ? 'selected' : ''}>행사</option>
					<option value="시설점검" ${dto.issueType == '시설점검' ? 'selected' : ''}>시설점검</option>
					<option value="기타" ${dto.issueType == '기타' ? 'selected' : ''}>기타</option>
				</select>
			</div>

			<div class="formGroup wide">
				<label for="reason" class="formLabel">사유</label>

				<textarea id="reason" name="reason" class="formControl textArea"
					maxlength="4000"><c:out value="${dto.reason}"/></textarea>
			</div>

		</div>

		<div class="formActions">
			<button type="button" class="btn btnCancel"
				onclick="location.href='${pageContext.request.contextPath}/admin/stadiumIssue/write';">
				취소
			</button>

			<button type="submit" class="btn btnSubmit">
				수정 완료
			</button>
		</div>

	</form>

</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

<script>
document.querySelector('#issueForm').addEventListener('submit', function(e) {
	const startDate = document.querySelector('#startDate').value;
	const endDate = document.querySelector('#endDate').value;

	if(!startDate || !endDate) {
		alert('시작일과 종료일을 입력하세요.');
		e.preventDefault();
		return;
	}

	if(startDate > endDate) {
		alert('종료일은 시작일보다 빠를 수 없습니다.');
		document.querySelector('#endDate').focus();
		e.preventDefault();
		return;
	}

	if(!confirm('경기장 이슈 정보를 수정하시겠습니까?')) {
		e.preventDefault();
	}
});
</script>