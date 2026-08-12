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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/player/mypage.css" />
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
					<a href="${pageContext.request.contextPath}/player/rating" class="list-group-item list-group-item-action ps-4">내 평점 조회</a>

					<!-- 대분류 2 -->
					<!-- 경기 참가신청 조회 항목에서 신청한 경기 수정/취소 -->
					<div class="list-group-item bg-light fw-bold">경기</div>
					<a href="${pageContext.request.contextPath}/player/matchHistory" class="list-group-item list-group-item-action ps-4">내 경기 참가 이력</a>
					<a href="${pageContext.request.contextPath}/player/matchApply" class="list-group-item list-group-item-action ps-4">신청 결과조회</a>

					<!-- 대분류 3 -->
					<div class="list-group-item bg-light fw-bold">내 구단정보</div>
					<a href="${pageContext.request.contextPath}/player/club" class="list-group-item list-group-item-action ps-4">내 구단팀 조회</a> 
					<a href="${pageContext.request.contextPath}/player/clubJoin" class="list-group-item list-group-item-action ps-4">입단 신청/결과조회</a>
					<a href="${pageContext.request.contextPath}/player/clubOwnerRequest" class="list-group-item list-group-item-action ps-4">구단주 신청</a> 
					<a href="${pageContext.request.contextPath}/player/clubOwnerRequestHistory" class="list-group-item list-group-item-action ps-4">구단주 신청 결과 조회/취소</a>

				</div>
			</div>

			<!-- 2. 오른쪽 메인 콘텐츠 영역 -->
			<div class="col-md-9">
				<div class="card p-4 profile-panel">
					<h4 class="border-bottom pb-2 mb-4 profile-panel-title">프로필 등록 및 수정</h4>

					<form action="${pageContext.request.contextPath}/player/profile/insert" method="post" class="profile-form" enctype="multipart/form-data">
						<div class="profile-primary">
							<div class="profile-photo-area">
									<div class="profile-image-box">
										<i class="bi bi-person"></i>
									</div>

									<label class="form-label profile-photo-label" for="profilePhoto"> 
										프로필 사진 
									</label> 
									
									<input type="file" id="profilePhoto" class="profile-file-input"
										name="profilePhoto" accept="image/*">
							</div>

							<div class="profile-info-area">
								<div class="profile-info-top">
									<div class="form-field email-area">
										<label class="form-label" for="email1">이메일</label>
										<div class="email-fields">
											<input type="text" id="email1" class="form-control" name="email1" placeholder="아이디">
											<span class="email-at">@</span>
											<select id="email2" class="form-select" name="email2">
												<option value="">도메인 선택</option>
												<option value="naver.com">naver.com</option>
												<option value="gmail.com">gmail.com</option>
												<option value="daum.net">daum.net</option>
												<option value="kakao.com">kakao.com</option>
												<option value="nate.com">nate.com</option>
											</select>
										</div>
									</div>

									<div class="form-field profile-birth-area">
										<label class="form-label" for="birth">생년월일</label>
										<input type="date" id="birth" class="form-control" name="birth">
									</div>
								</div>

								<div class="form-field tel-area">
									<label class="form-label" for="tel">전화번호</label>
									<div class="phone-fields">
										<select id="tel1" class="form-select" name="tel1">
											<option value="010">02</option>
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="011">031</option>
											<option value="011">032</option>
										</select> <span class="phone-separator">-</span> <input type="text"
											class="form-control" name="tel2" maxlength="4"
											placeholder="5555"> <span class="phone-separator">-</span>

										<input type="text" class="form-control" name="tel3"
											maxlength="4" placeholder="6666">
									</div>
								</div>
							</div>
						</div>

						<div class="profile-details">
							<div class="form-field">
								<label class="form-label" for="zip">우편번호</label>
								<div class="zip-row">
									<input type="text" id="zip" class="form-control" name="zip" maxlength="5" inputmode="numeric" placeholder="예: 07900">
									<button type="button" class="postcode-btn"><i class="bi bi-search"></i> 주소 찾기</button>
								</div>
							</div>

							<div class="form-field">
								<label class="form-label" for="gender">성별</label>
								<select id="gender" class="form-select" name="gender">
									<option value="">선택하세요</option>
									<option value="남">남</option>
									<option value="여">여</option>
								</select>
							</div>

							<div class="form-field address-field">
								<label class="form-label" for="addr1">주소</label>
								<input type="text" id="addr1" class="form-control" name="addr1" placeholder="기본 주소">
							</div>

							<div class="form-field address-field">
								<label class="form-label" for="addr2">상세주소</label>
								<input type="text" id="addr2" class="form-control" name="addr2" placeholder="동, 호수 등 상세 주소">
							</div>
							
							<div class="form-field preferred-position-field">
								<label class="form-label" for="preferredPosition">⚽ 선호 포지션 ⚽</label>

								<div id="preferredPosition" class="preferred-position-buttons">
									<button type="button">GK</button>
									<button type="button">DF</button>
									<button type="button">MF</button>
									<button type="button">FW</button>
								</div>
							</div>
							
						</div>

						<div class="profile-form-actions">
							<button type="button" class="profile-save-btn"><i class="bi bi-check-lg"></i> 저장</button>
							<button type="reset" class="profile-reset-btn"><i class="bi bi-arrow-counterclockwise"></i> 초기화</button>
						</div>
					</form>

				</div>
			</div>
		</div>
	</div>

	<!-- 하단 푸터 조립 -->
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

	<!-- 3. 마이페이지 전용 JS 연결 (dist/js/member/mypage.js) -->
	<script src="${pageContext.request.contextPath}/dist/js/member/mypage.js"></script>
</body>
</html>
