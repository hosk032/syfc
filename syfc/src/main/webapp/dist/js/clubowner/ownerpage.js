/* ==========================================================================
   구단주 마이페이지 (ownerpage.js) 전체 이벤트 및 함수 스크립트
   ========================================================================== */

// 전역 변수: 선택된 타임슬롯의 현재 참가 선수 수
let currentSelectedPlayerCount = 0;

// 라디오 버튼 선택 시 선택된 타임의 인원수를 세팅
function checkPlayerCount(count) {
    currentSelectedPlayerCount = count;
}

// 1. 선수 입단 승인 / 제적 관련
function approvePlayer(name) {
    if (confirm(`${name} 선수의 입단을 승인하시겠습니까?`)) {
        alert('입단 승인이 완료되었습니다.');
        // TODO: 백엔드 AJAX 연결
    }
}

function removePlayer(name) {
    if (confirm(`정말로 ${name} 선수를 구단에서 제적(강퇴)하시겠습니까?`)) {
        alert('제적 처리되었습니다.');
        // TODO: 백엔드 AJAX 연결
    }
}

// 2. 구단 정보 등록 및 수정 관련
function previewImage(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById('emblemPreview').innerHTML = 
                '<img src="' + e.target.result + '" class="rounded-circle w-100 h-100" style="object-fit: cover;">';
        }
        reader.readAsDataURL(input.files[0]);
    }
}

function saveTeamInfo() {
    if (confirm("구단 정보를 수정하시겠습니까?")) {
        alert("구단 정보가 성공적으로 수정되었습니다.");
        // document.getElementById("teamEditForm").submit();
    }
}

// 3. 구단주 변경 / 권한 양도 신청
function submitOwnerTransfer() {
    const form = document.getElementById('ownerTransferForm');
    if (!form) return;

    const nextOwner = form.nextOwnerId ? form.nextOwnerId.value : '';
    const password = form.currentPassword ? form.currentPassword.value : '';
    const agree = document.getElementById('transferAgree') ? document.getElementById('transferAgree').checked : false;

    if (!nextOwner) {
        alert("차기 구단주를 선택해 주세요.");
        return;
    }
    if (!password) {
        alert("현재 비밀번호를 입력해 주세요.");
        return;
    }
    if (!agree) {
        alert("권한 위임 주의사항 동의에 체크해 주세요.");
        return;
    }

    if (confirm("정말로 구단주 권한을 양도하시겠습니까?\n신청 후에는 즉시 권한이 변경되거나 승인 대기 상태로 전환됩니다.")) {
        alert("구단주 변경 신청이 완료되었습니다.");
        // form.submit();
    }
}

// 4. 경기장 선택 시 상세 정보 동적 변경
function changeStadiumInfo(stadiumId) {
    const status = document.getElementById('stadiumStatus');
    const address = document.getElementById('stadiumAddress');
    const price = document.getElementById('stadiumPrice');
    const turf = document.getElementById('stadiumTurf');

    if (!status) return;

    if (stadiumId === '1') {
        status.className = "badge bg-success position-absolute top-0 end-0 m-2 shadow-sm";
        status.innerText = "예약 가능";
        address.innerText = "서울 마포구 월드컵북로 21";
        price.innerText = "100,000원 / 2시간";
        turf.innerText = "인조잔디 / 주차 가능";
    } else if (stadiumId === '2') {
        status.className = "badge bg-success position-absolute top-0 end-0 m-2 shadow-sm";
        status.innerText = "예약 가능";
        address.innerText = "서울 마포구 성산동 55";
        price.innerText = "80,000원 / 2시간";
        turf.innerText = "우레탄 / 주차 불가";
    } else {
        status.className = "badge bg-danger position-absolute top-0 end-0 m-2 shadow-sm";
        status.innerText = "점검 중 (예약 불가)";
        address.innerText = "서울 마포구 성산동 515";
        price.innerText = "150,000원 / 2시간";
        turf.innerText = "천연잔디 / 유료 주차";
    }
}

// 5. 경기장 예약 및 매칭 신청 최종 제출 (인원수 및 성별 조건 검증)
function submitMatchBooking() {
    const selectedSlot = document.querySelector('input[name="matchSlot"]:checked');
    if (!selectedSlot) {
        alert("원하시는 경기 시간대(타임 슬롯)를 선택해 주세요.");
        return;
    }

    // A. 선택된 경기 방식 (11대11 -> 최소 11명, 6대6 -> 최소 6명)
    const matchTypeSelect = document.getElementById('matchTypeSelect');
    const minRequired = parseInt(matchTypeSelect.value); // 11 또는 6
    
    // B. 선택된 성별 옵션
    const genderSelect = document.getElementById('genderSelect');
    const genderText = genderSelect.options[genderSelect.selectedIndex].text;

    // C. 요구사항 핵심: 최소 인원수 미달 시 신청 차단
    if (currentSelectedPlayerCount < minRequired) {
        alert(`[신청 불가] ${minRequired}대${minRequired} 경기는 최소 ${minRequired}명 이상의 소속 선수가 모여야 구단주가 신청할 수 있습니다.\n(현재 참가 신청 선수: ${currentSelectedPlayerCount}명)`);
        return;
    }

    const isHome = selectedSlot.value.includes("home");
    const roleText = isHome ? "[홈팀 - 신규 모집]" : "[어웨이팀 - 매칭 참가]";

    if (confirm(`선택하신 타임에 ${roleText} (${minRequired}:${minRequired} / ${genderText})으로 경기 신청을 진행하시겠습니까?`)) {
        alert("경기장 예약 및 매칭 신청이 성공적으로 완료되었습니다!");
        // TODO: 백엔드 Controller 연동 (AJAX or Form Submit)
    }
}

