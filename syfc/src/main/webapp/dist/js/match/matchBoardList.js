function loadMatchBoardList() {
    $.ajax({
        url: contextPath + '/match/boardList',
        type: 'GET',
        dataType: 'json',

        success: function(res) {
            const area = $('#matchBoardListArea');
            area.empty();

            if(!res.success && res.list == null) {
                area.html(`<div class="text-center text-muted py-5">
                        게시글을 불러오지 못했습니다.</div>`);
                return;
            }

            const list = res.list;

            if(!list || list.length === 0) {
                area.html(`<div class="text-center text-muted py-5">
                        현재 모집 중인 게시글이 없습니다.</div>`);
                return;
            }

            list.forEach(function(dto) {

                let statusText = '';
                let statusClass = '';

                if(dto.match_status === 3) {
                    statusText = '매칭 대기중';
                    statusClass = 'bg-warning text-dark';

                } else if(dto.match_status === 2) {
                    statusText = '상대팀 신청';
                    statusClass = 'bg-info';

                } else if(dto.match_status === 1) {
                    statusText = '매칭 완료';
                    statusClass = 'bg-success';
                }

                const target = dto.targetCount;
                const count = dto.applicantCount || 0;
                const timeText = dto.apply_time === 1
                    ? '오전' : '오후';

                const item = `
                    <div class="card border rounded-3 p-3 mb-3 shadow-sm"
                         style="cursor:pointer;"
                         onclick="openMatchBoardDetail(${dto.cmb_num})">

                        <div class="d-flex justify-content-between
                                    align-items-center mb-2">

                            <h6 class="fw-bold mb-0 text-dark">
                                ${escapeHtml(dto.cmb_Subject)}
                            </h6>

                            <span class="badge ${statusClass}">
                                ${statusText}
                            </span>

                        </div>

                        <div class="small text-muted mb-2">
                            📅
                            ${dto.apply_date}
                            ${timeText}
                            &nbsp; | &nbsp;

                            📍
                            ${escapeHtml(dto.stadium_name)}
                            &nbsp; | &nbsp;

                            ⚽
                            ${escapeHtml(dto.match_type1)}
                            /
                            ${escapeHtml(dto.match_type2)}

                        </div>

                        <div class="d-flex justify-content-between
                                    align-items-center">

                            <span class="small text-muted">
                                선수 신청
                                <strong class="text-primary">
                                    ${count}/${target}
                                </strong>
                            </span>

                            <span class="small text-muted">
                                조회 ${dto.cmb_HitCount || 0}
                            </span>
                        </div>
                    </div>`;

                area.append(item);
            });
        },

        error: function(xhr) {
            console.error(xhr);

            $('#matchBoardListArea').html(`
                <div class="text-center text-danger py-5">
                    게시글 조회 중 오류가 발생했습니다.
                </div>`);
        }
    });
}


function openMatchBoardDetail(cmb_num) {
    loadMatchBoardDetail(cmb_num);
}


function escapeHtml(value) {

    if(value == null) {
        return '';
    }

    return $('<div>')
        .text(value)
        .html();
}


$(function() {
    loadMatchBoardList();

});


let currentCmbNum = null;
let currentMatchDetail = null;

