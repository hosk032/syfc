<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>쌍용축구예약 - 게시글 상세</title>

    <!-- 1. 공통 CSS/CDN/폰트 리소스 조립 -->
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

    <!-- 2. 게시판 전용 CSS 연결 (dist/css/community/ 하위 경로 적용) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/community/boardList.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/community/boardDetail.css" />
</head>
<body>

    <!-- 상단 헤더/네비게이션 조립 -->
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />

    <div class="board-container my-4">
        <!-- 왼쪽 서브 메뉴 (사이드바) -->
        <aside class="community-side-menu">
            <div class="side-menu-title">커뮤니티</div>
            <a href="${pageContext.request.contextPath}/community/noticeList">공지사항</a>
            <a href="${pageContext.request.contextPath}/community/boardList" class="active">게시판</a>
            <a href="${pageContext.request.contextPath}/community/qnaList">문의/신고 게시판</a>
        </aside>

        <!-- 오른쪽 상세 본문 영역 -->
        <section class="board-detail-area">
            <div class="detail-top">
                <h3>게시판</h3>
                <a href="${pageContext.request.contextPath}/community/boardList" class="list-btn">목록</a>
            </div>

            <div class="detail-box">
                <div class="detail-title">
                    <h4>축구장 예약 이용 안내</h4>
                    <span>공지</span>
                </div>

                <div class="detail-info">
                    <span>작성자 관리자</span>
                    <span>작성일 2026-08-04</span>
                    <span>조회수 80</span>
                </div>

                <div class="detail-content">
                    <p>축구장 예약 이용 방법을 안내드립니다.</p>
                    <p>원하는 경기장을 선택한 뒤 날짜와 시간을 확인하고 예약 신청을 진행해주세요.</p>
                    <p>예약 변경이나 취소가 필요한 경우 마이페이지에서 신청 내역을 확인할 수 있습니다.</p>
                </div>
            </div>
        </section>
    </div>

    <!-- 하단 푸터 조립 -->
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />

    <!-- 3. 게시글 상세 전용 JS 연결 (dist/js/community/boardDetail.js) -->
    <script src="${pageContext.request.contextPath}/dist/js/community/boardDetail.js"></script>
</body>
</html>