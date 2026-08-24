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
                매칭 진행상황을 확인할 수 있습니다. <br> 최근 100개의 결과까지 표시됩니다.
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
    
    <div class="d-flex justify-content-end mb-3">
    <select id="matchStatusFilter"
            class="form-select"
            style="width: 180px;"
            onchange="loadMyMatchApply()">

        <option value="">전체</option>
        <option value="6">상대팀 거절</option>
        <option value="5">매칭 실패</option>
        <option value="4">경기장 사정으로 반려</option>
        <option value="3">매칭 대기</option>
        <option value="2">상대팀 신청</option>
        <option value="1">매칭 완료</option>
        <option value="0">취소</option>

    </select>
	</div>


    <div id="matchHistoryList1">

        <div class="text-center
                    text-muted
                    py-5">

            경기신청 이력을 불러오는 중입니다.

        </div>

    </div>
    <div id="matchHistoryMoreArea"
     class="text-center mt-3 d-none">

    <button type="button"
            id="matchHistoryMoreBtn"
            class="btn btn-outline-primary px-4">
        더보기
    </button>

	</div>
    

</div>
<!-- 매치 취소 모달 -->
<div class="modal fade" id="cancelMatchModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">매치 취소 사유 입력</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <!-- 다음 AJAX 요청을 위해 applyId를 숨겨두는 공간 -->
        <input type="hidden" id="modalApplyId" value="">
        
        <p>매치를 취소하시는 사유를 입력해 주세요.</p>
        <textarea id="cancelReason" class="form-control" rows="3" placeholder="취소 사유를 입력하세요. (필수)"></textarea>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-danger" onclick="submitCancelMatch()">취소 신청</button>
      </div>
    </div>
  </div>
</div>