// 게시글 상세 조회
function loadMatchBoardDetail(cmb_num) {
    currentCmbNum = cmb_num;

    $.ajax({
        url: contextPath + '/match/detail',
        type: 'GET',
        data: {cmb_num: cmb_num},
        dataType: 'json',

        success: function(res) {
            if(!res.success) {
                alert(res.message);
                return;
            }

            currentMatchDetail = res;

            const board = res.board;
            const applicants = res.applicants || [];
            const myRequest = res.myRequest;

            // 게시글
            $('#detailSubject').text(board.cmb_Subject);
            $('#detailContent').text(board.cmb_Content);

            // 경기 정보
            $('#detailDate').text(board.apply_date);
            $('#detailTime').text(board.apply_time === 1
                    ? '오전' : '오후');
            $('#detailStadium').text(board.stadium_name);
            $('#detailRegion').text(board.region);
            $('#detailType').text(board.match_type1 + ' / '
                    + board.match_type2);

            if(board.away_clubOwner_key) {
                $('#detailOpponent').text( board.away_clubName || '상대팀');

            } else {
                $('#detailOpponent').text('매칭 대기중');
            }

            // 신청자 수
            const target = board.match_type1 === '11' ? 11 : 6;

            $('#applicantCount').text(res.applicantCount + ' / ' + target);

            // 신청자 목록
            renderApplicantList(applicants, myRequest, board);

            // 로그인 사용자 버튼
            renderActionButtons(board, myRequest, res.isOwner);

            // 모달 열기
            const modal = new bootstrap.Modal(document.getElementById(
                        'matchBoardDetailModal')
                );
            modal.show();

            // 지도
            showMatchMap(board);
        },

        error: function(xhr) {
            console.error(xhr);
            alert('게시글 정보를 불러오는 중 오류가 발생했습니다.');
        }
    });
}

// 신청자 목록 출력
function renderApplicantList(applicants, myRequest, board) {

    const area = $('#applicantList');
    area.empty();

    if(!applicants || applicants.length === 0) {

        area.html(`<div class="text-center text-muted
                        border rounded-3 p-4">
                아직 참가 신청한 선수가 없습니다.
            </div>`);
        return;
    }

    applicants.forEach(function(player) {

        let stateText = '';
        let stateClass = '';

        switch(player.request_state) {
            case 2:
                stateText = '대기';
                stateClass = 'bg-warning text-dark';
                break;
            case 1:
                stateText = '승인';
                stateClass = 'bg-success';
                break;
            case 0:
                stateText = '반려';
                stateClass = 'bg-danger';
                break;
        }

        const item = `
            <div class="border rounded-3 p-3 mb-2">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <strong>
                            ${escapeHtml(player.playerName)}
                        </strong>

                        <span class="badge ${stateClass} ms-2">
                            ${stateText}
                        </span>
                    </div>

                    <div class="owner-request-buttons"
                        data-club-join-num="${player.clubJoin_num}">

                        <button type="button" class="btn btn-sm btn-success me-1"
                            onclick="approvePlayerRequest( ${player.clubJoin_num})">
                            승인
                        </button>

                        <button type="button" class="btn btn-sm btn-outline-danger"
                            onclick="rejectPlayer(${player.clubJoin_num})">
                            반려
                        </button>
                    </div>
					
                </div>
				
            </div>`;

        area.append(item);
    });

    // 기본값은 선수 버튼 숨김
    $('.owner-request-buttons')
        .addClass('d-none');
}


// 로그인 사용자 버튼
function renderActionButtons(board, myRequest, isOwner) {

    if (isOwner) {

        $('#playerActionArea').addClass('d-none');
        $('#ownerActionArea').removeClass('d-none');
        $('.owner-request-buttons').removeClass('d-none');

        return;
    }

    $('#playerActionArea').removeClass('d-none');
    $('#ownerActionArea').addClass('d-none');
    $('.owner-request-buttons').addClass('d-none');

    if (myRequest) {

        $('#playerApplyBtn').addClass('d-none');
        $('#playerCancelBtn').removeClass('d-none');

        showMyRequestStatus(myRequest.request_state);

    } else {
        $('#playerApplyBtn').removeClass('d-none');
        $('#playerCancelBtn').addClass('d-none');
    }
}


// 본인 신청 상태
function showMyRequestStatus(state) {

    let message = '';

    switch(state) {
        case 2:
            message = '현재 참가 신청 대기 중입니다.';
            break;
        case 1:
            message = '구단주가 참가 신청을 승인했습니다.';
            break;
        case 0:
            message = '구단주가 참가 신청을 반려했습니다.';
            break;
		case -1:
			message = '참가 신청을 취소했습니다.';
			break;
    }

    if(message) {

        $('#playerActionArea').prepend(`
                <div class="small text-muted mb-2">
                    ${message}
                </div>`);
    }
}

