<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>쌍용축구예약</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/member/common.css" />
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
    <div class="page-container">
        <div class="common-card login-card">

            <div class="common-header">
                <h1>⚽ 회원 <span>로그인</span></h1>
                <p>쌍용축구예약 서비스를 이용하려면 로그인해주세요.</p>
            </div>

            <form name="loginForm" action="" method="post">
                <div class="input-group">
                    <label for="userId">아이디</label>
                    <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요">
                </div>

                <div class="input-group">
                    <label for="userPwd">패스워드</label>
                    <input type="password" id="userPwd" name="userPwd"
                           autocomplete="off" placeholder="패스워드를 입력하세요">
                </div>

                <div class="login-option">
                    <label class="checkbox-label">
                        <input type="checkbox" id="rememberMe">
                        <span>아이디 저장</span>
                    </label>
                </div>

                <button type="button" class="btn-submit" onclick="sendLogin();">
                    로그인
                </button>
            </form>

            <hr class="common-divider">

            <div class="page-links">
                <a href="${pageContext.request.contextPath}/member/pwdFind">아이디/패스워드 찾기</a>
                <a href="${pageContext.request.contextPath}/member/account">회원가입</a>
            </div>

            <p class="message-area">${message}</p>
        </div>
    </div>
</main>

<script type="text/javascript">
function sendLogin() {
    const f = document.loginForm;

    if (!f.userId.value.trim()) {
        f.userId.focus();
        return;
    }

    if (!f.userPwd.value.trim()) {
        f.userPwd.focus();
        return;
    }

    f.action = '${pageContext.request.contextPath}/member/login';
    f.submit();
}
</script>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

</body>
</html>
