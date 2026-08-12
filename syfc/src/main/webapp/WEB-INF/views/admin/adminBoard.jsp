<%@ page language="java" contentType="text/html; charset=UTF-8"%>    
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>쌍용축구예약 - 관리자 게시판 관리</title>
	
	<!-- 공통 리소스 -->
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />


<!-- 유정씨 css 외부로 빼셔야합니다 -->
<!-- 관리자 전용 CSS (기존 부트스트랩 패키지 활용) -->
	<style>
		.nav-pills .nav-link.active {
			background-color: #6b4ba1 !important;
			color: #ffffff !important;
			font-weight: bold;
		}
		.nav-pills .nav-link {
			color: #495057;
			border-radius: 12px;
			padding: 10px 20px;
		}
		.badge-purple {
			background-color: #6b4ba1;
			color: #fff;
		}
	</style>
	<!-- 유정씨 css 외부로 빼셔야합니다 -->
</head>
<body class="bg-light">

	<!-- 상단 헤더 -->
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<div class="container py-4">

		<!-- 관리자 상단 대시보드 헤더 -->
		<div class="card border-0 shadow-sm rounded-4 mb-4">
			<div class="card-body p-4 d-flex align-items-center justify-content-between">
				<div class="d-flex align-items-center">
					<div class="bg-primary bg-opacity-10 text-primary rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 56px; height: 56px; font-size: 24px;">
						🛡️
					</div>
					<div>
						<h4 class="mb-0 fw-bold text-dark">관리자 센터 (Admin)</h4>
						<p class="text-secondary mb-0 small">게시판 관리, 공지사항 등록 및 신고/문의건을 모니터링합니다.</p>
					</div>
				</div>
				<span class="badge bg-danger px-3 py-2 rounded-pill">최고 관리자 권한</span>
			</div>
		</div>

		<!-- 3대 게시판 메뉴 탭 -->
		<div class="card border-0 shadow-sm rounded-4 p-3 mb-4">
			<ul class="nav nav-pills nav-fill gap-2" id="adminBoardTab" role="tablist">
				<li class="nav-item" role="presentation">
					<button class="nav-link active" id="notice-tab" data-bs-toggle="pill" data-bs-target="#notice-pane" type="button" role="tab">
						📢 공지사항 등록 / 삭제
					</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="freeboard-tab" data-bs-toggle="pill" data-bs-target="#freeboard-pane" type="button" role="tab">
						💬 자유게시판 관리 및 삭제
					</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="report-tab" data-bs-toggle="pill" data-bs-target="#report-pane" type="button" role="tab">
						🚨 문의 / 신고 게시판
					</button>
				</li>
			</ul>
		</div>

		<!-- 탭 콘텐츠 영역 -->
		<div class="tab-content" id="adminBoardTabContent">

			<!-- ================= [메뉴 1] 공지사항 등록 / 삭제 ================= -->
			<div class="tab-pane fade show active" id="notice-pane" role="tabpanel">
				<div class="card border-0 shadow-sm rounded-4 p-4">
					<div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom">
						<div>
							<h5 class="fw-bold mb-1">공지사항 관리</h5>
							<p class="text-muted small mb-0">사이트에 노출되는 주요 공지사항을 등록하거나 관리합니다.</p>
						</div>
						<button class="btn btn-primary btn-sm px-3 fw-bold" onclick="openNoticeModal()">
							<i class="bi bi-pencil-plus me-1"></i> 새 공지사항 등록
						</button>
					</div>

					<div class="table-responsive">
						<table class="table table-hover align-middle mb-0 text-center">
							<thead class="table-light extra-small text-muted">
								<tr>
									<th style="width: 80px;">번호</th>
									<th class="text-start">제목</th>
									<th style="width: 120px;">작성자</th>
									<th style="width: 120px;">등록일</th>
									<th style="width: 100px;">조회수</th>
									<th style="width: 120px;">관리</th>
								</tr>
							</thead>
							<tbody class="small">
								<tr>
									<td><span class="badge bg-danger">상단고정</span></td>
									<td class="text-start fw-bold">[중요] 쌍용축구예약 서버 정기 점검 안내 (08/15)</td>
									<td>최고관리자</td>
									<td class="text-muted">2026-08-10</td>
									<td>1,240</td>
									<td>
										<button class="btn btn-sm btn-outline-danger" onclick="deleteNotice(101)">삭제</button>
									</td>
								</tr>
								<tr>
									<td>102</td>
									<td class="text-start">경기장 매칭 시 매너 플레이 준수 캠페인 안내</td>
									<td>운영자</td>
									<td class="text-muted">2026-08-01</td>
									<td>530</td>
									<td>
										<button class="btn btn-sm btn-outline-danger" onclick="deleteNotice(102)">삭제</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>

			<!-- ================= [메뉴 2] 자유게시판 관리 및 삭제 ================= -->
			<div class="tab-pane fade" id="freeboard-pane" role="tabpanel">
				<div class="card border-0 shadow-sm rounded-4 p-4">
					<div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom">
						<div>
							<h5 class="fw-bold mb-1">자유게시판 모니터링</h5>
							<p class="text-muted small mb-0">부적절한 게시글 및 부적절한 단어가 포함된 글을 블라인드/강제 삭제합니다.</p>
						</div>
						<span class="text-muted small">총 <strong>142</strong>개 게시글</span>
					</div>

					<!-- 검색 필터 -->
					<div class="d-flex gap-2 mb-3">
						<select class="form-select form-select-sm" style="width: 130px;">
							<option value="all">전체검색</option>
							<option value="subject">제목</option>
							<option value="userName">작성자</option>
						</select>
						<input type="text" class="form-control form-control-sm" placeholder="검색어를 입력하세요" style="max-width: 250px;">
						<button class="btn btn-sm btn-dark px-3">검색</button>
					</div>

					<div class="table-responsive">
						<table class="table table-hover align-middle mb-0 text-center">
							<thead class="table-light extra-small text-muted">
								<tr>
									<th style="width: 70px;">글번호</th>
									<th class="text-start">게시글 제목</th>
									<th style="width: 120px;">작성자</th>
									<th style="width: 120px;">작성일</th>
									<th style="width: 80px;">추천</th>
									<th style="width: 90px;">상태</th>
									<th style="width: 120px;">관리</th>
								</tr>
							</thead>
							<tbody class="small">
								<tr>
									<td>305</td>
									<td class="text-start">이번 주 마포 구민체육센터 매치 하실 팀 구합니다!</td>
									<td>홍길동</td>
									<td class="text-muted">2026-08-11</td>
									<td>12</td>
									<td><span class="badge bg-success-subtle text-success">정상</span></td>
									<td>
										<button class="btn btn-sm btn-outline-danger" onclick="deleteFreeBoard(305)">강제삭제</button>
									</td>
								</tr>
								<tr>
									<td>304</td>
									<td class="text-start text-muted"><del>비매너 플레이어 신고합니다 (차단됨)</del></td>
									<td>김철수</td>
									<td class="text-muted">2026-08-09</td>
									<td>0</td>
									<td><span class="badge bg-secondary">블라인드</span></td>
									<td>
										<button class="btn btn-sm btn-light border text-secondary" disabled>삭제완료</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>

			<!-- ================= [메뉴 3] 문의/신고 게시판 ================= -->
			<div class="tab-pane fade" id="report-pane" role="tabpanel">
				<div class="card border-0 shadow-sm rounded-4 p-4">
					<div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom">
						<div>
							<h5 class="fw-bold mb-1">문의 / 신고 접수 처리</h5>
							<p class="text-muted small mb-0">사용자들의 1:1 문의 및 비매너/욕설 신고 접수를 확인하고 답변 및 제재를 진행합니다.</p>
						</div>
						<span class="badge bg-warning text-dark px-3 py-2">미처리: 2건</span>
					</div>

					<div class="table-responsive">
						<table class="table table-hover align-middle mb-0 text-center">
							<thead class="table-light extra-small text-muted">
								<tr>
									<th style="width: 80px;">분류</th>
									<th class="text-start">문의/신고 제목</th>
									<th style="width: 110px;">신고자/문의자</th>
									<th style="width: 110px;">접수일</th>
									<th style="width: 100px;">처리상태</th>
									<th style="width: 110px;">상세보기</th>
								</tr>
							</thead>
							<tbody class="small">
								<tr>
									<td><span class="badge bg-danger-subtle text-danger">신고</span></td>
									<td class="text-start">8월 1일 경기 중 욕설 및 상대 선수 폭언 신고건</td>
									<td>박지성</td>
									<td class="text-muted">2026-08-02</td>
									<td><span class="badge bg-warning text-dark">접수대기</span></td>
									<td>
										<button class="btn btn-sm btn-primary px-3" onclick="openReportDetail('신고-01', '8월 1일 경기 욕설건', '박지성', '상대팀 7번 선수가 지속적인 폭언을 행사했습니다.')">처리하기</button>
									</td>
								</tr>
								<tr>
									<td><span class="badge bg-info-subtle text-info">1:1문의</span></td>
									<td class="text-start">구단주 권한 위임 신청 처리 기간 문의</td>
									<td>손흥민</td>
									<td class="text-muted">2026-08-01</td>
									<td><span class="badge bg-success">답변완료</span></td>
									<td>
										<button class="btn btn-sm btn-outline-secondary px-3" onclick="openReportDetail('문의-02', '권한 위임 기간 문의', '손흥민', '구단주 변경 시 승인은 얼마나 걸리나요?')">내역보기</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>

		</div>
	</div>

	<!-- ★ 공지사항 등록 모달 ★ -->
	<div class="modal fade" id="noticeWriteModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content border-0 rounded-4 shadow">
				<div class="modal-header border-bottom pb-3">
					<h6 class="fw-bold mb-0"><i class="bi bi-megaphone-fill text-primary me-2"></i>새 공지사항 작성</h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body py-4">
					<form id="noticeForm">
						<div class="form-check mb-3">
							<input class="form-check-input" type="checkbox" id="noticeTopPin">
							<label class="form-check-label small fw-bold text-danger" for="noticeTopPin">
								📌 최상단에 고정 공지사항으로 등록
							</label>
						</div>
						<div class="mb-3">
							<label class="form-label small fw-bold text-muted">공지 제목</label>
							<input type="text" class="form-control" id="noticeSubject" placeholder="공지사항 제목을 입력하세요">
						</div>
						<div class="mb-3">
							<label class="form-label small fw-bold text-muted">공지 내용</label>
							<textarea class="form-control" id="noticeContent" rows="6" placeholder="공지 내용을 작성하세요"></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer border-top pt-3">
					<button type="button" class="btn btn-light border btn-sm px-3" data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary btn-sm px-4 fw-bold" onclick="saveNotice()">공지사항 등록</button>
				</div>
			</div>
		</div>
	</div>

	<!-- ★ 신고 / 문의 상세보기 및 답변 모달 ★ -->
	<div class="modal fade" id="reportDetailModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content border-0 rounded-4 shadow">
				<div class="modal-header border-bottom pb-3">
					<h6 class="fw-bold mb-0 text-primary"><i class="bi bi-chat-square-dots me-2"></i>문의 / 신고 처리</h6>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body py-3">
					<div class="p-3 bg-light rounded-3 mb-3 small">
						<div class="mb-1"><strong class="text-muted">작성자:</strong> <span id="modalReportUser"></span></div>
						<div class="mb-1"><strong class="text-muted">제목:</strong> <span id="modalReportTitle" class="fw-bold"></span></div>
						<hr class="my-2">
						<div><strong class="text-muted">접수 내용:</strong></div>
						<div id="modalReportContent" class="mt-1 text-dark"></div>
					</div>

					<div class="mb-2">
						<label class="form-label fw-bold small text-muted mb-1">관리자 답변 / 제재 처리 조치 내용</label>
						<textarea class="form-control form-control-sm" id="adminReplyText" rows="4" placeholder="사용자에게 전달될 답변 또는 조치 내용을 입력하세요."></textarea>
					</div>
				</div>
				<div class="modal-footer border-top pt-2">
					<button type="button" class="btn btn-light border btn-sm px-3" data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary btn-sm px-4 fw-bold" onclick="submitReportReply()">처리 완료 저장</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 푸터 -->
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />


<!-- 유정씨 js 외부로 빼셔야합니다 -->
	<!-- 자바스크립트 -->
	<script>
		// 1. 공지사항 모달 열기 및 저장
		function openNoticeModal() {
			const modal = new bootstrap.Modal(document.getElementById('noticeWriteModal'));
			modal.show();
		}

		function saveNotice() {
			const subject = document.getElementById('noticeSubject').value.trim();
			if (!subject) {
				alert("공지 제목을 입력해주세요.");
				return;
			}
			if (confirm("공지사항을 등록하시겠습니까?")) {
				alert("공지사항이 성공적으로 등록되었습니다.");
				location.reload();
			}
		}

		function deleteNotice(num) {
			if (confirm(num + "번 공지사항을 삭제하시겠습니까?")) {
				alert("공지사항이 삭제되었습니다.");
			}
		}

		// 2. 자유게시판 강제 삭제
		function deleteFreeBoard(num) {
			if (confirm(num + "번 게시글을 강제 삭제(블라인드) 처리하시겠습니까?")) {
				alert("삭제 처리되었습니다.");
			}
		}

		// 3. 문의/신고 상세 모달 열기 및 처리
		function openReportDetail(id, title, user, content) {
			document.getElementById('modalReportTitle').innerText = title;
			document.getElementById('modalReportUser').innerText = user;
			document.getElementById('modalReportContent').innerText = content;

			const modal = new bootstrap.Modal(document.getElementById('reportDetailModal'));
			modal.show();
		}

		function submitReportReply() {
			const text = document.getElementById('adminReplyText').value.trim();
			if (!text) {
				alert("답변 내용을 입력해 주세요.");
				return;
			}
			if (confirm("답변 및 처리 조치를 저장하시겠습니까?")) {
				alert("처리가 완료되었습니다.");
				location.reload();
			}
		}
	</script>
	<!-- 유정씨 js 외부로 빼셔야합니다 -->
</body>
</html>