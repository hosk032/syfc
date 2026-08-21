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
						<th width="150">경기장</th>
						<th width="150">승무패</th>
						<th >구단</th>
						<th width="150">승무패</th>
						<th width="150">일정</th>
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
												<c:if test="${not empty dto.homeClubLogo}">
													<img src="${pageContext.request.contextPath}/uploads/club/${dto.homeClubLogo}" class="team-logo" alt="logo">
												</c:if>
												<span class="team-name"><c:out value="${dto.homeClubName}"/></span>
											</div>
											
											<!-- 스코어 -->
											<div class="score-box">
												<span class="score-num"><c:out value="${dto.homeScore != null ? dto.homeScore : 0}"/></span>
												<span class="colon">:</span>
												<span class="score-num"><c:out value="${dto.awayScore != null ? dto.awayScore : 0}"/></span>
											</div>
											
											<!-- 원정팀 (수정완료: awayClubName, awayClubLogo 적용) -->
											<div class="team-info away">
												<span class="team-name"><c:out value="${dto.awayClubName}"/></span>
												<c:if test="${not empty dto.awayClubLogo}">
													<img src="${pageContext.request.contextPath}/uploads/club/${dto.awayClubLogo}" class="team-logo" alt="logo">
												</c:if>
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
						
						<%-- DB 연결 전 또는 데이터가 없을 때 보일 샘플 4개 --%>
						<c:otherwise>
							<!-- 샘플 1 -->
							<tr>
								<td class="col-stadium text-center">문수경기장</td>
								<td class="text-center"><span class="result-badge lose">패배</span></td>
								<td class="col-teams">
									<div class="match-teams-wrap">
										<div class="team-info home">
											<span class="team-name">울산</span>
										</div>
										<div class="score-box">
											<span class="score-num">1</span>
											<span class="colon">:</span>
											<span class="score-num">3</span>
										</div>
										<div class="team-info away">
											<span class="team-name">강원</span>
										</div>
									</div>
								</td>
								<td class="text-center"><span class="result-badge win">승리</span></td>
								<td class="col-schedule text-center">2026-02-28</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</section>
</div>

	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

</body>
</html>