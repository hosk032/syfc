/* ==========================================================================
   구단주 마이페이지 (ownerpage.js) 전체 이벤트 및 통합 스크립트
   ========================================================================== */

let selectedStadiumName = "쌍용 주 경기장";
let currentSelectedPlayerCount = 0;

document.addEventListener('DOMContentLoaded', function() {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function(tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    const logoInput = document.getElementById("uploadLogoInput");
    if (logoInput) {
        logoInput.addEventListener("change", function() {
            previewImage(this);
        });
    }
});

function checkPlayerCount(count) {
    currentSelectedPlayerCount = count;
}

/* ==========================================================================
   [탭 1] 구단 정보 등록 / 수정
   ========================================================================== */

function previewImage(input) {
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const preview = document.getElementById('previewEmblem');
            const defaultIcon = document.getElementById('defaultEmblemIcon');
            const emblemPreview = document.getElementById('emblemPreview');

            if (preview) {
                preview.src = e.target.result;
                preview.classList.remove('d-none');
            }
            if (defaultIcon) {
                defaultIcon.classList.add('d-none');
            }
            if (emblemPreview) {
                emblemPreview.innerHTML =
                    '<img src="' + e.target.result + '" class="w-100 h-100" style="object-fit: cover;">';
            }
        };
        reader.readAsDataURL(input.files[0]);
    }
}

function saveTeamInfo() {
    const form = document.getElementById("teamEditForm");
    if (form && form.teamName && !form.teamName.value.trim()) {
        alert("구단명을 입력해 주세요.");
        form.teamName.focus();
        return;
    }

    if (confirm("구단 정보를 수정하시겠습니까?")) {
        if (form) form.submit();
    }
}

/* ==========================================================================
   [탭 2] 구단 경기 이력 조회
   ========================================================================== */

function loadTeamHistory() {
    var year = $('#searchYear').val();
    var month = $('#searchMonth').val();
    var result = $('#searchResult').val();

    var reqUrl = (typeof contextPath !== 'undefined' ? contextPath : '') + '/clubowner/searchMatchHistory';

    $.ajax({
        url: reqUrl,
        type: 'GET',
        data: { year: year, month: month, result: result },
        dataType: 'html',
        success: function(data) {
            $('#matchHistoryList').html(data);

            var isNoData = $('#matchHistoryList').find('.empty-row').length > 0;
            var realCount = isNoData ? 0 : $('#matchHistoryList').children('tr').length;

            $('#searchTotalCount').text(realCount);
            $('#team-history #summaryTotal').text(realCount + '전');
        },
        error: function(xhr, status, error) {
            console.error('AJAX error:', error);
            alert('경기 이력을 불러오는 중 오류가 발생했습니다.');
        }
    });
}

/* ==========================================================================
   [탭 3] 구단 성적 등록 / 관리 (백엔드 완벽 연동)
   ========================================================================== */

// 1. 경기 선택 시 폼 데이터 바인딩
function selectMatchForRegister(matchNum, matchDate, stadium, homeClub, awayClub, awayLogo) {
    $('#selectedMatchNum').val(matchNum);
    $('#regMatchDate').val(matchDate.substring(0, 10));
    $('#regStadiumName').val(stadium);
    $('#regAwayClubName').val(awayClub);
    
    $('#homeClubTitle').text(homeClub);
    $('#awayClubTitle').text(awayClub);
    
    // 상대팀 로고 유무에 따른 404 안전 처리
    if (awayLogo && awayLogo !== 'null' && awayLogo !== '') {
        var logoUrl = (typeof contextPath !== 'undefined' ? contextPath : '') + '/uploads/club/' + awayLogo;
        $('#awayEmblem').attr('src', logoUrl).show();
    } else {
        $('#awayEmblem').attr('src', '').hide();
    }

    $('#regHomeScore').val(0);
    $('#regAwayScore').val(0);

    $('#formCardTitle').html('<i class="bi bi-plus-circle-fill text-primary me-2"></i>경기 성적 신규 등록');
    $('#formStatusBadge').attr('class', 'badge bg-primary px-3 py-1 fs-8').text('성적 등록 모드');
    $('#btnSubmitScore').prop('disabled', false).html('<i class="bi bi-check-lg me-1"></i>성적 등록 완료');
    $('#btnCancelEdit').removeClass('d-none');

    $('html, body').animate({ scrollTop: $('#team-result-register').offset().top - 100 }, 300);
}

