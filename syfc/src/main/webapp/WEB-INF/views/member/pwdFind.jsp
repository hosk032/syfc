<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>쌍용축구예약</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
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
	<div class="container">
		<div class="body-container row justify-content-center">
			<div class="col-md-6 my-5 p-3">

                <div class="border mt-5 p-4">
                 	<form name="idForm" method="post" class="row g-3">
                        <h3 class="text-center fw-bold">아이디 찾기</h3>
                        
		                <div class="d-grid">
							<p class="form-control-plaintext text-center">이름과 이메일을 입력 하세요.</p>
		                </div>
                        <div class="d-grid">
                            <input type="text" id="userName" name="userName" class="form-control form-control-lg" placeholder="이름">
                        </div>
                        <div class="d-grid">
                            <input type="text" id="email" name="email" class="form-control form-control-lg" placeholder="이메일">
                        </div>
                        <div class="d-grid">
                            <button type="button" class="btn btn-lg btn-primary" onclick="idFind();">확인 <i class="bi bi-check2"></i> </button>
                        </div>
                        <div id="findIdResult"></div>
                    </form>
                    <br><br>
             	</div>
             	<div class="border mt-5 p-4">             
                    <form name="pwdForm" method="post" class="row g-3">
                        <h3 class="text-center fw-bold">패스워드 찾기</h3>
                        
		                <div class="d-grid">
							<p class="form-control-plaintext text-center">회원 아이디와 이름을 입력 하세요.</p>
		                </div>
                        <div class="d-grid">
                            <input type="text" id="userId" name="userId" class="form-control form-control-lg" placeholder="아이디">
                        </div>
                        <div class="d-grid">
                            <input type="text" id="userName1" name="userName1" class="form-control form-control-lg" placeholder="이름">
                        </div>
                        <div class="d-grid">
                            <button type="button" class="btn btn-lg btn-primary" onclick="sendOk();">확인 <i class="bi bi-check2"></i> </button>
                        </div>
                        <div id="result"></div>
                
                    </form>
                </div>

                <div class="d-grid">
					<p class="form-control-plaintext text-center py-3">${message}</p>
                </div>

			</div>
		</div>
	</div>
</main>

<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>


</body>
</html>