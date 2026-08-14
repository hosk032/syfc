/* ==========================================================================
   구단주 마이페이지 (ownerpage.js) 전체 이벤트 및 통합 함수 스크립트 (v2.4)
   ========================================================================== */

// 전역 변수: 선택된 경기장 이름 및 타임슬롯 참가 선수 수
let selectedStadiumName = "쌍용 주 경기장";
let currentSelectedPlayerCount = 0;

// 페이지 로드 시 부트스트랩 툴팁 활성화
document.addEventListener('DOMContentLoaded', function() {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function(tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
});

// 라디오 버튼 선택 시 선택된 타임의 인원수를 세팅
function checkPlayerCount(count) {
    currentSelectedPlayerCount = count;
}


/* ==========================================================================
   [탭 1] 구단 정보 등록 및 수정 전용
   ========================================================================== */

// 구단 엠블럼 이미지 파일 미리보기
function previewImage(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            const emblemPreview = document.getElementById('emblemPreview');
            if (emblemPreview) {
                emblemPreview.innerHTML =
                    '<img src="' + e.target.result + '" class="w-100 h-100" style="object-fit: cover;">';
            }
        }
        reader.readAsDataURL(input.files[0]);
    }
}

// 구단 정보 수정 저장
function saveTeamInfo() {
    const form = document.getElementById("teamEditForm");
    if (form && form.teamName && !form.teamName.value.trim()) {
        alert("구단명을 입력해 주세요.");
        form.teamName.focus();
        return;
    }

    if (confirm("구단 정보를 수정하시겠습니까?")) {
        alert("구단 정보가 성공적으로 수정되었습니다.");
        // 백엔드 연동 시 주석 해제
        // if (form) form.submit();
    }
}


/* ==========================================================================
   [탭 2] 구단 경기 이력 / 성적 조회 전용
   ========================================================================== */

// 연도/월별 경기 성적 이력 조회 함수 (Empty State 처리 포함)
function loadTeamHistory() {
    const yearSelect = document.getElementById('searchYear');
    if (!yearSelect) return;

    const year = yearSelect.value;
    const summaryTotal = document.getElementById('summaryTotal');
    const summaryRecord = document.getElementById('summaryRecord');
    const summaryWinRate = document.getElementById('summaryWinRate');
    const summaryGoals = document.getElementById('summaryGoals');
    const totalCount = document.getElementById('searchTotalCount');
    const matchHistoryList = document.getElementById('matchHistoryList');

    if (year === '2025') {
        if (summaryTotal) summaryTotal.innerText = '24전';
        if (summaryRecord) summaryRecord.innerText = '18승 2무 4패';
        if (summaryWinRate) summaryWinRate.innerText = '75.0%';
        if (summaryGoals) summaryGoals.innerText = '60 / 25';
        if (totalCount) totalCount.innerText = '24';

        if (matchHistoryList) {
            matchHistoryList.innerHTML = `
                <tr>
                    <td class="text-muted">2025-11-15 19:00</td>
                    <td class="fw-semibold">상암 보조경기장</td>
                    <td><span class="badge bg-light text-dark border me-1">홈</span><strong class="text-dark">FC 쌍용</strong> vs 불꽃 FC</td>
                    <td class="fw-bold fs-6 text-primary">3 : 1</td>
                    <td><span class="badge bg-primary px-3 py-1">승리</span></td>
                </tr>
                <tr>
                    <td class="text-muted">2025-10-10 18:00</td>
                    <td class="fw-semibold">잠실 풋살파크</td>
                    <td><span class="badge bg-light text-dark border me-1">원정</span>번개 FC vs <strong class="text-dark">FC 쌍용</strong></td>
                    <td class="fw-bold fs-6 text-danger">1 : 2</td>
                    <td><span class="badge bg-danger px-3 py-1">패배</span></td>
                </tr>
            `;
        }
    } else if (year === '2024') {
        if (summaryTotal) summaryTotal.innerText = '0전';
        if (summaryRecord) summaryRecord.innerText = '0승 0패';
        if (summaryWinRate) summaryWinRate.innerText = '0.0%';
        if (summaryGoals) summaryGoals.innerText = '0 / 0';
        if (totalCount) totalCount.innerText = '0';

        if (matchHistoryList) {
            matchHistoryList.innerHTML = `
                <tr>
                    <td colspan="5" class="py-5 text-center text-muted">
                        <i class="bi bi-journal-x fs-1 d-block mb-2 text-secondary opacity-50"></i>
                        조회된 경기 이력이 없습니다.
                    </td>
                </tr>
            `;
        }
    } else {
        if (summaryTotal) summaryTotal.innerText = '16전';
        if (summaryRecord) summaryRecord.innerText = '12승 4패';
        if (summaryWinRate) summaryWinRate.innerText = '75.0%';
        if (summaryGoals) summaryGoals.innerText = '42 / 18';
        if (totalCount) totalCount.innerText = '16';

        if (matchHistoryList) {
            matchHistoryList.innerHTML = `
                <tr>
                    <td class="text-muted">2026-08-01 20:00</td>
                    <td class="fw-semibold">쌍용 주 경기장</td>
                    <td><span class="badge bg-light text-dark border me-1">홈</span><strong class="text-dark">FC 쌍용</strong> vs 드림 FC</td>
                    <td class="fw-bold fs-6 text-primary">4 : 2</td>
                    <td><span class="badge bg-primary px-3 py-1">승리</span></td>
                </tr>
                <tr>
                    <td class="text-muted">2026-07-25 18:00</td>
                    <td class="fw-semibold">마포 구민 체육센터</td>
                    <td><span class="badge bg-light text-dark border me-1">홈</span><strong class="text-dark">FC 쌍용</strong> vs 마포 풋살 클럽</td>
                    <td class="fw-bold fs-6 text-secondary">2 : 2</td>
                    <td><span class="badge bg-secondary px-3 py-1">무승부</span></td>
                </tr>
            `;
        }
    }
}


