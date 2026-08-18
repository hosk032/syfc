function loadMyParticipation() {

    const container = document.getElementById("participationList");

    if (!container) {
        return;
    }

    container.innerHTML = `
        <div class="text-center py-5 text-muted">
            <div class="spinner-border spinner-border-sm me-2"></div>
            불러오는 중입니다.
        </div>
    `;

    $.ajax({
        url: `${contextPath}/match/myParticipation`,
        type: "GET",
        dataType: "json",

        success: function(res) {
            if (!res.success) {
                container.innerHTML = `
                    <div class="alert alert-warning">
                        ${escapeHtml(res.message)}
                    </div>
                `;

                return;
            }

            const list = res.list;

            if (!list || list.length === 0) {
                container.innerHTML = `
                    <div class="text-center text-muted py-5">
                        아직 출전신청한 경기가 없습니다.
                    </div>
                `;
                return;
            }

            let html = "";

            list.forEach(function(dto) {

                let requestStateText = "";
                let requestStateClass = "";

                switch (dto.request_state) {
                    case 2:
                        requestStateText = "대기";
                        requestStateClass =
                            "bg-warning text-dark";
                        break;
                    case 1:
                        requestStateText = "승인";
                        requestStateClass =
                            "bg-success";
                        break;
                    case 0:
                        requestStateText = "반려";
                        requestStateClass =
                            "bg-danger";
                        break;
                    case -1:
                        requestStateText = "취소";
                        requestStateClass =
                            "bg-secondary";
                        break;
                }

                let timeText = "";

                if (dto.apply_time === 1) {
                    timeText = "오전";
                } else if (dto.apply_time === 2) {
                    timeText = "오후";
                }

                let matchStatusText = "";

                switch (dto.status) {
                    case 3:
                        matchStatusText = "매칭 대기";
                        break;
                    case 2:
                        matchStatusText = "상대팀 신청";
                        break;
                    case 1:
                        matchStatusText = "매칭 완료";
                        break;
                    case 0:
                        matchStatusText = "취소";
                        break;
                    case 4:
                        matchStatusText = "경기장 사정으로 반려";
                        break;
                    case 5:
                        matchStatusText = "매칭 실패";
                        break;
                    case 6:
                        matchStatusText = "상대팀 거절";
                        break;

                    default:
                        matchStatusText = "알 수 없음";
                }

                let opponentText = dto.away_clubName || "상대팀 매칭 대기 중";

                let cancelHtml = "";

                // 선수 본인 취소
                if (dto.request_state === -1 && dto.request_cancel) {

                    cancelHtml += `
                        <div class="alert alert-secondary small mt-3 mb-0">
                            <div class="fw-bold mb-1">
                                출전신청 취소사유
                            </div>

                            <div>
                                ${escapeHtml(dto.request_cancel)}
                            </div>
                        </div>`;
                }

                // 경기 자체 취소
                if (dto.status === 0 && dto.cancel_reason) {

                    cancelHtml += `
                        <div class="alert alert-danger small mt-3 mb-0">
                            <div class="fw-bold mb-1">
                                경기 취소사유
                            </div>

                            <div>
                                ${escapeHtml(dto.cancel_reason)}
                            </div>
                        </div>`;
                }

                html += `
                    <div class="card border rounded-4 p-3 mb-3">

                        <div class="d-flex justify-content-between
                                    align-items-center mb-3">

                            <div>
                                <h6 class="fw-bold mb-1">
                                    ${escapeHtml(dto.cmb_subject || "-")}
                                </h6>

                                <span class="text-muted small">
                                    ${dto.apply_date || "-"}
                                    ·
                                    ${timeText || "-"}
                                </span>

                            </div>

                            <span class="badge ${requestStateClass}">
                                ${requestStateText}
                            </span>

                        </div>

                        <div class="bg-light rounded-3 p-3">

                            <div class="row g-2 small">

                                <div class="col-md-6">

                                    <span class="text-muted">
                                        경기장
                                    </span>

                                    <div class="fw-bold">
                                        ${escapeHtml(dto.stadium_name || "-")}
                                    </div>

                                </div>

                                <div class="col-md-6">

                                    <span class="text-muted">
                                        경기종류
                                    </span>

                                    <div class="fw-bold">
                                        ${escapeHtml(dto.match_type1 || "-")}
                                        /
                                        ${escapeHtml(dto.match_type2 || "-")}
                                    </div>

                                </div>

                                <div class="col-md-6">
                                    <span class="text-muted">
                                        홈팀
                                    </span>

                                    <div class="fw-bold">
                                        ${escapeHtml(dto.home_club_name || "-")}
                                    </div>

                                </div>

                                <div class="col-md-6">

                                    <span class="text-muted">
                                        원정팀
                                    </span>

                                    <div class="fw-bold">
                                        ${escapeHtml(dto.away_club_name || "-")}
                                    </div>

                                </div>

                                <div class="col-md-6">

                                    <span class="text-muted">
                                        경기상태
                                    </span>

                                    <div class="fw-bold">
                                        ${matchStatusText}
                                    </div>
                                </div>

                            </div>
							
                        </div>

                        ${cancelHtml}

                    </div>`;

            });

            container.innerHTML = html;
        },

        error: function(xhr) {

            console.error( "loadMyParticipation error:", xhr);

            container.innerHTML = `
                <div class="alert alert-danger">
                    출전신청 이력을 불러오지 못했습니다.
                </div>`;
        }
    });
}

/* HTML 출력 시 XSS 방지 */
function escapeHtml(value) {

    if (value === null ||
        value === undefined) {
        return "";
    }

    return String(value)
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}
