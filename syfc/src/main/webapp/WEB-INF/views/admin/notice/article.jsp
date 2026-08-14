<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="ko">

<head>
	<title>공지사항 상세보기</title>

	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/dist/css/admin/notice.css">
</head>

<body>

	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<div class="noticeContainer">

		<div class="noticeHeader">
			<h2 class="noticeTitle">공지사항 상세보기</h2>
		</div>

		<div class="articleBox">

			<div class="articleSubject">
				${dto.subject}
			</div>

			<div class="articleInfo">
				<span>작성자 : ${dto.userName}</span>
				<span>작성일 : ${dto.regDate}</span>
				<span>조회수 : ${dto.hitCount}</span>
			</div>

			<div class="articleContent">
				${dto.content}
			</div>

			<!-- 강사님 예제처럼 이전글 / 다음글 -->
			<div class="articlePrevNext">

				<div class="prevNextRow">
					<span class="prevNextLabel">이전글</span>

					<c:choose>
						<c:when test="${not empty prevDto}">
							<a href="${pageContext.request.contextPath}/admin/notice/article?num=${prevDto.num}&page=${page}">
								${prevDto.subject}
							</a>
						</c:when>

						<c:otherwise>
							<span class="noPost">이전글이 없습니다.</span>
						</c:otherwise>
					</c:choose>
				</div>

				<div class="prevNextRow">
					<span class="prevNextLabel">다음글</span>

					<c:choose>
						<c:when test="${not empty nextDto}">
							<a href="${pageContext.request.contextPath}/admin/notice/article?num=${nextDto.num}&page=${page}">
								${nextDto.subject}
							</a>
						</c:when>

						<c:otherwise>
							<span class="noPost">다음글이 없습니다.</span>
						</c:otherwise>
					</c:choose>
				</div>

			</div>

		</div>

		<div class="formActions">

			<button type="button"
				class="btn btnCancel"
				onclick="location.href='${pageContext.request.contextPath}/admin/notice/list?page=${page}'">
				목록
			</button>

			<button type="button"
				class="btn btnSubmit"
				onclick="location.href='${pageContext.request.contextPath}/admin/notice/update?num=${dto.num}&page=${page}'">
				수정
			</button>

			<button type="button"
				class="btn btnDanger"
				onclick="deleteNotice(${dto.num});">
				삭제
			</button>

		</div>

	</div>

	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

	<script>
		function deleteNotice(num) {
			if (! confirm('공지사항을 삭제하시겠습니까?')) {
				return;
			}

			location.href =
				'${pageContext.request.contextPath}/admin/notice/delete?num=' + num;
		}
	</script>

</body>
</html>
