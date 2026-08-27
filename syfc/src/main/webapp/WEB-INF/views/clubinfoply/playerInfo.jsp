<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>쌍용축구예약 - 선수 정보</title>
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/clubinfoply/playerInfo.css" />
</head>
<body>

	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<div class="club-container my-5 play-container">
		<section class="club-content-area">
			
			<c:choose>
   					<c:when test="${hasClub}">
					<div class="club-top d-flex justify-content-between align-items-end mb-3">
						<h3>선수단 정보</h3>
						<span class="text-muted fs-6">총 <strong>${list.size()}</strong>명 등록</span>
					</div>

					<article class="section-block">
						<div class="position-summary-grid">
							<div class="summary-card fw-bold">
								<span class="pos-badge pos-fw">FW</span>
								<span class="count">${fwCount}명</span>
							</div>
							<div class="summary-card fw-bold">
								<span class="pos-badge pos-mf">MF</span>
								<span class="count">${mfCount}명</span>
							</div>
							<div class="summary-card fw-bold">
								<span class="pos-badge pos-df">DF</span>
								<span class="count">${dfCount}명</span>
							</div>
							<div class="summary-card fw-bold">
								<span class="pos-badge pos-gk">GK</span>
								<span class="count">${gkCount}명</span>
							</div>
						</div>
					</article>
					<article class="section-block mt-4">
				    <h4 class="section-title mb-3">소속 선수 상세 목록</h4>
				    <c:choose>
				        <%-- 선수가 있는 경우 --%>
				        <c:when test="${not empty list}">
				            <div class="player-table-responsive">
				                <table class="table table-hover player-table align-middle">
				                    <thead>
				                        <tr>
				                            <th width="120">프로필</th>
				                            <th width="70">등번호</th>
				                            <th>선수명</th>
				                            <th width="70">포지션</th>
				                            <th width="70">키</th>
				                            <th width="70">몸무게</th>
				                            <th width="130">생년월일</th>
				                            <th width="70">득점</th>
				                            <th width="70">도움</th>
				                            <th width="80">옐로카드</th>
				                            <th width="80">레드카드</th>
				                            <th width="70">상태</th>
				                        </tr>
				                    </thead>
				                    <tbody>
				                        <c:forEach var="dto" items="${list}">
				                            <tr>
				                            	<td>
				                                    <c:choose>
				                                        <c:when test="${not empty dto.profile_photo}">
				                                            <img
				                                                src="${pageContext.request.contextPath}/uploads/member/${dto.profile_photo}"
				                                                class="player-img"
				                                                alt="프로필"
				                                                onerror="this.hidden=true; this.nextElementSibling.hidden=false;">
															<span class="club-default-logo" hidden>
																<i class="fa-solid fa-user"></i>
															</span>
				                                        </c:when>
				
				                                        <c:otherwise>
				                                            <span class="club-default-logo">
				                                                <i class="fa-solid fa-user"></i>
				                                            </span>
				                                        </c:otherwise>
				                                    </c:choose>
				                                </td>
				                                <td class="player-backno">
				                                    ${dto.uniform_no != null ? dto.uniform_no : '-'}
				                                </td>
				                                <td class="fw-bold text-start ps-3">
				                                    <c:out value="${dto.userName}"/>
				                                </td>
				                                <td>
				                                    <c:choose>
				                                        <c:when test="${dto.position == 'FW'}">
				                                            <span class="pos-badge pos-fw">FW</span>
				                                        </c:when>
				
				                                        <c:when test="${dto.position == 'MF'}">
				                                            <span class="pos-badge pos-mf">MF</span>
				                                        </c:when>
				
				                                        <c:when test="${dto.position == 'DF'}">
				                                            <span class="pos-badge pos-df">DF</span>
				                                        </c:when>
				
				                                        <c:when test="${dto.position == 'GK'}">
				                                            <span class="pos-badge pos-gk">GK</span>
				                                        </c:when>
				
				                                        <c:otherwise>
				                                            <span class="pos-badge pos-etc">
				                                                ${dto.position}
				                                            </span>
				                                        </c:otherwise>
				                                    </c:choose>
				                                </td>
				
				                                <td class="player-stat">
				                                    ${dto.height != null ? dto.height : '-'} cm
				                                </td>
				
				                                <td class="player-stat">
				                                    ${dto.weight != null ? dto.weight : '-'} kg
				                                </td>
				
				                                <td class="text-secondary">
				                                    ${dto.birth != null ? dto.birth : '-'}
				                                </td>
				
				                                <td>${dto.goal}</td>
				                                <td>${dto.assist}</td>
				                                <td>${dto.yellow}</td>
				                                <td>${dto.red}</td>
				
				                                <td>
				                                    <c:choose>
				
				                                        <c:when test="${dto.status == 0}">
				                                            <span class="status-pill status-injured">
				                                                탈퇴
				                                            </span>
				                                        </c:when>
				
				                                        <c:when test="${dto.status == 1}">
				                                            <span class="status-pill status-active">
				                                                활동
				                                            </span>
				                                        </c:when>
				                                        <c:otherwise>
				                                            <span class="status-pill status-inactive">
				                                                제적
				                                            </span>
				                                        </c:otherwise>
				                                    </c:choose>
				                                </td>
				                            </tr>
				                        </c:forEach>
				                    </tbody>
				                </table>
				            </div>
				        </c:when>
				
				        <%-- 구단은 있지만 선수가 없는 경우 --%>
				        <c:otherwise>
				            <div class="text-center py-5 px-3 bg-white rounded-4 border">
				                <div class="mb-3">
				                    <i class="fa-solid fa-users text-secondary opacity-50"
				                       style="font-size: 4.5rem;"></i>
				                </div>
				                <h4 class="fw-bold text-dark mb-2">
				                    소속 선수들이 없습니다
				                </h4>
				                <p class="text-muted mb-0">
				                    현재 등록된 소속 선수가 없습니다.
				                </p>
				            </div>
				        </c:otherwise>
				    </c:choose>
				
				    <div class="d-flex justify-content-end mt-3">
				        <button type="button"
				                class="btn btn-outline-secondary"
				                onclick="history.back();">
				            이전으로
				        </button>
				    </div>
				
				</article>
				</c:when>

				<c:otherwise>
					<div class="text-center py-5 px-3 my-4 bg-white rounded-4 shadow-sm border">
						<div class="mb-3">
							<i class="fa-solid fa-shield-halved text-secondary opacity-50" style="font-size: 4.5rem;"></i>
						</div>
						<h3 class="fw-bold text-dark mb-2">소속된 구단이 없습니다</h3>
						<p class="text-muted fs-6 mb-4">
							현재 참여 중인 구단이 없어서 선수 목록을 조회할 수 없습니다.<br>
							쌍용축구예약의 다양한 구단을 둘러보고 마음에 드는 팀에 가입해 보세요!
						</p>
						<div class="d-flex justify-content-center gap-2">
							<a href="${pageContext.request.contextPath}/clubinfoply/clubList" class="btn btn-primary btn-lg fs-6 px-4">
								<i class="fa-solid fa-magnifying-glass me-1"></i> 구단 둘러보기
							</a>
							<button type="button" class="btn btn-outline-secondary btn-lg fs-6 px-4" onclick="history.back();">
								이전으로
							</button>
						</div>
					</div>
				</c:otherwise>
			</c:choose>

		</section>
	</div>

	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

</body>
</html>