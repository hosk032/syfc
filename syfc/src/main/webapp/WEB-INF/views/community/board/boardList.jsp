<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>쌍용축구예약 - 커뮤니티 게시판</title>

	<!-- 1. 공통 CSS/CDN/폰트 리소스 조립 -->
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

	<!-- 2. 게시판 목록 전용 CSS 연결 (dist/css/community/boardList.css) -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/community/boardList.css" />
</head>
<body>

	<!-- 상단 헤더/네비게이션 조립 -->
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<div class="board-container my-4">
		<!-- 왼쪽 서브 메뉴 (사이드바) -->
		<aside class="community-side-menu">
			<div class="side-menu-title">커뮤니티</div>
			<a href="${pageContext.request.contextPath}/community/notify/noticeList">공지사항</a> 
			<a href="${pageContext.request.contextPath}/community/board/boardList" class="active">자유 게시판</a> 
			<a href="${pageContext.request.contextPath}/community/qna/qnaList">문의/신고 게시판</a>
		</aside>

		<!-- 오른쪽 목록 본문 영역 -->
		<section class="board-list-area">
			<div class="board-top">
				<h3>자유 게시판</h3>
			</div>

	<table class="table table-hover board-list">
	    <thead class="table-light">
	        <tr>
	            <th width="70">번호</th>
	            <th>제목</th>
	            <th width="100">작성자</th>
	            <th width="120">작성일</th>
	            <th width="70">조회수</th>
	        </tr>
	    </thead>
	
	    <tbody>
	        <c:forEach var="dto" items="${list}" varStatus="status">
	            <tr>
	                <td>${dataCount - (page - 1) * size - status.index}</td>
	                <td class="left">
	                    <div class="text-wrap">
	                        <a href="${noticeDetailUrl}&bnum=${dto.bnum}" class="text-reset"> <c:out value="${dto.b_subject}"/><c:if test="${dto.replyCount > 0}">(${dto.replyCount})</c:if></a>
	                    </div>
	                </td>
	                <td> ${dto.userName}</td>
	                <td>${dto.b_reg_date}</td>
	                <td>${dto.b_hitCount}</td>
	            </tr>
	        </c:forEach>
	    </tbody>
	</table>
			
			<div class="row board-list-footer">
				<div class="col">
					<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/community/board/boardList';" title="새로고침"><i class="bi bi-arrow-counterclockwise"></i></button>
				</div>
				<div class="col-6 d-flex justify-content-center">
					<form class="row" name="searchForm">
						<div class="col-auto p-1">
							<select name="schType" class="form-select">
								<option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
								<option value="userName" ${schType=="userName"?"selected":""}>작성자</option>
								<option value="b_subject" ${schType=="b_subject"?"selected":""}>제목</option>
								<option value="b_content" ${schType=="b_content"?"selected":""}>내용</option>
							</select>
						</div>
						<div class="col-auto p-1">
							<input type="text" name="kwd" value="${kwd}" class="form-control">
						</div>
						<div class="col-auto p-1">
							<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
						</div>
					</form>
				</div>
				
				<div class="col text-end">
					<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/community/board/write';">글올리기</button>
				</div>
			</div>
			<div class="board-number">
				${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
			</div>
		</section>
	</div>

<script type="text/javascript">
// 검색 키워드 입력란에서 엔터를 누른 경우 서버 전송 막기 
document.addEventListener('DOMContentLoaded', () => {
	const inputEL = document.querySelector('form input[name=kwd]'); 
	inputEL.addEventListener('keydown', function (evt) {
		if(evt.key === 'Enter') {
			evt.preventDefault();
	    	
			searchList();
		}
	});
});

function searchList() {
	const f = document.searchForm;
	if(! f.kwd.value.trim()) {
		return;
	}
	
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	let url = '${pageContext.request.contextPath}/community/board/boardList';
	location.href = url + '?' + params;
}
</script>


	<!-- 하단 푸터 조립 -->
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

	<!-- 3. 게시판 목록 전용 JS 연결 (dist/js/community/boardList.js) -->
	<!-- 
	<script src="${pageContext.request.contextPath}/dist/js/community/boardList.js"></script>
	 -->
</body>
</html>