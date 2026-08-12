<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- 1. 공통 CSS/CDN/폰트 리소스 조립 -->
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

<!-- 2. 구단주 마이페이지 전용 CSS 연결 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/clubowner/ownerpage.css" />
</head>
<body class="bg-light">

	<!-- 상단 헤더/네비게이션 -->
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<div class="container py-4">

		<!-- 1. 구단 및 구단주 요약 프로필 바 -->
		<div class="card border-0 shadow-sm rounded-4 mb-4">
			<div
				class="card-body p-4 d-flex flex-wrap align-items-center justify-content-between gap-3">
				<div class="d-flex align-items-center">
					<div
						class="bg-primary bg-opacity-10 text-primary rounded-circle d-flex align-items-center justify-content-center me-3"
						style="width: 64px; height: 64px; font-size: 28px;">⚽</div>
					<div>
						<div class="d-flex align-items-center gap-2 mb-1">
							<h4 class="mb-0 fw-bold text-dark">FC 쌍용</h4>
							<span class="badge bg-warning text-dark px-2 py-1 fs-7">구단주</span>
						</div>
						<p class="text-secondary mb-0 small">
							구단주 <strong>홍길동</strong> &nbsp;|&nbsp; 연고지 <strong>서울
								마포구</strong> &nbsp;|&nbsp; 창단일 <strong>2024-01-15</strong>
						</p>
					</div>
				</div>
				<div class="d-none d-md-flex gap-4 text-center border-start ps-4">
					<div>
						<div class="fs-4 fw-bold text-dark">18명</div>
						<div class="extra-small text-muted">소속 선수</div>
					</div>
					<div>
						<div class="fs-4 fw-bold text-primary">12승 4패</div>
						<div class="extra-small text-muted">최근 전적</div>
					</div>
					<div>
						<div class="fs-4 fw-bold text-warning">⭐ 4.8</div>
						<div class="extra-small text-muted">구단 평점</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 2. 메인 대시보드 레이아웃 -->
		<div class="row g-4">

			<!-- 왼쪽: 구단주 전용 사이드바 (LNB) -->
			<div class="col-lg-3">
				<div class="card border-0 shadow-sm rounded-4 p-3 sticky-top"
					style="top: 20px;">
					<div class="list-group list-group-flush border-0">

						<div
							class="text-uppercase text-muted fw-bold extra-small mb-2 px-2">개인
							프로필</div>
						<a href="#profile-edit"
							class="list-group-item list-group-item-action border-0 rounded-3 mb-1"
							data-bs-toggle="list"> <i class="bi bi-person-gear me-2"></i>프로필
							수정
						</a>

						<div
							class="text-uppercase text-muted fw-bold extra-small my-2 px-2">구단
							관리</div>
						<a href="#team-edit"
							class="list-group-item list-group-item-action border-0 rounded-3 mb-1"
							data-bs-toggle="list"> <i class="bi bi-shield-shaded me-2"></i>구단
							등록 / 수정
						</a> <a href="#team-history"
							class="list-group-item list-group-item-action border-0 rounded-3 mb-1"
							data-bs-toggle="list"> <i class="bi bi-journal-text me-2"></i>구단
							경기 이력 / 성적
						</a>

						<div
							class="text-uppercase text-muted fw-bold extra-small my-2 px-2">선수
							관리</div>
						<a href="#player-approval"
							class="list-group-item list-group-item-action border-0 rounded-3 mb-1 active d-flex justify-content-between align-items-center"
							data-bs-toggle="list"> <span><i
								class="bi bi-person-plus me-2"></i>입단 승인 관리</span> <span
							class="badge bg-danger rounded-pill">2</span>
						</a> <a href="#player-list"
							class="list-group-item list-group-item-action border-0 rounded-3 mb-1"
							data-bs-toggle="list"> <i class="bi bi-people me-2"></i>소속 선수
							조회 / 제적
						</a>

						<div
							class="text-uppercase text-muted fw-bold extra-small my-2 px-2">경기
							및 매칭</div>
						<a href="#match-apply"
							class="list-group-item list-group-item-action border-0 rounded-3 mb-1"
							data-bs-toggle="list"> <i class="bi bi-calendar-check me-2"></i>경기장
							예약 & 매칭
						</a>

						<div
							class="text-uppercase text-muted fw-bold extra-small my-2 px-2">설정</div>
						<a href="#owner-transfer"
							class="list-group-item list-group-item-action border-0 rounded-3 text-danger"
							data-bs-toggle="list"> <i class="bi bi-arrow-left-right me-2"></i>구단주
							변경 신청
						</a>

					</div>
				</div>
			</div>

			<!-- 오른쪽: 콘텐츠 영역 (탭 패널 연동) -->
			<div class="col-lg-9">
				<div class="tab-content">

					<!-- [탭 1] 구단 등록 / 수정 -->
					<div class="tab-pane fade" id="team-edit">
						<div class="card border-0 shadow-sm rounded-4 p-4">
							<div
								class="d-flex justify-content-between align-items-center pb-3 mb-4 border-bottom">
								<div>
									<h5 class="fw-bold mb-1">구단 정보 등록 및 수정</h5>
									<p class="text-muted small mb-0">우리 구단의 대표 이미지와 회칙, 연고지를
										관리합니다.</p>
								</div>
								<span
									class="badge bg-success-subtle text-success px-3 py-2 rounded-pill">활동
									중</span>
							</div>

							<form id="teamEditForm">
								<div
									class="p-3 bg-light rounded-4 mb-4 d-flex align-items-center gap-3">
									<div
										class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center shadow-sm"
										style="width: 80px; height: 80px; font-size: 32px;"
										id="emblemPreview">⚽</div>
									<div>
										<label class="form-label fw-bold small text-dark mb-1">구단
											엠블럼 (로고)</label>
										<p class="text-muted extra-small mb-2">권장 규격: 300x300px
											(PNG, JPG)</p>
										<input type="file" class="form-control form-control-sm"
											id="clubEmblem" accept="image/*"
											onchange="previewImage(this)">
									</div>
								</div>

								<h6 class="fw-bold text-dark mb-3">
									<i class="bi bi-info-circle text-primary me-1"></i> 기본 정보
								</h6>
								<div class="row g-3 mb-4">
									<div class="col-md-6">
										<label class="form-label small text-muted">구단명 <span
											class="text-danger">*</span></label> <input type="text"
											class="form-control" name="teamName" value="FC 쌍용" required>
									</div>
									<div class="col-md-6">
										<label class="form-label small text-muted">창단일</label> <input
											type="date" class="form-control" name="foundedDate"
											value="2024-01-15">
									</div>
									<div class="col-md-6">
										<label class="form-label small text-muted">연고지 <span
											class="text-danger">*</span></label> <select class="form-select"
											name="region">
											<option value="서울 마포구" selected>서울 마포구</option>
											<option value="서울 강남구">서울 강남구</option>
											<option value="경기 고양시">경기 고양시</option>
										</select>
									</div>
									<div class="col-md-6">
										<label class="form-label small text-muted">주 활동 시간대</label> <select
											class="form-select" name="preferredTime">
											<option value="주말 야간 (18:00~22:00)" selected>주말 야간
												(18:00~22:00)</option>
											<option value="주말 주간 (10:00~14:00)">주말 주간
												(10:00~14:00)</option>
										</select>
									</div>
								</div>

								<h6 class="fw-bold text-dark mb-3">
									<i class="bi bi-file-text text-primary me-1"></i> 구단 소개
								</h6>
								<div class="mb-3">
									<label class="form-label small text-muted">한 줄 소개</label> <input
										type="text" class="form-control" name="shortIntro"
										value="즐겁고 매너 있는 축구를 지향하는 마포구 풋살/축구 팀입니다!">
								</div>
								<div class="mb-3">
									<label class="form-label small text-muted">상세 소개글</label>
									<textarea class="form-control" name="fullIntro" rows="4">FC 쌍용은 2024년에 창단된 마포구 기반 아마추어 축구팀입니다. 매주 토요일 저녁 정기 매치를 진행하며, 매너와 친목을 최우선으로 합니다!</textarea>
								</div>
								<div class="mb-4">
									<label class="form-label small text-muted">회칙 및 가입 조건</label>
									<textarea class="form-control" name="rules" rows="3">1. 매너 플레이 필수 (지각/무단불참 금지)&#10;2. 연령대: 20대 ~ 30대&#10;3. 유니폼 착용 필수</textarea>
								</div>

								<div class="d-flex justify-content-end gap-2 pt-3 border-top">
									<button type="button" class="btn btn-primary px-4 fw-bold"
										onclick="saveTeamInfo()">저장하기</button>
								</div>
							</form>
						</div>
					</div>

					<!-- [탭 2] 구단 경기 이력 / 성적 -->
					<div class="tab-pane fade" id="team-history">
						<div class="card border-0 shadow-sm rounded-4 p-4">
							<div
								class="d-flex justify-content-between align-items-center pb-3 mb-4 border-bottom">
								<div>
									<h5 class="fw-bold mb-1">경기 이력 및 전적</h5>
									<p class="text-muted small mb-0">우리 팀의 누적 매치 통계 및 경기 결과 조회</p>
								</div>
							</div>

							<!-- ★ ID 추가: 검색 조건(연도별)에 따라 동적으로 바뀔 성적 요약 카드 ★ -->
							<div class="row g-3 mb-4">
								<div class="col-6 col-md-3">
									<div class="p-3 bg-light rounded-3 text-center">
										<div class="text-muted extra-small fw-bold">전체 경기</div>
										<div class="fs-4 fw-bold text-dark mt-1" id="summaryTotal">16전</div>
									</div>
								</div>
								<div class="col-6 col-md-3">
									<div class="p-3 bg-light rounded-3 text-center">
										<div class="text-muted extra-small fw-bold">전적</div>
										<div class="fs-4 fw-bold text-primary mt-1" id="summaryRecord">12승
											4패</div>
									</div>
								</div>
								<div class="col-6 col-md-3">
									<div class="p-3 bg-light rounded-3 text-center">
										<div class="text-muted extra-small fw-bold">승률</div>
										<div class="fs-4 fw-bold text-success mt-1"
											id="summaryWinRate">75.0%</div>
									</div>
								</div>
								<div class="col-6 col-md-3">
									<div class="p-3 bg-light rounded-3 text-center">
										<div class="text-muted extra-small fw-bold">득/실점</div>
										<div class="fs-4 fw-bold text-dark mt-1" id="summaryGoals">42
											/ 18</div>
									</div>
								</div>
							</div>

							<!-- 검색 필터 (조회 버튼에 onclick 이벤트 추가) -->
							<div
								class="d-flex flex-wrap gap-2 mb-3 align-items-center justify-content-between">
								<div class="d-flex gap-2">
									<select class="form-select form-select-sm" id="searchYear"
										style="width: 110px;">
										<option value="2026" selected>2026년</option>
										<option value="2025">2025년</option>
										<option value="2024">2024년</option>
									</select> <select class="form-select form-select-sm" id="searchMonth"
										style="width: 100px;">
										<option value="">전체 월</option>
										<option value="08" selected>8월</option>
										<option value="07">7월</option>
										<option value="06">6월</option>
									</select> <select class="form-select form-select-sm" id="searchResult"
										style="width: 110px;">
										<option value="">전체 결과</option>
										<option value="WIN">승리</option>
										<option value="LOSE">패배</option>
									</select>
									<!-- 조회 버튼 클릭 시 loadTeamHistory() 실행 -->
									<button class="btn btn-sm btn-dark px-3"
										onclick="loadTeamHistory()">조회</button>
								</div>
								<span class="text-muted small">총 <strong
									id="searchTotalCount">16</strong>건
								</span>
							</div>

							<!-- 매치 리스트 테이블 -->
							<div class="table-responsive">
								<table
									class="table table-hover align-middle text-center border-top mb-0">
									<thead class="table-light extra-small text-muted">
										<tr>
											<th>일시</th>
											<th>경기장</th>
											<th>대진 (홈 vs 원정)</th>
											<th>스코어</th>
											<th>결과</th>
										</tr>
									</thead>
									<tbody class="small" id="matchHistoryList">
										<!-- JS에서 동적으로 매치 리스트가 들어오는 영역 -->
										<tr>
											<td class="text-muted">2026-08-01 20:00</td>
											<td>쌍용 주 경기장</td>
											<td><strong>FC 쌍용</strong> vs 드림 FC</td>
											<td class="fw-bold">4 : 2</td>
											<td><span class="badge bg-primary px-3 py-1">승리</span></td>
										</tr>
										<tr>
											<td class="text-muted">2026-07-25 18:00</td>
											<td>마포 구민 체육센터</td>
											<td><strong>FC 쌍용</strong> vs 마포 풋살 클럽</td>
											<td class="fw-bold">2 : 2</td>
											<td><span class="badge bg-secondary px-3 py-1">무승부</span></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					
					<!-- [탭 3] 입단 승인 관리 (기본 활성화) -->
					<div class="tab-pane fade show active" id="player-approval">
						<div class="card border-0 shadow-sm rounded-4 p-4">
							<div
								class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom">
								<h5 class="fw-bold mb-0">입단 신청 관리</h5>
								<span class="text-muted small">대기 중: <strong
									class="text-danger">2건</strong></span>
							</div>

							<div class="table-responsive">
								<table class="table table-hover align-middle mb-0">
									<thead class="table-light extra-small text-muted">
										<tr>
											<th>신청자</th>
											<th>포지션</th>
											<th>신청일자</th>
											<th class="text-end">승인 / 거절</th>
										</tr>
									</thead>
									<tbody class="small">
										<tr>
											<td class="fw-bold">김철수 (26세)</td>
											<td><span class="badge bg-light text-dark border">MF</span></td>
											<td class="text-muted">2026-08-03</td>
											<td class="text-end">
												<button class="btn btn-sm btn-primary px-3 me-1"
													onclick="approvePlayer('김철수')">승인</button> <!-- 거절 버튼 클릭 시 모달 열기 함수 호출 -->
												<button class="btn btn-sm btn-light border text-danger px-3"
													onclick="openRejectModal('김철수')">거절</button>
											</td>
										</tr>
										<tr>
											<td class="fw-bold">이영희 (24세)</td>
											<td><span class="badge bg-light text-dark border">FW</span></td>
											<td class="text-muted">2026-08-02</td>
											<td class="text-end">
												<button class="btn btn-sm btn-primary px-3 me-1"
													onclick="approvePlayer('이영희')">승인</button> <!-- 거절 버튼 클릭 시 모달 열기 함수 호출 -->
												<button class="btn btn-sm btn-light border text-danger px-3"
													onclick="openRejectModal('이영희')">거절</button>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>

					<!-- [탭 4] 소속 선수 목록 & 평점 관리 -->
					<div class="tab-pane fade" id="player-list">
						<div class="card border-0 shadow-sm rounded-4 p-4">
							<div
								class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom">
								<div>
									<h5 class="fw-bold mb-1">소속 선수 목록 & 평점 관리</h5>
									<p class="text-muted small mb-0">우리 팀 선수들의 목록을 조회하고 경기
										매너/실력 평점을 부여합니다.</p>
								</div>
								<span class="text-muted small">총 <strong>18</strong>명
								</span>
							</div>

							<div class="table-responsive">
								<table class="table table-hover align-middle mb-0">
									<thead class="table-light extra-small text-muted">
										<tr>
											<th>선수명</th>
											<th>포지션</th>
											<th>가입일</th>
											<th>현재 평점</th>
											<th>평가 메모</th>
											<th class="text-end">관리</th>
										</tr>
									</thead>
									<tbody class="small">
										<tr>
											<td class="fw-bold">박지성</td>
											<td><span class="badge bg-danger-subtle text-danger">FW</span></td>
											<td class="text-muted">2025-03-10</td>
											<td><span class="fw-bold text-warning">⭐ 4.9</span></td>
											<td class="text-muted text-truncate"
												style="max-width: 150px;">활동량 최고, 매너 우수</td>
											<td class="text-end">
												<button class="btn btn-sm btn-outline-primary me-1"
													onclick="openRatingModal('박지성', '4.9', '활동량 최고, 매너 우수')">
													<i class="bi bi-star-fill me-1"></i>평점 관리
												</button>
												<button class="btn btn-sm btn-outline-danger"
													onclick="removePlayer('박지성')">제적</button>
											</td>
										</tr>
										<tr>
											<td class="fw-bold">손흥민</td>
											<td><span class="badge bg-danger-subtle text-danger">FW</span></td>
											<td class="text-muted">2025-01-20</td>
											<td><span class="fw-bold text-warning">⭐ 5.0</span></td>
											<td class="text-muted text-truncate"
												style="max-width: 150px;">골 결정력 탁월</td>
											<td class="text-end">
												<button class="btn btn-sm btn-outline-primary me-1"
													onclick="openRatingModal('손흥민', '5.0', '골 결정력 탁월')">
													<i class="bi bi-star-fill me-1"></i>평점 관리
												</button>
												<button class="btn btn-sm btn-outline-danger"
													onclick="removePlayer('손흥민')">제적</button>
											</td>
										</tr>
										<tr>
											<td class="fw-bold">김민재</td>
											<td><span class="badge bg-primary-subtle text-primary">DF</span></td>
											<td class="text-muted">2025-05-12</td>
											<td><span class="text-muted extra-small">평점 없음</span></td>
											<td class="text-muted">-</td>
											<td class="text-end">
												<button class="btn btn-sm btn-outline-primary me-1"
													onclick="openRatingModal('김민재', '0', '')">
													<i class="bi bi-star me-1"></i>평점 등록
												</button>
												<button class="btn btn-sm btn-outline-danger"
													onclick="removePlayer('김민재')">제적</button>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>

					<!-- [탭 5] 경기장 예약 & 매칭 신청 -->
					<div class="tab-pane fade" id="match-apply">
						<div class="card border-0 shadow-sm rounded-4 p-4">
							<div
								class="d-flex justify-content-between align-items-center pb-3 mb-4 border-bottom">
								<div>
									<h5 class="fw-bold mb-1">
										<i class="bi bi-calendar-plus text-primary me-2"></i>경기장 예약 &
										매칭 신청
									</h5>
									<p class="text-muted small mb-0">경기장을 선택하고 위치, 주차 정보 및 타임
										슬롯별 매칭 현황을 확인하세요.</p>
								</div>
								<span class="badge bg-primary px-3 py-2">실시간 예약</span>
							</div>

							<!-- 지도 & 상세정보 -->
							<div class="row g-3 mb-4">
								<div class="col-lg-7">
									<div
										class="card border rounded-4 overflow-hidden h-100 shadow-sm">
										<div
											class="card-header bg-light border-0 py-2.5 px-3 d-flex justify-content-between align-items-center">
											<span class="fw-bold small text-dark"><i
												class="bi bi-geo-alt-fill text-danger me-1"></i> 경기장 위치</span> <span
												class="text-muted extra-small">지도에서 핀을 클릭해 선택 가능</span>
										</div>
										<div id="stadiumMap"
											class="bg-secondary-subtle d-flex align-items-center justify-content-center p-4"
											style="min-height: 280px; height: 100%;">
											<div class="text-center text-muted small">
												<i class="bi bi-map fs-1 text-secondary d-block mb-2"></i> <strong
													class="d-block text-dark">카카오 / 네이버 지도 API 영역</strong> <span
													class="extra-small text-muted">(선택된 구장: 쌍용 주 경기장)</span>
											</div>
										</div>
									</div>
								</div>

								<div class="col-lg-5">
									<div
										class="card border rounded-4 p-3 bg-light-subtle h-100 d-flex flex-column justify-content-between shadow-sm">
										<div>
											<div class="mb-2">
												<label
													class="form-label fw-bold extra-small text-muted mb-1">경기장
													선택</label> <select
													class="form-select form-select-sm fw-bold border-primary-subtle"
													id="stadiumSelect" onchange="changeStadiumInfo(this.value)">
													<option value="1" selected>쌍용 주 경기장 (인조잔디)</option>
													<option value="2">마포 구민 체육센터 (풋살장)</option>
													<option value="3">상암 월드컵 보조경기장 (천연잔디)</option>
												</select>
											</div>

											<div class="position-relative rounded-3 overflow-hidden mb-3"
												style="height: 110px; background-color: #e9ecef;">
												<img
													src="https://images.unsplash.com/photo-1529900748604-07564a03e7a6?q=80&w=500&auto=format&fit=crop"
													id="stadiumImg" class="w-100 h-100 object-fit-cover"
													alt="경기장 이미지"> <span
													class="badge bg-success position-absolute top-0 end-0 m-2 shadow-sm"
													id="stadiumStatus">예약 가능</span>
											</div>

											<div class="small space-y-2">
												<div
													class="d-flex justify-content-between align-items-center border-bottom pb-1.5 mb-1.5">
													<span class="text-muted extra-small"><i
														class="bi bi-geo-alt text-primary me-1"></i> 주소</span> <span
														class="text-dark small fw-normal text-truncate ms-2"
														style="max-width: 170px;" id="stadiumAddress">서울
														마포구 월드컵북로 21</span>
												</div>
												<div
													class="d-flex justify-content-between align-items-center border-bottom pb-1.5 mb-1.5">
													<span class="text-muted extra-small"><i
														class="bi bi-cash-stack text-primary me-1"></i> 대관료</span> <span
														class="text-dark small fw-normal" id="stadiumPrice">100,000원
														/ 2시간</span>
												</div>
												<div
													class="d-flex justify-content-between align-items-center border-bottom pb-1.5 mb-1.5">
													<span class="text-muted extra-small"><i
														class="bi bi-p-square text-primary me-1"></i> 주차</span> <span
														class="text-dark small fw-normal" id="stadiumParking">가능
														(최대 40대 무료)</span>
												</div>
												<div
													class="d-flex justify-content-between align-items-center border-bottom pb-1.5 mb-1.5">
													<span class="text-muted extra-small"><i
														class="bi bi-layers text-primary me-1"></i> 잔디</span> <span
														class="text-dark small fw-normal" id="stadiumTurf">최고급
														인조잔디</span>
												</div>
												<div
													class="d-flex justify-content-between align-items-center">
													<span class="text-muted extra-small"><i
														class="bi bi-info-circle text-primary me-1"></i> 편의시설</span> <span
														class="text-dark small fw-normal" id="stadiumFacility">샤워실,
														조명, 대기실</span>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<!-- 3. 날짜 선택 & 정돈된 팁 박스 -->
							<div class="card border-0 bg-light rounded-3 p-3 mb-4">
								<div class="row align-items-center g-3">
									<div class="col-md-4 col-lg-3">
										<label class="form-label fw-bold small text-dark mb-1">경기
											예약 희망 날짜</label> <input type="date"
											class="form-control form-control-sm fw-bold bg-white"
											id="bookingDate" value="2026-08-15">
									</div>
									<div class="col-md-8 col-lg-9">
										<div
											class="d-flex align-items-center gap-2 p-2 px-3 bg-white border rounded-3 text-secondary small">
											<i class="bi bi-info-circle-fill text-primary fs-6"></i> <span>이미
												선 예약된 팀이 있는 타임에 신청하시면 <strong class="text-primary">[어웨이(원정)팀]</strong>으로
												자동 매칭 신청됩니다.
											</span>
										</div>
									</div>
								</div>
							</div>

							<!-- 4. 타임 슬롯 -->
							<h6 class="fw-bold text-dark mb-3">
								<i class="bi bi-clock me-1 text-primary"></i> 시간대별 매칭 현황 선택
							</h6>
							<div class="row g-3 mb-4">
								<div class="col-md-6">
									<div
										class="card border border-primary border-opacity-50 bg-primary-subtle rounded-3 p-3 shadow-sm">
										<div
											class="d-flex justify-content-between align-items-center mb-2">
											<span class="fw-bold text-dark"><i
												class="bi bi-clock me-1"></i> 16:00 ~ 18:00</span> <span
												class="badge bg-warning text-dark">매칭 대기중 (1/2)</span>
										</div>
										<div
											class="p-2 bg-white rounded border mb-2 extra-small text-muted d-flex justify-content-between">
											<span>[홈팀] 선 예약 완료</span> <strong class="text-dark">FC
												드림</strong>
										</div>
										<div class="form-check mb-0">
											<input class="form-check-input" type="radio" name="matchSlot"
												id="slot1" value="slot1_away"> <label
												class="form-check-label small fw-bold text-primary"
												for="slot1"> [어웨이팀]으로 매칭 참가 신청 </label>
										</div>
									</div>
								</div>

								<div class="col-md-6">
									<div class="card border rounded-3 p-3 shadow-sm bg-white">
										<div
											class="d-flex justify-content-between align-items-center mb-2">
											<span class="fw-bold text-dark"><i
												class="bi bi-clock me-1"></i> 18:00 ~ 20:00</span> <span
												class="badge bg-success">신규 예약 가능</span>
										</div>
										<div
											class="p-2 bg-light rounded border mb-2 extra-small text-muted text-center">
											현재 예약된 팀이 없습니다.</div>
										<div class="form-check mb-0">
											<input class="form-check-input" type="radio" name="matchSlot"
												id="slot2" value="slot2_home"> <label
												class="form-check-label small fw-bold text-success"
												for="slot2"> [홈팀]으로 신규 예약 신청 </label>
										</div>
									</div>
								</div>
							</div>

							<div class="d-flex justify-content-end pt-3 border-top">
								<button type="button" class="btn btn-primary px-4 fw-bold"
									onclick="submitMatchBooking()">
									<i class="bi bi-check-circle me-1"></i> 선택한 타임에 경기장 예약 신청
								</button>
							</div>
						</div>
					</div>

					<!-- [탭 6] 구단주 변경 신청 -->
					<div class="tab-pane fade" id="owner-transfer">
						<div class="card border-0 shadow-sm rounded-4 p-4">
							<div
								class="d-flex justify-content-between align-items-center pb-3 mb-4 border-bottom">
								<div>
									<h5 class="fw-bold text-danger mb-1">구단주 권한 위임 / 변경 신청</h5>
									<p class="text-muted small mb-0">팀 관리 권한을 팀원(선수)에게 넘깁니다.</p>
								</div>
							</div>

							<div
								class="alert alert-warning border-0 p-3 rounded-3 mb-4 small text-secondary">
								<strong class="d-block text-dark mb-1">⚠️ 주의사항</strong> 권한 양도가
								완료되면 현재 계정은 <strong>일반 선수</strong>로 등급이 내려가며, 변경 후에는 직접 취소할 수
								없습니다.
							</div>

							<form id="ownerTransferForm" style="max-width: 500px;">
								<div class="mb-3">
									<label class="form-label small text-muted">차기 구단주 선택</label> <select
										class="form-select" name="nextOwnerId">
										<option value="" selected disabled>선수를 선택하세요</option>
										<option value="user02">박지성 (FW / 010-1234-5678)</option>
										<option value="user03">손흥민 (FW / 010-9876-5432)</option>
									</select>
								</div>
								<div class="mb-3">
									<label class="form-label small text-muted">양도 사유</label>
									<textarea class="form-control" name="transferReason" rows="2"
										placeholder="사유를 간단히 입력하세요"></textarea>
								</div>
								<div class="mb-3">
									<label class="form-label small text-muted">현재 비밀번호 재확인</label>
									<input type="password" class="form-control"
										name="currentPassword">
								</div>
								<div class="form-check mb-4">
									<input class="form-check-input" type="checkbox"
										id="transferAgree"> <label
										class="form-check-label small text-dark" for="transferAgree">주의사항을
										확인했으며 권한 위임에 동의합니다.</label>
								</div>
								<button type="button" class="btn btn-danger w-100 fw-bold"
									onclick="submitOwnerTransfer()">구단주 변경 신청</button>
							</form>
						</div>
					</div>

				</div>
			</div>

		</div>
	</div>

	<!-- ★ 1. 선수 평점 등록/수정/삭제 모달 팝업 ★ -->
	<div class="modal fade" id="playerRatingModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content border-0 rounded-4 shadow">
				<div class="modal-header border-bottom pb-3">
					<h6 class="modal-header-title fw-bold mb-0">
						<i class="bi bi-star-fill text-warning me-2"></i><span
							id="modalPlayerName">선수</span> 평점 관리
					</h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body py-4">
					<form id="playerRatingForm">
						<input type="hidden" id="targetPlayerName">

						<!-- 별점 선택 -->
						<div class="mb-3 text-center">
							<label class="form-label d-block fw-bold small text-muted mb-2">평점
								선택 (1.0 ~ 5.0)</label> <select
								class="form-select form-select-lg fw-bold text-center mx-auto"
								id="playerScore" style="max-width: 200px;">
								<option value="5.0">⭐⭐⭐⭐⭐ (5.0)</option>
								<option value="4.0">⭐⭐⭐⭐ (4.0)</option>
								<option value="3.0">⭐⭐⭐ (3.0)</option>
								<option value="2.0">⭐⭐ (2.0)</option>
								<option value="1.0">⭐ (1.0)</option>
							</select>
						</div>

						<!-- 평점 코멘트/메모 -->
						<div class="mb-2">
							<label class="form-label fw-bold extra-small text-muted mb-1">선수
								평가 메모 (선택사항)</label>
							<textarea class="form-control" id="playerComment" rows="3"
								placeholder="출석률, 매너, 경기 활약도에 대한 간단한 메모를 남겨주세요."></textarea>
						</div>
					</form>
				</div>
				<div
					class="modal-footer border-top pt-3 d-flex justify-content-between">
					<!-- 삭제 버튼 -->
					<button type="button"
						class="btn btn-light border text-danger btn-sm px-3"
						onclick="deletePlayerRating()">
						<i class="bi bi-trash me-1"></i>평점 삭제
					</button>
					<div>
						<button type="button"
							class="btn btn-light border btn-sm px-3 me-1"
							data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary btn-sm px-4 fw-bold"
							onclick="savePlayerRating()">저장하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- ★ 2. [신규] 입단 거절 사유 입력 모달 팝업 ★ -->
	<div class="modal fade" id="rejectReasonModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content border-0 rounded-4 shadow">
				<div class="modal-header border-bottom pb-3">
					<h6 class="modal-header-title fw-bold mb-0 text-danger">
						<i class="bi bi-x-circle me-1"></i><span id="rejectApplicantName">신청자</span>
						입단 거절
					</h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body py-3">
					<input type="hidden" id="targetRejectName">

					<div class="mb-3">
						<label class="form-label fw-bold small text-muted mb-1">거절
							사유 선택 / 작성</label> <select class="form-select form-select-sm mb-2"
							id="rejectReasonSelect" onchange="changeRejectReason(this.value)">
							<option value="정원 초과">포지션 정원이 초과되었습니다.</option>
							<option value="가입 조건 미충족">우리 구단의 가입 조건과 맞지 않습니다.</option>
							<option value="활동 시간 불일치">구단 정기전 활동 시간 참여가 어렵습니다.</option>
							<option value="custom">직접 입력</option>
						</select>

						<textarea class="form-control form-control-sm"
							id="rejectReasonText" rows="3"
							placeholder="신청자에게 전달될 거절 사유를 작성해 주세요.">포지션 정원이 초과되었습니다.</textarea>
					</div>
				</div>
				<div class="modal-footer border-top pt-2">
					<button type="button" class="btn btn-light border btn-sm px-3"
						data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-danger btn-sm px-4 fw-bold"
						onclick="submitRejectReason()">거절 확정</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 하단 푸터 -->
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

	<!-- JS 스크립트 연결 -->
	<script
		src="${pageContext.request.contextPath}/dist/js/clubowner/ownerpage.js"></script>
</body>
</html>