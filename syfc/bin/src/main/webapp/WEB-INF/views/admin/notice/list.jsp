<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin/notice.css">

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="noticeContainer">

	<div class="noticeHeader">
		<h2 class="noticeTitle">공지사항 관리</h2>
		<p class="noticeDesc">
			게시글을 등록하고 공지 여부를 관리할 수 있습니다.
		</p>
	</div>

	<div class="tableWrap">

		<table class="noticeTable">

			<!-- 열 너비를 여기서 아예 고정 -->
			<colgroup>
				<col style="width: 8%;">
				<col style="width: 46%;">
				<col style="width: 12%;">
				<col style="width: 14%;">
				<col style="width: 8%;">
				<col style="width: 12%;">
			</colgroup>

			<thead>

				<tr>
					<th>번호</th>
					<th class="subjectHead">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>관리</th>
				</tr>

			</thead>

			<tbody>

				<!-- =============================
				     공지글
				     ============================= -->
				<c:forEach var="dto" items="${listNotice}">

					<tr>

						<td class="cellCenter">
							<span class="noticeBadge">공지</span>
						</td>

						<td class="subject">
							<a href="${pageContext.request.contextPath}/admin/notice/article?num=${dto.num}&page=${page}">
								${dto.subject}
							</a>
						</td>

						<td class="cellCenter">
							${dto.userName}
						</td>

						<td class="cellCenter">
							${dto.regDate}
						</td>

						<td class="cellCenter">
							${dto.hitCount}
						</td>

						<td class="cellCenter">

							<button type="button"
								class="btnSmall btnUpdate"
								onclick="location.href='${pageContext.request.contextPath}/admin/notice/update?num=${dto.num}&page=${page}'">
								수정
							</button>

							<button type="button"
								class="btnSmall btnDelete"
								onclick="deleteNotice(${dto.num});">
								삭제
							</button>

						</td>

					</tr>

				</c:forEach>

				<!-- =============================
				     일반글
				     ============================= -->
				<c:forEach var="dto"
					items="${list}"
					varStatus="status">

					<tr>

						<!-- 화면용 번호 -->
						<td class="cellCenter">
							${dataCount - (page - 1) * 10 - status.index}
						</td>

						<td class="subject">

							<a href="${pageContext.request.contextPath}/admin/notice/article?num=${dto.num}&page=${page}">
								${dto.subject}
							</a>

						</td>

						<td class="cellCenter">
							${dto.userName}
						</td>

						<td class="cellCenter">
							${dto.regDate}
						</td>

						<td class="cellCenter">
							${dto.hitCount}
						</td>

						<td class="cellCenter">

							<button type="button"
								class="btnSmall btnUpdate"
								onclick="location.href='${pageContext.request.contextPath}/admin/notice/update?num=${dto.num}&page=${page}'">
								수정
							</button>

							<button type="button"
								class="btnSmall btnDelete"
								onclick="deleteNotice(${dto.num});">
								삭제
							</button>

						</td>

					</tr>

				</c:forEach>

				<c:if test="${empty listNotice and empty list}">

					<tr>
						<td colspan="6" class="cellCenter">
							등록된 게시글이 없습니다.
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

	<!-- 강사님 방식 : 왼쪽 새로고침 / 가운데 검색 / 오른쪽 글올리기 -->
	<div class="listFooterArea">

		<div class="footerLeft">
			<button type="button"
				class="btnRefresh"
				onclick="location.href='${pageContext.request.contextPath}/admin/notice/list';"
				title="새로고침">
				↻
			</button>
		</div>

		<div class="footerCenter">
			<form class="searchArea"
				action="${pageContext.request.contextPath}/admin/notice/list"
				method="get">

				<select name="schType" class="searchSelect">
					<option value="all" ${schType == 'all' ? 'selected' : ''}>제목 + 내용</option>
					<option value="subject" ${schType == 'subject' ? 'selected' : ''}>제목</option>
					<option value="content" ${schType == 'content' ? 'selected' : ''}>내용</option>
				</select>

				<input type="text"
					name="kwd"
					value="${kwd}"
					class="searchInput"
					placeholder="검색어를 입력하세요">

				<button type="submit" class="btnSearch">
					검색
				</button>
			</form>
		</div>

		<div class="footerRight">
			<button type="button"
				class="btnWrite"
				onclick="location.href='${pageContext.request.contextPath}/admin/notice/write'">
				게시글 등록
			</button>
		</div>

	</div>

</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

<script>
	function deleteNotice(num) {

		if (!confirm('게시글을 삭제하시겠습니까?')) {
			return;
		}

		location.href =
			'${pageContext.request.contextPath}/admin/notice/delete?num=' + num;
	}
</script>