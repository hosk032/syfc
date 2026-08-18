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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/player/mypage.css?v=20260816-password-overlay" />
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
					<a href="${pageContext.request.contextPath}/player/mypage" class="list-group-item list-group-item-action ps-4 active">프로필 등록/수정</a> 
					<a href="${pageContext.request.contextPath}/player/todo" class="list-group-item list-group-item-action ps-4">투두리스트</a>

					<!-- 대분류 2 -->
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
				<div class="profile-edit-area">
					<div class="profile-edit-content"<c:if test="${not playerUpdateVerified}"> inert aria-hidden="true"</c:if>>
						<div class="profile-panel-heading">
					<h4 class="profile-panel-title">프로필 등록 및 수정</h4>
					<p class="profile-edit-notice">
						비밀번호 확인 후 프로필을 수정할 수 있습니다.
					</p>
						</div>
				
					<form action="${pageContext.request.contextPath}/player/profile" method="post" class="profile-form" enctype="multipart/form-data">
						<input type="hidden" name="clubJoin_num" value="${dto.clubJoin_num}">
					
						<c:set var="emailId" value="${fn:substringBefore(dto.email, '@')}" />
						<c:set var="emailDomain" value="${fn:substringAfter(dto.email, '@')}" />
						<c:set var="telFirst" value="${fn:substringBefore(dto.tel, '-')}" />
						<c:set var="telLastTwo" value="${fn:substringAfter(dto.tel, '-')}" />
						<c:set var="telMiddle" value="${fn:substringBefore(telLastTwo, '-')}" />
						<c:set var="telLast" value="${fn:substringAfter(telLastTwo, '-')}" />
						<div class="profile-primary">
							<div class="profile-photo-area">
									<div class="profile-image-box">
										<c:choose>
											<c:when test="${not empty dto.profile_photo}">
												<img id="profilePreview" src="${pageContext.request.contextPath}/uploads/member/${dto.profile_photo}" alt="프로필 사진">
											</c:when>
											<c:otherwise>
												<img id="profilePreview" src="" alt="프로필 사진" style="display: none;">
													<i id="profileDefaultIcon" class="bi bi-person"></i>
											</c:otherwise>
										</c:choose>
									</div>

									<label class="form-label profile-photo-label" for="profilePhoto"> 
										프로필 사진 
									</label> 
									
									<input type="file" id="profilePhoto" class="profile-file-input" name="profilePhoto" accept="image/*">
							</div>

							<div class="profile-info-area">
								<div class="profile-info-top">
									<div class="form-field name">
										<label class="form-label" for="name">이름</label>
										<input type="text" class="form-control" name="name" placeholder="이름" value="${name}">
									</div>
									
										<div class="form-field email-area">
											<label class="form-label" for="email1">이메일</label>
											<div class="email-fields">
												<input type="text" id="email1" class="form-control" name="email1" placeholder="이메일" value="${emailId}">
												<span class="email-at">@</span>
												<select id="email2" class="form-select" name="email2">
													<option value="" <c:if test="${empty emailDomain}">selected</c:if>>도메인 선택</option>
													<option value="naver.com" <c:if test="${emailDomain eq 'naver.com'}">selected</c:if>>naver.com</option>
													<option value="gmail.com" <c:if test="${emailDomain eq 'gmail.com'}">selected</c:if>>gmail.com</option>
													<option value="daum.net" <c:if test="${emailDomain eq 'daum.net'}">selected</c:if>>daum.net</option>
													<option value="kakao.com" <c:if test="${emailDomain eq 'kakao.com'}">selected</c:if>>kakao.com</option>
													<option value="nate.com" <c:if test="${emailDomain eq 'nate.com'}">selected</c:if>>nate.com</option>
												</select>
											</div>
										</div>

									<div class="form-field profile-birth-area">
										<label class="form-label" for="birth">생년월일</label>
										<input type="date" id="birth" class="form-control" name="birth" value="${dto.birth}">
									</div>
								</div>

								<div class="form-field tel-area">
									<label class="form-label" for="tel">전화번호</label>
									<div class="phone-fields">
										<select id="tel1" class="form-select" name="tel1">
											<option value="02" <c:if test="${telFirst eq '02'}">selected</c:if>>02</option>
											<option value="010" <c:if test="${telFirst eq '010'}">selected</c:if>>010</option>
											<option value="011" <c:if test="${telFirst eq '011'}">selected</c:if>>011</option>
											<option value="031" <c:if test="${telFirst eq '031'}">selected</c:if>>031</option>
											<option value="032" <c:if test="${telFirst eq '032'}">selected</c:if>>032</option>
										</select> <span class="phone-separator">-</span> <input type="text"
											class="form-control" name="tel2" maxlength="4" value="${telMiddle}"
											placeholder="5555"> <span class="phone-separator">-</span>

										<input type="text" class="form-control" name="tel3"
											maxlength="4" placeholder="6666" value="${telLast}">
									</div>
								</div>
							</div>
						</div>

						<div class="profile-details">
							<div class="form-field">
								<label class="form-label" for="zip">우편번호</label>
								<div class="zip-row">
									<input type="text" id="zip" class="form-control" name="zip" maxlength="5" inputmode="numeric" placeholder="예: 07900" value="${dto.zip}">
									<button type="button" class="postcode-btn"><i class="bi bi-search"></i> 주소 찾기</button>
								</div>
							</div>

							<div class="form-field">
								<label class="form-label" for="gender">성별</label>
								<select id="gender" class="form-select" name="gender">
									<option value="" <c:if test="${empty dto.gender}">selected</c:if>>선택하세요</option>
									<option value="남" <c:if test="${dto.gender eq '남'}">selected</c:if>>남</option>
									<option value="여" <c:if test="${dto.gender eq '여'}">selected</c:if>>여</option>
								</select>
							</div>

							<div class="form-field address-field">
								<label class="form-label" for="addr1">주소</label>
								<input type="text" id="addr1" class="form-control" name="addr1" placeholder="기본 주소" value="${dto.addr1}">
							</div>

							<div class="form-field address-field">
								<label class="form-label" for="addr2">상세주소</label>
								<input type="text" id="addr2" class="form-control" name="addr2" placeholder="동, 호수 등 상세 주소" value="${dto.addr2}">
							</div>
							
							<div class="form-field preferred-position-field">
								<label class="form-label" for="preferredPosition">⚽ 선호 포지션 ⚽</label>

								<div id="preferredPosition" class="preferred-position-buttons">
									<button type="button" class="position-btn">GK</button>
									<button type="button" class="position-btn">DF</button>
									<button type="button" class="position-btn">MF</button>
									<button type="button" class="position-btn">FW</button>
								</div>

								<div class="player-specs-section" aria-labelledby="playerSpecsLabel">
									<p id="playerSpecsLabel" class="player-specs-title">선수 정보 <span>(선택)</span></p>

									<div class="row g-3 player-specs-row">
										<div class="col-12 col-md-4">
											<label class="form-label" for="height">키</label>
											<div class="input-group">
												<input type="number" id="height" class="form-control" name="height"
													min="50" max="300" step="1" inputmode="numeric" placeholder="예: 175" value="${dto.height}">
												<span class="input-group-text">cm</span>
											</div>
										</div>

										<div class="col-12 col-md-4">
											<label class="form-label" for="weight">몸무게</label>
											<div class="input-group">
												<input type="number" id="weight" class="form-control" name="weight"
													min="20" max="300" step="1" inputmode="numeric" placeholder="예: 70" value="${dto.weight}">
												<span class="input-group-text">kg</span>
											</div>
										</div>

										<div class="col-12 col-md-4">
											<label class="form-label" for="uniformNo">등번호</label>
											<div class="input-group">
												<input type="number" id="uniformNo" class="form-control" name="uniform_no"
													min="1" max="99" step="1" inputmode="numeric" placeholder="예: 7" value="${dto.uniform_no}">
												<span class="input-group-text">번</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							
						</div>

						<div class="profile-form-actions">
							<div class="profile-main-actions">
								<button type="submit" class="profile-save-btn" id="saveBtn"><i class="bi bi-check-lg"></i> 저장하기</button>
								<button type="reset" class="profile-reset-btn"><i class="bi bi-arrow-counterclockwise"></i> 초기화</button>
							</div>
							<button type="button" class="profile-delete-btn" id="withdrawBtn"> 탈퇴하기</button>
						</div>
					</form>

					</div>

					<c:if test="${not playerUpdateVerified}">
						<section class="password-check-overlay" aria-labelledby="passwordCheckTitle">
							<form class="password-check-form" action="${pageContext.request.contextPath}/player/checkPassword" method="post">
								<h4 id="passwordCheckTitle">비밀번호 확인</h4>
								<p class="password-check-guide">개인정보 수정을 위해 비밀번호를 입력해주세요.</p>

								<div class="password-check-field">
									<label for="checkPassword" class="form-label">비밀번호</label>
									<input type="password" id="checkPassword" name="userPwd" class="form-control" required autofocus>
								</div>

								<c:if test="${passwordError}">
									<div class="password-check-error">비밀번호가 일치하지 않습니다.</div>
								</c:if>

								<button type="submit" class="password-check-submit">확인</button>
							</form>
						</section>
					</c:if>
				</div>
			</div>
		</div>
