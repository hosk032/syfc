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

	<!-- 2. 마이페이지 전용 CSS 연결 (dist/css/member/mypage.css) -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/player/clubOwnerRequestHistory.css" />
</head>
<body>

	<!-- 상단 헤더 조립 -->
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<div class="container my-4">
		<!-- 상단 간단 요약 프로필 바 -->
		<div class="card mb-4 p-3 bg-light">
			<div class="d-flex align-items-center">
				<img src="${pageContext.request.contextPath}/dist/images/user.png" class="rounded-circle me-3" style="width: 60px; height: 60px" alt="프로필 이미지" />
				<div>
					<h5 class="mb-1">
						<strong>홍길동</strong> 님 환영합니다!
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
						마이페이지
					</div>

					<!-- 대분류 1 -->
					<div class="list-group-item bg-light fw-bold">내 프로필</div>
					<a href="${pageContext.request.contextPath}/player/mypage"  class="list-group-item list-group-item-action ps-4 active">프로필 등록/수정</a> 
					<a href="${pageContext.request.contextPath}/player/todo" class="list-group-item list-group-item-action ps-4">투두리스트</a>

					<!-- 경기 참가신청 조회 항목에서 신청한 경기 수정/취소 -->
					<div class="list-group-item bg-light fw-bold">경기</div>
					<a href="${pageContext.request.contextPath}/player/matchHistory" class="list-group-item list-group-item-action ps-4">내 경기 참가 이력</a>
					<a href="${pageContext.request.contextPath}/player/playerProfile" class="list-group-item list-group-item-action ps-4">내 선수 프로필</a>
					<a href="${pageContext.request.contextPath}/player/rating" class="list-group-item list-group-item-action ps-4">내 경기 성적</a>


					<!-- 대분류 3 -->
					<div class="list-group-item bg-light fw-bold">내 구단정보</div>
					<a href="${pageContext.request.contextPath}/player/club" class="list-group-item list-group-item-action ps-4">내 구단팀 조회</a> 
					<a href="${pageContext.request.contextPath}/player/clubJoin" class="list-group-item list-group-item-action ps-4">입단 신청/결과조회</a>
					<a href="${pageContext.request.contextPath}/player/clubOwnerRequest" class="list-group-item list-group-item-action ps-4">구단주 신청</a> 
					<a href="${pageContext.request.contextPath}/player/clubOwnerRequestHistory" class="list-group-item list-group-item-action ps-4">구단주 신청 결과 조회/취소</a>

					<!-- 대분류 4 -->
					<div class="list-group-item bg-light fw-bold">경기 신청</div>
					<a href="#" class="list-group-item list-group-item-action ps-4">경기 참가 신청</a> 
					<a href="#" class="list-group-item list-group-item-action ps-4">신청 경기 조회</a>
					<a href="#" class="list-group-item list-group-item-action ps-4">경기 신청 수정/취소</a> 
				</div>
			</div>

			<!-- 2. 오른쪽 메인 콘텐츠 영역 -->
			<div class="col-md-9">
				<div class="card p-4 profile-panel">
					<h4 class="border-bottom pb-2 mb-4 profile-panel-title">신청결과조회/취소</h4>
					<div class="table-responsive">
						<table class="table table-hover text-center align-middle">
							<thead class="table-light">
								<tr>
									<th>구단주명</th>
									<th>신청일</th>
									<th>신청결과</th>
									<th>반려사유</th>
								</tr>
							</thead>

							<tbody>
								<tr>
									<td>쌍용구단주</td>
									<td>2026-08-10</td>
									<td><span class="clubOwnerRequestHistory-status status-pending">반려</span></td>
									<td>
										<button type="button" class="btn btn-link p-0 text-danger text-decoration-underline"
									          data-bs-toggle="modal" data-bs-target="#rejectReasonModal">포지션 불일치
									    </button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- 반려사유 모달 창 -->
					<div class="modal fade reject-reason-modal" id="rejectReasonModal" tabindex="-1">
						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">
					
								<div class="modal-header">
									<h5 class="modal-title">반려 사유</h5>
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
	</div>