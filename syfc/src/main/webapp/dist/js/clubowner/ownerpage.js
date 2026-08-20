/* ==========================================================================
   구단주 마이페이지 전용 통합 JS (ownerpage.js v3.1)
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

// [추가] 경기 이력 행 클릭 시 상세 모달을 띄우는 함수
function openMatchDetailModal(matchNum) {
    if (!matchNum) return;

    var reqUrl = (typeof contextPath !== 'undefined' ? contextPath : '') + '/clubowner/matchDetailModal';

    $.ajax({
        url: reqUrl,
        type: 'GET',
        data: { matchNum: matchNum },
        dataType: 'html',
        success: function(htmlResponse) {
            // 모달 바디 영역에 서버에서 받아온 상세 기록 HTML 주입
            $('#matchDetailContent').html(htmlResponse);
            
            // Bootstrap 모달 실행
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

function saveMatchRecord() {
    const matchDate = document.getElementById('matchDate').value;
    const playerSelect = document.getElementById('ratingPlayerSelect');
    const recordIdx = document.getElementById('recordIdx').value;

    if (!matchDate) {
        alert("경기 일자를 선택해 주세요.");
        return;
    }

    if (!playerSelect.value) {
        alert("대상 선수를 선택해 주세요.");
        return;
    }

    alert("성적이 정상적으로 처리되었습니다.");
    resetRatingForm();
}

function resetRatingForm() {
    document.getElementById('playerRatingForm').reset();
    document.getElementById('recordIdx').value = "";
    document.getElementById('ratingFormTitle').innerText = "경기 성적 등록 / 수정";
    document.getElementById('btnSubmitRating').innerHTML = '<i class="bi bi-check-lg me-1"></i>성적 저장하기';
    document.getElementById('btnCancelEdit').classList.add('d-none');
}