<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:forEach var="dto" items="${matchList}">
	<tr>
		<td class="text-muted">${dto.matchDate.substring(0, 10)}</td>
		<td class="fw-semibold">${dto.stadiumName}</td>
		<td>${dto.awayClubName}</td>
		<td>
			<c:choose>
				<%-- 성적이 등록된 경우 (점수가 null이 아닐 때) --%>
				<c:when test="${dto.homeScore != null && dto.awayScore != null}">
					<span class="fw-bold text-primary">${dto.homeScore} : ${dto.awayScore}</span>
					<c:choose>
						<c:when test="${dto.homeScore > dto.awayScore}">
							<span class="badge bg-primary bg-opacity-10 text-primary ms-1">승리</span>
						</c:when>
						<c:when test="${dto.homeScore < dto.awayScore}">
							<span class="badge bg-danger bg-opacity-10 text-danger ms-1">패배</span>
						</c:when>
						<c:otherwise>
							<span class="badge bg-secondary bg-opacity-10 text-secondary ms-1">무승부</span>
						</c:otherwise>
					</c:choose>
				</c:when>
				<%-- 성적이 등록되지 않은 경우 (미등록) --%>
				<c:otherwise>
					<span class="text-muted">- : -</span>
					<span class="badge bg-secondary bg-opacity-10 text-secondary border border-secondary px-2 py-1 ms-1">미등록</span>
				</c:otherwise>
			</c:choose>
		</td>
		<td>
			<button type="button" class="btn btn-xs btn-outline-secondary py-0 px-2" onclick="openMatchDetailModal('${dto.matchNum}')">
				상세
			</button>
		</td>
	</tr>
</c:forEach>

<c:if test="${empty matchList}">
	<tr class="empty-row">
		<td colspan="5" class="py-5 text-center text-muted">
			<i class="bi bi-journal-x fs-1 d-block mb-2 text-secondary opacity-50"></i>
			조회된 경기 이력이 없습니다.
		</td>
	</tr>
</c:if>