// 선수 참가신청
function applyMatchPlayer() {

    if(!currentCmbNum) { 
		return; 
	}

    const intro =prompt('구단주에게 전달할 소개글을 입력해주세요.');

    if(intro === null) {
        return;
    }

    $.ajax({
        url: contextPath + '/match/request',
        type: 'POST',
        data: {
            cmb_num: currentCmbNum,
            request_intro: intro
        },

        dataType: 'json',

        success: function(res) {
            alert(res.message);

            if(res.success) {
                reloadMatchDetail();
            }
        }
    });
}

// 선수 신청취소
function cancelMatchPlayer() {

    if(!confirm(
        '참가 신청을 취소하시겠습니까?'
    )) {
        return;
    }
	
	const requestCancel = prompt("참가 신청 취소 사유를 입력해주세요.");

	if(requestCancel === null) {
	    return;
	}

	if(!requestCancel.trim()) {
	    alert("취소 사유를 입력해주세요.");
	    return;
	}


    $.ajax({
        url: contextPath + '/match/requestCancel',
        type: 'POST',
        data: {
            cmb_num: currentCmbNum,
			request_cancel: requestCancel.trim()
        },
        dataType: 'json',

        success: function(res) {
            alert(res.message);

            if(res.success) {
                reloadMatchDetail();
            }
        }
    });
}

// 구단주 - 선수 승인
function approvePlayerRequest(clubJoin_num) {

    if(!confirm(
        '이 선수의 참가 신청을 승인하시겠습니까?'
    )) {
        return;
    }

    $.ajax({
        url: contextPath + '/match/approveRequest',
        type: 'POST',
        data: {
            cmb_num: currentCmbNum,
            clubJoin_num: clubJoin_num
        },

        dataType: 'json',

        success: function(res) {
            alert(res.message);

            if(res.success) {
                reloadMatchDetail();
            }
        }
    });
}


// 구단주 - 선수 반려
function rejectPlayer(clubJoin_num) {

    const reason = prompt('반려 사유를 입력해주세요.');

    if(reason === null) {
        return;
    }

    $.ajax({
        url: contextPath + '/match/rejectRequest',
        type: 'POST',
        data: {
            cmb_num: currentCmbNum,
            clubJoin_num: clubJoin_num,
            reject_reason: reason
        },

        dataType: 'json',

        success: function(res) {
            alert(res.message);

            if(res.success) {
                reloadMatchDetail();
            }
        }
    });
}

// 구단주 - 매칭 취소
function cancelMatchOwner() {

    const reason = prompt('경기 취소 사유를 입력해주세요.');

    if(reason === null) {
        return;
    }

    $.ajax({
        url: contextPath + '/match/cancelMatch',
        type: 'POST',
        data: {
            cmb_num: currentCmbNum,
            cancel_reason: reason
        },

        dataType: 'json',

        success: function(res) {
            alert(res.message);

            if(res.success) {
                bootstrap.Modal.getInstance(
                        document.getElementById(
                            'matchBoardDetailModal')
                    ).hide();
					
                loadMatchBoardList();
            }
        }
    });
}


// 상세정보 다시 조회
function reloadMatchDetail() {
    loadMatchBoardDetail(currentCmbNum);
}

// 지도
function showMatchMap(board) {

    // 카카오 지도 API를 붙일 자리. DB의 latitude, longitude 사용하기

    if(board.latitude == null ||board.longitude == null) {

        $('#matchMap').html(`<div class="text-center text-muted p-5">
                경기장 위치 정보가 없습니다.</div>`);
        return;
    }

    // 여기에서 실제 지도 API 호출
    // 예) new kakao.maps.LatLng(
    //     board.latitude,
    //     board.longitude );

}

// HTML escape
function escapeHtml(value) {

    if(value == null) {
        return '';
    }
    return $('<div>')
        .text(value)
        .html();
}
