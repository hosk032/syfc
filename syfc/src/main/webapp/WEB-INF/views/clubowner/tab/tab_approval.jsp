<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="tab-pane fade" id="player-approval" role="tabpanel">
    <div class="card border-0 shadow-sm rounded-4 p-4">
        <div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom">
            <div>
                <h5 class="fw-bold mb-1">입단 신청 관리</h5>
                <p class="text-muted small mb-0">우리 구단에 가입 신청한 선수들의 프로필을 확인하고 승인/거절합니다.</p>
            </div>
            <span class="text-muted small">
                대기 중: <strong class="text-danger fs-6" id="approvalPendingCount">${pendingCount}</strong>건
            </span>
        </div>
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light extra-small text-muted text-center">
                    <tr><th class="text-start ps-3">신청자</th><th>포지션</th><th>신청일자</th><th>자기소개</th><th class="text-end pe-3">관리</th></tr>
                </thead>
                <tbody class="small text-center" id="approvalListBody">
                    <c:forEach var="dto" items="${approvalList}">
                        <tr id="approval-row-${dto.applyNum}">
                            <td class="text-start ps-3 fw-bold text-dark">${dto.userName} (${dto.userAge}세)</td>
                            <td><span class="badge bg-primary-subtle text-primary border">${dto.position}</span></td>
                            <td class="text-muted">${dto.applyDate}</td>
                            <td class="text-start text-muted text-truncate" data-bs-toggle="tooltip" title="${dto.memo}">${dto.memo}</td>
                            <td class="text-end pe-3">
                                <button class="btn btn-sm btn-primary px-3 py-1 me-1" onclick="approvePlayerProcess('${dto.applyNum}', '${dto.userName}')">승인</button>
                                <button class="btn btn-sm btn-outline-danger px-3 py-1" onclick="openRejectModal('${dto.applyNum}', '${dto.userName}')">거절</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>