// 2. 수정 모드 바인딩
function selectMatchForEdit(matchNum, matchDate, stadium, homeClub, awayClub, homeScore, awayScore, awayLogo) {
    selectMatchForRegister(matchNum, matchDate, stadium, homeClub, awayClub, awayLogo);

    $('#regHomeScore').val(homeScore);
    $('#regAwayScore').val(awayScore);

    $('#formCardTitle').html('<i class="bi bi-pencil-square text-warning me-2"></i>경기 성적 수정');
    $('#formStatusBadge').attr('class', 'badge bg-warning text-dark px-3 py-1 fs-8').text('성적 수정 모드');
    $('#btnSubmitScore').prop('disabled', false).html('<i class="bi bi-pencil-square me-1"></i>성적 수정 완료');
}

// 3. 폼 초기화
function resetResultForm() {
    $('#teamResultForm')[0].reset();
    $('#selectedMatchNum').val('');
    $('#regMatchDate').val('');
    $('#regStadiumName').val('');
    $('#regAwayClubName').val('');
    $('#awayClubTitle').text('상대팀');
    $('#awayEmblem').attr('src', '').hide();
    
    $('#formCardTitle').html('<i class="bi bi-plus-circle-fill text-primary me-2"></i>경기 성적 입력');
    $('#formStatusBadge').attr('class', 'badge bg-secondary px-3 py-1 fs-8').text('경기를 선택해 주세요');
    $('#btnSubmitScore').prop('disabled', true).html('<i class="bi bi-check-lg me-1"></i>성적 등록 완료');
    $('#btnCancelEdit').addClass('d-none');
}

// 성적 저장 AJAX
function submitMatchScore() {
    var matchNum = $('#selectedMatchNum').val();
    var homeScore = $('#regHomeScore').val();
    var awayScore = $('#regAwayScore').val();

    if (!matchNum) {
        alert("성적을 등록할 경기를 아래 목록에서 먼저 선택해 주세요.");
        return;
    }

    if (homeScore === "" || awayScore === "" || homeScore < 0 || awayScore < 0) {
        alert("정확한 스코어를 입력해 주세요.");
        return;
    }

    if (confirm("경기 성적(스코어)을 저장하시겠습니까?")) {
        var reqUrl = (typeof contextPath !== 'undefined' ? contextPath : '') + '/clubowner/saveMatchScore';

        $.ajax({
            url: reqUrl,
            type: 'POST',
            data: { matchNum: matchNum, homeScore: homeScore, awayScore: awayScore },
            dataType: 'html',
            success: function(resp) {
                alert("성적이 성공적으로 저장되었습니다.");
                location.reload();
            },
            error: function(xhr, status, error) {
                console.error("Score save error:", error);
                alert("성적 저장 중 오류가 발생했습니다.");
            }
        });
    }
}

// 성적 삭제 AJAX
function deleteMatchScore(matchNum) {
    if (!matchNum) return;

    if (confirm("등록된 경기 성적을 삭제하시겠습니까?\n삭제 시 스코어가 초기화됩니다.")) {
        var reqUrl = (typeof contextPath !== 'undefined' ? contextPath : '') + '/clubowner/deleteMatchScore';

        $.ajax({
            url: reqUrl,
            type: 'POST',
            data: { matchNum: matchNum },
            dataType: 'html',
            success: function(resp) {
                alert("경기 성적이 성공적으로 삭제(초기화)되었습니다.");
                location.reload(); 
            },
            error: function(xhr, status, error) {
                console.error("Score delete error:", error);
                alert("성적 삭제 중 오류가 발생했습니다.");
            }
        });
    }
}

// 6. 목록 비동기 새로고침
function reloadMatchResultList() {
    var reqUrl = (typeof contextPath !== 'undefined' ? contextPath : '') + '/clubowner/matchResultList';

    $.ajax({
        url: reqUrl,
        type: 'GET',
        dataType: 'html',
        success: function(htmlData) {
            $('#team-result-register').html(htmlData);
        },
        error: function(xhr, status, error) {
            console.error("List reload error:", error);
        }
    });
}

/* ==========================================================================
   [탭 4] 입단 승인 관리 (백엔드 완벽 연동)
   ========================================================================== */

