<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<script src="${pageContext.request.contextPath}/dist/js/match/matchBoardList.js"></script>
<div class="card border-0 shadow-sm rounded-4 p-4">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <div>
            <h5 class="fw-bold mb-1">
                경기 참가 선수 모집 게시판
            </h5>

            <p class="text-muted small mb-0">
                경기 참가를 원하는 선수는 게시글을 확인하고 참가 신청할 수 있습니다.
            </p>
        </div>

        <button type="button"
                class="btn btn-primary btn-sm"
                onclick="loadMatchBoardList()">

            <i class="bi bi-arrow-clockwise"></i>
            새로고침

        </button>

    </div>


    <!-- 게시판 목록 -->

    <div id="matchBoardListArea">

        <div class="text-center text-muted py-5">
            게시글을 불러오는 중입니다.
        </div>

    </div>

</div>