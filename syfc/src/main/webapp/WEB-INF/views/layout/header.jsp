<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!-- 1. 헤더 상단 (로고와 우측 아이콘) -->
<div class="header_top">
    <div class="container d-flex justify-content-between align-items-center">
        <!-- 좌측 로고 -->
        <div class="logo" onclick="location.href='${pageContext.request.contextPath}/';">쌍용축구예약</div>
        
        <!-- 우측 아이콘 3개 -->
        <div class="header-icons">
        <c:choose>
      <c:when test="${sessionScope.member.userLevel >= 1}">
         <i class="fa-regular fa-bell" title="알림"
            onclick="location.href='${pageContext.request.contextPath}/notice';"></i>
      </c:when>
       <c:otherwise>
        <i id="singupBtn" class="fa-regular fa-bell" title="로그인/회원가입" data-bs-toggle="modal" data-bs-target="#signupModal"></i> 
     </c:otherwise>
      </c:choose>
      
          <c:choose>   
      <c:when test="${sessionScope.member.userLevel < 50}">
         <i class="fa-regular fa-user"
            title="마이페이지"
            onclick="location.href='${pageContext.request.contextPath}/player/mypage';"></i>
      </c:when>
   
      <c:when test="${sessionScope.member.userLevel == 50}">
         <i class="fa-regular fa-user"
            title="마이페이지"
            onclick="location.href='${pageContext.request.contextPath}/clubowner/ownerpage';"></i>
      </c:when>
   
      <c:when test="${sessionScope.member.userLevel == 100}">
         <i class="fa-regular fa-user"
            title="마이페이지"
            onclick="location.href='${pageContext.request.contextPath}/admin/main';"></i>
      </c:when>
   
      <c:otherwise>
         <i class="fa-regular fa-user"
            title="마이페이지"
            onclick="location.href='${pageContext.request.contextPath}/member/login';"></i>
      </c:otherwise>
         </c:choose>
      
            
            <i class="fa-solid fa-right-from-bracket" title="로그아웃" onclick="location.href='${pageContext.request.contextPath}/member/logout';"></i>
            
        </div>
    </div>
</div>

<!-- 2. 상단 네비게이션 & 드롭다운 -->
<div class="header_bottom">
	<div class="container">
		<nav class="main-nav">
			<div class="nav-container">
				<ul class="nav-menu" onclick="return false;">
					<li><a href="${pageContext.request.contextPath}/community/boardList" class="active">커뮤니티</a></li>
					<li><a href="${pageContext.request.contextPath}/community/stadium_info">경기장 정보</a></li>
					<li><a href="#">경기 일정</a></li>
					<li><a href="#">구단 정보</a></li>
				</ul>

				<!-- 드롭다운 슬라이드 패널 -->
				<div class="dropdown-panel">
					<div class="dropdown-column">
						<a href="${pageContext.request.contextPath}/community/notify/noticeList">공지사항</a> 
						<a href="${pageContext.request.contextPath}/community/board/boardList">자유게시판</a> 
						<a href="${pageContext.request.contextPath}/community/qna/qnaList">문의/신고</a>
					</div>
					<div class="dropdown-column">
						<a href="${pageContext.request.contextPath}/stadium/stadiumInfo">경기장 정보 검색</a>
					</div>
					<div class="dropdown-column">
						<a href="${pageContext.request.contextPath}/clubmatch/clubCalendar">캘린더</a> 
						<a href="${pageContext.request.contextPath}/clubmatch/clubMatchRank">최근 기록</a> 
						<a href="${pageContext.request.contextPath}/clubmatch/matchInfo">구단 검색 (연도별 / 구단별)</a>
					</div>
					<div class="dropdown-column">
						<a href="${pageContext.request.contextPath}/clubinfoply/clubList">구단 정보</a> 
						<a href="${pageContext.request.contextPath}/clubinfoply/playerInfo">소속 선수들의 정보</a> 
						<a href="${pageContext.request.contextPath}/clubinfoply/playerList">선수 정보</a>
					</div>
				</div>
			</div>
		</nav>

		<!-- 필터 태그 바 -->
		<div class="tag-bar">
			<button class="tag-btn" onclick="location.href='${pageContext.request.contextPath}/player/mypage';">
				<i class="bi bi-person me-1"></i>내 프로필
			</button>
			<button class="tag-btn">
				<i class="bi bi-trophy me-1"></i>경기정보
			</button>
			<button class="tag-btn" onclick="location.href='${pageContext.request.contextPath}/clubowner/ownerpage';">
				<i class="bi bi-shield me-1"></i>내 구단정보
			</button>
			<button class="tag-btn">
				<i class="bi bi-calendar-check me-1"></i>경기 신청
			</button>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/layout/loginModal.jsp" />