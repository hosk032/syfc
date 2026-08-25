/* ==========================================================================
   구단주 마이페이지 전용 통합 JS (ownerpage.js v3.10 - 최종 전체 버전)
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

    // 상대팀 점수 입력 차단
    const awayScoreInput = document.getElementById('regAwayScore');
    if (awayScoreInput) {
        awayScoreInput.addEventListener('keydown', function(e) {
            e.preventDefault();
            alert("상대팀 점수는 수정할 수 없습니다.");
            document.getElementById('regHomeScore').focus();
        });
    }

    // 💡 [최종 해결] 사이드바 메뉴 클릭 시 강제로 탭을 활성화하고 데이터 로드 (이벤트 위임 방식)
    $(document).on('click', '.owner-sidebar a[data-bs-toggle="list"]', function(e) {
        e.preventDefault();

        // 1. 사이드바 active 이동
        $('.owner-sidebar a[data-bs-toggle="list"]').removeClass('active');
        $(this).addClass('active');

        // 2. 대상 탭 ID 추출 (#team-history 등)
        var target = $(this).attr('href');

        // 3. 모든 탭 컨텐츠 숨기고 선택한 탭만 강제 노출
        $('.tab-content .tab-pane').removeClass('show active');
        $(target).addClass('show active');

        // 4. 구단 경기 이력 탭이면 AJAX 데이터 로드 실행
        if (target === '#team-history') {
            loadTeamHistory();
        }
    });

    // 페이지 최초 로딩 시 첫 번째 active 탭 강제 노출
    var initialTarget = $('.owner-sidebar a.active').attr('href');
    if (initialTarget) {
        $(initialTarget).addClass('show active');
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
   [탭 2] 구단 경기 이력 조회 & 상세 모달 오픈 기능 추가
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

function openMatchDetailModal(matchNum) {
    if (!matchNum) return;

    var reqUrl = (typeof contextPath !== 'undefined' ? contextPath : '') + '/clubowner/matchDetailModal';

    $.ajax({
        url: reqUrl,
        type: 'GET',
        data: { matchNum: matchNum },
        dataType: 'html',
        success: function(htmlResponse) {
            $('#matchDetailContent').html(htmlResponse);

            var modalElem = document.getElementById('matchDetailModal');
            if (modalElem) {
                var modal = bootstrap.Modal.getOrCreateInstance(modalElem);
                modal.show();
            }
        },
        error: function(xhr, status, error) {
            console.error("Match detail load error:", error);
            alert("경기 상세 기록을 불러오는 중 오류가 발생했습니다.");
        }
    });
}

/* ==========================================================================
   [탭 3] 구단 성적 등록 / 관리
   ========================================================================== */

function selectMatchForRegister(matchNum, matchDate, stadium, homeClub, awayClub, awayLogo) {
    $('#selectedMatchNum').val(matchNum);
    $('#regMatchDate').val(matchDate.substring(0, 10));
    $('#regStadiumName').val(stadium);
    $('#regAwayClubName').val(awayClub);

    $('#homeClubTitle').text(homeClub);
    $('#awayClubTitle').text(awayClub);

    if (awayLogo && awayLogo !== 'null' && awayLogo !== '') {
        var logoUrl = (typeof contextPath !== 'undefined' ? contextPath : '') + '/uploads/club/' + awayLogo;
        $('#awayEmblem').attr('src', logoUrl).show();
    } else {
        $('#awayEmblem').attr('src', '').hide();
    }

    $('#regHomeScore').val(0);
    $('#regAwayScore').val(0);
    $('#regAwayScore').attr('readonly', true);

    $('#formCardTitle').html('<i class="bi bi-plus-circle-fill text-primary me-2"></i>경기 성적 신규 등록');
    $('#formStatusBadge').attr('class', 'badge bg-primary px-3 py-1 fs-8').text('성적 등록 모드');
    $('#btnSubmitScore').prop('disabled', false).html('<i class="bi bi-check-lg me-1"></i>성적 등록 완료');
    $('#btnCancelEdit').removeClass('d-none');

    $('html, body').animate({ scrollTop: $('#team-result-register').offset().top - 100 }, 300);
}

