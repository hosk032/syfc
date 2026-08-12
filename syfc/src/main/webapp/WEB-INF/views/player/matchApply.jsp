<%@ page language="java" contentType="text/html; charset=UTF-8"%>    
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<title>쌍용축구예약 - 경기 매칭 & 참가 모집</title>
	<!-- 공통 리소스 -->
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
	
	<!-- 지연씨 css 외부로 빼셔야합니다 -->
	<style>
		.nav-pills .nav-link.active { background-color: #6b4ba1 !important; color: #fff !important; font-weight: bold; }
		.nav-pills .nav-link { color: #495057; border-radius: 12px; padding: 10px 20px; }
		.stadium-card:hover { border-color: #6b4ba1 !important; cursor: pointer; }
		.stadium-card.selected { border: 2px solid #6b4ba1 !important; background-color: #f5f0ff; }
	</style>
	<!-- 지연씨 css 외부로 빼셔야합니다 -->
	
</head>
<body class="bg-light">

	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<div class="container py-4">

		<!-- 상단 타이틀 -->
		<div class="card border-0 shadow-sm rounded-4 mb-4">
			<div class="card-body p-4 d-flex align-items-center justify-content-between">
				<div class="d-flex align-items-center">
					<div class="bg-primary bg-opacity-10 text-primary rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 56px; height: 56px; font-size: 24px;">
						⚽
					</div>
					<div>
						<h4 class="mb-0 fw-bold text-dark">경기 매칭 & 참가 선수 모집</h4>
						<p class="text-secondary mb-0 small">경기장을 검색하여 매칭을 개설하거나, 참가 모집 게시글에서 출전을 신청하세요.</p>
					</div>
				</div>
			</div>
		</div>

		<!-- 탭 구성 (1: 경기 매칭 개설 / 2: 모집 게시판 / 3: 구단주 경기신청 이력) -->
		<div class="card border-0 shadow-sm rounded-4 p-3 mb-4">
			<ul class="nav nav-pills nav-fill gap-2" id="matchTab" role="tablist">
				<li class="nav-item">
					<button class="nav-link active" id="create-tab" data-bs-toggle="pill" data-bs-target="#create-pane" type="button">
						📅 1. 경기 매칭 개설 (구단주)
					</button>
				</li>
				<li class="nav-item">
					<button class="nav-link" id="board-tab" data-bs-toggle="pill" data-bs-target="#board-pane" type="button">
						🏃 2. 참가 선수 모집 게시판 (선수/구단주)
					</button>
				</li>
				<li class="nav-item">
					<button class="nav-link" id="history-tab" data-bs-toggle="pill" data-bs-target="#history-pane" type="button">
						📋 4. 경기 신청 이력 (구단주)
					</button>
				</li>
			</ul>
		</div>

		<div class="tab-content" id="matchTabContent">

			<!-- ================= [요구사항 1] 경기 매칭 개설 (구단주) ================= -->
			<div class="tab-pane fade show active" id="create-pane" role="tabpanel">
				<div class="card border-0 shadow-sm rounded-4 p-4">
					<h5 class="fw-bold mb-3"><i class="bi bi-search text-primary me-2"></i>(1) 이용 가능한 경기장 검색</h5>
					
					<!-- 1-(1) 검색 필터: 날짜 - 지역 -->
					<div class="row g-3 p-3 bg-light rounded-3 mb-4">
						<div class="col-md-4">
							<label class="form-label small fw-bold">날짜 선택</label>
							<input type="date" class="form-control" id="searchDate" value="2026-08-20">
						</div>
						<div class="col-md-4">
							<label class="form-label small fw-bold">지역 선택</label>
							<select class="form-select" id="searchRegion">
								<option value="서울 마포구" selected>서울 마포구</option>
								<option value="서울 강남구">서울 강남구</option>
								<option value="경기 고양시">경기 고양시</option>
							</select>
						</div>
						<div class="col-md-4 d-flex align-items-end">
							<button type="button" class="btn btn-primary w-100 fw-bold" onclick="searchStadiums()">
								<i class="bi bi-search me-1"></i> 가능 경기장 조회 (DB)
							</button>
						</div>
					</div>

					<!-- 조회된 경기장 목록 영역 -->
					<h6 class="fw-bold mb-2">조회된 경기장 선택 및 경기 종류 선택</h6>
					<div class="row g-3 mb-4" id="stadiumListArea">
						<div class="col-md-6">
							<div class="card stadium-card border p-3 rounded-3 shadow-sm" onclick="selectStadium(this, '쌍용 주 경기장')">
								<div class="d-flex justify-content-between align-items-center mb-2">
									<h6 class="fw-bold mb-0">쌍용 주 경기장</h6>
									<span class="badge bg-success">예약가능</span>
								</div>
								<p class="text-muted extra-small mb-1">서울 마포구 월드컵북로 21 | 인조잔디</p>
								<div class="text-primary fw-bold small">100,000원 / 2시간</div>
							</div>
						</div>
					</div>

					<!-- 경기 종류 선택 (대분류, 중분류) -->
					<div class="row g-3 mb-4">
						<div class="col-md-6">
							<label class="form-label small fw-bold">경기 종류 (대분류)</label>
							<select class="form-select" id="matchTypeMain" onchange="changeSubTypes(this.value)">
								<option value="11" selected>11vs11 정규 축구</option>
								<option value="6">6vs6 풋살</option>
							</select>
						</div>
						<div class="col-md-6">
							<label class="form-label small fw-bold">성별/유형 (중분류)</label>
							<select class="form-select" id="matchTypeSub">
								<option value="남성">남성 매치</option>
								<option value="여성">여성 매치</option>
								<option value="혼성">혼성 매치</option>
							</select>
						</div>
					</div>

					<hr class="my-4">

					<!-- 1-(2) 매칭 대기 중인 다른 팀 선택 옵션 -->
					<h5 class="fw-bold mb-3"><i class="bi bi-calendar-event text-primary me-2"></i>(2) 또는, 기존 매칭 대기중인 팀 선택</h5>
					<div class="p-3 bg-white border rounded-3 mb-4">
						<div class="form-check">
							<input class="form-check-input" type="radio" name="existingMatch" id="matchA" value="A팀 (2026-08-20 / 잠실경기장)">
							<label class="form-check-label small fw-bold text-dark" for="matchA">
								[매칭 대기중] A팀 - 2026년 8월 20일 | 잠실 경기장 (어웨이 참가)
							</label>
						</div>
					</div>

					<div class="d-flex justify-content-end">
						<!-- 요구사항 (3): 모달창 열기 -->
						<button type="button" class="btn btn-primary px-4 fw-bold" onclick="openWriteModal()">
							글 작성하기 (모달)
						</button>
					</div>
				</div>
			</div>

			<!-- ================= [요구사항 2] 참가 선수 모집 게시판 목록 ================= -->
			<div class="tab-pane fade" id="board-pane" role="tabpanel">
				<div class="card border-0 shadow-sm rounded-4 p-4">
					<h5 class="fw-bold mb-3">경기 참가 선수 모집 게시판</h5>
					<div class="list-group">
						<a href="javascript:void(0)" class="list-group-item list-group-item-action p-3 rounded-3 mb-2 border" onclick="viewPostDetail(101)">
							<div class="d-flex justify-content-between align-items-center mb-1">
								<h6 class="fw-bold text-dark mb-0">[FC 쌍용] 8/20 마포 경기 용병 및 출전 선수 모집합니다!</h6>
								<span class="badge bg-primary">모집중 (8/11명)</span>
							</div>
							<p class="text-muted small mb-0">일시: 2026-08-20 18:00 | 경기장: 쌍용 주 경기장 | 종목: 11vs11 남성</p>
						</a>
					</div>
				</div>
			</div>

			<!-- ================= [요구사항 4] 구단주 경기 신청 이력 페이지 ================= -->
			<div class="tab-pane fade" id="history-pane" role="tabpanel">
				<div class="card border-0 shadow-sm rounded-4 p-4">
					<h5 class="fw-bold mb-3">구단주 경기 신청 이력</h5>

					<!-- (1) 홈팀 개별 신청 이력 카드 -->
					<div class="card border rounded-3 p-3 mb-3 bg-white shadow-sm">
						<div class="d-flex justify-content-between align-items-center mb-2">
							<span class="fw-bold text-dark">[홈팀] 2026-08-20 18:00 | 쌍용 주 경기장 (오후 / 11vs11 혼성)</span>
							<span class="badge bg-warning text-dark">매칭 대기</span>
						</div>
						<div class="p-3 bg-light rounded-3 small">
							<!-- 상대팀이 없을 때 -->
							<div class="text-muted">아직 상대팀이 신청하지 않았습니다.</div>
							<hr class="my-2">
							<!-- 상대팀이 신청했을 때 -->
							<div class="d-flex justify-content-between align-items-center mt-2">
								<span>신청한 상대팀: <strong>FC 드림 (구단주: 이영희)</strong></span>
								<div>
									<button class="btn btn-sm btn-primary px-3 me-1" onclick="acceptOpponent('FC 드림')">수락</button>
									<button class="btn btn-sm btn-outline-danger px-3" onclick="rejectOpponent('FC 드림')">거절</button>
								</div>
							</div>
						</div>
					</div>

					<!-- (2) 원정팀 개별 신청 이력 카드 -->
					<div class="card border rounded-3 p-3 mb-3 bg-white shadow-sm">
						<div class="d-flex justify-content-between align-items-center mb-2">
							<span class="fw-bold text-dark">[원정팀] 2026-08-22 20:00 | 잠실 경기장 (야간 / 6vs6 남성)</span>
							<span class="badge bg-info text-white">수락 대기중</span>
						</div>
						<div class="p-3 bg-light rounded-3 small text-muted">
							상대팀(홈팀: FC 마포)이 아직 수락하지 않았습니다.
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>

	<!-- ★ [요구사항 1-(3)] 글 입력 모달 ★ -->
	<div class="modal fade" id="writeModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content border-0 rounded-4 shadow">
				<div class="modal-header border-bottom pb-3">
					<h6 class="fw-bold mb-0">모집 게시글 작성</h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body py-3">
					<div class="mb-3">
						<label class="form-label small fw-bold">제목</label>
						<input type="text" class="form-control" id="postTitle" placeholder="예: [FC 쌍용] 8/20 경기 출전 선수 모집합니다!">
					</div>
					<div class="mb-3">
						<label class="form-label small fw-bold">내용 (기본 텍스트 입력창)</label>
						<textarea class="form-control" id="postContent" rows="5" placeholder="선수들에게 전달할 전달사항 및 안내글을 입력하세요."></textarea>
					</div>
				</div>
				<div class="modal-footer border-top pt-2">
					<button type="button" class="btn btn-light border btn-sm" data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary btn-sm px-4 fw-bold" onclick="createPost()">게시글 생성</button>
				</div>
			</div>
		</div>
	</div>

	<!-- ★ [요구사항 1-(4), 2, 3] 게시글 상세 & 선수 참가신청 모달 ★ -->
	<div class="modal fade" id="postDetailModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content border-0 rounded-4 shadow">
				<div class="modal-header border-bottom pb-3">
					<h5 class="fw-bold mb-0" id="detailTitle">[제목] 구단주가 입력한 제목</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body py-4">
					
					<!-- 경기 정보 표시 카드 (지도 API 포함) -->
					<div class="card border-0 bg-light rounded-3 p-3 mb-3">
						<h6 class="fw-bold text-primary mb-2"><i class="bi bi-info-circle me-1"></i> 경기 상세 정보</h6>
						<div class="row g-2 small text-dark mb-3">
							<div class="col-6">📍 경기장: <strong>쌍용 주 경기장</strong></div>
							<div class="col-6">📅 일시: <strong>2026-08-20 18:00</strong></div>
							<div class="col-6">⚽ 경기종류: <strong>11vs11 남성 매치</strong></div>
							<div class="col-6">⚔️ 상대팀: <strong>매칭 대기 중</strong></div>
						</div>
						<!-- 지도 API 영역 -->
						<div class="bg-secondary-subtle rounded text-center p-3 text-muted extra-small">
							<i class="bi bi-map fs-3 d-block mb-1"></i>
							지도 API 영역 (경기장 위치 표시)
						</div>
					</div>

					<!-- 구단주가 작성한 내용 -->
					<div class="mb-4 p-2">
						<h6 class="fw-bold small text-muted mb-1">구단주 작성 내용</h6>
						<p id="detailContent" class="small text-dark mb-0">지각하지 말고 17:30까지 경기장 로비로 모여주세요!</p>
					</div>

					<hr>

					<!-- [요구사항 2-(2)] 참가 신청 선수 목록 (AJAX) -->
					<div class="mb-3">
						<div class="d-flex justify-content-between align-items-center mb-2">
							<h6 class="fw-bold mb-0">참가 신청 선수 목록</h6>
							<span class="badge bg-primary" id="playerCountBadge">8 / 11명</span>
						</div>
						<ul class="list-group list-group-flush border rounded-3 small" id="applicantList">
							<li class="list-group-item d-flex justify-content-between align-items-center">
								<span>홍길동 (MF)</span>
								<span class="text-muted extra-small">2026-08-11 신청</span>
							</li>
							<li class="list-group-item d-flex justify-content-between align-items-center">
								<span>박지성 (FW)</span>
								<span class="text-muted extra-small">2026-08-11 신청</span>
							</li>
						</ul>
					</div>
				</div>

				<div class="modal-footer border-top pt-3 d-flex justify-content-between">
					<!-- 일반 선수용 버튼 [요구사항 2-(1)] -->
					<div id="playerBtnArea">
						<button type="button" class="btn btn-outline-primary px-4 fw-bold" id="btnApply" onclick="togglePlayerApply(true)">
							참가신청
						</button>
						<button type="button" class="btn btn-danger px-4 fw-bold d-none" id="btnCancel" onclick="togglePlayerApply(false)">
							신청취소
						</button>
					</div>

					<!-- 구단주용 버튼 [요구사항 3] -->
					<div id="ownerBtnArea">
						<!-- 인원 충족 시 활성화 (disabled 해제) -->
						<button type="button" class="btn btn-success px-4 fw-bold" id="btnFinalMatch" onclick="submitFinalMatch()" disabled>
							경기 신청 (인원 미달)
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

	<!-- 스크립트 -->
	<!-- 지연씨 js 외부로 빼셔야합니다 -->
	<script>
		let selectedStadiumName = "";
		let isApplied = false; // 로그인 선수의 신청 여부
		let currentPlayers = 8; // 현재 신청 인원
		const maxPlayers = 11;  // 목표 인원 (11명 또는 6명)

		// 1-(1) 경기장 조회 (DB 연동)
		function searchStadiums() {
			alert("DB에서 해당 날짜/지역의 이용 가능한 경기장을 검색합니다.");
		}

		function selectStadium(element, name) {
			document.querySelectorAll('.stadium-card').forEach(c => c.classList.remove('selected'));
			element.classList.add('selected');
			selectedStadiumName = name;
		}

		// 1-(3) 모달창 열기
		function openWriteModal() {
			const modal = new bootstrap.Modal(document.getElementById('writeModal'));
			modal.show();
		}

		// 1-(4) 게시글 생성
		function createPost() {
			alert("게시글이 성공적으로 등록되었습니다!");
			bootstrap.Modal.getInstance(document.getElementById('writeModal')).hide();
		}

		// 2. 게시글 상세 보기 모달
		function viewPostDetail(id) {
			const modal = new bootstrap.Modal(document.getElementById('postDetailModal'));
			modal.show();
		}

		// 2-(1), 2-(2) 선수 참가신청 / 신청취소 토글 (AJAX)
		function togglePlayerApply(apply) {
			isApplied = apply;
			const btnApply = document.getElementById('btnApply');
			const btnCancel = document.getElementById('btnCancel');
			const list = document.getElementById('applicantList');

			if (apply) {
				btnApply.classList.add('d-none');
				btnCancel.classList.remove('d-none');
				currentPlayers++;
				
				// AJAX 리스트 추가 예시
				list.innerHTML += `<li class="list-group-item d-flex justify-content-between align-items-center" id="myApplyRow">
					<span><strong>손흥민 (FW) [나]</strong></span>
					<span class="text-muted extra-small">방금 전</span>
				</li>`;
			} else {
				btnCancel.classList.add('d-none');
				btnApply.classList.remove('d-none');
				currentPlayers--;
				
				const row = document.getElementById('myApplyRow');
				if(row) row.remove();
			}

			// 카운트 갱신
			document.getElementById('playerCountBadge').innerText = `${currentPlayers} / ${maxPlayers}명`;

			// 3. 인원 충족 시 구단주 '경기 신청' 버튼 활성화 체크
			const btnFinal = document.getElementById('btnFinalMatch');
			if (currentPlayers >= maxPlayers) {
				btnFinal.disabled = false;
				btnFinal.innerText = "경기 신청 가능! (클릭)";
				btnFinal.classList.replace('btn-secondary', 'btn-success');
			} else {
				btnFinal.disabled = true;
				btnFinal.innerText = `경기 신청 (${currentPlayers}/${maxPlayers}명)`;
			}
		}

		// 3. 구단주 최종 경기 신청 (예약 가능 여부 체크 예시)
		function submitFinalMatch() {
			// 도중에 예약이 생기거나 불가능해진 경우 예시
			const isAvailable = true; // DB 체크 결과

			if (!isAvailable) {
				alert("해당 경기장은 해당 일시에 이용 불가합니다. 다른 일시나 경기장을 선택해주세요.");
				return;
			}

			if (confirm("인원이 모두 모였습니다! 정식 경기장 예약을 신청하시겠습니까?")) {
				alert("경기장 신청이 성공적으로 완료되었습니다!");
			}
		}

		// 4-(1) 구단주: 상대팀 수락 / 거절
		function acceptOpponent(teamName) {
			if(confirm(`[${teamName}]의 매칭 신청을 수락하시겠습니까?`)) {
				alert("매칭이 확정되었습니다!");
			}
		}
		function rejectOpponent(teamName) {
			if(confirm(`[${teamName}]의 매칭 신청을 거절하시겠습니까?`)) {
				alert("거절 처리되었습니다.");
			}
		}
	</script>
	
	<!-- 지연씨 js 외부로 빼셔야합니다 -->
</body>
</html>