/* ==========================================================================
   [탭 3] 입단 승인 관리 전용
   ========================================================================== */

// 입단 승인 처리
function approvePlayer(name, rowId) {
    if (confirm(`${name} 선수의 입단을 승인하시겠습니까?\n승인 시 소속 선수 목록으로 이동합니다.`)) {
        alert(`${name} 선수의 입단 승인이 완료되었습니다.`);

        const row = document.getElementById(`approval-row-${rowId}`);
        if (row) row.remove();

        updatePendingCount();
    }
}

// 입단 거절 모달 열기
function openRejectModal(name, rowId) {
    const applicantNameElem = document.getElementById('rejectApplicantName');
    const targetNameInput = document.getElementById('targetRejectName');

    if (applicantNameElem) applicantNameElem.innerText = name;
    if (targetNameInput) {
        targetNameInput.value = name;
        targetNameInput.setAttribute('data-row-id', rowId);
    }

    const selectBox = document.getElementById('rejectReasonSelect');
    if (selectBox) selectBox.value = "정원 초과";

    const textarea = document.getElementById('rejectReasonText');
    if (textarea) textarea.value = "포지션 정원이 초과되었습니다.";

    const modalElement = document.getElementById('rejectReasonModal');
    if (modalElement) {
        const rejectModal = bootstrap.Modal.getOrCreateInstance(modalElement);
        rejectModal.show();
    }
}

// 거절 사유 셀렉트 박스 변경 이벤트
function changeRejectReason(value) {
    const textarea = document.getElementById('rejectReasonText');
    const selectBox = document.getElementById('rejectReasonSelect');

    if (!textarea || !selectBox) return;

    if (value === 'custom') {
        textarea.value = '';
        textarea.focus();
    } else {
        textarea.value = selectBox.options[selectBox.selectedIndex].text;
    }
}

