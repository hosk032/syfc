// 3번탭 우리 구단 홈/원정 경기신청 이력

function loadMyMatchApply() {

    const container = document.getElementById("matchHistoryList");

    if(!container) {
        return;
    }

    container.innerHTML = `
        <div class="text-center text-muted py-5">
            <div class="spinner-border spinner-border-sm me-2">
            </div>
            경기신청 이력을 불러오는 중입니다.
        </div>`;

    $.ajax({
        url: `${contextPath}/match2/myMatchApply`,
        type: "GET",
        dataType: "json",

        success: function(res) {
			console.log("===== myMatchApply 응답 =====");
			console.log(res);
			console.log("isOwner:", res.isOwner);
			console.log("list:", res.list);
			console.log("list length:", res.list ? res.list.length : null);

            if(!res.success) {
                container.innerHTML = `
                    <div class="alert alert-warning">
                        ${escapeHtml(res.message)}
                    </div>
                `;
                return;
            }

            const list = res.list;

            if(!list || list.length === 0) {

                container.innerHTML = `
                    <div class="text-center text-muted py-5">
                        아직 경기신청 이력이 없습니다.
                    </div>
                `;
                return;
            }

            let html = "";

            list.forEach(function(dto) {

                // 홈 / 원정
                let teamTypeText = "";
                let teamTypeClass = "";

                if(dto.my_team_type === "HOME") {
                    teamTypeText = "홈팀";
                    teamTypeClass = "bg-primary";

                } else {
                    teamTypeText = "원정팀";
                    teamTypeClass = "bg-info";
                }

                // 오전 / 오후
                let timeText = "";

                if(dto.apply_time === 1) {
                    timeText = "오전";
                } else if(dto.apply_time === 2) {
                    timeText = "오후";
                }
				
                // 매칭 상태
                let statusText = "";
                let statusClass = "";

                switch(dto.status) {
                    case 3:
                        statusText = "매칭 대기";
                        statusClass = "bg-warning text-dark";
                        break;
                    case 2:
                        statusText = "상대팀 신청";
                        statusClass = "bg-info";
                        break;
                    case 1:
                        statusText = "매칭 완료";
                        statusClass = "bg-success";
                        break;

                    case 0:
                        statusText = "취소";
                        statusClass = "bg-secondary";
                        break;

                    case 4:
                        statusText = "경기장 사정으로 반려";
                        statusClass = "bg-danger";
                        break;
                    case 5:
                        statusText = "매칭 실패";
                        statusClass = "bg-danger";
                        break;

                    case 6:
                        statusText =  "상대팀 거절";
                        statusClass =  "bg-danger";
                        break;

                    default:
                        statusText = "알 수 없음";
                        statusClass = "bg-secondary";
                }

                // 상대팀
                let opponentHtml = "";

                if(dto.opponent_club_name) {
                    opponentHtml = `<span class="fw-bold">
                            ${escapeHtml(dto.opponent_club_name)}
                        </span>`;

                } else {
                    opponentHtml = `<span class="text-muted">
                            아직 상대팀이 없습니다. </span>`;
                }


                // 홈팀이고 상대팀이 존재하면서 아직 매칭 완료가 아니라면
                // 수락 / 거절 버튼 표시
                let opponentButtonHtml = "";

				const isOwner = res.isOwner === true;

				if(isOwner && dto.my_team_type === "HOME") {

				    if(dto.status === 2 && dto.opponent_clubOwner_key != null) {

				        opponentButtonHtml = `
				            <div class="mt-3 pt-3 border-top">
				                <div class="d-flex justify-content-end gap-2">

				                    <button type="button"
				                        class="btn btn-primary btn-sm px-3"
				                        onclick="acceptOpponent(${dto.apply_id})">
				                        수락
				                    </button>

				                    <button type="button"
				                        class="btn btn-outline-danger btn-sm px-3"
				                        onclick="rejectOpponent(${dto.apply_id})">
				                        거절
				                    </button>

				                    <button type="button"
				                        class="btn btn-outline-secondary btn-sm px-3"
				                        onclick="cancelMatch(${dto.apply_id})">
				                        매칭 취소
				                    </button>

				                </div>
				            </div>`;

				    } else if(dto.status === 3) {

				        opponentButtonHtml = `
				            <div class="mt-3 pt-3 border-top text-end">
				                <button type="button"
				                    class="btn btn-outline-secondary btn-sm px-3"
				                    onclick="cancelMatch(${dto.apply_id})">
				                    매칭 취소
				                </button>
				            </div>`;
				    }
				}
				
				//취소버튼
				let cancelButtonHtml = "";

				if(isOwner &&
				   dto.my_team_type === "HOME" &&
				   (dto.status === 2 || dto.status === 3)) {

				    cancelButtonHtml = `
				        <button type="button"
				            class="btn btn-outline-secondary btn-sm px-3"
				            onclick="cancelMatch(${dto.apply_id})">
				            매칭 취소
				        </button>`;
				}

                // 취소사유
                let cancelReasonHtml = "";

                if(dto.status === 0 && dto.cancel_reason) {

                    cancelReasonHtml = `
                        <div class="alert alert-danger small mt-3 mb-0">
                            <div class="fw-bold mb-1">
                                경기 취소사유
                            </div>

                            <div>
                                ${escapeHtml(dto.cancel_reason)}
                            </div>
                        </div>`;
                }

                // 카드
                html += `
                    <div class="card border rounded-4 p-3 mb-3 shadow-sm">

                        <!-- 상단 -->
                        <div class="d-flex justify-content-between
                                    align-items-center mb-3">

                            <div>
                                <div class="mb-1">
                                    <span class="badge ${teamTypeClass} me-2">
                                        ${teamTypeText}
                                    </span>

                                    <span class="badge ${statusClass}">
                                        ${statusText}
                                    </span>
                                </div>

                                <h6 class="fw-bold mb-0">
                                    ${dto.apply_date || "-"}
                                    ·
                                    ${timeText}
                                </h6>

                            </div>

                            <span class="text-muted small">
                                신청번호: ${dto.apply_id}
                            </span>

                        </div>


                        <!-- 경기 정보 -->
                        <div class="bg-light rounded-3 p-3">

                            <div class="row g-2 small">

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
                                        경기장
                                    </span>

                                    <div class="fw-bold">
                                        ${escapeHtml(dto.stadium_name || "-")}
                                    </div>

                                </div>

                                <div class="col-md-6">

                                    <span class="text-muted">
                                        경기시간
                                    </span>

                                    <div class="fw-bold">
                                        ${timeText || "-"}
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
                                        상대팀
                                    </span>

                                    <div>
                                        ${opponentHtml}
                                    </div>

                                </div>

                            </div>

                        </div>

                        ${cancelReasonHtml}
                        ${opponentButtonHtml}
						${cancelButtonHtml}

                    </div>`;
            });

            container.innerHTML = html;
        },

        error: function(xhr, status, error) {
            console.error(
                "myMatchApply error:",
                error
            );

            container.innerHTML = `
                <div class="alert alert-danger">
                    경기신청 이력을 불러오지 못했습니다.
                </div>`;
        }
    });
}

