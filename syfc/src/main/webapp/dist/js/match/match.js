$(function() {
    loadRegions();
});
// 지역 목록 조회 GET /match/region

$(document).ready(function() {
  let today = new Date().toISOString().split('T')[0];
  $('#searchDate').attr('min', today);
});

function loadRegions() {

    $.ajax({
        url: contextPath + "/match/region",
        type: "GET",
        dataType: "json",

        success: function(data) {

            const select = $("#searchRegion");

            select.empty();

            select.append(
                '<option value="">지역을 선택하세요</option>'
            );

            if (data.success && data.list != null) {

                data.list.forEach(function(region) {

                    select.append(
                        `<option value="${region}">${region}</option>`
                    );

                });
            }
        },

        error: function(xhr) {

            console.log(xhr.responseText);

            alert("지역 목록을 불러오지 못했습니다.");
        }
    });
}


function searchStadiums1() {

    const applyDate = $("#searchDate").val();
    const region = $("#searchRegion").val();
    const applyTime = Number($("#applyTime").val());
    const matchType1 = $("#matchTypeMain").val();
    const matchType2 = $("#matchTypeSub").val();
	selectedStadium = null;

    if (!applyDate) {
        alert("경기 날짜를 선택해주세요.");
        return;
    }

    if (!region) {
        alert("지역을 선택해주세요.");
        return;
    }

    if (!applyTime) {
        alert("경기 시간을 선택해주세요.");
        return;
    }

    if (!matchType1) {
        alert("경기 방식을 선택해주세요.");
        return;
    }

    if (!matchType2) {
        alert("경기 유형을 선택해주세요.");
        return;
    }
		//이용가능한 경기장 조회
    $.ajax({

        url: contextPath + "/match/searchStadiums",
        type: "GET",
        data: {
            applyDate: applyDate,
            region: region,
            applyTime: applyTime
        },

        dataType: "json",
        success: function(data) {
            if (!data.success) {
                alert(
                    data.message ||
                    "경기장 조회에 실패했습니다."
                );

                return;
            }

            renderStadiumList(data.list);
        },

        error: function(xhr) {
            console.error(xhr);
            alert(
                "경기장 조회 중 오류가 발생했습니다."
            );
        }
    });

    // ② 같은 조건의 기존 대기매칭 조회
    loadWaitingMatches( applyDate, region, applyTime,
        matchType1, matchType2);
}

//경기장 카드 <div class="card stadium-card..." onclick="selectStadiumCard(...)">부분
function renderStadiumList(list) {
    const area = $("#stadiumListArea");
    area.empty();
    if (!list || list.length === 0) {
        area.html(`<div class="col-12">
                <div class="alert alert-secondary text-center">
                    선택하신 날짜와 지역에는 이용 가능한 경기장이 없습니다.
                </div>
            </div>`);
        return;
    }

    list.forEach(function(stadium) {
        const capacity = stadium.capacity != null ? stadium.capacity + "명" : "정보없음";
        const latitude = stadium.latitude != null ? stadium.latitude : "";
        const longitude = stadium.longitude != null ? stadium.longitude : "";
        const addr = stadium.addr1 != null ? stadium.addr1 : "주소 정보없음";
        const cost = stadium.stadium_cost != null
                ? Number(stadium.stadium_cost).toLocaleString() + "원"
                : "대관료 정보없음";

        // onclick을 지우고 모든 정보를 data- 속성에 안전하게 담습니다.
        area.append(`<div class="col-md-6">
                <div class="card stadium-card border p-3 rounded-3 shadow-sm bg-white cursor-pointer"
                     data-id="${stadium.stadium_id}"
                     data-name="${escapeHtml(stadium.stadium_name)}"
                     data-addr="${escapeHtml(addr)}"
                     data-cost="${cost}"
                     data-lat="${latitude}"
                     data-lng="${longitude}">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <h6 class="fw-bold mb-0 text-dark">
                            ${escapeHtml(stadium.stadium_name)}
                        </h6>
                        <span class="badge bg-success"> 예약가능 </span>
                    </div>

                    <p class="text-muted extra-small mb-1">${escapeHtml(addr)}</p>
                    <div class="text-primary fw-bold small">${cost}</div>
                    <div class="text-muted extra-small mt-1">수용인원: ${capacity}</div>
                </div>
            </div>`);
    });
}