function selectMatchForEdit(matchNum, matchDate, stadium, homeClub, awayClub, homeScore, awayScore, awayLogo) {
    selectMatchForRegister(matchNum, matchDate, stadium, homeClub, awayClub, awayLogo);

    $('#regHomeScore').val(homeScore);
    $('#regAwayScore').val(awayScore);
    $('#regAwayScore').attr('readonly', true);

    $('#formCardTitle').html('<i class="bi bi-pencil-square text-warning me-2"></i>경기 성적 수정');
    $('#formStatusBadge').attr('class', 'badge bg-warning text-dark px-3 py-1 fs-8').text('성적 수정 모드');
    $('#btnSubmitScore').prop('disabled', false).html('<i class="bi bi-pencil-square me-1"></i>성적 수정 완료');
}

function resetResultForm() {
    $('#teamResultForm')[0].reset();
    $('#selectedMatchNum').val('');
    $('#regMatchDate').val('');
    $('#regStadiumName').val('');
    $('#regAwayClubName').val('');
    $('#awayClubTitle').text('상대팀');
    $('#awayEmblem').attr('src', '').hide();

    $('#regAwayScore').val(0);
    $('#regAwayScore').attr('readonly', true);

    $('#formCardTitle').html('<i class="bi bi-plus-circle-fill text-primary me-2"></i>경기 성적 입력');
    $('#formStatusBadge').attr('class', 'badge bg-secondary px-3 py-1 fs-8').text('경기를 선택해 주세요');
    $('#btnSubmitScore').prop('disabled', true).html('<i class="bi bi-check-lg me-1"></i>성적 등록 완료');
    $('#btnCancelEdit').addClass('d-none');
}

function submitMatchScore() {
    var matchNum = $('#selectedMatchNum').val();
    var homeScore = $('#regHomeScore').val();
    var awayScore = $('#regAwayScore').val();

    if (!matchNum) {
        alert("성적을 등록할 경기를 아래 목록에서 먼저 선택해 주세요.");
        return;
    }

    if (homeScore === "" || homeScore < 0) {
        alert("정확한 우리팀 점수를 입력해 주세요.");
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

/* ==========================================================================
   [탭 4] 입단 승인 관리
   ========================================================================== */

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
    }
}

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
            data: { applyNum: applyNum, rejectReason: reason.trim() },
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

/* ==========================================================================
   [탭 5] 소속 선수 관리
   ========================================================================== */

function removePlayer(name, clubJoinNum) {
    if (!clubJoinNum) {
        alert("선수 식별 정보가 올바르지 않습니다.");
        return;
    }

    if (confirm("정말로 " + name + " 선수를 구단에서 제적(강퇴)하시겠습니까?")) {
        var reqUrl = (typeof contextPath !== 'undefined' ? contextPath : '') + '/clubowner/removePlayer';

        $.ajax({
            url: reqUrl,
            type: 'POST',
            data: { clubJoinNum: clubJoinNum },
            dataType: 'html',
            success: function() {
                alert(name + " 선수가 성공적으로 제적 처리되었습니다.");
                const row = document.getElementById('player-row-' + clubJoinNum);
                if (row) row.remove();
            },
            error: function(xhr, status, error) {
                console.error("Remove player error:", error);
                alert("선수 제적 처리 중 오류가 발생했습니다.");
            }
        });
    }
}

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

function editMatchRecord(recordId) {
    const row = document.getElementById('record-row-' + recordId);
    if (!row) return;

    document.getElementById('recordIdx').value = recordId;
    document.getElementById('matchNum').value = row.dataset.match;
    document.getElementById('ratingPlayerSelect').value = row.dataset.player;
    document.getElementById('playerRatingScore').value = parseFloat(row.dataset.score).toFixed(1);

    document.getElementById('statGoal').value = row.dataset.goal;
    document.getElementById('statAssist').value = row.dataset.assist;
    document.getElementById('statOwnGoal').value = row.dataset.owngoal;

    document.getElementById('statYellowCard').checked = (row.dataset.yellow > 0);
    document.getElementById('statRedCard').checked = (row.dataset.red > 0);
    document.getElementById('statComment').value = row.dataset.comment;

    document.getElementById('btnSubmitRating').innerHTML = '<i class="bi bi-pencil-square me-1"></i>성적 수정하기';
    document.getElementById('ratingFormTitle').innerHTML = '<i class="bi bi-pencil-square text-warning me-2 fs-5"></i>경기 성적 수정';
    document.getElementById('btnCancelEdit').classList.remove('d-none');

    window.scrollTo({ top: 0, behavior: 'smooth' });
}

function resetRatingForm() {
    document.getElementById('playerRatingForm').reset();
    document.getElementById('recordIdx').value = '';

    document.getElementById('btnSubmitRating').innerHTML = '<i class="bi bi-check-lg me-1"></i>성적 저장하기';
    document.getElementById('ratingFormTitle').innerHTML = '경기 성적 등록 / 수정';
    document.getElementById('btnCancelEdit').classList.add('d-none');
}