function acceptOpponent(applyId) {

    if (!applyId) {
        alert("경기 신청번호가 없습니다.");
        return;
    }

    if (!confirm(
        "이 상대팀의 신청을 수락하시겠습니까?\n" +
        "수락하면 다른 상대팀 신청은 자동으로 거절됩니다."
    )) {
        return;
    }

    $.ajax({
        url: contextPath + "/match2/acceptOpponent",
        type: "POST",
        data: {
            apply_id: applyId
        },

        dataType: "json",

        success: function(res) {
            if (res.success) {
                alert(res.message);

                // DB 변경 후 경기신청 이력을 다시 조회
                loadMyMatchApply();

            } else {
                alert(res.message);
            }
        },

        error: function(xhr) {

            console.error("acceptOpponent error:", xhr);

            alert("상대팀 수락 중 오류가 발생했습니다.");
        }
    });
}

function rejectOpponent(applyId) {

    if (!applyId) {
        alert("경기 신청번호가 없습니다.");
        return;
    }

    if (!confirm(
        "이 상대팀의 신청을 거절하시겠습니까?"
    )) {
        return;
    }

    $.ajax({
        url: contextPath + "/match2/rejectOpponent",
        type: "POST",
        data: {
            apply_id: applyId
        },
        dataType: "json",

        success: function(res) {
            if (res.success) {
                alert(res.message);

                // 거절 후 다시 DB 조회
                loadMyMatchApply();

            } else {
                alert(res.message);
            }
        },

        error: function(xhr) {

            console.error("rejectOpponent error:", xhr);
            alert( "상대팀 거절 중 오류가 발생했습니다.");
        }
    });
}


$(document).on(
    "shown.bs.tab",
    '[data-bs-target="#match-history-pane"]',
    function() {

        loadMyMatchApply();

    }
);