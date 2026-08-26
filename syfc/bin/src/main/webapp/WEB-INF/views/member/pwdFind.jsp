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
<script defer>
    const contextPath = "${pageContext.request.contextPath}";
</script>
<script defer src="${pageContext.request.contextPath}/dist/js/common/idpwdfind.js"></script>
</head>
<body>

<header>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>

<main>
    <div class="page-container find-page">

        <div class="common-card find-card">

            <section class="find-section">
                <div class="common-header">
                    <h1>아이디 <span>찾기</span></h1>
                    <p>이름과 이메일을 입력하세요.</p>
                </div>

                <form name="idForm" method="post">
                    <div class="input-group">
                        <label for="userName">이름</label>
                        <input type="text" id="userName" name="userName" placeholder="이름">
                    </div>

                    <div class="input-group">
                        <label for="email">이메일</label>
                        <input type="text" id="email" name="email" placeholder="이메일">
                    </div>

                    <button type="button" class="btn-submit" onclick="idFind();">확인</button>

                    <div id="findIdResult" class="result-area"></div>
                </form>
            </section>

            <hr class="common-divider">

            <section class="find-section">
                <div class="common-header">
                    <h1>패스워드 <span>찾기</span></h1>
                    <p>회원 아이디와 이름을 입력하세요.</p>
                </div>

                <form name="pwdForm" method="post">
                    <div class="input-group">
                        <label for="userId">아이디</label>
                        <input type="text" id="userId" name="userId" placeholder="아이디">
                    </div>

                    <div class="input-group">
                        <label for="userName1">이름</label>
                        <input type="text" id="userName1" name="userName1" placeholder="이름">
                    </div>

                    <button type="button" class="btn-submit" onclick="sendOk();">확인</button>

                    <div id="result" class="result-area"></div>
                </form>
            </section>

            <p class="message-area">${message}</p>
        </div>
    </div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

</body>
</html>