function saveMatchRecord() {
    const recordId = document.getElementById('recordIdx').value;
    const matchSelect = document.getElementById('matchNum');
    const matchNum = matchSelect.value;
    const clubJoinNum = document.getElementById('ratingPlayerSelect').value;
    const inputGoal = parseInt(document.getElementById('statGoal').value) || 0; // 입력한 골

    if (!matchNum || !clubJoinNum) {
        alert('경기와 대상 선수를 모두 선택해 주세요.');
        return;
    }

    const selectedOption = matchSelect.options[matchSelect.selectedIndex];
    const teamTotalGoals = parseInt(selectedOption.getAttribute('data-homescore')) || 0;

    let existingGoals = 0;
    const rows = document.querySelectorAll('#matchRecordListBody tr');

    rows.forEach(row => {
        const rowMatchNum = row.getAttribute('data-match');
        const rowRecordId = row.id ? row.id.replace('record-row-', '') : '';

        if (rowMatchNum === matchNum && rowRecordId !== recordId) {
            existingGoals += parseInt(row.getAttribute('data-goal')) || 0;
        }
    });

    if ((existingGoals + inputGoal) > teamTotalGoals) {
        alert(`❌ 등록 실패\n\n해당 경기의 우리 팀 총 득점은 ${teamTotalGoals}골입니다.\n(현재 다른 선수에게 등록된 골: ${existingGoals}골)\n\n입력하신 ${inputGoal}골을 추가하면 팀 총 득점을 초과합니다.`);
        document.getElementById('statGoal').focus();
        return;
    }

    const data = {
        recordId: recordId,
        matchNum: matchNum,
        clubJoinNum: clubJoinNum,
        rating: document.getElementById('playerRatingScore').value,
        goal: inputGoal,
        assist: document.getElementById('statAssist').value,
        ownGoal: document.getElementById('statOwnGoal').value,
        yellow: document.getElementById('statYellowCard').checked ? 1 : 0,
        red: document.getElementById('statRedCard').checked ? 1 : 0,
        memo: document.getElementById('statComment').value
    };

    var reqUrl = (typeof contextPath !== 'undefined' ? contextPath : '') + '/clubowner/savePlayerRecord';

    $.ajax({
        url: reqUrl,
        type: 'POST',
        data: data,
        success: function() {
            alert(recordId ? '성적이 성공적으로 수정되었습니다.' : '새로운 성적이 등록되었습니다.');
            location.reload();
        },
        error: function(xhr, status, error) {
            console.error("Save record error:", error);
            alert('성적 저장 중 오류가 발생했습니다.');
        }
    });
}

function deleteMatchRecord(recordId) {
    if (!recordId) return;

    if (confirm('정말 삭제하시겠습니까?\n삭제 시 해당 선수의 상세 기록이 0으로 반영됩니다.')) {
        var reqUrl = (typeof contextPath !== 'undefined' ? contextPath : '') + '/clubowner/deletePlayerRecord';

        $.ajax({
            url: reqUrl,
            type: 'POST',
            data: { recordId: recordId },
            success: function() {
                alert('기록이 성공적으로 삭제되었습니다.');
                location.reload();
            },
            error: function(xhr, status, error) {
                console.error("Delete record error:", error);
                alert('삭제 중 오류가 발생했습니다.');
            }
        });
    }


}

$(function() {
    // 1. 페이지가 처음 로드될 때 '프로필 수정' 탭 영역에 상대방 폼 불러오기
    loadUserProfileForm();

    // 2. 만약 다른 메뉴에 갔다 오거나 탭 클릭 시 다시 불러오도록 이벤트 연결
    $('a[href="#profile-edit"]').on('click', function() {
        loadUserProfileForm();
    });
});

// 상대방 프로필 수정 폼을 불러오는 함수
function loadUserProfileForm() {
    // #profile-edit 패널의 내용이 아직 비어있을 때만 불러옴 (중복 요청 방지)
    if ($('#profile-edit').children().length === 0) {
        $('#profile-edit').load('${pageContext.request.contextPath}/player/profile .profile-form', function(response, status, xhr) {
            if (status === "error") {
                console.error("프로필 수정 폼 로드 실패:", xhr.statusText);
                $('#profile-edit').html('<p class="text-danger p-3">프로필 수정 정보를 불러오는데 실패했습니다.</p>');
            }
        });
    }
}