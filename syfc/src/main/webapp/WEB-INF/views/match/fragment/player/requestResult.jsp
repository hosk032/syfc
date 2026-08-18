<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>


<div class="card border-0 shadow-sm rounded-4 p-4">

   <div class="d-flex justify-content-between align-items-center mb-4">

      <div>
         <h5 class="fw-bold mb-1">
            나의 출전신청 이력
         </h5>

         <p class="text-muted small mb-0">
            내가 신청한 경기의 출전신청 상태를 확인할 수 있습니다.
         </p>
      </div>

      <button
         type="button"
         class="btn btn-outline-primary btn-sm"
         onclick="loadMyParticipation()">

         <i class="bi bi-arrow-clockwise"></i>
         새로고침

      </button>

   </div>


   <div id="participationList">

      <div class="text-center text-muted py-5">
         출전신청 이력을 불러오는 중입니다.
      </div>

   </div>

</div>