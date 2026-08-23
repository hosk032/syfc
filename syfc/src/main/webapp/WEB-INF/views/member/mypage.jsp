<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>마이페이지 - 쌍용축구예약</title>
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/member/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/member/mypage.css" />
</head>
<body>

<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<main>
    <div class="member-page-container">

        <div class="profile-summary">
            <img src="${pageContext.request.contextPath}/dist/images/user.png"
                 class="profile-summary-image"
                 alt="프로필 이미지" />
            <div>
                <h2><strong>홍길동</strong> 님 환영합니다!</h2>
                <span class="member-level">구단주</span>
            </div>
        </div>

        <div class="mypage-layout">

            <aside class="mypage-sidebar">
                <div class="sidebar-title">마이페이지</div>

                <div class="sidebar-category">내 프로필</div>
                <a href="#" class="sidebar-link active">프로필 수정</a>
                <a href="#" class="sidebar-link">내 평점 조회</a>

                <div class="sidebar-category">경기정보</div>
                <a href="#" class="sidebar-link">내 경기 참가 이력</a>

                <div class="sidebar-category">내 구단정보</div>
                <a href="#" class="sidebar-link">내 구단팀 조회</a>
                <a href="#" class="sidebar-link">입단 신청/결과조회</a>
            </aside>

            <section class="mypage-content">
                <h2 class="section-title">프로필 수정</h2>
                <div>콘텐츠 영역 (프로필 수정 폼 등)</div>
            </section>

        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

<script src="${pageContext.request.contextPath}/dist/js/member/mypage.js"></script>
</body>
</html>
