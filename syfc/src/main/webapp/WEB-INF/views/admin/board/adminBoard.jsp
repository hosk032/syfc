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

	<!-- 관리자 게시판 전용 CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/adminBoard.css">

</head>
<body class="bg-light" data-context-path="${pageContext.request.contextPath}">

	<!-- 상단 헤더 -->
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<div class="container py-4">

		<!-- 관리자 상단 대시보드 헤더 -->
		<div class="card border-0 shadow-sm rounded-4 mb-4">
			<div class="card-body p-4 d-flex align-items-center justify-content-between">
				<div class="d-flex align-items-center">
					<div class="bg-primary bg-opacity-10 text-primary rounded-circle d-flex align-items-center justify-content-center me-3"
						style="width: 56px; height: 56px; font-size: 24px;">
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
					<button class="nav-link ${activeTab == 'freeboard' ? '' : 'active'}"
						id="notice-tab"
						data-bs-toggle="pill"
						data-bs-target="#notice-pane"
						type="button"
						role="tab"
						onclick="location.href='${pageContext.request.contextPath}/admin/notice/list';">
						📢 공지사항 등록 / 삭제
					</button>
				</li>

				<li class="nav-item" role="presentation">
					<button class="nav-link ${activeTab == 'freeboard' ? 'active' : ''}"
						id="freeboard-tab"
						data-bs-toggle="pill"
						data-bs-target="#freeboard-pane"
						type="button"
						role="tab"
						onclick="location.href='${pageContext.request.contextPath}/admin/board/list';">
						💬 자유게시판 관리 및 삭제
					</button>
				</li>

				<li class="nav-item" role="presentation">
					<button class="nav-link"
						id="report-tab"
						data-bs-toggle="pill"
						data-bs-target="#report-pane"
						type="button"
						role="tab">
						🚨 문의 / 신고 게시판
					</button>
				</li>

			</ul>
		</div>

		<!-- 탭 콘텐츠 영역 -->
		<div class="tab-content" id="adminBoardTabContent">

			<!-- ================= [메뉴 1] 공지사항 등록 / 삭제 ================= -->
			<div class="tab-pane fade ${activeTab == 'freeboard' ? '' : 'show active'}"
				id="notice-pane" role="tabpanel">

				<div class="card border-0 shadow-sm rounded-4 p-4">

					<div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom">
						<div>
							<h5 class="fw-bold mb-1">공지사항 관리</h5>
							<p class="text-muted small mb-0">사이트에 노출되는 주요 공지사항을 등록하거나 관리합니다.</p>
						</div>

						<button class="btn btn-primary btn-sm px-3 fw-bold"
							onclick="openNoticeModal()">
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
									<th style="width: 150px;">관리</th>
								</tr>
							</thead>

							<tbody class="small">

								<!-- ★ DB에서 조회한 공지사항 목록 -->
								<c:forEach var="dto" items="${list}" varStatus="status">
									<tr>
										<td>${dataCount - (page - 1) * 10 - status.index}</td>

										<td class="text-start">
											<a href="${pageContext.request.contextPath}/admin/notice/article?num=${dto.num}&page=${page}"
												class="text-decoration-none text-dark">
												<c:out value="${dto.subject}"/>
											</a>
										</td>

										<td><c:out value="${dto.userName}"/></td>
										<td class="text-muted">${dto.regDate}</td>
										<td>${dto.hitCount}</td>

										<td>
											<button type="button"
												class="btn btn-sm btn-outline-primary me-1"
												onclick="location.href='${pageContext.request.contextPath}/admin/notice/update?num=${dto.num}&page=${page}'">
												수정
											</button>

											<button type="button"
												class="btn btn-sm btn-outline-danger"
												onclick="deleteNotice(${dto.num})">
												삭제
											</button>
										</td>
									</tr>
								</c:forEach>

								<c:if test="${empty list}">
									<tr>
										<td colspan="6" class="text-center text-muted py-4">
											등록된 공지사항이 없습니다.
										</td>
									</tr>
								</c:if>

							</tbody>
						</table>
					</div>

					<!-- 공지사항 페이징 -->
					<div class="text-center mt-4">
						${paging}
					</div>

				</div>
			</div>


			<!-- ================= [메뉴 2] 자유게시판 관리 및 삭제 ================= -->
			<div class="tab-pane fade ${activeTab == 'freeboard' ? 'show active' : ''}"
				id="freeboard-pane" role="tabpanel">

				<div class="card border-0 shadow-sm rounded-4 p-4">

					<div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom">
						<div>
							<h5 class="fw-bold mb-1">자유게시판 모니터링</h5>
							<p class="text-muted small mb-0">
								부적절한 게시글을 블라인드하거나 실제 삭제할 수 있습니다.
							</p>
						</div>

						<span class="text-muted small">
							총 <strong>${boardDataCount}</strong>개 게시글
						</span>
					</div>


					<!-- 자유게시판 검색 -->
					<form class="d-flex gap-2 mb-3"
						action="${pageContext.request.contextPath}/admin/board/list"
						method="get">

						<select name="schType"
							class="form-select form-select-sm"
							style="width: 130px;">

							<option value="all"
								${boardSchType == 'all' ? 'selected' : ''}>
								제목 + 내용
							</option>

							<option value="subject"
								${boardSchType == 'subject' ? 'selected' : ''}>
								제목
							</option>

							<option value="content"
								${boardSchType == 'content' ? 'selected' : ''}>
								내용
							</option>

							<option value="userName"
								${boardSchType == 'userName' ? 'selected' : ''}>
								작성자
							</option>

							<option value="regDate"
								${boardSchType == 'regDate' ? 'selected' : ''}>
								작성일
							</option>

						</select>

						<input type="text"
							name="kwd"
							value="${boardKwd}"
							class="form-control form-control-sm"
							placeholder="검색어를 입력하세요"
							style="max-width: 250px;">

						<button type="submit"
							class="btn btn-sm btn-dark px-3">
							검색
						</button>

					</form>


					<!-- 자유게시판 목록 -->
					<div class="table-responsive">
						<table class="table table-hover align-middle mb-0 text-center">

							<thead class="table-light extra-small text-muted">
								<tr>
									<th style="width: 70px;">번호</th>
									<th class="text-start">게시글 제목</th>
									<th style="width: 120px;">작성자</th>
									<th style="width: 120px;">작성일</th>
									<th style="width: 80px;">조회수</th>
									<th style="width: 90px;">상태</th>
									<th style="width: 180px;">관리</th>
								</tr>
							</thead>

							<tbody class="small">

								<!-- ★ DB에서 조회한 자유게시판 목록 -->
								<c:forEach var="dto"
									items="${boardList}"
									varStatus="status">

									<tr>

										<!-- 화면용 번호 -->
										<td>
											${boardDataCount - (boardPage - 1) * boardSize - status.index}
										</td>

										<!-- 제목 -->
										<td class="text-start">
											<c:out value="${dto.subject}"/>
										</td>

										<!-- 작성자 -->
										<td>
											<c:out value="${dto.userName}"/>
										</td>

										<!-- 작성일 -->
										<td class="text-muted">
											${dto.regDate}
										</td>

										<!-- 조회수 -->
										<td>
											${dto.hitCount}
										</td>

										<!-- 상태 -->
										<td>
											<c:choose>

												<c:when test="${dto.block == 1}">
													<span class="badge bg-secondary">
														블라인드
													</span>
												</c:when>

												<c:otherwise>
													<span class="badge bg-success-subtle text-success">
														정상
													</span>
												</c:otherwise>

											</c:choose>
										</td>

										<!-- 관리 -->
										<td>

											<!-- 정상 게시글 → 블라인드 -->
											<c:if test="${dto.block == 0}">
												<form action="${pageContext.request.contextPath}/admin/board/block"
													method="post"
													class="d-inline">

													<input type="hidden"
														name="num"
														value="${dto.num}">

													<input type="hidden"
														name="block"
														value="1">

													<button type="submit"
														class="btn btn-sm btn-outline-warning me-1"
														onclick="return confirm('게시글을 블라인드 처리하시겠습니까?');">
														블라인드
													</button>

												</form>
											</c:if>


											<!-- 블라인드 게시글 → 블라인드 해제 -->
											<c:if test="${dto.block == 1}">
												<form action="${pageContext.request.contextPath}/admin/board/block"
													method="post"
													class="d-inline">

													<input type="hidden"
														name="num"
														value="${dto.num}">

													<input type="hidden"
														name="block"
														value="0">

													<button type="submit"
														class="btn btn-sm btn-outline-secondary me-1"
														onclick="return confirm('블라인드를 해제하시겠습니까?');">
														해제
													</button>

												</form>
											</c:if>


											<!-- 실제 삭제 -->
											<form action="${pageContext.request.contextPath}/admin/board/delete"
												method="post"
												class="d-inline">

												<input type="hidden"
													name="num"
													value="${dto.num}">

												<button type="submit"
													class="btn btn-sm btn-outline-danger"
													onclick="return confirm('게시글을 실제 삭제하시겠습니까?');">
													삭제
												</button>

											</form>

										</td>

									</tr>

								</c:forEach>


								<!-- 자유게시판 글이 없는 경우 -->
								<c:if test="${empty boardList}">
									<tr>
										<td colspan="7"
											class="text-center text-muted py-4">
											등록된 자유게시판 글이 없습니다.
										</td>
									</tr>
								</c:if>

							</tbody>
						</table>
					</div>


					<!-- 자유게시판 페이징 -->
					<div class="text-center mt-4">
						${boardPaging}
					</div>

				</div>
			</div>


			<!-- ================= [메뉴 3] 문의/신고 게시판 ================= -->
			<div class="tab-pane fade" id="report-pane" role="tabpanel">

				<div class="card border-0 shadow-sm rounded-4 p-4">

					<div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom">
						<div>
							<h5 class="fw-bold mb-1">문의 / 신고 접수 처리</h5>
							<p class="text-muted small mb-0">
								사용자들의 1:1 문의 및 비매너/욕설 신고 접수를 확인하고 답변 및 제재를 진행합니다.
							</p>
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
									<td>
										<span class="badge bg-danger-subtle text-danger">
											신고
										</span>
									</td>

									<td class="text-start">
										8월 1일 경기 중 욕설 및 상대 선수 폭언 신고건
									</td>

									<td>박지성</td>
									<td class="text-muted">2026-08-02</td>

									<td>
										<span class="badge bg-warning text-dark">
											접수대기
										</span>
									</td>

									<td>
										<button class="btn btn-sm btn-primary px-3"
											onclick="openReportDetail('신고-01', '8월 1일 경기 욕설건', '박지성', '상대팀 7번 선수가 지속적인 폭언을 행사했습니다.')">
											처리하기
										</button>
									</td>
								</tr>

								<tr>
									<td>
										<span class="badge bg-info-subtle text-info">
											1:1문의
										</span>
									</td>

									<td class="text-start">
										구단주 권한 위임 신청 처리 기간 문의
									</td>

									<td>손흥민</td>
									<td class="text-muted">2026-08-01</td>

									<td>
										<span class="badge bg-success">
											답변완료
										</span>
									</td>

									<td>
										<button class="btn btn-sm btn-outline-secondary px-3"
											onclick="openReportDetail('문의-02', '권한 위임 기간 문의', '손흥민', '구단주 변경 시 승인은 얼마나 걸리나요?')">
											내역보기
										</button>
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
					<h6 class="fw-bold mb-0">
						<i class="bi bi-megaphone-fill text-primary me-2"></i>
						새 공지사항 작성
					</h6>

					<button type="button"
						class="btn-close"
						data-bs-dismiss="modal"
						aria-label="Close">
					</button>
				</div>

				<form id="noticeForm"
					action="${pageContext.request.contextPath}/admin/notice/write"
					method="post">

					<div class="modal-body py-4">

						<div class="mb-3">
							<label class="form-label small fw-bold text-muted">
								공지 제목
							</label>

							<input type="text"
								class="form-control"
								id="noticeSubject"
								name="subject"
								placeholder="공지사항 제목을 입력하세요"
								required>
						</div>

						<div class="mb-3">
							<label class="form-label small fw-bold text-muted">
								공지 내용
							</label>

							<textarea class="form-control"
								id="noticeContent"
								name="content"
								rows="6"
								placeholder="공지 내용을 작성하세요"
								required></textarea>
						</div>

					</div>

					<div class="modal-footer border-top pt-3">
						<button type="button"
							class="btn btn-light border btn-sm px-3"
							data-bs-dismiss="modal">
							취소
						</button>

						<button type="button"
							class="btn btn-primary btn-sm px-4 fw-bold"
							onclick="saveNotice()">
							공지사항 등록
						</button>
					</div>

				</form>

			</div>
		</div>
	</div>


	<!-- ★ 신고 / 문의 상세보기 및 답변 모달 ★ -->
	<div class="modal fade" id="reportDetailModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content border-0 rounded-4 shadow">

				<div class="modal-header border-bottom pb-3">
					<h6 class="fw-bold mb-0 text-primary">
						<i class="bi bi-chat-square-dots me-2"></i>
						문의 / 신고 처리
					</h6>

					<button type="button"
						class="btn-close"
						data-bs-dismiss="modal"
						aria-label="Close">
					</button>
				</div>

				<div class="modal-body py-3">

					<div class="p-3 bg-light rounded-3 mb-3 small">
						<div class="mb-1">
							<strong class="text-muted">작성자:</strong>
							<span id="modalReportUser"></span>
						</div>

						<div class="mb-1">
							<strong class="text-muted">제목:</strong>
							<span id="modalReportTitle" class="fw-bold"></span>
						</div>

						<hr class="my-2">

						<div>
							<strong class="text-muted">접수 내용:</strong>
						</div>

						<div id="modalReportContent"
							class="mt-1 text-dark">
						</div>
					</div>

					<div class="mb-2">
						<label class="form-label fw-bold small text-muted mb-1">
							관리자 답변 / 제재 처리 조치 내용
						</label>

						<textarea class="form-control form-control-sm"
							id="adminReplyText"
							rows="4"
							placeholder="사용자에게 전달될 답변 또는 조치 내용을 입력하세요."></textarea>
					</div>

				</div>

				<div class="modal-footer border-top pt-2">
					<button type="button"
						class="btn btn-light border btn-sm px-3"
						data-bs-dismiss="modal">
						취소
					</button>

					<button type="button"
						class="btn btn-primary btn-sm px-4 fw-bold"
						onclick="submitReportReply()">
						처리 완료 저장
					</button>
				</div>

			</div>
		</div>
	</div>


	<!-- 푸터 -->
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

	<!-- 관리자 게시판 전용 JavaScript -->
	<script src="${pageContext.request.contextPath}/dist/js/admin/adminBoard.js"></script>

</body>
</html>
