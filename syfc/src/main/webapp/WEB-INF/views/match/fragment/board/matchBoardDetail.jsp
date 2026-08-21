<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>


<!-- 상세모달 내부 fragement -->
<div class="modal fade"
     id="matchBoardDetailModal"
     tabindex="-1"
     aria-hidden="true">

    <div class="modal-dialog modal-lg modal-dialog-centered">

        <div class="modal-content border-0 rounded-4 shadow">

            <div class="modal-header">
                <h5 class="modal-title fw-bold" id="detailSubject">
                    경기 참가 선수 모집
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <!-- 경기 정보 -->
                <div class="card bg-light border-0 rounded-3 p-3 mb-4">
                    <h6 class="fw-bold text-primary mb-3">
                        <i class="bi bi-info-circle me-1"></i>
                        경기 정보
                    </h6>

                    <div class="row g-2 small">
                        <div class="col-md-6">
                            📅 경기일
                            <strong id="detailDate"></strong>
                        </div>

                        <div class="col-md-6">
                            🕐 시간
                            <strong id="detailTime"></strong>
                        </div>

                        <div class="col-md-6">
                            📍 경기장
                            <strong id="detailStadium"></strong>
                        </div>

                        <div class="col-md-6">
                            📌 지역
                            <strong id="detailRegion"></strong>
                        </div>

                        <div class="col-md-6">
                            ⚽ 경기 종류
                            <strong id="detailType"></strong>
                        </div>

                        <div class="col-md-6">
                            ⚔️ 상대팀
                            <strong id="detailOpponent"></strong>
                        </div>
                    </div>

                </div>


                <!-- 지도 -->
                <div class="mb-4">
                    <h6 class="fw-bold mb-2">
                        경기장 위치
                    </h6>
                    <div id="matchMap"
                         style="width:100%; height:300px;
                                border-radius:12px;
                                background:#f1f3f5;">

                    </div>

                </div>


                <!-- 게시글 내용 -->
                <div class="mb-4">

                    <h6 class="fw-bold mb-2">
                        모집글 내용
                    </h6>

                    <div id="detailContent"
                         class="border rounded-3 p-3"
                         style="white-space:pre-wrap;">
                    </div>

                </div>


                <hr>


                <!-- 신청자 수 -->

                <div class="d-flex justify-content-between
                            align-items-center mb-2">

                    <h6 class="fw-bold mb-0">
                        참가 신청 선수
                    </h6>

                    <span id="applicantCount"
                          class="badge bg-primary">
                        0/0
                    </span>

                </div>


                <!-- 신청자 목록 -->

                <div id="applicantList">

                </div>


            </div>


            <!-- FOOTER -->

            <div class="modal-footer">

                <!-- 선수 버튼 -->

                <div id="playerActionArea"
                     class="me-auto">

                    <button type="button"
                            id="playerApplyBtn"
                            class="btn btn-primary"
                            onclick="applyMatchPlayer()">

                        참가신청

                    </button>


                    <button type="button"
                            id="playerCancelBtn"
                            class="btn btn-danger d-none"
                            onclick="cancelMatchPlayer()">

                        신청취소

                    </button>

                </div>


                <!-- 구단주 버튼 -->

                <div id="ownerActionArea"
                     class="me-auto d-none">

                    <button type="button"
                            class="btn btn-danger"
                            onclick="cancelMatchOwner()">

                        매칭 취소

                    </button>

                </div>


                <button type="button"
                        class="btn btn-secondary"
                        data-bs-dismiss="modal">

                    닫기

                </button>

            </div>

        </div>

    </div>

</div>