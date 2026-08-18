<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>


<div class="card border-0 shadow-sm rounded-4 p-4">

    <div class="d-flex
                justify-content-between
                align-items-center
                mb-4">

        <div>

            <h5 class="fw-bold mb-1">
                우리 구단 경기신청 이력
            </h5>

            <p class="text-muted small mb-0">
                우리 구단이 신청한 홈·원정 경기의
                매칭 진행상황을 확인할 수 있습니다.
            </p>

        </div>


        <button
            type="button"
            class="btn btn-outline-primary btn-sm"
            onclick="loadMyMatchApply()">

            <i class="bi bi-arrow-clockwise"></i>
            새로고침

        </button>

    </div>


    <div id="matchHistoryList">

        <div class="text-center
                    text-muted
                    py-5">

            경기신청 이력을 불러오는 중입니다.

        </div>

    </div>

</div>

