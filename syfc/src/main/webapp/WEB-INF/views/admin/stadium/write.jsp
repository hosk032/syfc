<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin/stadium.css">

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="stadiumContainer">

	<div class="stadiumHeader">
		<h2 class="stadiumTitle">
			<c:choose>
				<c:when test="${mode == 'update'}">경기장 정보 수정</c:when>
				<c:otherwise>경기장 등록</c:otherwise>
			</c:choose>
		</h2>

		<p class="stadiumDesc">
			<c:choose>
				<c:when test="${mode == 'update'}">등록된 경기장 정보를 수정합니다.</c:when>
				<c:otherwise>새 경기장의 기본 정보를 입력합니다.</c:otherwise>
			</c:choose>
		</p>
	</div>

	<form id="stadiumForm" class="stadiumForm"
		action="${pageContext.request.contextPath}/admin/stadium/${mode == 'update' ? 'update' : 'write'}"
		method="post">

		<c:if test="${mode == 'update'}">
			<input type="hidden" name="stadiumId" value="${dto.stadiumId}">
		</c:if>

		<div class="formSectionTitle">기본 정보</div>

		<div class="formGrid">
			<div class="formGroup wide">
				<label for="stadiumName" class="formLabel">경기장명 <span class="required">*</span></label>
				<input type="text" id="stadiumName" name="stadiumName" class="formControl"
					value="${fn:escapeXml(dto.stadiumName)}" maxlength="200" required>
			</div>

			<div class="formGroup">
				<label for="region" class="formLabel">지역 <span class="required">*</span></label>
				<select id="region" name="region" class="formControl" required>
					<option value="">지역 선택</option>
					<option value="서울시" ${dto.region == '서울시' ? 'selected' : ''}>서울시</option>
					<option value="경기도" ${dto.region == '경기도' ? 'selected' : ''}>경기도</option>
					<option value="인천시" ${dto.region == '인천시' ? 'selected' : ''}>인천시</option>
					<option value="안산시" ${dto.region == '안산시' ? 'selected' : ''}>안산시</option>
					<option value="수원시" ${dto.region == '수원시' ? 'selected' : ''}>수원시</option>
					<option value="성남시" ${dto.region == '성남시' ? 'selected' : ''}>성남시</option>
				</select>
			</div>

			<div class="formGroup">
				<label for="capacity" class="formLabel">수용인원</label>
				<input type="number" id="capacity" name="capacity" class="formControl"
					value="${dto.capacity > 0 ? dto.capacity : ''}" min="0" placeholder="예: 300">
			</div>

			<c:if test="${mode == 'update'}">
				<div class="formGroup">
					<label for="status" class="formLabel">예약 상태</label>
					<select id="status" name="status" class="formControl">
						<option value="1" ${dto.status == 1 ? 'selected' : ''}>예약 가능</option>
						<option value="0" ${dto.status == 0 ? 'selected' : ''}>예약 불가</option>
					</select>
				</div>
			</c:if>

			<div class="formGroup">
				<label for="stadiumCost" class="formLabel">대관료</label>
				<input type="number" id="stadiumCost" name="stadiumCost" class="formControl"
					value="${dto.stadiumCost > 0 ? dto.stadiumCost : ''}" min="0" placeholder="원 단위">
			</div>
		</div>

		<div class="formSectionTitle">주소 및 위치</div>

		<div class="formGrid">
			<div class="formGroup">
				<label for="zip" class="formLabel">우편번호</label>
				<input type="text" id="zip" name="zip" class="formControl"
					value="${fn:escapeXml(dto.zip)}" maxlength="4000">
			</div>

			<div class="formGroup wide">
				<label for="addr1" class="formLabel">우편주소</label>
				<input type="text" id="addr1" name="addr1" class="formControl"
					value="${fn:escapeXml(dto.addr1)}" maxlength="4000">
			</div>

			<div class="formGroup wide">
				<label for="addr2" class="formLabel">상세주소</label>
				<input type="text" id="addr2" name="addr2" class="formControl"
					value="${fn:escapeXml(dto.addr2)}" maxlength="4000">
			</div>

			<div class="formGroup">
				<label for="latitude" class="formLabel">위도</label>
				<input type="number" id="latitude" name="latitude" class="formControl"
					value="${dto.latitude != 0 ? dto.latitude : ''}" placeholder="위도">
			</div>

			<div class="formGroup">
				<label for="longitude" class="formLabel">경도</label>
				<input type="number" id="longitude" name="longitude" class="formControl"
					value="${dto.longitude != 0 ? dto.longitude : ''}" placeholder="경도">
			</div>
		</div>

		<div class="formSectionTitle">이미지</div>

		<div class="formGrid">
			<div class="formGroup wide">
				<label for="stadiumImg" class="formLabel">경기장 이미지 경로</label>
				<input type="text" id="stadiumImg" name="stadiumImg" class="formControl"
					value="${fn:escapeXml(dto.stadiumImg)}" maxlength="1000"
					placeholder="현재 단계에서는 이미지 URL 또는 경로 문자열 입력">
			</div>
		</div>

		<div class="formActions">
			<c:choose>
				<c:when test="${mode == 'update'}">
					<button type="reset" class="btn btnReset">원래대로</button>
					<button type="button" class="btn btnCancel"
						onclick="location.href='${pageContext.request.contextPath}/admin/stadium/article?stadiumId=${dto.stadiumId}&page=${empty param.page ? 1 : param.page}';">
						취소
					</button>
					<button type="submit" class="btn btnSubmit">수정 완료</button>
				</c:when>

				<c:otherwise>
					<button type="button" class="btn btnCancel"
						onclick="location.href='${pageContext.request.contextPath}/admin/stadium/list';">
						취소
					</button>
					<button type="submit" class="btn btnSubmit">등록</button>
				</c:otherwise>
			</c:choose>
		</div>
	</form>

</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

<script>
document.querySelector('#stadiumForm').addEventListener('submit', function(e) {
	const stadiumName = document.querySelector('#stadiumName').value.trim();
	const region = document.querySelector('#region').value;

	if(!stadiumName) {
		alert('경기장명을 입력하세요.');
		document.querySelector('#stadiumName').focus();
		e.preventDefault();
		return;
	}

	if(!region) {
		alert('지역을 선택하세요.');
		document.querySelector('#region').focus();
		e.preventDefault();
	}
});
</script>