// 6. 선수 평점 모달 관련 함수
function openRatingModal(playerName, currentScore, currentComment) {
    document.getElementById('modalPlayerName').innerText = playerName;
    document.getElementById('targetPlayerName').value = playerName;
    
    const scoreNum = parseFloat(currentScore);
    const scoreSelect = document.getElementById('playerScore');
    
    if (!isNaN(scoreNum) && scoreNum > 0) {
        scoreSelect.value = scoreNum.toFixed(1);
    } else {
        scoreSelect.value = "5.0";
    }
    
    document.getElementById('playerComment').value = currentComment || "";

    const modalElement = document.getElementById('playerRatingModal');
    if (modalElement) {
        const ratingModal = bootstrap.Modal.getOrCreateInstance(modalElement);
        ratingModal.show();
    }
}

function savePlayerRating() {
    const name = document.getElementById('targetPlayerName').value;
    const score = document.getElementById('playerScore').value;

    if (confirm(`${name} 선수의 평점을 [${score}점]으로 저장하시겠습니까?`)) {
        alert("선수 평점이 성공적으로 등록/수정되었습니다.");
        
        const modalElement = document.getElementById('playerRatingModal');
        const modal = bootstrap.Modal.getInstance(modalElement);
        if (modal) modal.hide();
    }
}

function deletePlayerRating() {
    const name = document.getElementById('targetPlayerName').value;

    if (confirm(`${name} 선수의 등록된 평점을 삭제하시겠습니까?`)) {
        alert("평점이 삭제되었습니다.");
        
        const modalElement = document.getElementById('playerRatingModal');
        const modal = bootstrap.Modal.getInstance(modalElement);
        if (modal) modal.hide();
    }
}

// 7. 입단 거절 사유 모달 관련 함수
function openRejectModal(name) {
    document.getElementById('rejectApplicantName').innerText = name;
    document.getElementById('targetRejectName').value = name;
    
    const selectBox = document.getElementById('rejectReasonSelect');
    selectBox.value = "정원 초과";
    document.getElementById('rejectReasonText').value = "포지션 정원이 초과되었습니다.";
    
    const modalElement = document.getElementById('rejectReasonModal');
    if (modalElement) {
        const rejectModal = bootstrap.Modal.getOrCreateInstance(modalElement);
        rejectModal.show();
    }
}

function changeRejectReason(value) {
    const textarea = document.getElementById('rejectReasonText');
    const selectBox = document.getElementById('rejectReasonSelect');
    
    if (value === 'custom') {
        textarea.value = '';
        textarea.focus();
    } else {
        textarea.value = selectBox.options[selectBox.selectedIndex].text;
    }
}

function submitRejectReason() {
    const name = document.getElementById('targetRejectName').value;
    const reason = document.getElementById('rejectReasonText').value.trim();

    if (!reason) {
        alert('거절 사유를 입력해 주세요.');
        document.getElementById('rejectReasonText').focus();
        return;
    }

    if (confirm(`${name} 선수의 입단 신청을 거절하시겠습니까?\n[사유]: ${reason}`)) {
        alert('입단 거절 처리가 완료되었습니다.');
        
        const modalElement = document.getElementById('rejectReasonModal');
        const modal = bootstrap.Modal.getInstance(modalElement);
        if (modal) modal.hide();
    }
}

// 8. 연도/월별 경기 성적 이력 조회 함수
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
        if (summaryRecord) summaryRecord.innerText = '18승 6패';
        if (summaryWinRate) summaryWinRate.innerText = '75.0%';
        if (summaryGoals) summaryGoals.innerText = '60 / 25';
        if (totalCount) totalCount.innerText = '24';

        if (matchHistoryList) {
            matchHistoryList.innerHTML = `
                <tr>
                    <td class="text-muted">2025-11-15 19:00</td>
                    <td>상암 보조경기장</td>
                    <td><strong>FC 쌍용</strong> vs 불꽃 FC</td>
                    <td class="fw-bold">3 : 1</td>
                    <td><span class="badge bg-primary px-3 py-1">승리</span></td>
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
                    <td>쌍용 주 경기장</td>
                    <td><strong>FC 쌍용</strong> vs 드림 FC</td>
                    <td class="fw-bold">4 : 2</td>
                    <td><span class="badge bg-primary px-3 py-1">승리</span></td>
                </tr>
            `;
        }
    }
}