<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<script>
const contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/dist/js/match/match.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/match/matchBoardList.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/match/matchHistory.js"></script>
<script src="${pageContext.request.contextPath}/dist/js/match/requestResult.js"></script>


<div class="tab-pane fade"
     id="match-apply"
     role="tabpanel">

    <div class="card border-0 shadow-sm rounded-4 p-4">

        <!-- =========================
             경기 매칭 전용 탭
             ========================= -->

        <ul class="nav nav-pills nav-fill gap-2 mb-4"
            id="matchSubTab"
            role="tablist">

            <li class="nav-item">

                <button
                    class="nav-link active"
                    data-bs-toggle="pill"
                    data-bs-target="#match-create-pane"
                    type="button">

                    📅 경기 매칭 개설

                </button>

            </li>


            <li class="nav-item">

                <button
                    class="nav-link"
                    data-bs-toggle="pill"
                    data-bs-target="#match-board-pane"
                    type="button">

                    🏃 참가 선수 모집 게시판

                </button>

            </li>


            <li class="nav-item">

                <button
                    class="nav-link"
                    data-bs-toggle="pill"
                    data-bs-target="#match-history-pane"
                    type="button">

                    📋 경기 신청 이력

                </button>

            </li>

        </ul>


        <!-- =========================
             하위 탭 내용
             ========================= -->

        <div class="tab-content">


            <!-- ① 경기 매칭 개설 -->

            <div
                class="tab-pane fade show active"
                id="match-create-pane"
                role="tabpanel">

                <jsp:include
                    page="/WEB-INF/views/match/fragment/owner/matchCreate.jsp" />

            </div>


            <!-- ② 모집 게시판 -->

            <div
                class="tab-pane fade"
                id="match-board-pane"
                role="tabpanel">

                <jsp:include
                    page="/WEB-INF/views/match/fragment/board/matchBoardList.jsp" />

            </div>


            <!-- ③ 경기 신청 이력 -->

            <div
                class="tab-pane fade"
                id="match-history-pane"
                role="tabpanel">

                <jsp:include
                    page="/WEB-INF/views/match/fragment/owner/matchHistory.jsp" />

            </div>

        </div>

    </div>


    <!-- 게시글 상세 모달 -->
    <jsp:include
        page="/WEB-INF/views/match/fragment/board/matchBoardDetail.jsp" />

</div>