// 1. 입단 승인 처리 (AJAX)
function approvePlayerProcess(applyNum, name) {
    if (!applyNum) {
        alert("선택된 신청 정보가 없습니다.");
        return;
    }

    if (confirm(name + " 선수의 입단을 승인하시겠습니까?\n승인 시 소속 선수로 정식 등록됩니다.")) {
        var reqUrl = (typeof contextPath !== 'undefined' ? contextPath : '') + '/clubowner/approvePlayer';

        $.ajax({
            url: reqUrl,
            type: 'POST',
            data: { applyNum: applyNum },
            dataType: 'html',
            success: function() {
                alert(name + " 선수의 입단 승인이 완료되었습니다.");
                location.reload();
            },
            error: function(xhr, status, error) {
                console.error("Approve error:", error);
                alert("입단 승인 처리 중 오류가 발생했습니다.");
            }
        });
    }
}

// 2. 입단 거절 모달 열기
function openRejectModal(applyNum, name) {
    if (!applyNum) {
        alert("선택된 신청 정보가 없습니다.");
        return;
    }

    $('#rejectApplyNum').val(applyNum);
    $('#rejectTargetName').text(name);

    if ($('#rejectReasonSelect').length > 0) {
        $('#rejectReasonSelect').val('정원 초과');
    }
    if ($('#rejectReasonText').length > 0) {
        $('#rejectReasonText').val('포지션 정원이 초과되었습니다.');
    }

    var modalElem = document.getElementById('rejectReasonModal');
    if (modalElem) {
        var modal = bootstrap.Modal.getInstance(modalElem);
        if (!modal) {
            modal = new bootstrap.Modal(modalElem);
        }
        modal.show();
    } else {
        alert("거절 모달(rejectReasonModal) 요소가 존재하지 않습니다.");
    }
}

// 3. 셀렉트 박스 변경 이벤트
function changeRejectReason(val) {
    var $text = $('#rejectReasonText');
    if (!$text.length) return;

    if (val === 'custom') {
        $text.val('').focus();
    } else {
        var selectedText = $('#rejectReasonSelect option:selected').text();
        $text.val(selectedText);
    }
}

// 4. 입단 거절 최종 제출 (AJAX)
function submitRejectProcess() {
    var applyNum = $('#rejectApplyNum').val();
    var reason = $('#rejectReasonText').val();

    if (!reason || !reason.trim()) {
        alert("거절 사유를 입력해 주세요.");
        $('#rejectReasonText').focus();
        return;
    }

    if (confirm("정말로 입단 신청을 거절하시겠습니까?")) {
        var reqUrl = (typeof contextPath !== 'undefined' ? contextPath : '') + '/clubowner/rejectPlayer';

        $.ajax({
            url: reqUrl,
            type: 'POST',
            data: { 
                applyNum: applyNum, 
                rejectReason: reason.trim() 
            },
            dataType: 'html',
            success: function() {
                alert("입단 신청이 성공적으로 거절 처리되었습니다.");

                var modalElem = document.getElementById('rejectReasonModal');
                if (modalElem) {
                    var modal = bootstrap.Modal.getInstance(modalElem);
                    if (modal) modal.hide();
                }

                location.reload();
            },
            error: function(xhr, status, error) {
                console.error("Reject error:", error);
                alert("거절 처리 중 오류가 발생했습니다.");
            }
        });
    }
}

// 5. 입단 대기 건수 UI 업데이트 (동적 제거 시 활용)
function updatePendingCount() {
    const listBody = document.getElementById('approvalListBody');
    const countBadge = document.getElementById('approvalPendingCount');
    const sidebarBadge = document.getElementById('approvalPendingBadge');

    if (!listBody) return;

    const remainingRows = listBody.querySelectorAll('tr:not(.empty-row)').length;
    if (countBadge) countBadge.innerText = remainingRows;
    if (sidebarBadge) sidebarBadge.innerText = remainingRows;

    if (remainingRows === 0) {
        listBody.innerHTML = `
            <tr class="empty-row">
                <td colspan="5" class="py-5 text-center text-muted">
                    <i class="bi bi-person-check fs-1 d-block mb-2 text-secondary opacity-50"></i>
                    현재 대기 중인 입단 신청이 없습니다.
                </td>
            </tr>
        `;
    }
}

/* ==========================================================================
   [탭 5] 소속 선수 관리 (백엔드 연동)
   ========================================================================== */

