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
				<div class="profile-panel-heading">
					<h4 class="profile-panel-title">프로필 등록 및 수정</h4>
					<p class="profile-edit-notice">
						※프로필 수정은 하단의 수정하기 버튼을 클릭해주세요※
					</p>
				</div>
				
					<form action="${pageContext.request.contextPath}/player/profile" method="post" class="profile-form" enctype="multipart/form-data">
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
									
									<input type="file" id="profilePhoto" class="profile-file-input" name="profilePhoto" accept="image/*" disabled>
							</div>

							<div class="profile-info-area">
								<div class="profile-info-top">
									<div class="form-field email-area">
										<label class="form-label" for="email1">이메일</label>
										<div class="email-fields">
											<input type="text" id="email1" class="form-control" name="email1" placeholder="이메일" readonly>
											<span class="email-at">@</span>
											<select id="email2" class="form-select" name="email2" disabled>
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
										<input type="date" id="birth" class="form-control" name="birth" value="${dto.birth}" readonly>
									</div>
								</div>

								<div class="form-field tel-area">
									<label class="form-label" for="tel">전화번호</label>
									<div class="phone-fields">
										<select id="tel1" class="form-select" name="tel1" disabled>
											<option value="010">02</option>
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="011">031</option>
											<option value="011">032</option>
										</select> <span class="phone-separator">-</span> <input type="text"
											class="form-control" name="tel2" maxlength="4" disabled
											placeholder="5555"> <span class="phone-separator">-</span>

										<input type="text" class="form-control" name="tel3"
											maxlength="4" placeholder="6666" disabled>
									</div>
								</div>
							</div>
						</div>

						<div class="profile-details">
							<div class="form-field">
								<label class="form-label" for="zip">우편번호</label>
								<div class="zip-row">
									<input type="text" id="zip" class="form-control" name="zip" maxlength="5" inputmode="numeric" placeholder="예: 07900" value="${dto.zip}" readonly>
									<button type="button" class="postcode-btn"><i class="bi bi-search"></i> 주소 찾기</button>
								</div>
							</div>

							<div class="form-field">
								<label class="form-label" for="gender">성별</label>
								<select id="gender" class="form-select" name="gender" disabled>
									<option value="">선택하세요</option>
									<option value="남">남</option>
									<option value="여">여</option>
								</select>
							</div>

							<div class="form-field address-field">
								<label class="form-label" for="addr1">주소</label>
								<input type="text" id="addr1" class="form-control" name="addr1" placeholder="기본 주소" value="${dto.addr1}" readonly>
							</div>

							<div class="form-field address-field">
								<label class="form-label" for="addr2">상세주소</label>
								<input type="text" id="addr2" class="form-control" name="addr2" placeholder="동, 호수 등 상세 주소" value="${dto.addr2}" readonly>
							</div>
							
							<div class="form-field preferred-position-field">
								<label class="form-label" for="preferredPosition">⚽ 선호 포지션 ⚽</label>

								<div id="preferredPosition" class="preferred-position-buttons">
									<button type="button" class="position-btn">GK</button>
									<button type="button" class="position-btn">DF</button>
									<button type="button" class="position-btn">MF</button>
									<button type="button" class="position-btn">FW</button>
								</div>
							</div>
							
						</div>

						<div class="profile-form-actions">
							<div class="profile-main-actions">
								<button type="button" class="profile-edit-btn" id="editBtn"><i class="bi bi-check-lg"></i> 수정하기</button>
								<button type="submit" class="profile-save-btn" id="saveBtn" style="display: none;"><i class="bi bi-check-lg"></i> 저장하기</button>
								<button type="reset" class="profile-reset-btn"><i class="bi bi-arrow-counterclockwise"></i> 초기화</button>
							</div>
							<button type="button" class="profile-delete-btn" id="withdrawBtn"> 탈퇴하기</button>
						</div>
					</form>

				</div>
			</div>
		</div>


	<!-- 하단 푸터 조립 -->
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
	
		
	<!-- 비밀번호 확인 모달창 -->
	<div class="modal fade" id="passwordCheckModal" tabindex="-1" aria-labelledby="passwordCheckModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<form action="${pageContext.request.contextPath}/member/pwd" method="post">
					<input type="hidden" name="mode" value="playerUpdate">
					
					<div class="modal-header">
						<h5 class="modal-title" id="passwordCheckModalLabel">
							비밀번호 확인
						</h5>
						
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					
					<div class="modal-body">
						<p class="small text-muted">
							개인정보 수정을 위해 비밀번호를 입력해주세요.
						</p>
						
						<label for="checkPassword" class="form-label">
							비밀번호
						</label>
						
						<input type="password" id="checkPassword" name="userPwd" class="form-control" required>
					
						<div class="text-danger small mt-2" id="passwordError">
						
						</div>

					</div>
					
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">
							확인
						</button>
						
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
							취소
						</button>
						
					</div>
				
				</form>
	
			</div>
		</div>
	</div>
	<!-- 비밀번호 확인 모달창 끝 -->
	
	<!-- 3. 마이페이지 전용 JS 연결 (dist/js/member/mypage.js) -->
	<script src="${pageContext.request.contextPath}/dist/js/member/mypage.js"></script>
	
	<script type="text/javascript">
	// 수정 전에 읽기전용 -> 수정버튼 클릭 후 비밀번호 수정창으로 변경
	// editBtn 버튼 찾기
	const editBtn = document.getElementById("editBtn");
	
	// 부트스트랩 생성 + 아이디 호출
	const passwordModal = new bootstrap.Modal(
		document.getElementById("passwordCheckModal")
	);
	
	// 버튼 클릭이벤트 , 모달창 보여주기
	editBtn.addEventListener("click", function(){
		passwordModal.show();
	});
	
	
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
	});
	

	
	
	</script>

	
	
</body>
</html>
