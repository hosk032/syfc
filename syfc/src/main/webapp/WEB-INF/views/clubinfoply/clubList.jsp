<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"  %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>쌍용축구예약 - 구단 목록</title>
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/clubinfoply/clubList.css" />
</head>
<body>

	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<div class="club-container my-4">
		<section class="club-content-area">
			<div class="club-top d-flex justify-content-between align-items-center">
				<h3>구단 목록</h3>
				<span class="text-muted fs-6">총 ${dataCount}개 구단</span>
			</div>

			<div class="club-list-group">
				<c:choose>
					<c:when test="${not empty list}">
						<c:forEach var="dto" items="${list}" varStatus="status">
							<a href="${clubInfoUrl}&clubowner_key=${dto.clubowner_key}" class="club-item-card">
								<!-- 구단 로고 불러오기 -->
						        <div class="club-logo-wrapper">
						            <c:choose>
						                <%-- DB에 저장된 club_logo 파일명이 존재하는 경우 --%>
						                <c:when test="${not empty dto.club_logo}">
									        <img src="${pageContext.request.contextPath}/uploads/club/${dto.club_logo}" 
									             onerror="this.outerHTML='<span class=\'club-default-logo\'>⚽</span>';" 
									             alt="${dto.club_name}">
									    </c:when>
						                <%-- DB에 club_logo가 null이거나 비어있을 경우 기본 이미지 출력 --%>
						                <c:otherwise>
										    <span class="club-default-logo">⚽</span>
										</c:otherwise>
									</c:choose>
						        </div>
								<!-- 구단 이름 & 소개 -->
								<div class="club-info-wrapper">
									<div class="club-name"><c:out value="${dto.club_name}"/></div>
									<div class="club-intro-summary">
										<span><c:out value="${dto.club_region}"/></span>
										<span class="dot">•</span>
										<span><c:out value="${dto.club_content}"/></span>
									</div>
								</div>
							</a>
						</c:forEach>
					</c:when>

					<c:otherwise>
						<div class="text-center py-5 text-muted">
							등록된 구단이 없습니다.
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			
			<div class="row board-list-footer">
				<div class="col">
					<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/clubinfoply/clubList';" title="새로고침"><i class="bi bi-arrow-counterclockwise"></i></button>
				</div>
				<div class="col-6 d-flex justify-content-center">
					<form class="row" name="searchForm">
						<div class="col-auto p-1">
							<select name="schType" class="form-select">
								<option value="all" ${schType=="all"?"selected":""}>구단명+지역</option>
								<option value="club_name" ${schType=="club_name"?"selected":""}>구단명</option>
								<option value="club_region" ${schType=="club_region"?"selected":""}>지역</option>
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
				
				<!-- 위치 잡기위하여 삭제안하고 냅둔 클레스 -->
				<div class="col text-end">
					<button type="button" class="btn btn-light" style="display: none;" onclick="location.href='${pageContext.request.contextPath}/';">글올리기</button>
				</div>
			</div>
			
			<!-- 페이징 -->
			<div class="club-list-footer my-3">
				${dataCount == 0 ? "" : paging}
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
	
	let url = '${pageContext.request.contextPath}/clubinfoply/clubList';
	location.href = url + '?' + params;
}
</script>



	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

</body>
</html>