function escapeHtml(value) {
    if (value == null) { return ""; }
    return String(value)
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}


//경기장 카드 선택해서 정보 서버에 저장
let selectedStadium = null;

// 동적으로 생성된 경기장 카드를 안전하게 클릭 처리하는 jQuery 리스너
$(document).on("click", ".stadium-card", function() {
    const $card = $(this);

    // 선택 효과 제어
    $(".stadium-card").removeClass("selected");
    $card.addClass("selected");

    // data 속성에서 값을 안전하게 꺼내 전역 변수에 할당
    selectedStadium = {
        stadium_id: $card.data("id"),
        stadium_name: $card.data("name"),
        address: $card.data("addr"),
        cost: $card.data("cost"),
        latitude: $card.data("lat"),
        longitude: $card.data("lng")
    };

    // 우측 UI 텍스트 갱신
    const applyDate = $("#searchDate").val();
    const applyTime = Number($("#applyTime").val()) === 1 ? "오전" : "오후";
    const matchType1 = $("#matchTypeMain").val();
    const matchType2 = $("#matchTypeSub").val();

    $("#selectedMatchText").html(`
        경기일: ${escapeHtml(applyDate)}<br>
        시간: ${escapeHtml(applyTime)}<br>
        경기장: ${escapeHtml(selectedStadium.stadium_name)}<br>
        경기종류: ${escapeHtml(matchType1)} / ${escapeHtml(matchType2)}
    `);

    $("#selectedMatchInfo").removeClass("d-none");
});



// 글 올리는 과정
//<button type="button" class="btn btn-primary btn-sm px-4 fw-bold"
//    onclick="submitMatchPost1()">모집글 등록하기</button> 에 연결
function submitMatchPost1() {
	if (window.matchPostSubmitting) {
	    return;
	}
	window.matchPostSubmitting = true;

    const cmb_Subject = $("#postTitle").val().trim();
    const cmb_Content = $("#postContent").val().trim();

    const applyDate = $("#searchDate").val();
    const applyTime = Number($("#applyTime").val());
    const matchType1 = $("#matchTypeMain").val();
    const matchType2 = $("#matchTypeSub").val();

    if (selectedStadium == null) { alert("경기장을 선택해주세요."); return; }

    const stadiumId = selectedStadium.stadium_id;

    if (!cmb_Subject) {alert( "모집글 제목을 입력해주세요.");
        $("#postTitle").focus(); return; }
    if (!applyDate) { alert("경기 날짜를 선택해주세요."); return; }
    if (!applyTime) { alert( "경기 시간을 선택해주세요." ); return; }
    if (!matchType1) { alert( "경기 방식을 선택해주세요." ); return; }
    if (!matchType2) { alert("경기 유형을 선택해주세요." ); return; }

    $.ajax({
		
        url: contextPath + "/match/createMatchPost",
        type: "POST",
        data: {
            cmb_Subject: cmb_Subject,
            cmb_Content: cmb_Content,
            apply_date: applyDate,
            apply_time: applyTime,
            stadium_id: stadiumId,
            match_type1: matchType1,
            match_type2: matchType2,
            stadium_fee: null //현재 결제 api 구현 안 함
        },

        dataType: "json",
		success: function(data) {
		    if (data.success) {
		        alert(data.message);
		        // 1. 모달 닫기
		        const modalElement = document.getElementById("writeModal");
		        const modal = bootstrap.Modal.getInstance(modalElement);
		        if (modal) { modal.hide(); }

		        // 2. 입력값 초기화
		        $("#postTitle").val("");
		        $("#postContent").val("");

		        // 3. 선택 경기장 초기화
		        selectedStadium = null;
		        $(".stadium-card").removeClass("selected");
		        $("#selectedMatchInfo").addClass("d-none");

		        // 4. 모집 게시판 목록 다시 조회
		        loadMatchBoardList();

		        // 5. '참가 선수 모집 게시판' 탭으로 이동
		        const boardTab =
		            document.querySelector(
		                '[data-bs-target="#match-board-pane"]'
		            );

		        if (boardTab) {
		            bootstrap.Tab
		                .getOrCreateInstance(boardTab)
		                .show();
		        }

		    } else {

		        alert(
		            data.message ||
		            "게시글 등록에 실패했습니다."
		        );
		    }
		},

        error: function(xhr) {
            console.log(xhr.responseText);
            alert("게시글 등록 중 오류가 발생했습니다.");
        },
		
		complete: function() {
		    window.matchPostSubmitting = false;
		}
    });
}

