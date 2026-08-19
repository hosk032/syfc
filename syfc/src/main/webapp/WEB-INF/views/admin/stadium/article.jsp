<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin/stadium.css">

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="stadiumContainer">

	<div class="stadiumHeader">
		<h2 class="stadiumTitle">경기장 상세 정보</h2>
		<p class="stadiumDesc">등록된 경기장의 상세 정보를 확인합니다.</p>
	</div>

	<div class="detailCard">
		<div class="detailTop">
			<div>
				<span class="detailNo">경기장 번호 ${dto.stadiumId}</span>
				<h3 class="detailName"><c:out value="${dto.stadiumName}"/></h3>
			</div>

			<c:choose>
				<c:when test="${dto.status == 1}">
					<span class="statusBadge available large">예약 가능</span>
				</c:when>
				<c:otherwise>
					<span class="statusBadge unavailable large">예약 불가</span>
				</c:otherwise>
			</c:choose>
		</div>

		<c:if test="${not empty dto.stadiumImg}">
			<div class="stadiumImageWrap">
				<img src="<c:out value='${dto.stadiumImg}'/>" alt="경기장 이미지" class="stadiumImage">
			</div>
		</c:if>

		<div class="detailGrid">
			<div class="detailItem">
				<span class="detailLabel">지역</span>
				<strong><c:out value="${dto.region}"/></strong>
			</div>

			<div class="detailItem">
				<span class="detailLabel">수용인원</span>
				<strong>${dto.capacity > 0 ? dto.capacity : '-'}<c:if test="${dto.capacity > 0}">명</c:if></strong>
			</div>

			<div class="detailItem">
				<span class="detailLabel">대관료</span>
				<strong>${dto.stadiumCost > 0 ? dto.stadiumCost : '-'}<c:if test="${dto.stadiumCost > 0}">원</c:if></strong>
			</div>

			<div class="detailItem">
				<span class="detailLabel">우편번호</span>
				<strong><c:out value="${empty dto.zip ? '-' : dto.zip}"/></strong>
			</div>

			<div class="detailItem wide">
				<span class="detailLabel">우편주소</span>
				<strong><c:out value="${empty dto.addr1 ? '-' : dto.addr1}"/></strong>
			</div>

			<div class="detailItem wide">
				<span class="detailLabel">상세주소</span>
				<strong><c:out value="${empty dto.addr2 ? '-' : dto.addr2}"/></strong>
			</div>

			<div class="detailItem">
				<span class="detailLabel">위도</span>
				<strong>${dto.latitude != 0 ? dto.latitude : '-'}</strong>
			</div>

			<div class="detailItem">
				<span class="detailLabel">경도</span>
				<strong>${dto.longitude != 0 ? dto.longitude : '-'}</strong>
			</div>
		</div>
	</div>

	<div class="formActions articleActions">
		<button type="button" class="btn btnCancel"
			onclick="location.href='${pageContext.request.contextPath}/admin/stadium/list?page=${empty param.page ? 1 : param.page}';">
			목록
		</button>

		<button type="button" class="btn btnSubmit"
			onclick="location.href='${pageContext.request.contextPath}/admin/stadium/update?stadiumId=${dto.stadiumId}&page=${empty param.page ? 1 : param.page}';">
			수정
		</button>
	</div>

</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