</div>

	<!-- 하단 푸터 조립 -->
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	
		
	<!-- 3. 마이페이지 전용 JS 연결 (dist/js/member/mypage.js) -->
	
	<script type="text/javascript">
	// 버튼 클릭 이벤트
	document.querySelectorAll(".position-btn").forEach(function(button) {
		button.addEventListener("click", function() {
			document.querySelectorAll(".position-btn").forEach(function(item) {
				// 모든 버튼에서 css 클래스 지우고
				item.classList.remove("active");
			});
			// 클릭한 버튼(this)에만 active 클래스 추가 
			this.classList.add("active");
		});
	});
	
	
	
	// 프로필 사진 미리보기
	document.getElementById("profilePhoto").addEventListener("change", function(){
		const file = this.files[0];
		
		if(!file){
			return;
		}
		// img 태그를 찾아서 preview 변수에 저장
		const preview = document.getElementById("profilePreview");
		// 사용자가 선택한 이미지 파일을 브라우저가 임시 URL 로 만들어서
		// img 의 사진 주소 src 로 넣는다
		preview.src = URL.createObjectURL(file);
		preview.style.display = "block";
		
		// 기본 아이콘(사람모양) 찾기
		const defaultIcon = document.getElementById("profileDefaultIcon");
		// 기본 프로필이 없었던 회원에게만 아이콘(사람모양)이 존재함
		if(defaultIcon){
			defaultIcon.style.display = "none";
		}
	});
	
	// 하단 회원 탈퇴하기 버튼 이벤트
	const withdrawBtn = document.getElementById("withdrawBtn");
	
	// 클릭 이벤트 발생
	withdrawBtn.addEventListener("click", function(){
		// 정말 탈퇴하실건지 물어보는 문구
		const iswithdrawBtn = confirm("정말 탈퇴하시겠습니까 ?");
		
		if(! iswithdrawBtn){
			return;
		}
		
		// 회원탈퇴 POST 요청 보내기
		location.href = '${pageContext.request.contextPath}/member/pwd?mode=delete';
	});
	

	
	
	</script>

	
	
</body>
</html>
