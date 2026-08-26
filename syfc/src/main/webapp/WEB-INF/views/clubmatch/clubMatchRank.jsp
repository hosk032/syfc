<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"  %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>쌍용축구예약 - 구단 경기기록</title>
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
	<!-- 통일된 파일명의 CSS 연결 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/clubmatch/clubMatchRank.css" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="board-container my-4">
	<section class="board-list-area">
		<div class="match-table-responsive">
			<div class="board-top mb-3">
				<h3>구단 경기기록</h3>
			</div>
			
			<table class="match-table text-center">
				<thead>
					<tr>
						<th>구단명</th>
						<th width="70">경기</th>
						<th width="60">승</th>
						<th width="60">무</th>
						<th width="60">패</th>
						<th width="70">득점</th>
						<th width="70">실점</th>
						<th width="70">득실</th>
						<th width="130">최근 3경기</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${not empty rankList}">
							<c:forEach var="dto" items="${rankList}" varStatus="status">
								<tr>
									<!-- DTO의 club_logo, club_name 필드에 맞게 출력 -->
									<td class="text-start ps-3">
										<div class="d-flex align-items-center gap-2">
											<c:choose>
											    <c:when test="${not empty dto.club_logo}">
											        <img src="${pageContext.request.contextPath}/uploads/club/${dto.club_logo}" 
											             class="team-logo"
											             onerror="this.outerHTML='<span class=\'club-default-logo\'>⚽</span>';" 
											             alt="${dto.club_name}">
											    </c:when>
											    <c:otherwise>
											        <span class="club-default-logo">⚽</span>
											    </c:otherwise>
											</c:choose>
											<span class="fw-bold"><c:out value="${dto.club_name}"/></span>
										</div>
									</td>
									
									<!-- 경기 수 -->
									<td><c:out value="${dto.totalGames}"/></td>
									
									<!-- 승 / 무 / 패 -->
									<td class="text-success fw-bold"><c:out value="${dto.winCount}"/></td>
									<td class="text-secondary"><c:out value="${dto.drawCount}"/></td>
									<td class="text-danger"><c:out value="${dto.loseCount}"/></td>
									
									<!-- 득점 / 실점 / 득실차 -->
									<td><c:out value="${dto.goalsFor}"/></td>
									<td><c:out value="${dto.goalsAgainst}"/></td>
									<td class="fw-bold"><c:out value="${dto.goalDifference}"/></td>
									
									<!-- 최근 3경기 -->
									<td>
										<div class="recent-matches">
											<c:forEach var="res" items="${dto.recentResults}">
												<c:choose>
													<c:when test="${res == '승' || res == 'W'}">
														<span class="recent-badge win" title="승리">승</span>
													</c:when>
													<c:when test="${res == '무' || res == 'D'}">
														<span class="recent-badge draw" title="무승부">무</span>
													</c:when>
													<c:otherwise>
														<span class="recent-badge lose" title="패배">패</span>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</div>
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="9" class="text-center py-4">등록된 경기 기록이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			
			<div class="row align-items-center gx-2 mx-0 w-100">
				<!-- 왼쪽 새로고침 버튼 -->
				<div class="col-auto p-0">
					<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/clubmatch/clubMatchRank';" title="새로고침">
						<i class="bi bi-arrow-counterclockwise"></i>
					</button>
				</div>
			
				<!-- 가운데 검색 폼 -->
				<div class="col d-flex justify-content-center px-0">
					<form class="row g-1 m-0 align-items-center" name="searchForm">
						<div class="col-auto">
							<select name="schType" class="form-select">
								<option value="club_name" ${schType=="club_name"?"selected":""}>구단명</option>
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
	
	let url = '${pageContext.request.contextPath}/clubmatch/clubMatchRank';
	location.href = url + '?' + params;
}
</script>


	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

</body>
</html>