<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"  %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>쌍용축구예약 - 구단 정보</title>

	<!-- 1. 공통 CSS/CDN/폰트 리소스 조립 -->
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

	<!-- 2. 구단 정보 전용 CSS 연결 -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/clubinfoply/clubInfo.css" />
</head>
<body>

	<!-- 상단 헤더/네비게이션 조립 -->
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<div class="club-container my-4">
	
		<section class="club-content-area">
			<div class="club-top">
				<h3>${dto.club_name} 구단 정보</h3>
			</div>

			<article id="history-section" class="section-block">
                <h4 class="section-title">구단 역사</h4>
                <div class="history-timeline">
                    <c:choose>
                        <c:when test="${not empty historyList}">
                            <c:forEach var="history" items="${historyList}">
                            	<div class="timeline-item">
                                    <span class="timeline-year">${history.year} :</span>
                                    <span><c:out value="${history.content}"/></span>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="text-muted">등록된 구단 역사가 없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </article>

			<article id="intro-section" class="section-block">
				<h4 class="section-title">구단 소개</h4>
				<div class="info-card">
					<p><c:out value="${dto.club_content}"/></p>
				</div>
			</article>

			<!-- 3. 구단주 -->
			<article id="owner-section" class="section-block">
				<h4 class="section-title">구단주</h4>
				<div class="info-card">
					<p><strong>구단명:</strong> <c:out value="${dto.club_name}"/></p>
				</div>
			</article>

			<!-- 4. 선수 명단 -->
			<article id="player-section" class="section-block">
				<h4 class="section-title">선수 명단</h4>
				<div class="player-table-responsive">
					<table class="table table-hover player-table align-middle">
						<thead class="table-light">
							<tr>
								<th width="60">번호</th>
								<th width="80">사진</th>
								<th>이름</th>
								<th width="80">위치</th>
								<th width="120">경기기록</th>
								<th width="60">번호</th>
								<th width="80">사진</th>
								<th>이름</th>
								<th width="80">위치</th>
								<th width="120">경기기록</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty playerList}">
									<!-- 2개씩 짝지어서 반복문 처리 -->
									<c:forEach var="player" items="${playerList}" varStatus="status">
										<c:if test="${status.index % 2 == 0}">
										</c:if>
										
										<td>${player.clubjoin_num}</td>
										<td>
                                            <c:choose>
												<c:when test="${not empty player.club_logo}">
													<img src="${pageContext.request.contextPath}/uploads/club/${player.club_logo}" class="player-img"
														onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/dist/images/default-profile.png';" 
														alt="${player.userName}">
												</c:when>
			
												<c:otherwise>
													<img src="${pageContext.request.contextPath}/dist/images/default-profile.png" class="player-img" 
														onerror="this.onerror=null; this.outerHTML='<span class=\'player-default-icon\'>👤</span>';"
														alt="${player.userName}">
												</c:otherwise>
											</c:choose>
										</td>
										<td><c:out value="${player.userName}"/></td>
										<td>${player.position}</td>
										<td class="player-stat">
											상장: 0 <br>축가: 0
										</td>

										<c:if test="${status.index % 2 == 1 || status.last}">
											<c:if test="${status.last && status.index % 2 == 0}">
												<td colspan="5"></td> <!-- 홀수 개일 때 마지막 빈 칸 채움 -->
											</c:if>
											</tr>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
                                        <td colspan="10" class="text-center py-5 text-muted"> 등록된 선수가 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<div class="data-update-date">
					데이터 업데이트 날짜: <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd" />
				</div>
			</article>
		</section>
	</div>

	<!-- 하단 푸터 조립 -->
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

	<!-- 사이드바 메뉴 클릭 시 active 상태 전환 스크립트 -->
	<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', () => {
		const menuItems = document.querySelectorAll('.club-side-menu a');
		menuItems.forEach(item => {
			item.addEventListener('click', function() {
				menuItems.forEach(i => i.classList.remove('active'));
				this.classList.add('active');
			});
		});
	});
	</script>
</body>
</html>