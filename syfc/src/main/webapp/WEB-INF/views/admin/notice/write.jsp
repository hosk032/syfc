<%@ page language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
	uri="jakarta.tags.core"%>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin/notice.css">

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="noticeContainer">

	<div class="noticeHeader">

		<h2 class="noticeTitle">

			<c:choose>

				<c:when test="${mode == 'update'}">
					공지사항 수정
				</c:when>

				<c:otherwise>
					공지사항 등록
				</c:otherwise>

			</c:choose>

		</h2>

	</div>

	<form class="noticeWriteForm"
		action="${pageContext.request.contextPath}/admin/notice/${mode == 'update' ? 'update' : 'write'}"
		method="post">

		<c:if test="${mode == 'update'}">

			<input type="hidden"
				name="num"
				value="${dto.num}">

			<input type="hidden"
				name="page"
				value="${page}">

		</c:if>

		<div class="formGroup">

			<label class="formLabel"
				for="subject">
				제목
			</label>

			<div class="formInputWrap">

				<input type="text"
					id="subject"
					name="subject"
					class="formControl"
					value="${dto.subject}"
					required>

			</div>

		</div>

		<div class="formGroup">

			<label class="formLabel"
				for="type">
				공지 여부
			</label>

			<div class="formInputWrap">

				<input type="checkbox"
					id="type"
					name="type"
					value="1"
					<c:if test="${mode == 'update' && dto.type == 1}">checked</c:if>>

				<label for="type">
					공지로 등록
				</label>

			</div>

		</div>

		<div class="formGroup alignTop">

			<label class="formLabel"
				for="content">
				내용
			</label>

			<div class="formInputWrap">

				<textarea
					id="content"
					name="content"
					class="formControl contentArea"
					required>${dto.content}</textarea>

			</div>

		</div>

		<div class="formActions">

			<button type="button"
				class="btn btnCancel"
				onclick="history.back();">
				취소
			</button>

			<button type="submit"
				class="btn btnSubmit">

				<c:choose>

					<c:when test="${mode == 'update'}">
						수정 완료
					</c:when>

					<c:otherwise>
						등록
					</c:otherwise>

				</c:choose>

			</button>

		</div>

	</form>

</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />