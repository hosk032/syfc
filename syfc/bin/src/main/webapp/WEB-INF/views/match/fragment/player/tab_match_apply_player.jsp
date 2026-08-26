<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>경기 참가 신청 - 쌍용축구예약</title>

    <!-- 공통 CSS -->
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

    <!-- 선수 경기 매칭 전용 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/match/matchApply.css">
	<script src="${pageContext.request.contextPath}/dist/js/match/matchApplyTab.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/match/matchBoardList.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/match/requestResult.js"></script>  
	<script src="${pageContext.request.contextPath}/dist/js/match/match.js"></script>
	<script src="${pageContext.request.contextPath}/dist/js/match/matchHistory.js"></script>
    
</head>

<body>

<!-- 공통 헤더 -->
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container my-4">

    <div class="row">
    <!-- 상단 간단 요약 프로필 바 -->
		<div class="card mb-4 p-3 bg-light">
			<div class="d-flex align-items-center">
				<div class="summary-profile-box me-3">
					<img src="${pageContext.request.contextPath}/uploads/member/${dto.profile_photo}"
						class="summary-profile-image" alt="프로필 이미지" />

					<c:if test="${not empty mainBall}">
						<div class="summary-main-ball">
							<img alt="대표공 이미지" src="${pageContext.request.contextPath}${mainBall.ball_image}">
						</div>
					</c:if>
				</div>
				
				<div>
					<h5 class="mb-1">
						<strong>${sessionScope.member.userName}</strong> 님 환영합니다!
					</h5>
										
					<!-- 등급 표시 -->
					<c:choose>
						<c:when test="${sessionScope.member.userLevel eq 1}">
							<span class="badge bg-secondary">일반회원</span>
						</c:when>
						<c:when test="${sessionScope.member.userLevel eq 10}">
							<span class="badge bg-success">선수</span>
						</c:when>
						<c:when test="${sessionScope.member.userLevel eq 50}">
							<span class="badge bg-primary">구단주</span>
						</c:when>
						<c:when test="${sessionScope.member.userLevel eq 100}">
							<span class="badge bg-dark">관리자</span>
						</c:when>
					
					</c:choose>
				</div>
			</div>
		</div>

        <!-- 왼쪽 선수 마이페이지 메뉴 -->
        <div class="col-md-3 mb-4">
            <div class="list-group">

                <div class="list-group-item bg-dark text-white fw-bold">
                    마이페이지
                </div>

                <!-- 내 프로필 -->
                <div class="list-group-item bg-light fw-bold">
                    내 프로필
                </div>

                <a href="${pageContext.request.contextPath}/player/mypage"
                   class="list-group-item list-group-item-action ps-4">
                    프로필 등록/수정
                </a>

                <a href="${pageContext.request.contextPath}/player/miniGame"
                   class="list-group-item list-group-item-action ps-4">
                    미니게임
                </a>


                <!-- 경기 -->
                <div class="list-group-item bg-light fw-bold">
                    경기
                </div>

                <a href="${pageContext.request.contextPath}/player/matchHistory"
                   class="list-group-item list-group-item-action ps-4">
                    내 경기 참가 이력
                </a>

                <a href="${pageContext.request.contextPath}/player/playerProfile"
                   class="list-group-item list-group-item-action ps-4">
                    내 선수 프로필
                </a>

                <a href="${pageContext.request.contextPath}/player/rating"
                   class="list-group-item list-group-item-action ps-4">
                    내 경기 성적
                </a>


                <!-- 내 구단정보 -->
                <div class="list-group-item bg-light fw-bold">
                    내 구단정보
                </div>

                <a href="${pageContext.request.contextPath}/player/club"
                   class="list-group-item list-group-item-action ps-4">
                    내 구단팀 조회
                </a>

                <a href="${pageContext.request.contextPath}/player/clubJoin"
                   class="list-group-item list-group-item-action ps-4">
                    입단 신청/결과조회
                </a>

                <a href="${pageContext.request.contextPath}/player/clubOwnerRequest"
                   class="list-group-item list-group-item-action ps-4">
                    구단주 신청
                </a>

                <a href="${pageContext.request.contextPath}/player/clubOwnerRequestHistory"
                   class="list-group-item list-group-item-action ps-4">
                    구단주 신청 결과 조회/취소
                </a>


                <!-- 경기 신청 -->
                <div class="list-group-item bg-light fw-bold">
                    경기 신청
                </div>

                <a href="${pageContext.request.contextPath}/match2/playermatchtab"
                   class="list-group-item list-group-item-action ps-4 active">
                    경기 참가 신청 / 이력
                </a>
            </div>

        </div>


        <!-- 오른쪽 경기 매칭 영역 -->
        <div class="col-md-9">
            <div class="card border-0 shadow-sm rounded-4 p-4">

                <!-- 경기 매칭 하위 탭 -->
                <ul class="nav nav-pills nav-fill gap-2 mb-4" id="matchSubTab">
                    <li class="nav-item">
                        <button type="button" class="nav-link active" data-match-tab="create">
                            📅 출전신청 결과
                        </button>
                    </li>

                    <li class="nav-item">
                        <button type="button" class="nav-link" data-match-tab="board">
                            🏃 참가 선수 모집 게시판
                        </button>
                    </li>

                    <li class="nav-item">
                        <button type="button" class="nav-link" data-match-tab="history">
                            📋 경기 신청 이력
                        </button>
                    </li>
                </ul>

                <!-- 하위 탭 내용 -->
                <div id="matchSubTabContent">

                    <!-- ① 출전신청 결과 -->
                    <div id="match-create-pane" class="match-sub-pane">
                        <jsp:include page="/WEB-INF/views/match/fragment/player/requestResult.jsp" />
                    </div>

                    <!-- ② 선수 모집 게시판 -->
                    <div id="match-board-pane" class="match-sub-pane" style="display:none;">
                        <jsp:include page="/WEB-INF/views/match/fragment/board/matchBoardList.jsp" />
                    </div>


                    <!-- ③ 경기 신청 이력 -->
                    <div id="match-history-pane" class="match-sub-pane" style="display:none;">
                        <jsp:include page="/WEB-INF/views/match/fragment/owner/matchHistory.jsp" />
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>


<!-- 게시글 상세 모달 -->
<jsp:include page="/WEB-INF/views/match/fragment/board/matchBoardDetail.jsp" />



<!-- footer -->
<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

</body>
</html>