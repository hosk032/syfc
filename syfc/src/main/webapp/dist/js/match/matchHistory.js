// 3번탭 우리 구단 홈/원정 경기신청 이력
if (typeof escapeHtml !== 'function') {
    window.escapeHtml = function(str) {
        if (!str) return '';
        return String(str)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#039;');
    };
}

// 경기이력 더보기용 (페이징)
let myMatchApplyList = [];
let myMatchApplyPage = 1;

const MY_MATCH_APPLY_PAGE_SIZE = 5;

function loadMyMatchApply() {

    const container = document.getElementById("matchHistoryList1");

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

            if(!res.success) {
                container.innerHTML = `
                    <div class="alert alert-warning">
                        ${escapeHtml(res.message)}
                    </div>
                `;
                return;
            }

            const list = res.list;
			
			// 선택된 status 가져오기
			const filterElement = document.getElementById("matchStatusFilter");
			const selectedStatus = filterElement? filterElement.value : "";

			// status 필터링
			const filteredList = selectedStatus === ""
			    ? list
			    : list.filter(function(dto) {
			        return Number(dto.status) === Number(selectedStatus);
			    });

			// 필터 결과가 없는 경우
			if(!filteredList || filteredList.length === 0) {

			    container.innerHTML = `
			        <div class="text-center text-muted py-5">
			            해당 상태의 경기신청 이력이 없습니다.
			        </div>
			    `;
			    return;
			}

            let html = "";

            filteredList.forEach(function(dto) {

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

function renderMoreMyMatchApply() {

    const container = document.getElementById("matchHistoryList1");
    const moreArea = document.getElementById("matchHistoryMoreArea");
    const moreBtn = document.getElementById("matchHistoryMoreBtn");

    if(!container || !moreArea || !moreBtn) {
        return;
    }

    // 현재 페이지까지 보여줄 개수
    const endIndex =
        myMatchApplyPage * MY_MATCH_APPLY_PAGE_SIZE;

    const visibleList =
        myMatchApplyList.slice(0, endIndex);

    let html = "";

    visibleList.forEach(function(dto) {

        // =========================
        // 홈 / 원정
        // =========================

        let teamTypeText = "";
        let teamTypeClass = "";

        if(dto.my_team_type === "HOME") {

            teamTypeText = "홈팀";
            teamTypeClass = "bg-primary";

        } else {

            teamTypeText = "원정팀";
            teamTypeClass = "bg-info";
        }


        // =========================
        // 오전 / 오후
        // =========================

        let timeText = "";

        if(dto.apply_time === 1) {

            timeText = "오전";

        } else if(dto.apply_time === 2) {

            timeText = "오후";
        }


        // =========================
        // 매칭 상태
        // =========================

        let statusText = "";
        let statusClass = "";

        switch(Number(dto.status)) {

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
                statusText = "상대팀 거절";
                statusClass = "bg-danger";
                break;

            default:
                statusText = "알 수 없음";
                statusClass = "bg-secondary";
        }


        // =========================
        // 상대팀
        // =========================

        let opponentHtml = "";

        if(dto.opponent_club_name) {

            opponentHtml = `
                <span class="fw-bold">
                    ${escapeHtml(dto.opponent_club_name)}
                </span>`;

        } else {

            opponentHtml = `
                <span class="text-muted">
                    아직 상대팀이 없습니다.
                </span>`;
        }


        // =========================
        // 홈팀 수락 / 거절 버튼
        // =========================

        let opponentButtonHtml = "";

        const isOwner = window.myMatchApplyIsOwner === true;

        if(isOwner && dto.my_team_type === "HOME") {

            if(Number(dto.status) === 2 &&
               dto.opponent_clubOwner_key != null) {

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

            } else if(Number(dto.status) === 3) {

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


        // =========================
        // 취소 사유
        // =========================

        let cancelReasonHtml = "";

        if(Number(dto.status) === 0 &&
           dto.cancel_reason) {

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


        // =========================
        // 카드
        // =========================

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
                                ${escapeHtml(
                                    dto.home_club_name || "-"
                                )}
                            </div>

                        </div>


                        <div class="col-md-6">

                            <span class="text-muted">
                                원정팀
                            </span>

                            <div class="fw-bold">
                                ${escapeHtml(
                                    dto.away_club_name || "-"
                                )}
                            </div>

                        </div>


                        <div class="col-md-6">

                            <span class="text-muted">
                                경기장
                            </span>

                            <div class="fw-bold">
                                ${escapeHtml(
                                    dto.stadium_name || "-"
                                )}
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

                                ${escapeHtml(
                                    dto.match_type1 || "-"
                                )}

                                /

                                ${escapeHtml(
                                    dto.match_type2 || "-"
                                )}

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

            </div>`;
    });


    container.innerHTML = html;


    // =========================
    // 더보기 버튼 처리
    // =========================

    if(visibleList.length < myMatchApplyList.length) {

        moreArea.classList.remove("d-none");
        moreBtn.disabled = false;
        moreBtn.textContent = "더보기";

    } else {

        moreArea.classList.add("d-none");
    }
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

// 1. [취소] 버튼 클릭 시 모달을 띄우는 함수
function cancelMatch(applyId) {
    if (!applyId) {
        alert("경기 신청번호가 없습니다.");
        return;
    }
    // 모달 안의 hidden input과 textarea 초기화
    $("#modalApplyId").val(applyId);
    $("#cancelReason").val("");

    // Bootstrap 모달 띄우기
    var myModal = new bootstrap.Modal(document.getElementById('cancelMatchModal'));
    myModal.show();
}

// 2. 모달 안에서 [취소 신청] 버튼을 누를 때 실행되는 AJAX 함수
function submitCancelMatch() {
    var applyId = $("#modalApplyId").val();
    var reason = $("#cancelReason").val().trim();

    // 유효성 검사
    if (!reason) {
        alert("취소 사유를 입력해 주세요.");
        $("#cancelReason").focus();
        return;
    }

    $.ajax({
        url: contextPath + "/match2/cancelMatch",
        type: "POST",
        data: { 
            apply_id: applyId,
            cancel_reason: reason // 컨트롤러로 취소 사유도 함께 전송
        },
        dataType: "json",
        success: function(res) {
            if (res.success) {
                alert(res.message);
                
                // 모달 닫기
                var cancelModal = bootstrap.Modal.getInstance(document.getElementById('cancelMatchModal'));
                cancelModal.hide();

                // 취소 후 목록 새로고침
                loadMyMatchApply();
            } else {
                alert(res.message);
            }
        },
        error: function(xhr) {
            console.error("cancelMatch error:", xhr);
            alert("매치 취소 중 오류가 발생했습니다.");
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

$(document).on("click", "#matchHistoryMoreBtn", function() {
    myMatchApplyPage++;
    renderMoreMyMatchApply();
});