function removePlayer(name, clubJoinNum) {
    if (!clubJoinNum) {
        alert("선수 식별 정보가 올바르지 않습니다.");
        return;
    }

    if (confirm("정말로 " + name + " 선수를 구단에서 제적(강퇴)하시겠습니까?\n제적 처리 시 선수 목록에서 제외됩니다.")) {
        var reqUrl = (typeof contextPath !== 'undefined' ? contextPath : '') + '/clubowner/removePlayer';

        $.ajax({
            url: reqUrl,
            type: 'POST',
            data: { clubJoinNum: clubJoinNum },
            dataType: 'html',
            success: function() {
                alert(name + " 선수가 성공적으로 제적 처리되었습니다.");
                
                // 화면에서 해당 행 제거
                const row = document.getElementById('player-row-' + clubJoinNum);
                if (row) row.remove();
                
                // 총 인원수 갱신 및 빈 목록 체크
                updateTotalPlayerCount();
            },
            error: function(xhr, status, error) {
                console.error("Remove player error:", error);
                alert("선수 제적 처리 중 오류가 발생했습니다.");
            }
        });
    }
}

function updateTotalPlayerCount() {
    const listBody = document.getElementById('playerListBody');
    const totalCountElem = document.getElementById('totalPlayerCount');

    if (!listBody) return;

    const remainingRows = listBody.querySelectorAll('tr:not(.empty-row)').length;
    if (totalCountElem) totalCountElem.innerText = remainingRows;

    if (remainingRows === 0) {
        listBody.innerHTML = `
            <tr class="empty-row">
                <td colspan="4" class="py-5 text-center text-muted">
                    <i class="bi bi-people fs-1 d-block mb-2 text-secondary opacity-50"></i>
                    소속된 선수가 없습니다.
                </td>
            </tr>
        `;
    }
}