function openWriteModal() {
    const modalElement = document.getElementById("writeModal");

    const modal = bootstrap.Modal.getOrCreateInstance(modalElement);
    modal.show();
}


function applyAwayMatch(applyId) {

    if (!confirm("이 경기에 원정팀으로 신청하시겠습니까?")) {
        return;
    }

    $.ajax({
        url: contextPath + "/match2/awayApply",
        type: "POST",
        data: {
            apply_id: applyId
        },
        dataType: "json",

        success: function(res) {
            if (res.success) {
                alert(res.message);

                loadMyMatchApply(); //경기신청 후 이력 새로 조회

            } else {
                alert(res.message);
            }
        },

        error: function(xhr) {
            alert("원정팀 매칭 신청 중 오류가 발생했습니다.");
        }
    });
}

function loadWaitingMatches(
    applyDate, region, applyTime, matchType1, matchType2) {

    const area = $("#waitingMatchList");

    area.html(`<div class="text-center text-muted py-4">
            매칭 대기 중인 경기를 조회 중입니다.</div>`);

    $.ajax({
        url:
            contextPath +
            "/match/waitingMatches",

        type: "GET",
        data: {
            applyDate: applyDate,
            region: region,
            applyTime: applyTime,
            matchType1: matchType1,
            matchType2: matchType2
        },

        dataType: "json",

        success: function(res) {

            if (!res.success) {
                area.html(`<div class="alert alert-warning">
                        ${escapeHtml(res.message)}</div>`);
                return;
            }

            if (!res.list || res.list.length === 0) {

                area.html(`<div class="text-center text-muted py-4">
                        선택한 조건에 해당하는 대기 중인 매칭이 없습니다. </div>`);
                return;
            }

            let html = "";

            res.list.forEach(function(dto) {
                const timeText = dto.apply_time === 1
                    ? "오전" : "오후";

                html += `<div class="card border rounded-3 p-3 mb-2 shadow-sm">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <div class="fw-bold">
                                    ${escapeHtml(dto.home_club_name)}
                                </div>

                                <div class="small text-muted">
                                    ${dto.apply_date}
                                    · ${timeText}
                                    · ${escapeHtml(dto.stadium_name)}
                                    · ${escapeHtml(dto.match_type1)}
                                    /
                                    ${escapeHtml(dto.match_type2)}
                                </div>
                            </div>

                            <button type="button" class="btn btn-primary btn-sm"
                                onclick=" applyAwayMatch( ${dto.apply_id})">
                                원정팀 신청
                            </button>
                        </div>
                    </div>`;
            });
			
            area.html(html);
        },

        error: function(xhr) {
            console.error(xhr);

            area.html(`<div class="alert alert-danger">대기 매칭 조회 중 오류가 발생했습니다.
                </div>`);
        }
    });
}
