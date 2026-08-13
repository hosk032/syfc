<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="tab-pane fade" id="match-apply">
	<div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
		<div class="d-flex align-items-center justify-content-between pb-3 mb-4 border-bottom">
			<div class="d-flex align-items-center">
				<div class="bg-primary bg-opacity-10 text-primary rounded-circle d-flex align-items-center justify-content-center me-3 match-header-icon">⚽</div>
				<div>
					<h5 class="mb-1 fw-bold text-dark">경기 매칭 & 참가 선수 모집</h5>
					<p class="text-secondary mb-0 small">경기장을 선택하여 우리 팀 참가 선수를 모집하거나, 상대 팀 매칭에 참가하세요.</p>
				</div>
			</div>
		</div>

		<div class="row g-3 mb-4">
			<div class="col-md-6">
				<div class="form-check card p-3 border rounded-3 cursor-pointer shadow-sm active-match-option" id="optionCard1">
					<input class="form-check-input me-2" type="radio" name="matchMode" id="modeHome" value="HOME" checked onchange="toggleMatchMode('HOME')">
					<label class="form-check-label fw-bold text-dark cursor-pointer d-block" for="modeHome">
						<i class="bi bi-house-door-fill text-primary me-1"></i> (1) 신규 경기장 대관 & 선수 모집
						<span class="d-block extra-small text-muted fw-normal mt-1">원하는 경기장을 직접 검색하고 우리 팀 소속/용병 선수를 모집합니다.</span>
					</label>
				</div>
			</div>
			<div class="col-md-6">
				<div class="form-check card p-3 border rounded-3 cursor-pointer shadow-sm" id="optionCard2">
					<input class="form-check-input me-2" type="radio" name="matchMode" id="modeAway" value="AWAY" onchange="toggleMatchMode('AWAY')">
					<label class="form-check-label fw-bold text-dark cursor-pointer d-block" for="modeAway">
						<i class="bi bi-flag-fill text-danger me-1"></i> (2) 기존 개설된 매칭 참가 (어웨이)
						<span class="d-block extra-small text-muted fw-normal mt-1">상대 구단이 이미 경기장을 잡고 대기 중인 매칭에 우리 팀이 참가합니다.</span>
					</label>
				</div>
			</div>
		</div>

		<div id="homeMatchArea">
			<h6 class="fw-bold mb-3 text-dark"><i class="bi bi-search text-primary me-2"></i>이용 가능한 경기장 검색</h6>

			<div class="row g-3 p-3 bg-light rounded-3 mb-4 align-items-end border">
				<div class="col-md-4">
					<label class="form-label small fw-bold text-muted mb-1">날짜 선택</label>
					<input type="date" class="form-control form-control-sm fw-bold bg-white" id="searchDate" value="2026-08-20">
				</div>
				<div class="col-md-4">
					<label class="form-label small fw-bold text-muted mb-1">지역 선택</label>
					<select class="form-select form-select-sm fw-bold bg-white" id="searchRegion">
						<option value="서울 마포구" selected>서울 마포구</option>
						<option value="서울 강남구">서울 강남구</option>
						<option value="경기 고양시">경기 고양시</option>
					</select>
				</div>
				<div class="col-md-4">
					<button type="button" class="btn btn-primary btn-sm w-100 fw-bold py-2 shadow-sm" onclick="searchStadiums()">
						<i class="bi bi-search me-1"></i> 가능 경기장 조회 (DB)
					</button>
				</div>
			</div>

			<h6 class="fw-bold mb-2 small text-muted">조회된 경기장 선택 <span class="text-danger">*</span></h6>
			<div class="row g-3 mb-4" id="stadiumListArea">
				<div class="col-md-6">
					<div class="card stadium-card border p-3 rounded-3 shadow-sm bg-white cursor-pointer selected" id="stadium-card-1" onclick="selectStadiumCard(this, '쌍용 주 경기장', '서울 마포구 월드컵북로 21', '100,000원')">
						<div class="d-flex justify-content-between align-items-center mb-2">
							<h6 class="fw-bold mb-0 text-dark">쌍용 주 경기장</h6>
							<span class="badge bg-success">예약가능</span>
						</div>
						<p class="text-muted extra-small mb-1">서울 마포구 월드컵북로 21 | 인조잔디</p>
						<div class="text-primary fw-bold small">100,000원 / 2시간</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="card stadium-card border p-3 rounded-3 shadow-sm bg-white cursor-pointer" id="stadium-card-2" onclick="selectStadiumCard(this, '마포 풋살 파크', '서울 마포구 성산동 55', '80,000원')">
						<div class="d-flex justify-content-between align-items-center mb-2">
							<h6 class="fw-bold mb-0 text-dark">마포 풋살 파크</h6>
							<span class="badge bg-success">예약가능</span>
						</div>
						<p class="text-muted extra-small mb-1">서울 마포구 성산동 55 | 우레탄</p>
						<div class="text-primary fw-bold small">80,000원 / 2시간</div>
					</div>
				</div>
			</div>

			<div class="row g-3 mb-4">
				<div class="col-md-6">
					<label class="form-label small fw-bold text-muted mb-1">경기 방식 (대분류)</label>
					<select class="form-select form-select-sm fw-bold" id="matchTypeMain">
						<option value="11" selected>11 vs 11 정규 축구 (목표 11명)</option>
						<option value="6">6 vs 6 풋살 (목표 6명)</option>
					</select>
				</div>
				<div class="col-md-6">
					<label class="form-label small fw-bold text-muted mb-1">성별 / 매치 유형 (중분류)</label>
					<select class="form-select form-select-sm fw-bold" id="matchTypeSub">
						<option value="남성">남성 매치</option>
						<option value="여성">여성 매치</option>
						<option value="혼성" selected>혼성 매치</option>
					</select>
				</div>
			</div>
		</div>

		<div id="awayMatchArea" class="d-none">
			<h6 class="fw-bold mb-3 text-dark"><i class="bi bi-calendar-event text-primary me-2"></i>매칭 대기 중인 상대 팀 선택</h6>
			<div class="p-3 bg-light rounded-3 border mb-4">
				<div class="form-check mb-2">
					<input class="form-check-input" type="radio" name="existingMatch" id="matchA" value="A팀" checked>
					<label class="form-check-label small fw-bold text-dark cursor-pointer" for="matchA">
						[매칭 대기중] FC 드림 - 2026년 8월 20일 18:00 | 잠실 경기장 (11vs11 / 혼성)
					</label>
				</div>
				<div class="form-check">
					<input class="form-check-input" type="radio" name="existingMatch" id="matchB" value="B팀">
					<label class="form-check-label small fw-bold text-dark cursor-pointer" for="matchB">
						[매칭 대기중] 마포 풋살 클럽 - 2026년 8월 22일 10:00 | 상암 보조경기장 (6vs6 / 남성)
					</label>
				</div>
			</div>
		</div>

		<div class="d-flex justify-content-end pt-3 border-top">
			<button type="button" class="btn btn-primary px-4 py-2 fw-bold shadow-sm" onclick="openMatchPostModal()">
				<i class="bi bi-pencil-square me-1"></i> 선수 모집글 작성하기
			</button>
		</div>
	</div>
