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
				
					<p><strong>창단일:</strong> <c:out value="${dto.club_created}"/></p>
				</div>
			</article>

		
			<article id="intro-section" class="section-block">
				<h4 class="section-title">구단 소개</h4>
				<div class="info-card">
					<p><c:out value="${dto.club_content}"/></p>
					<p><strong>구단주:</strong> <c:out value="${ownerName}"/></p>
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
								<th width="120">번호</th>
								<th>이름</th>
								<th width="200">선호 포지션</th>
								<th width="240">선수 평점</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty playerList}">
									<c:forEach var="player" items="${playerList}">
										<tr class="player-row">
											<td>${player.clubjoin_num}</td>
											<td>${player.userName}</td>
											<td>${player.position}</td>
											<td>${player.rating}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
                                        <td colspan="4" class="text-center py-5 text-muted"> 등록된 선수가 없습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				 <div class="d-flex justify-content-end">
					<button type="button" class="btn btn-light"  onclick="location.href='${pageContext.request.contextPath}/clubinfoply/clubList?${query}';">
						리스트</button>
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