<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"  %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>쌍용축구예약 - 선수 목록</title>
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/clubinfoply/playerList.css" />
</head>
<body>

	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

		<div class="club-container my-4">
			<section class="club-content-area">
				<div class="club-top d-flex justify-content-between align-items-center">
					<h3>선수 목록</h3>
					<span class="text-muted fs-6">총 ${dataCount}명 선수</span>
				</div>
	
				<div class="player-list-group">
					<c:choose>
						<c:when test="${not empty list}">
							<c:forEach var="dto" items="${list}">
								<div class="player-item-card">
									<div class="player-backno-wrapper">
										<span class="player-backno-badge">
											No. <c:out value="${dto.uniform_no != null ? dto.uniform_no : '-'}"/>
										</span>
									</div>
				
									<div class="player-info-wrapper">
										<div class="player-header">
											<span class="player-name"><c:out value="${dto.userName}"/></span>
											<span class="player-club-tag"><c:out value="${dto.club_name}"/></span>
										</div>
										<div class="player-details">
											<span>키: <strong>${dto.height != null ? dto.height : '-'}</strong> cm</span>
											<span class="dot">•</span>
											<span>몸무게: <strong>${dto.weight != null ? dto.weight : '-'}</strong> kg</span>
											<span class="dot">•</span>
											<span>생년월일: <strong><c:out value="${dto.birth != null ? dto.birth : '-'}"/></strong></span>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:when>
				
						<c:otherwise>
							<%-- 디자인 확인용 샘플 데이터 1건 --%>
							<div class="player-item-card">
								<div class="player-backno-wrapper">
									<span class="player-backno-badge">
										No. 7
									</span>
								</div>
				
								<div class="player-info-wrapper">
									<div class="player-header">
										<span class="player-name">손흥민</span>
										<span class="player-club-tag">쌍용 FC</span>
									</div>
									<div class="player-details">
										<span>키: <strong>183</strong> cm</span>
										<span class="dot">•</span>
										<span>몸무게: <strong>78</strong> kg</span>
										<span class="dot">•</span>
										<span>생년월일: <strong>1992-07-08</strong></span>
									</div>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</div>

<%-- 샘플 데이터 지울때 주석 제거할것
						<c:otherwise>
							<div class="text-center py-5 text-muted bg-white rounded-3 border">
								등록된 선수 정보가 없습니다.
							</div>
						</c:otherwise>
					</c:choose>
				</div>
--%>

			
			<div class="row board-list-footer">
				<div class="col">
					<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/clubinfoply/playerList';" title="새로고침">
						<i class="bi bi-arrow-counterclockwise"></i>
					</button>
				</div>
				<div class="col-6 d-flex justify-content-center">
					<form class="row" name="searchForm">
						<div class="col-auto p-1">
							<select name="schType" class="form-select">
								<option value="all" ${schType=="all"?"selected":""}>선수명+구단명</option>
								<option value="userName" ${schType=="userName"?"selected":""}>선수명</option>
								<option value="club_name" ${schType=="club_name"?"selected":""}>구단명</option>
							</select>
						</div>
						<div class="col-auto p-1">
							<input type="text" name="kwd" value="${kwd}" class="form-control" placeholder="검색어 입력">
						</div>
						<div class="col-auto p-1">
							<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
						</div>
					</form>
				</div>
				
				<div class="col text-end"></div>
			</div>
			
			<!-- 페이징 -->
			<div class="club-list-footer my-3">
				${dataCount == 0 ? "" : paging}
			</div>
		</section>
	</div>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', () => {
	const inputEL = document.querySelector('form input[name=kwd]'); 
	if(inputEL) {
		inputEL.addEventListener('keydown', function (evt) {
			if(evt.key === 'Enter') {
				evt.preventDefault();
				searchList();
			}
		});
	}
});

function searchList() {
	const f = document.searchForm;
	if(! f.kwd.value.trim()) {
		return;
	}
	
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	let url = '${pageContext.request.contextPath}/clubinfoply/playerList';
	location.href = url + '?' + params;
}
</script>

	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

</body>
</html>