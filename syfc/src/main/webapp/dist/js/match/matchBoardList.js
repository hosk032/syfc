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

            if(board.home_clubOwner_key) {
                $('#detailhome').text( board.home_clubName || '홈팀');

            } 
			if(board.away_clubOwner_key) {
				$('#detailOpponent').text( board.away_clubName || '원정팀');

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

            showMatchMap(board); // 지도
			showStadiumImage(board); //경기장 사진
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
			case -1:
			    stateText = '취소';
			    stateClass = 'bg-black';
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
						${ player.request_cancel 
						    ? `<span> ${escapeHtml(player.request_cancel)} </span>` 
						    : `<span> ${escapeHtml(player.request_intro)} </span>` 
						}
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

        //showMyRequestStatus(myRequest.request_state);

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
				//(모달창 끈 후 배경 먹통되는 현상 해결)데이터를 새로 그리기 전에 현재 열려있는 모달을 완전히 숨기기
				const modalEl = document.getElementById('matchBoardDetailModal');
				const modalInstance = bootstrap.Modal.getOrCreateInstance(modalEl);
				modalInstance.hide();      
				//혹시 몰라서: 부트스트랩 버전이나 환경에 따라 백드롭이 남는 현상 방지
				$('.modal-backdrop').remove();
				$('body').removeClass('modal-open').css('overflow', '');
				
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

				const modalEl = document.getElementById('matchBoardDetailModal');
				const modalInstance = bootstrap.Modal.getOrCreateInstance(modalEl);
				modalInstance.hide();      

				$('.modal-backdrop').remove();
				$('body').removeClass('modal-open').css('overflow', '');
				
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

// 경기장 주소를 이용해서 카카오 지도 표시
function showMatchMap(board) {

    const mapContainer = document.getElementById('matchMap');

    if (!mapContainer) {
        return;
    }

    // 기존 지도 영역 초기화
    mapContainer.innerHTML = "";

    // DB에서 가져온 경기장 주소
    const addr1 = board.addr1 || "";
    const addr2 = board.addr2 || "";

    // addr1 + addr2 조합
    const address = (addr1 + " " + addr2).trim();

    // 주소가 없는 경우
    if (!address) {

        mapContainer.innerHTML = `
            <div class="d-flex
                        justify-content-center
                        align-items-center
                        h-100
                        text-muted">
                경기장 주소 정보가 없습니다.
            </div>
        `;

        return;
    }


    // 카카오 주소 → 좌표 변환 객체
    const geocoder = new kakao.maps.services.Geocoder();

    // 주소 검색
    geocoder.addressSearch(address, function(result, status) {

        // 정상적으로 검색된 경우
        if (status === kakao.maps.services.Status.OK) {

            const coords = new kakao.maps.LatLng(
                result[0].y,
                result[0].x
            );


            // 지도 옵션
            const mapOption = {
                center: coords,
                level: 3
            };


            // 지도 생성
            const map = new kakao.maps.Map(
                mapContainer,
                mapOption
            );

            // 마커 생성
            const marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });

            // 경기장 이름
            const stadiumName = board.stadium_name || "경기장";

            // 인포윈도우
            const infowindow =
                new kakao.maps.InfoWindow({
                    content: `
                        <div style="
                            width:180px;
                            text-align:center;
                            padding:8px;
                            font-size:13px;
                            font-weight:bold;
                        ">
                            ${escapeHtml(stadiumName)}
                        </div>
                    `
                });

            // 인포윈도우 표시
            infowindow.open(map, marker);

        } else {

            // 주소 검색 실패
            mapContainer.innerHTML = `
                <div class="d-flex
                            flex-column
                            justify-content-center
                            align-items-center
                            h-100
                            text-muted">

                    <i class="bi bi-geo-alt fs-3 mb-2"></i>

                    <div>
                        경기장 위치를 찾을 수 없습니다.
                    </div>

                    <small class="mt-1">
                        ${escapeHtml(address)}
                    </small>

                </div>
            `;

        }
    });
}


function showStadiumImage(board) {

    console.log("🔥 showStadiumImage 호출");
    console.log("board =", board);

    // HTML에 이미 존재하는 이미지와 빈 상태 영역 가져오기
    const image = document.getElementById('stadiumImage');
    const emptyBox = document.getElementById('stadiumImageEmpty');

    if (!image || !emptyBox) {
        console.log("❌ stadiumImage 또는 stadiumImageEmpty를 찾을 수 없습니다.");
        return;
    }

    // DB에 경기장 이미지 경로가 없는 경우
    if (!board.stadium_img) {

        console.log("📷 경기장 사진 없음");

        image.src = "";
        image.style.display = "none";

        emptyBox.style.setProperty("display", "flex", "important");

        return;
    }

    // header.jsp의 meta 태그에서 contextPath 가져오기
    const contextPathElement =
        document.querySelector('meta[name="contextPath"]');

    if (!contextPathElement) {
        console.log("❌ contextPath meta 태그를 찾을 수 없습니다.");
        return;
    }

    const contextPath = contextPathElement.content;

    // contextPath와 DB의 이미지 경로를 안전하게 결합
    // 예: contextPath = /syfc, stadium_img = /dist/images/stadium/IncheonStadium.JPG
    //최종: /syfc/dist/images/stadium/IncheonStadium.JPG
    const imageUrl =
        contextPath.replace(/\/$/, '') +
        '/' +
        board.stadium_img.replace(/^\//, '');

    console.log("📁 contextPath =", contextPath);
    console.log("📁 stadium_img =", board.stadium_img);
    console.log("🌐 최종 imageUrl =", imageUrl);

    // 이미지 설정
    image.src = imageUrl;
    image.alt = board.stadium_name || "경기장 사진";

    // 이미지 표시
    image.style.display = "block";

    // "경기장 사진이 없습니다." 영역 숨기기
    emptyBox.style.setProperty("display", "none", "important");

    // 이미지 로딩 실패 처리
    image.onerror = function () {

        console.log("❌ 경기장 이미지 로딩 실패:", imageUrl);

        image.src = "";
        image.style.display = "none";

        emptyBox.style.setProperty("display", "flex", "important");
    };
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


document.addEventListener('DOMContentLoaded', function() {
    const detailModal = document.getElementById('matchBoardDetailModal');
    
    if (detailModal) {
        detailModal.addEventListener('hidden.bs.modal', function () {
            // 남아있는 백드롭(회색 막) 모두 제거
            document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
            // body에 남아있는 모달용 스타일 및 클래스 정상화
            document.body.classList.remove('modal-open');
            document.body.style.overflow = '';
            document.body.style.paddingRight = '';
        });
    }
});