<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin/stadium.css">

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="stadiumContainer">

	<div class="stadiumHeader">
		<h2 class="stadiumTitle">경기장 등록 및 관리</h2>
		<p class="stadiumDesc">경기장 정보를 조회하고 등록·수정하며 예약 가능 상태를 관리합니다.</p>
	</div>


	<div class="stadiumSummary">
		<span>등록 경기장</span>
		<strong>${dataCount}</strong>
		<span>개</span>
	</div>

	<div class="tableWrap">
		<table class="stadiumTable">
			<colgroup>
				<col style="width: 8%;">
				<col style="width: 28%;">
				<col style="width: 18%;">
				<col style="width: 14%;">
				<col style="width: 16%;">
				<col style="width: 16%;">
			</colgroup>

			<thead>
				<tr>
					<th>번호</th>
					<th class="nameHead">경기장 이름</th>
					<th>지역</th>
					<th>수용인원</th>
					<th>상태</th>
					<th>대관료</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach var="dto" items="${stadiumList}" varStatus="status">
					<tr>
						<td class="center">
							${dataCount - (page - 1) * size - status.index}
						</td>

						<td class="stadiumNameCell">
							<a href="${pageContext.request.contextPath}/admin/stadium/article?stadiumId=${dto.stadiumId}&page=${page}">
								<c:out value="${dto.stadiumName}"/>
							</a>
						</td>

						<td class="center"><c:out value="${dto.region}"/></td>

						<td class="center">
							<c:choose>
								<c:when test="${dto.capacity > 0}">${dto.capacity}명</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose>
						</td>

						<td class="center">
							<c:choose>
								<c:when test="${dto.status == 1}">
									<span class="statusBadge available">예약 가능</span>
								</c:when>
								<c:otherwise>
									<span class="statusBadge unavailable">예약 불가</span>
								</c:otherwise>
							</c:choose>
						</td>

						<td class="center">
							<c:choose>
								<c:when test="${dto.stadiumCost > 0}">${dto.stadiumCost}원</c:when>
								<c:otherwise>-</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>

				<c:if test="${empty stadiumList}">
					<tr>
						<td colspan="6" class="emptyRow">등록된 경기장이 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>

	<div class="pagingArea">${paging}</div>

	<div class="listFooterArea">
		<div class="footerLeft">
			<button type="button" class="btnRefresh"
				onclick="location.href='${pageContext.request.contextPath}/admin/stadium/list';"
				title="새로고침">↻</button>
		</div>

		<div class="footerCenter">
			<form id="stadiumSearchForm" class="searchArea"
				action="${pageContext.request.contextPath}/admin/stadium/list" method="get">

				<select id="schType" name="schType" class="searchSelect">
					<option value="stadiumName" ${schType == 'stadiumName' ? 'selected' : ''}>경기장 이름</option>
					<option value="region" ${schType == 'region' ? 'selected' : ''}>지역</option>
				</select>

				<input type="text" id="stadiumNameKeyword" class="searchInput"
					value="${schType == 'stadiumName' ? kwd : ''}"
					placeholder="경기장 이름을 입력하세요">

				<select id="regionKeyword" class="searchSelect regionSelect">
					<option value="">지역 선택</option>
					<option value="서울시" ${schType == 'region' && kwd == '서울시' ? 'selected' : ''}>서울시</option>
					<option value="경기도" ${schType == 'region' && kwd == '경기도' ? 'selected' : ''}>경기도</option>
					<option value="인천시" ${schType == 'region' && kwd == '인천시' ? 'selected' : ''}>인천시</option>
					<option value="안산시" ${schType == 'region' && kwd == '안산시' ? 'selected' : ''}>안산시</option>
					<option value="수원시" ${schType == 'region' && kwd == '수원시' ? 'selected' : ''}>수원시</option>
					<option value="성남시" ${schType == 'region' && kwd == '성남시' ? 'selected' : ''}>성남시</option>
				</select>

				<input type="hidden" id="kwd" name="kwd" value="${kwd}">
				<button type="submit" class="btnSearch">검색</button>
			</form>
		</div>

		<div class="footerRight">
			<button type="button" class="btnWrite"
				onclick="location.href='${pageContext.request.contextPath}/admin/stadium/write';">
				경기장 등록
			</button>
		</div>
	</div>

</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

<script>
(function() {
	const schType = document.querySelector('#schType');
	const stadiumNameKeyword = document.querySelector('#stadiumNameKeyword');
	const regionKeyword = document.querySelector('#regionKeyword');
	const kwd = document.querySelector('#kwd');
	const form = document.querySelector('#stadiumSearchForm');

	function changeSearchInput() {
		const isRegion = schType.value === 'region';

		stadiumNameKeyword.style.display = isRegion ? 'none' : 'block';
		regionKeyword.style.display = isRegion ? 'block' : 'none';
	}

	schType.addEventListener('change', function() {
		stadiumNameKeyword.value = '';
		regionKeyword.value = '';
		changeSearchInput();
	});

	form.addEventListener('submit', function() {
		if(schType.value === 'region') {
			kwd.value = regionKeyword.value;
		} else {
			kwd.value = stadiumNameKeyword.value.trim();
		}
	});

	changeSearchInput();
})();
</script>