// 입단 거절 확정 제출
function submitRejectReason() {
    const nameInput = document.getElementById('targetRejectName');
    if (!nameInput) return;

    const name = nameInput.value;
    const rowId = nameInput.getAttribute('data-row-id');
    const reasonText = document.getElementById('rejectReasonText');
    const reason = reasonText ? reasonText.value.trim() : '';

    if (!reason) {
        alert('거절 사유를 입력해 주세요.');
        if (reasonText) reasonText.focus();
        return;
    }

    if (confirm(`${name} 선수의 입단 신청을 거절하시겠습니까?\n[거절 사유]: ${reason}`)) {
        alert('입단 거절 처리가 완료되었습니다.');

        const modalElement = document.getElementById('rejectReasonModal');
        if (modalElement) {
            const modal = bootstrap.Modal.getInstance(modalElement);
            if (modal) modal.hide();
        }

        const row = document.getElementById(`approval-row-${rowId}`);
        if (row) row.remove();

        updatePendingCount();
    }
}

// 입단 대기 건수 및 사이드바 뱃지 업데이트
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
   [탭 4] 소속 선수 목록 전용 (제적 및 필터링)
   ========================================================================== */

// 소속 선수 제적 처리
function removePlayer(name, rowId) {
    if (confirm(`정말로 ${name} 선수를 구단에서 제적(강퇴)하시겠습니까?\n제적 처리 시 선수 목록에서 즉시 삭제됩니다.`)) {
        alert(`${name} 선수가 제적 처리되었습니다.`);

        const row = document.getElementById(`player-row-${rowId}`);
        if (row) row.remove();

        updateTotalPlayerCount();
    }
}

// 전체 선수 수 차감 및 Empty State 체크
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

// 선수명 및 포지션 실시간 필터링
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
   [탭 5] 경기장 예약 & 경기 매칭 / 모집글 작성 전용
   ========================================================================== */

// 1. 홈팀 모집 vs 어웨이 참가 모드 전환
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

// 2. 가능 경기장 조회
function searchStadiums() {
    const date = document.getElementById('searchDate') ? document.getElementById('searchDate').value : '';
    const region = document.getElementById('searchRegion') ? document.getElementById('searchRegion').value : '';
    alert(`[${region}] ${date} 날짜에 사용 가능한 경기장을 DB에서 불러옵니다.`);
}

// 3. 경기장 카드 선택 visual Highlight
function selectStadiumCard(element, name, address, price) {
    const cards = document.querySelectorAll('.stadium-card');
    cards.forEach(card => {
        card.classList.remove('border-primary', 'bg-primary-subtle', 'selected');
    });

    element.classList.add('border-primary', 'bg-primary-subtle', 'selected');
    selectedStadiumName = name;
}

// 4. 모집글 작성 모달 오픈 및 데이터 연결
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

// 5. 모집글 최종 등록 제출
function submitMatchPost() {
    const titleInput = document.getElementById('postTitle');
    const title = titleInput ? titleInput.value.trim() : '';

    if (!title) {
        alert('모집글 제목을 입력해 주세요.');
        if (titleInput) titleInput.focus();
        return;
    }

    if (confirm(`선수 모집글 [${title}]을(를) 등록하시겠습니까?\n등록 후 선수가 모두 모이면 경기장을 최종 대관할 수 있습니다.`)) {
        alert('선수 모집글이 성공적으로 등록되었습니다!\n일반 선수 마이페이지의 [경기 참가 신청] 탭에 노출됩니다.');

        const modalElem = document.getElementById('matchPostModal');
        if (modalElem) {
            const modal = bootstrap.Modal.getInstance(modalElem);
            if (modal) modal.hide();
        }
    }
}

// 6. 타임슬롯 선택 후 경기 신청 검증
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
        alert(`[신청 불가] ${minRequired}대${minRequired} 경기는 최소 ${minRequired}명 이상의 소속 선수가 모여야 구단주가 신청할 수 있습니다.\n(현재 참가 신청 선수: ${currentSelectedPlayerCount}명)`);
        return;
    }

    const isHome = selectedSlot.value.includes("home");
    const roleText = isHome ? "[홈팀 - 신규 모집]" : "[어웨이팀 - 매칭 참가]";

    if (confirm(`선택하신 타임에 ${roleText} (${minRequired}:${minRequired} / ${genderText})으로 경기 신청을 진행하시겠습니까?`)) {
        alert("경기장 예약 및 매칭 신청이 성공적으로 완료되었습니다!");
    }
}


