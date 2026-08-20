<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>마이페이지 - 쌍용축구예약</title>

	<!-- 1. 공통 CSS/CDN/폰트 리소스 조립 -->
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/player/clubJoin.css" />
</head>
<body>

	<!-- 상단 헤더 조립 -->
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<div class="container my-4">
		<!-- 상단 간단 요약 프로필 바 -->
		<div class="card mb-4 p-3 bg-light">
			<div class="d-flex align-items-center">
				<div class="summary-profile-box me-3">
					<img src="${pageContext.request.contextPath}/uploads/member/${profileDto.profile_photo}" class="rounded-circle me-3" style="width: 60px; height: 60px" alt="프로필 이미지" />
					
						<c:if test="${not empty mainBall}">
							<div class="summary-main-ball">
								<img alt="대표공 이미지" src="${pageContext.request.contextPath}${mainBall.ball_image}">
							</div>
						</c:if>
				</div>
	
					<div>
						<h5 class="mb-1">
							<strong>${sessionScope.member.userName}</strong> 님 환영합니다!
						</h5>
						<span class="badge bg-primary">구단주</span>
						<!-- 등급 표시 -->
					</div>
			</div>
		</div>

		<div class="row">
			<!-- 1. 왼쪽 사이드바 (LNB) -->
			<div class="col-md-3 mb-4">
				<div class="list-group">
					<div class="list-group-item bg-dark text-white fw-bold">
						마이페이지</div>

					<!-- 대분류 1 -->
					<div class="list-group-item bg-light fw-bold">내 프로필</div>
					<a href="${pageContext.request.contextPath}/player/mypage"
						class="list-group-item list-group-item-action ps-4">프로필 등록/수정</a> 
					<a href="${pageContext.request.contextPath}/player/miniGame" class="list-group-item list-group-item-action ps-4">미니게임</a>

					<!-- 경기 참가신청 조회 항목에서 신청한 경기 수정/취소 -->
					<div class="list-group-item bg-light fw-bold">경기</div>
					<a href="${pageContext.request.contextPath}/player/matchHistory" class="list-group-item list-group-item-action ps-4">내 경기 참가 이력</a>
					<a href="${pageContext.request.contextPath}/player/playerProfile" class="list-group-item list-group-item-action ps-4">내 선수 프로필</a>
					<a href="${pageContext.request.contextPath}/player/rating" class="list-group-item list-group-item-action ps-4">내 경기 성적</a>


					<!-- 대분류 3 -->
					<div class="list-group-item bg-light fw-bold">내 구단정보</div>
					<a href="${pageContext.request.contextPath}/player/club"
						class="list-group-item list-group-item-action ps-4">내 구단팀 조회</a> 
						<a href="${pageContext.request.contextPath}/player/clubJoin" class="list-group-item list-group-item-action ps-4 active">입단신청/결과조회</a> 
						<a href="${pageContext.request.contextPath}/player/clubOwnerRequest" class="list-group-item list-group-item-action ps-4">구단주 신청</a> 
						<a href="${pageContext.request.contextPath}/player/clubOwnerRequestHistory" class="list-group-item list-group-item-action ps-4">구단주 신청 결과 조회/취소</a>

					<!-- 대분류 4 -->
					<a href="${pageContext.request.contextPath}/match2/playermatchtab" class="list-group-item list-group-item-action ps-4">경기 참가 신청/이력</a>
				</div>
			</div>

			<!-- 2. 오른쪽 메인 콘텐츠 영역 -->
			<div class="col-md-9">
				<div class="card p-4 mb-4">
					<h4 class="border-bottom pb-2 mb-4">입단신청</h4>

					<div class="club-join-form">
						<div class="row g-3">
							<div class="col-md-6">
								<label class="form-label" for="preferredPosition">선호 포지션</label>

								<select id="preferredPosition" class="form-select" name="position">
									<option value="">선택하세요</option>
									<option value="GK" ${dto.clubJoinPosition eq 'GK' ? 'selected' : ''}>GK</option>
									<option value="DF" ${dto.clubJoinPosition eq 'DF' ? 'selected' : ''}>DF</option>
									<option value="MF" ${dto.clubJoinPosition eq 'MF' ? 'selected' : ''}>MF</option>
									<option value="FW" ${dto.clubJoinPosition eq 'FW' ? 'selected' : ''}>FW</option>
								</select>
							</div>

							<div class="col-md-6">
								<label class="form-label">신청일</label> 
								<input type="date" class="form-control" name="clubJoin-date" value="${dto.clubJoinDate}">
							</div>

							<div class="clubJoin-introduction">
								<span>자기소개</span> 
								<textarea class="form-control" rows="5" name="clubJoin-info" placeholder="구단에 전달할 간단한 자기소개를 작성해주세요.">${dto.clubJoinIntro}</textarea>
							</div>

						</div>
						
					</div>
				</div>
				
					<div class="clubJoin-actions">
						<button type="button" class="clubJoin-save-btn"><i class="bi bi-check-lg"></i> 신청하기</button>
						<button type="reset" class="clubJoin-reset-btn"><i class="bi bi-arrow-counterclockwise"></i> 초기화</button>
					</div>
				<div class="card p-4">
				<form action="${pageContext.request.contextPath}/member/profile/matchApply" method="post" class="profile-form" enctype="multipart/form-data">

					<h4 class="border-bottom pb-2 mb-4">입단 신청 결과</h4>
					<div class="clubJoin-responsive">
						<table class="table table-hover text-center align-middle">
							<thead class="table-light">
								<tr>
									<th>구단명</th>
									<th>신청일</th>
									<th>신청결과</th>
									<th>반려사유</th>
									<th>관리</th>
								</tr>
							</thead>

							<tbody>
								<c:forEach var="history" items="${list}">
									<tr>
										<td>${history.club_name}</td>
										<td>${history.clubJoin_date}</td>
										  
										   <td>
												<c:choose>
													<c:when test="${history.clubJoin_result eq 1}">승인</c:when>
													<c:when test="${history.clubJoin_result eq 0}">반려</c:when>
													<c:when test="${history.clubJoin_result eq 2}">대기</c:when>
													<c:otherwise>알 수 없음</c:otherwise>       
												</c:choose>
										   </td>
									
										   <td>${history.clubJoin_reason}</td>
									
										   <td>
												<c:if test="${history.clubJoin_result eq 2}">
													<button type="button" class="btn btn-sm btn-outline-danger">
														신청 취소
													</button>
												</c:if>
												
												<c:if test="${history.clubJoin_result ne 2}">-</c:if>
										   </td>
									
									 </tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</form>

				</div>
					
					<!-- 반려사유 모달 창 -->
					<div class="modal fade reject-reason-modal" id="rejectReasonModal" tabindex="-1">
						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">
					
								<div class="modal-header">
									<h5 class="modal-title">${history.clubJoin_reason}</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
								</div>
					
								<div class="modal-body">
									신청하신 포지션과 구단에서 모집 중인 포지션이 일치하지 않습니다.
									모집 공고를 확인한 뒤 다시 신청해 주세요.
								</div>
					
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">닫기</button>
								</div>
					
							</div>
						</div>
					</div>




				</div>
			</div>

		</div>
