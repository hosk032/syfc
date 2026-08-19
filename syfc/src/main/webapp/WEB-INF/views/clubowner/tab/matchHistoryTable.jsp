<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:forEach var="dto" items="${matchList}">
	<tr>
		<td class="text-muted">
			<c:set var="mDate" value="${dto.matchDate}" />
			${mDate.substring(0, 10)} 
			
			<c:choose>
				<c:when test="${dto.matchTime == 1}">
					<span class="badge bg-light text-dark border ms-1">오전 (09:00 ~ 12:00)</span>
				</c:when>
				<c:when test="${dto.matchTime == 2}">
					<span class="badge bg-light text-dark border ms-1">오후 (14:00 ~ 17:00)</span>
				</c:when>
			</c:choose>
		</td>
		<td class="fw-semibold">${dto.stadiumName}</td>
		<td>
			<strong class="text-dark">${dto.homeClubName}</strong> vs ${dto.awayClubName}
		</td>
		<td class="fw-bold fs-6 text-primary">${dto.homeScore} : ${dto.awayScore}</td>
		<td>
			<c:choose>
				<c:when test="${dto.homeScore > dto.awayScore}">
					<span class="badge bg-primary px-3 py-1">승리</span>
				</c:when>
				<c:when test="${dto.homeScore == dto.awayScore}">
					<span class="badge bg-secondary px-3 py-1">무승부</span>
				</c:when>
				<c:otherwise>
					<span class="badge bg-danger px-3 py-1">패배</span>
				</c:otherwise>
			</c:choose>
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