</div>

<div class="modal fade" id="matchPostModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content border-0 rounded-4 shadow">
			<div class="modal-header border-bottom pb-3">
				<h6 class="modal-header-title fw-bold mb-0 text-dark">
					<i class="bi bi-megaphone-fill text-primary me-2"></i>경기 참가 선수 모집글 등록
				</h6>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body py-4">
				<div class="p-3 bg-light rounded-3 mb-3 border">
					<div class="fw-bold small text-primary mb-1"><i class="bi bi-check-circle-fill me-1"></i> 선택된 경기 정보</div>
					<div class="row g-2 small text-dark" id="modalSelectedSummary">
						<div class="col-md-6">📍 경기장: <strong id="summaryStadiumName">쌍용 주 경기장</strong></div>
						<div class="col-md-6">📅 일시: <strong id="summaryDate">2026-08-20</strong></div>
						<div class="col-md-6">⚽ 경기 방식: <strong id="summaryType">11 vs 11 정규 축구</strong></div>
						<div class="col-md-6">🚻 유형: <strong id="summaryGender">혼성 매치</strong></div>
					</div>
				</div>

				<form id="matchPostForm">
					<div class="mb-3">
						<label class="form-label small fw-bold text-muted mb-1">모집글 제목 <span class="text-danger">*</span></label>
						<input type="text" class="form-control fw-bold" id="postTitle" value="[FC 쌍용] 8/20 마포 경기 출전 선수 모집합니다!">
					</div>
					<div class="row g-3 mb-3">
						<div class="col-md-6">
							<label class="form-label small fw-bold text-muted mb-1">목표 모집 인원 <span class="text-danger">*</span></label>
							<div class="input-group">
								<input type="number" class="form-control fw-bold" id="targetPlayerCount" value="11" readonly>
								<span class="input-group-text bg-light text-muted">명</span>
							</div>
							<span class="extra-small text-muted">※ 인원이 모두 채워져야 경기장을 최종 대관할 수 있습니다.</span>
						</div>
						<div class="col-md-6">
							<label class="form-label small fw-bold text-muted mb-1">모집 마감일</label>
							<input type="date" class="form-control" id="postDeadline" value="2026-08-18">
						</div>
					</div>
					<div class="mb-2">
						<label class="form-label small fw-bold text-muted mb-1">팀원 전달 사항 및 안내글</label>
						<textarea class="form-control" id="postContent" rows="3" placeholder="예: 지각없이 30분 전 도착 부탁드립니다. 유니폼은 상의 파란색입니다.">즐겁게 경기 뛰실 소속 선수 및 용병 분들 모집합니다! 시간 엄수 부탁드립니다.</textarea>
					</div>
				</form>
			</div>
			<div class="modal-footer border-top pt-3">
				<button type="button" class="btn btn-light border btn-sm px-3" data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary btn-sm px-4 fw-bold" onclick="submitMatchPost()">모집글 등록하기</button>
			</div>
		</div>
	</div>
</div>