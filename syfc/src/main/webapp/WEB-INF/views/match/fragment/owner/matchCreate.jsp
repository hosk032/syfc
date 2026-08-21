<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<div class="card border-0 shadow-sm rounded-4 p-4">

    <h5 class="fw-bold mb-3">

        <i class="bi bi-search text-primary me-2"></i>

        이용 가능한 경기장 검색

    </h5>


    <!-- ==========================
         날짜 / 지역 / 시간
         ========================== -->

    <div class="row g-3 p-3 bg-light rounded-3 mb-4">


        <!-- 날짜 -->

        <div class="col-md-3">

            <label class="form-label small fw-bold">
                경기 날짜
            </label>

            <input
                type="date"
                class="form-control"
                id="searchDate">

        </div>


        <!-- 지역 -->

        <div class="col-md-3">

            <label class="form-label small fw-bold">
                지역
            </label>

            <select
                class="form-select"
                id="searchRegion">

                <option value="">
                    지역을 선택하세요
                </option>

            </select>

        </div>


        <!-- 오전 / 오후 -->

        <div class="col-md-3">

            <label class="form-label small fw-bold">
                경기 시간
            </label>

            <select
                class="form-select"
                id="applyTime">

                <option value="">
                    시간을 선택하세요
                </option>

                <option value="1">
                    오전
                </option>

                <option value="2">
                    오후
                </option>

            </select>

        </div>


        <!-- 검색 -->

        <div class="col-md-3 d-flex align-items-end">

            <button
                type="button"
                class="btn btn-primary w-100 fw-bold"
                onclick="searchStadiums1()">

                <i class="bi bi-search me-1"></i>

                가능 경기장 조회

            </button>

        </div>

    </div>


    <!-- ==========================
         경기장 목록
         ========================== -->

    <h6 class="fw-bold mb-2">
    조회된 경기장
	</h6>

	<div
    	class="row g-3 mb-4"
    	id="stadiumListArea">

    	<div class="col-12 text-center text-muted py-4">

        날짜와 지역과 시간을 선택한 후
        <strong>가능 경기장 조회</strong>를 눌러주세요.

    	</div>

	</div>
        
      <hr class="my-4">

		<h5 class="fw-bold mb-3">
		    <i class="bi bi-calendar-event text-primary me-2"></i>
		    기존 매칭에 원정팀으로 참가
		</h5>
		
		<p class="text-muted small mb-3">
		    다른 구단이 개설하고 매칭을 기다리고 있는 경기를 확인할 수 있습니다.
		</p>
		
		<div id="waitingMatchList">

    		<div class="text-center text-muted py-4">

        	검색 조건을 선택하고
        	<strong>가능 경기장 조회</strong>를 눌러주세요.

    		</div>

		</div>

    </div>


    <!-- ==========================
         경기 종류
         ========================== -->

    <div class="row g-3 mb-4">


        <div class="col-md-6">

            <label class="form-label small fw-bold">
                경기 종류
            </label>

            <select
                class="form-select"
                id="matchTypeMain">

                <option value="11">
                    11vs11 정규 축구
                </option>

                <option value="6">
                    6vs6 풋살
                </option>

            </select>

        </div>


        <div class="col-md-6">

            <label class="form-label small fw-bold">
                성별 / 유형
            </label>

            <select
                class="form-select"
                id="matchTypeSub">

                <option value="남성">
                    남성 매치
                </option>

                <option value="여성">
                    여성 매치
                </option>

                <option value="혼성">
                    혼성 매치
                </option>

            </select>

        </div>

    </div>


    <!-- 선택된 경기정보 -->

    <div
        id="selectedMatchInfo"
        class="alert alert-light border d-none">

        <div class="fw-bold mb-2">
            선택한 경기 정보
        </div>

        <div id="selectedMatchText"></div>

    </div>


    <div class="d-flex justify-content-end">

        <button
            type="button"
            class="btn btn-primary px-4 fw-bold"
            onclick="openWriteModal()">

            <i class="bi bi-pencil-square me-1"></i>

            모집글 작성

        </button>

    </div>

</div>


<!-- ==========================
     모집글 작성 모달
     ========================== -->

<div
    class="modal fade"
    id="writeModal"
    tabindex="-1">

    <div class="modal-dialog modal-dialog-centered">

        <div class="modal-content border-0 rounded-4 shadow">


            <div class="modal-header">

                <h6 class="fw-bold mb-0">
                    경기 참가 선수 모집글 작성
                </h6>

                <button
                    type="button"
                    class="btn-close"
                    data-bs-dismiss="modal">
                </button>

            </div>


            <div class="modal-body">


                <!-- 선택 경기 정보 -->

                <div
                    class="alert alert-light border small"
                    id="writeMatchSummary">

                    경기 정보를 먼저 선택해주세요.

                </div>


                <!-- 제목 -->

                <div class="mb-3">

                    <label class="form-label fw-bold">
                        제목
                    </label>

                    <input
                        type="text"
                        class="form-control"
                        id="postTitle"
                        maxlength="100"
                        placeholder="모집글 제목을 입력하세요.">

                </div>


                <!-- 내용 -->

                <div class="mb-3">

                    <label class="form-label fw-bold">
                        내용
                    </label>

                    <textarea
                        class="form-control"
                        id="postContent"
                        rows="6"
                        maxlength="4000"
                        placeholder="선수들에게 전달할 내용을 입력하세요."></textarea>

                </div>

            </div>


            <div class="modal-footer">

                <button
                    type="button"
                    class="btn btn-light border"
                    data-bs-dismiss="modal">

                    취소

                </button>


                <button
                    type="button"
                    class="btn btn-primary fw-bold"
                    onclick="submitMatchPost1()">

                    모집글 등록

                </button>

            </div>

        </div>

    </div>

</div>
