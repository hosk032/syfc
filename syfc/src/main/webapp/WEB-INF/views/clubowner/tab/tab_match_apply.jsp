<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<script> const contextPath = "${pageContext.request.contextPath}"; </script>
<!-- 경기 매칭 시스템 전용 JS -->
<script src="${pageContext.request.contextPath}/dist/js/match/matchApplyTab.js"></script>

<div class="tab-pane" id="match-apply" role="tabpanel">
    <div class="card border-0 shadow-sm rounded-4 p-4">

        <!-- 경기 매칭 하위 탭 메뉴 -->
        <ul class="nav nav-pills nav-fill gap-2 mb-4" id="matchSubTab">

            <li class="nav-item">
                <button type="button" class="nav-link active" data-match-tab="create">
                    📅 경기 매칭 개설
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
            <!-- ① 경기 매칭 개설 -->
            <div id="match-create-pane" class="match-sub-pane">
                <jsp:include page="/WEB-INF/views/match/fragment/owner/matchCreate.jsp" />
            </div>

            <!-- ② 참가 선수 모집 게시판 -->
            <div id="match-board-pane" class="match-sub-pane" style="display:none;">
                <jsp:include page="/WEB-INF/views/match/fragment/board/matchBoardList.jsp" />
            </div>

            <!-- ③ 경기 신청 이력 -->
            <div id="match-history-pane" class="match-sub-pane" style="display:none;">
                <jsp:include page="/WEB-INF/views/match/fragment/owner/matchHistory.jsp" />
            </div>
        </div>

    </div>

    <!-- 게시글 상세 모달 -->
    <jsp:include page="/WEB-INF/views/match/fragment/board/matchBoardDetail.jsp" />

</div>