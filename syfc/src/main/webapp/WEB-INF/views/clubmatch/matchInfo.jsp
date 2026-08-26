<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"  %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>쌍용축구예약 - 경기 일정 및 결과</title>
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/clubmatch/matchInfo.css" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="board-container my-4">
	<section class="board-list-area">

		<div class="match-table-responsive">
			<div class="board-top mb-3">
				<h3>경기 일정 / 결과</h3>
			</div>
			<table class="match-table">
				<thead>
					<tr>
						<th width="140">경기장</th>
						<th width="140">승무패</th>
						<th >구단</th>
						<th width="140">승무패</th>
						<th width="140">일정</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty matchList}">
							<c:forEach var="dto" items="${matchList}">
								<tr>
									<!-- 경기장 -->
									<td class="col-stadium text-center">
										<c:out value="${dto.stadiumName}"/>
									</td>
									
									<!-- 홈팀 승무패 -->
									<td class="text-center">
										<c:choose>
											<c:when test="${dto.homeScore > dto.awayScore}">
												<span class="result-badge win">승리</span>
											</c:when>
											<c:when test="${dto.homeScore == dto.awayScore}">
												<span class="result-badge draw">무승부</span>
											</c:when>
											<c:otherwise>
												<span class="result-badge lose">패배</span>
											</c:otherwise>
										</c:choose>
									</td>

									<!-- 구단 대진 (홈팀 [점수 : 점수] 원정팀) -->
									<td class="col-teams">
									    <div class="match-teams-wrap">
									        <!-- 홈팀 -->
									        <div class="team-info home">
									            <c:choose>
									                <c:when test="${not empty dto.homeClubLogo}">
									                    <img src="${pageContext.request.contextPath}/uploads/club/${dto.homeClubLogo}" 
									                         class="team-logo"
									                         alt="${dto.homeClubName}"
									                         onerror="this.onerror=null; this.style.display='none'; this.nextElementSibling.style.display='inline-block';">
									                    <span class="club-default-logo" style="display:none;">⚽</span>
									                </c:when>
									                <c:otherwise>
									                    <span class="club-default-logo">⚽</span>
									                </c:otherwise>
									            </c:choose>
									            <span class="team-name"><c:out value="${dto.homeClubName}"/></span>
									        </div>
									        
									        <!-- 스코어 -->
									        <div class="score-box">
									            <span class="score-num"><c:out value="${dto.homeScore != null ? dto.homeScore : 0}"/></span>
									            <span class="colon">:</span>
									            <span class="score-num"><c:out value="${dto.awayScore != null ? dto.awayScore : 0}"/></span>
									        </div>
									        
									        <!-- 원정팀 -->
									        <div class="team-info away">
									            <span class="team-name"><c:out value="${dto.awayClubName}"/></span>
									            <c:choose>
									                <c:when test="${not empty dto.awayClubLogo}">
									                    <img src="${pageContext.request.contextPath}/uploads/club/${dto.awayClubLogo}" 
									                         class="team-logo"
									                         alt="${dto.awayClubName}"
									                         onerror="this.onerror=null; this.style.display='none'; this.nextElementSibling.style.display='inline-block';">
									                    <span class="club-default-logo" style="display:none;">⚽</span>
									                </c:when>
									                <c:otherwise>
									                    <span class="club-default-logo">⚽</span>
									                </c:otherwise>
									            </c:choose>
									        </div>
									    </div>
									</td>
									
									<!-- 원정팀 승무패 -->
									<td class="text-center">
										<c:choose>
											<c:when test="${dto.awayScore > dto.homeScore}">
												<span class="result-badge win">승리</span>
											</c:when>
											<c:when test="${dto.awayScore == dto.homeScore}">
												<span class="result-badge draw">무승부</span>
											</c:when>
											<c:otherwise>
												<span class="result-badge lose">패배</span>
											</c:otherwise>
										</c:choose>
									</td>
									
									<!-- 경기 일정 -->
									<td class="col-schedule text-center">
										<c:out value="${dto.matchDate}"/>
									</td>
								</tr>
							</c:forEach>
						</c:when>
					</c:choose>
				</tbody>
			</table>
			
			<div class="row align-items-center gx-2 mx-0 w-100">
				<!-- 왼쪽 새로고침 버튼 -->
				<div class="col-auto p-0">
					<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/clubmatch/matchInfo';" title="새로고침">
						<i class="bi bi-arrow-counterclockwise"></i>
					</button>
				</div>
			
				<!-- 가운데 검색 폼 -->
				<div class="col d-flex justify-content-center px-0">
					<form class="row g-1 m-0 align-items-center" name="searchForm">
						<div class="col-auto">
							<select name="schType" class="form-select">
								<option value="club_name" ${schType=="club_name"?"selected":""}>구단명</option>
								<option value="match_date" ${schType=="match_date"?"selected":""}>경기일정</option>
							</select>
						</div>
						<div class="col-auto">
							<input type="text" name="kwd" value="${kwd}" class="form-control" placeholder="검색어 입력">
						</div>
						<div class="col-auto">
							<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
						</div>
					</form>
				</div>
			
				<!-- 중앙 밸런스용 투명 영역 -->
				<div class="col-auto p-0" style="visibility: hidden;" aria-hidden="true">
					<button type="button" class="btn btn-light"><i class="bi bi-arrow-counterclockwise"></i></button>
				</div>
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
	
	let url = '${pageContext.request.contextPath}/clubmatch/matchInfo';
	location.href = url + '?' + params;
}
</script>


	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

</body>
</html>