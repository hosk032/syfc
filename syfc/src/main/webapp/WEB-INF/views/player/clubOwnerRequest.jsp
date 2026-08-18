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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/player/clubOwnerRequest.css" />
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
			<!-- 신청사유, 신청할 구단주명, 신청일, 신청상태(대기,승인,반려) -->
			<div class="col-md-9">
				<form id="clubOwnerRequestForm" action="${pageContext.request.contextPath}/player/clubOwnerRequest" method="post">
					<div class="card p-4 profile-panel">
						<h4 class="border-bottom pb-2 mb-4 profile-panel-title">구단주 신청</h4>
					
						<div class="clubOwnerRequest-form">
							<div class="row g-3">
	
								<div class="col-md-6">
									<label class="form-label">신청일</label> 
									<p class="form-control-plaintext text-muted mb-0">
										<fmt:formatDate value="${today}" pattern="yyyy-MM-dd"/>
									</p>
								</div>
								
								<div class="clubOwnerRequest-reason">
									<span>신청사유</span> 
									<textarea class="form-control" rows="5" name="cor_content" required
										placeholder="해당 구단에 구단주로 신청하게된 사유를 간단히 작성해주세요.">
									</textarea>
								</div>
	
							</div>
							
						</div>
					
					<div class="clubOwnerRequest-actions">
						<button type="submit" class="clubOwnerRequest-save-btn"><i class="bi bi-check-lg"></i> 신청하기</button>
						<button type="reset" class="clubOwnerRequest-reset-btn"><i class="bi bi-arrow-counterclockwise"></i> 초기화</button>
					</div>
				
					</div>
			
			   </form>	
			   
			   
			</div>
		</div>
	</div>

<c:if test="${clubOwnerRequestSuccess}">
	<script type="text/javascript">
		alert('구단주 신청이 완료되었습니다.');
	</script>
</c:if>

<script type="text/javascript">
	document.getElementById("clubOwnerRequestForm").addEventListener("submit", function(event){
			if(!confirm("구단주 신청을 완료하시겠습니까 ? ")){
				event.preventDefault();
			}
		});
		
</script>

</body>
</html>	
