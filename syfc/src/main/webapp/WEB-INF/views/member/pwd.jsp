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
        <div class="common-card pwd-card">

            <div class="common-header">
                <h1>패스워드 <span>재확인</span></h1>
                <p>정보보호를 위해 패스워드를 다시 한 번 입력해주세요.</p>
            </div>

            <form name="pwdForm" method="post">
                <div class="input-group">
                    <label for="userId">아이디</label>
                    <input type="text" id="userId" name="userId"
                           value="${sessionScope.member.userId}" readonly>
                </div>

                <div class="input-group">
                    <label for="userPwd">패스워드</label>
                    <input type="password" id="userPwd" name="userPwd"
                           autocomplete="off" placeholder="패스워드를 입력하세요">
                </div>

                <button type="button" class="btn-submit" onclick="sendOk();">
                    확인
                </button>

                <input type="hidden" name="mode" value="${mode}">
            </form>

            <p class="message-area">${message}</p>
        </div>
    </div>
</main>

<script type="text/javascript">
function sendOk() {
    const f = document.pwdForm;

    let str = f.userPwd.value;
    if (!str) {
        alert("패스워드를 입력하세요. ");
        f.userPwd.focus();
        return;
    }

    f.action = "${pageContext.request.contextPath}/member/pwd";
    f.submit();
}
</script>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

</body>
</html>
