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
        <div class="common-card complete-card unauthorized-card">

            <div class="common-header">
                <h1>⚠ <span>접근 권한 없음</span></h1>
                <p>
                    해당 정보를 접근할 수 있는 권한이 없습니다.<br>
                    메인화면으로 이동하시기 바랍니다.
                </p>
            </div>

            <button type="button" class="btn-submit"
                    onclick="location.href='${pageContext.request.contextPath}/';">
                메인화면으로 이동
            </button>
        </div>
    </div>
</main>

<footer>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>

</body>
</html>