/* ==========================================================================
   [탭 6] 구단주 변경 / 권한 양도 신청 전용
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

    const confirmMessage = `⚠️ [경고] 구단주 권한을 정말로 변경하시겠습니까?\n\n` +
        `· 차기 구단주: ${selectedName}\n` +
        `· 변경 후 본인 계정: 일반 소속 선수로 변경됨\n\n` +
        `이 작업은 즉시 실행되며 취소할 수 없습니다.`;

    if (confirm(confirmMessage)) {
        alert(`${selectedName} 선수에게 구단주 권한 양도 신청이 성공적으로 완료되었습니다.\n마이페이지로 이동합니다.`);
        // 백엔드 연동 시 주석 해제 후 submit
        // document.getElementById('ownerTransferForm').submit();
    }
}

/* ==========================================================================
   [신규 탭] 선수 평점 & 경기 성적 관리 전용 (등록, 수정, 삭제)
   ========================================================================== */

// 1. 성적 저장 (신규 등록 및 수정 처리)
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
        ? `[${matchDate}] ${playerName} 선수의 경기 성적 및 평점을 수정하시겠습니까?`
        : `[${matchDate}] ${playerName} 선수의 경기 성적 및 평점을 등록하시겠습니까?`;

    if (confirm(confirmMsg)) {
        alert(isEdit ? "성적이 성공적으로 수정되었습니다." : "성적이 성공적으로 등록되었습니다.");

        // 프론트엔드 입력 폼 리셋
        resetRatingForm();

        // 백엔드 연결 시: AJAX 호출 또는 form.submit() 진행
    }
}

// 2. 수정 버튼 클릭 시 목록 데이터를 입력 폼에 바인딩
function editMatchRecord(recordId) {
    const row = document.getElementById(`record-row-${recordId}`);
    if (!row) return;

    // dataset에서 기존 기록 추출
    const date = row.getAttribute('data-date');
    const playerId = row.getAttribute('data-player-id');
    const score = row.getAttribute('data-score');
    const goal = row.getAttribute('data-goal');
    const assist = row.getAttribute('data-assist');
    const ownGoal = row.getAttribute('data-owngoal');
    const yellow = row.getAttribute('data-yellow') === 'true';
    const red = row.getAttribute('data-red') === 'true';
    const comment = row.getAttribute('data-comment');

    // 입력 폼에 값 채우기
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

    // 폼 UI를 [수정 모드]로 전환
    document.getElementById('ratingFormTitle').innerText = "경기 성적 수정";
    document.getElementById('btnSubmitRating').innerHTML = `<i class="bi bi-pencil-square me-1"></i>성적 수정 완료`;
    document.getElementById('btnCancelEdit').classList.remove('d-none');

    // 입력 폼 위치로 상단 스크롤
    document.getElementById('playerRatingForm').scrollIntoView({ behavior: 'smooth' });
}

// 3. 수정 취소 / 폼 초기화 (등록 모드로 복귀)
function resetRatingForm() {
    document.getElementById('playerRatingForm').reset();
    document.getElementById('recordIdx').value = "";

    document.getElementById('ratingFormTitle').innerText = "경기 성적 등록 / 수정";
    document.getElementById('btnSubmitRating').innerHTML = `<i class="bi bi-check-lg me-1"></i>성적 저장하기`;
    document.getElementById('btnCancelEdit').classList.add('d-none');
}

// 4. 성적 기록 삭제
function deleteMatchRecord(recordId) {
    if (confirm("해당 경기 성적 기록을 삭제하시겠습니까?\n삭제된 기록은 복구되지 않습니다.")) {
        alert("기록이 삭제되었습니다.");

        const row = document.getElementById(`record-row-${recordId}`);
        if (row) row.remove();
    }
}