<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script defer
	src="${pageContext.request.contextPath}/dist/js/common/loginModal.js"></script>
</head>
<body>

	<div class="modal fade memberShip" id="signupModal" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header-custom">
					<h4 class="fw-bold text-dark mb-1">로그인</h4>
					<p class="text-muted small mb-0">쌍용축구예약 서비스 이용을 위해 로그인해주세요.</p>
					<button type="button" class="btn-close-custom"
						data-bs-dismiss="modal" aria-label="Close">
						<i class="bi bi-x-lg"></i>
					</button>
				</div>

				<form id="loginForm" class="mt-4"
					action="${pageContext.request.contextPath}/member/login"
					method="post">
					<div class="form-floating mb-3">
						<input type="text" class="form-control custom-input" id="loginId"
							name="userId" placeholder="아이디" required> <label
							for="loginId" class="text-muted">아이디</label>
					</div>
					<div class="form-floating mb-3">
						<input type="password" class="form-control custom-input"
							id="loginPwd" name="userPwd" placeholder="비밀번호" required>
						<label for="loginPwd" class="text-muted">비밀번호</label>
					</div>

					<div
						class="d-flex justify-content-between align-items-center mb-4 px-1">
						<div class="form-check">
							<input class="form-check-input custom-checkbox" type="checkbox"
								id="keepLogin" name="rememberMe"> <label
								class="form-check-label small text-muted cursor-pointer"
								for="keepLogin"> 로그인 유지하기 </label>
						</div>
						<a href="#"
							class="small text-muted text-decoration-none hover-purple">아이디
							/ 비밀번호 찾기</a>
					</div>

					<button type="submit"
						class="btn btn-login-submit w-100 py-3 fw-bold mb-3">로그인</button>
				</form>

				<div class="modal-footer-custom pt-3 border-top text-center">
					<span class="text-muted small">아직 회원이 아니신가요?</span>
					<button type="button"
						class="btn btn-link btn-signup-link p-0 ms-1 fw-bold text-decoration-none"
						onclick="location.href='${pageContext.request.contextPath}/member/account';">
						회원가입하기</button>
				</div>
			</div>
		</div>
	</div>

</body>


</html>