// 누락되었던 필터링 함수 추가 완료
function filterPlayerList() {
    const keyword = document.getElementById('searchPlayerKeyword').value.toLowerCase().trim();
    const posFilter = document.getElementById('filterPosition').value;
    const rows = document.querySelectorAll('#playerListBody tr:not(.empty-row)');

    rows.forEach(row => {
        const name = (row.getAttribute('data-name') || '').toLowerCase();
        const pos = row.getAttribute('data-position') || '';

        const matchName = name.includes(keyword);
        const matchPos = !posFilter || pos === posFilter;

        if (matchName && matchPos) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}

/* ==========================================================================
   [탭 6] 개인/선수 평점 & 성적 기록 관리
   ========================================================================== */

function saveMatchRecord() {
    const matchDate = document.getElementById('matchDate').value;
    const playerSelect = document.getElementById('ratingPlayerSelect');
    const recordIdx = document.getElementById('recordIdx').value;

    if (!matchDate) {
        alert("경기 일자를 선택해 주세요.");
        document.getElementById('matchDate').focus();
        return;
    }

    if (!playerSelect.value) {
        alert("대상 선수를 선택해 주세요.");
        playerSelect.focus();
        return;
    }

    const playerName = playerSelect.options[playerSelect.selectedIndex].getAttribute('data-name');
    const isEdit = recordIdx !== "";

    const confirmMsg = isEdit
        ? "[" + matchDate + "] " + playerName + " 선수의 경기 성적 및 평점을 수정하시겠습니까?"
        : "[" + matchDate + "] " + playerName + " 선수의 경기 성적 및 평점을 등록하시겠습니까?";

    if (confirm(confirmMsg)) {
        alert(isEdit ? "성적이 성공적으로 수정되었습니다." : "성적이 성공적으로 등록되었습니다.");
        resetRatingForm();
    }
}

function editMatchRecord(recordId) {
    const row = document.getElementById('record-row-' + recordId);
    if (!row) return;

    const date = row.getAttribute('data-date');
    const playerId = row.getAttribute('data-player-id');
    const score = row.getAttribute('data-score');
    const goal = row.getAttribute('data-goal');
    const assist = row.getAttribute('data-assist');
    const ownGoal = row.getAttribute('data-owngoal');
    const yellow = row.getAttribute('data-yellow') === 'true';
    const red = row.getAttribute('data-red') === 'true';
    const comment = row.getAttribute('data-comment');

    document.getElementById('recordIdx').value = recordId;
    document.getElementById('matchDate').value = date;
    document.getElementById('ratingPlayerSelect').value = playerId;
    document.getElementById('playerRatingScore').value = score;
    document.getElementById('statGoal').value = goal;
    document.getElementById('statAssist').value = assist;
    document.getElementById('statOwnGoal').value = ownGoal;
    document.getElementById('statYellowCard').checked = yellow;
    document.getElementById('statRedCard').checked = red;
    document.getElementById('statComment').value = comment;

    document.getElementById('ratingFormTitle').innerText = "경기 성적 수정";
    document.getElementById('btnSubmitRating').innerHTML = '<i class="bi bi-pencil-square me-1"></i>성적 수정 완료';
    document.getElementById('btnCancelEdit').classList.remove('d-none');

    document.getElementById('playerRatingForm').scrollIntoView({ behavior: 'smooth' });
}

function resetRatingForm() {
    document.getElementById('playerRatingForm').reset();
    document.getElementById('recordIdx').value = "";

    document.getElementById('ratingFormTitle').innerText = "경기 성적 등록 / 수정";
    document.getElementById('btnSubmitRating').innerHTML = '<i class="bi bi-check-lg me-1"></i>성적 저장하기';
    document.getElementById('btnCancelEdit').classList.add('d-none');
}

function deleteMatchRecord(recordId) {
    if (confirm("해당 경기 성적 기록을 삭제하시겠습니까?\n삭제된 기록은 복구되지 않습니다.")) {
        alert("기록이 삭제되었습니다.");
        const row = document.getElementById('record-row-' + recordId);
        if (row) row.remove();
    }
}

/* ==========================================================================
   [탭 7] 경기장 예약 & 매칭 신청
   ========================================================================== */

function toggleMatchMode(mode) {
    const homeArea = document.getElementById('homeMatchArea');
    const awayArea = document.getElementById('awayMatchArea');
    const card1 = document.getElementById('optionCard1');
    const card2 = document.getElementById('optionCard2');

    if (mode === 'HOME') {
        if (homeArea) homeArea.style.display = 'block';
        if (awayArea) awayArea.style.display = 'none';
        if (card1) card1.classList.add('border-primary', 'bg-primary-subtle');
        if (card2) card2.classList.remove('border-primary', 'bg-primary-subtle');
    } else {
        if (homeArea) homeArea.style.display = 'none';
        if (awayArea) awayArea.style.display = 'block';
        if (card2) card2.classList.add('border-primary', 'bg-primary-subtle');
        if (card1) card1.classList.remove('border-primary', 'bg-primary-subtle');
    }
}

function searchStadiums() {
    const date = document.getElementById('searchDate') ? document.getElementById('searchDate').value : '';
    const region = document.getElementById('searchRegion') ? document.getElementById('searchRegion').value : '';
    alert("[" + region + "] " + date + " 날짜에 사용 가능한 경기장을 DB에서 불러옵니다.");
}

function selectStadiumCard(element, name, address, price) {
    const cards = document.querySelectorAll('.stadium-card');
    cards.forEach(card => {
        card.classList.remove('border-primary', 'bg-primary-subtle', 'selected');
    });

    element.classList.add('border-primary', 'bg-primary-subtle', 'selected');
    selectedStadiumName = name;
}

function openMatchPostModal() {
    const date = document.getElementById('searchDate') ? document.getElementById('searchDate').value : '2026-08-20';
    const mainTypeSelect = document.getElementById('matchTypeMain');
    const subTypeSelect = document.getElementById('matchTypeSub');

    const mainText = mainTypeSelect ? mainTypeSelect.options[mainTypeSelect.selectedIndex].text : '11vs11 정규 축구';
    const subText = subTypeSelect ? subTypeSelect.options[subTypeSelect.selectedIndex].text : '혼성 매치';
    const targetCount = mainTypeSelect && mainTypeSelect.value === '6' ? 6 : 11;

    if (document.getElementById('summaryStadiumName')) document.getElementById('summaryStadiumName').innerText = selectedStadiumName;
    if (document.getElementById('summaryDate')) document.getElementById('summaryDate').innerText = date;
    if (document.getElementById('summaryType')) document.getElementById('summaryType').innerText = mainText;
    if (document.getElementById('summaryGender')) document.getElementById('summaryGender').innerText = subText;
    if (document.getElementById('targetPlayerCount')) document.getElementById('targetPlayerCount').value = targetCount;

    const modalElem = document.getElementById('matchPostModal');
    if (modalElem) {
        const modal = bootstrap.Modal.getOrCreateInstance(modalElem);
        modal.show();
    }
}

function submitMatchPost() {
    const titleInput = document.getElementById('postTitle');
    const title = titleInput ? titleInput.value.trim() : '';

    if (!title) {
        alert('모집글 제목을 입력해 주세요.');
        if (titleInput) titleInput.focus();
        return;
    }

    if (confirm("선수 모집글 [" + title + "]을(를) 등록하시겠습니까?\n등록 후 선수가 모두 모이면 경기장을 최종 대관할 수 있습니다.")) {
        alert('선수 모집글이 성공적으로 등록되었습니다!\n일반 선수 마이페이지의 [경기 참가 신청] 탭에 노출됩니다.');

        const modalElem = document.getElementById('matchPostModal');
        if (modalElem) {
            const modal = bootstrap.Modal.getInstance(modalElem);
            if (modal) modal.hide();
        }
    }
}

function submitMatchBooking() {
    const selectedSlot = document.querySelector('input[name="matchSlot"]:checked');
    if (!selectedSlot) {
        alert("원하시는 경기 시간대(타임 슬롯)를 선택해 주세요.");
        return;
    }

    const matchTypeSelect = document.getElementById('matchTypeSelect');
    const minRequired = matchTypeSelect ? parseInt(matchTypeSelect.value) : 11;

    const genderSelect = document.getElementById('genderSelect');
    const genderText = genderSelect ? genderSelect.options[genderSelect.selectedIndex].text : "혼성 매치";

    if (currentSelectedPlayerCount < minRequired) {
        alert("[신청 불가] " + minRequired + "대" + minRequired + " 경기는 최소 " + minRequired + "명 이상의 소속 선수가 모여야 구단주가 신청할 수 있습니다.\n(현재 참가 신청 선수: " + currentSelectedPlayerCount + "명)");
        return;
    }

    const isHome = selectedSlot.value.includes("home");
    const roleText = isHome ? "[홈팀 - 신규 모집]" : "[어웨이팀 - 매칭 참가]";

    if (confirm("선택하신 타임에 " + roleText + " (" + minRequired + ":" + minRequired + " / " + genderText + ")으로 경기 신청을 진행하시겠습니까?")) {
        alert("경기장 예약 및 매칭 신청이 성공적으로 완료되었습니다!");
    }
}

/* ==========================================================================
   [탭 8] 구단주 권한 양도
   ========================================================================== */

function submitOwnerTransfer() {
    const nextOwnerSelect = document.getElementById('nextOwnerSelect');
    const passwordInput = document.getElementById('transferPassword');
    const agreeCheckbox = document.getElementById('transferAgree');

    const nextOwnerId = nextOwnerSelect ? nextOwnerSelect.value : '';
    const password = passwordInput ? passwordInput.value.trim() : '';
    const agree = agreeCheckbox ? agreeCheckbox.checked : false;

    if (!nextOwnerId) {
        alert("차기 구단주를 부여할 선수를 선택해 주세요.");
        if (nextOwnerSelect) nextOwnerSelect.focus();
        return;
    }

    if (!password) {
        alert("본인 확인을 위해 현재 비밀번호를 입력해 주세요.");
        if (passwordInput) passwordInput.focus();
        return;
    }

    if (!agree) {
        alert("권한 위임 주의사항 확인 동의에 체크해 주세요.");
        if (agreeCheckbox) agreeCheckbox.focus();
        return;
    }

    const selectedOption = nextOwnerSelect.options[nextOwnerSelect.selectedIndex];
    const selectedName = selectedOption.getAttribute('data-name') || selectedOption.text;

    const confirmMessage = "⚠️ [경고] 구단주 권한을 정말로 변경하시겠습니까?\n\n" +
        "· 차기 구단주: " + selectedName + "\n" +
        "· 변경 후 본인 계정: 일반 소속 선수로 변경됨\n\n" +
        "이 작업은 즉시 실행되며 취소할 수 없습니다.";

    if (confirm(confirmMessage)) {
        alert(selectedName + " 선수에게 구단주 권한 양도 신청이 성공적으로 완료되었습니다.\n마이페이지로 이동합니다.");
    }
}