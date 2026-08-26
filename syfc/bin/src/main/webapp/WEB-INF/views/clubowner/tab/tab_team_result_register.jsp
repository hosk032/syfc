<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<style>
    /* 크롬, 사파리, 엣지에서 숫자 input의 화살표 스피너 완벽 제거 */
    #regAwayScore::-webkit-outer-spin-button,
    #regAwayScore::-webkit-inner-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }
</style>

<div class="tab-pane fade" id="team-result-register">
	<div class="card border-0 shadow-sm rounded-4 p-4">

		<!-- 탭 헤더 -->
		<div class="d-flex justify-content-between align-items-center pb-3 mb-4 border-bottom">
			<div>
				<h5 class="fw-bold mb-1 text-dark">
					<i class="bi bi-pencil-square text-primary me-2"></i>구단 성적 등록 / 관리
				</h5>
				<p class="text-muted small mb-0">완료된 매치 목록에서 경기를 선택하여 최종 스코어 및 성적을 등록/수정합니다.</p>
			</div>
		</div>

		<!-- 1. 성적 등록 & 수정 폼 (엠블럼 및 자동 바인딩 카드) -->
		<div class="card border bg-light rounded-4 p-4 mb-4 shadow-sm">
			<div class="d-flex align-items-center justify-content-between mb-3 border-bottom pb-2">
				<h6 class="fw-bold text-dark mb-0" id="formCardTitle">
					<i class="bi bi-plus-circle-fill text-primary me-2"></i>경기 성적 입력
				</h6>
				<span class="badge bg-secondary px-3 py-1 fs-8" id="formStatusBadge">경기를 선택해 주세요</span>
			</div>

			<form id="teamResultForm">
				<!-- 선택된 매치 PK 번호 (Hidden) -->
				<input type="hidden" id="selectedMatchNum" name="matchNum" value="">

				<div class="row g-3">
					<!-- 경기 일자 (읽기 전용/자동셋팅) -->
					<div class="col-md-4">
						<label class="form-label small fw-bold text-secondary">
							<i class="bi bi-calendar-event me-1"></i>경기 날짜
						</label>
						<input type="text" class="form-control form-control-sm bg-white" id="regMatchDate" readonly placeholder="목록에서 경기를 선택하세요">
					</div>

					<!-- 경기장 (읽기 전용/자동셋팅) -->
					<div class="col-md-4">
						<label class="form-label small fw-bold text-secondary">
							<i class="bi bi-geo-alt me-1"></i>경기장
						</label>
						<input type="text" class="form-control form-control-sm bg-white" id="regStadiumName" readonly placeholder="목록에서 경기를 선택하세요">
					</div>

					<!-- 상대 구단명 (읽기 전용/자동셋팅) -->
					<div class="col-md-4">
						<label class="form-label small fw-bold text-secondary">
							<i class="bi bi-shield-slash me-1"></i>상대 구단
						</label>
						<input type="text" class="form-control form-control-sm bg-white" id="regAwayClubName" readonly placeholder="목록에서 경기를 선택하세요">
					</div>

					<!-- VS 스코어 보드 (엠블럼 포함) -->
					<div class="col-12 mt-4">
						<div class="p-3 bg-white rounded-3 border">
							<div class="row align-items-center text-center g-2">

								<!-- 홈팀 (우리팀) -->
								<div class="col-5 col-md-4">
									<div class="d-flex align-items-center justify-content-center gap-2 mb-2">
										<c:choose>
											<c:when test="${not empty club.club_logo}">
												<img src="${pageContext.request.contextPath}/uploads/club/${club.club_logo}" class="rounded-circle border" style="width: 32px; height: 32px; object-fit: cover;" id="homeEmblem">
											</c:when>
											<c:otherwise>
												<div class="bg-primary bg-opacity-10 text-primary rounded-circle d-flex align-items-center justify-content-center fw-bold" style="width: 32px; height: 32px;" id="homeEmblem">⚽</div>
											</c:otherwise>
										</c:choose>
										<span class="fw-bold text-dark small" id="homeClubTitle">${empty club.club_name ? '울산 HD FC' : club.club_name}</span>
									</div>
									<div class="input-group input-group-sm">
										<span class="input-group-text bg-primary text-white fw-bold">우리팀 점수</span>
										<input type="number" class="form-control text-center fw-bold fs-5 text-primary" id="regHomeScore" name="homeScore" min="0" value="0">
									</div>
								</div>

								<!-- VS 구분 바 -->
								<div class="col-2 col-md-4">
									<span class="badge bg-dark rounded-circle fs-6 px-2 py-2 shadow-sm">VS</span>
								</div>

								<!-- 원정팀 (상대팀) - readonly + 클릭 시 경고 및 포커스 이동 -->
								<div class="col-5 col-md-4">
									<div class="d-flex align-items-center justify-content-center gap-2 mb-2">
										<img src="${pageContext.request.contextPath}/dist/images/default_club.png" class="rounded-circle border" style="width: 32px; height: 32px; object-fit: cover;" id="awayEmblem">
										<span class="fw-bold text-dark small" id="awayClubTitle">상대팀</span>
									</div>
									<div class="input-group input-group-sm">
										<input type="number" class="form-control text-center fw-bold fs-5 text-danger bg-light" 
											   id="regAwayScore" name="awayScore" value="0" readonly 
											   onclick="alert('상대팀 점수는 수정할 수 없습니다.'); document.getElementById('regHomeScore').focus();">
										<span class="input-group-text bg-danger text-white fw-bold">상대팀 점수</span>
									</div>
								</div>

							</div>
						</div>
					</div>

					<!-- 등록 / 취소 버튼 -->
					<div class="col-12 text-end mt-3 d-flex justify-content-end gap-2">
						<button type="button" class="btn btn-sm btn-outline-secondary d-none" id="btnCancelEdit" onclick="resetResultForm()">취소</button>
						<button type="button" class="btn btn-dark btn-sm px-4 fw-bold" id="btnSubmitScore" onclick="submitMatchScore()" disabled>
							<i class="bi bi-check-lg me-1"></i>성적 등록 완료
						</button>
					</div>
				</div>
			</form>
		</div>

		<!-- 2. 구단 매치 경기 목록 -->
		<div class="d-flex align-items-center justify-content-between mb-3">
			<h6 class="fw-bold mb-0 text-dark">
				<i class="bi bi-list-stars me-1"></i>우리 구단 경기 목록
			</h6>
			<span class="text-muted extra-small">※ 경기를 선택하여 성적을 등록하거나 수정할 수 있습니다.</span>
		</div>

		<div class="table-responsive">
			<table class="table table-hover align-middle text-center border-top mb-0">
				<thead class="table-light extra-small text-muted">
					<tr>
						<th>경기 일자</th>
						<th>경기장</th>
						<th>대진 (홈 vs 원정)</th>
						<th>현재 스코어</th>
						<th>성적 등록 상태</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody class="small" id="clubMatchManageList">
					<c:forEach var="dto" items="${matchList}">
						<tr id="match-row-${dto.matchNum}">
							<td class="text-muted">${dto.matchDate.substring(0, 10)}</td>
							<td class="fw-semibold">${dto.stadiumName}</td>
							<td>
								<strong class="text-dark">${dto.homeClubName}</strong> vs ${dto.awayClubName}
							</td>
							<td class="fw-bold text-primary">
								<c:choose>
									<c:when test="${dto.homeScore != null && dto.awayScore != null}">
										${dto.homeScore} : ${dto.awayScore}
									</c:when>
									<c:otherwise>
										<span class="text-muted fs-7">- : -</span>
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${dto.homeScore != null && dto.awayScore != null}">
										<span class="badge bg-success bg-opacity-10 text-success border border-success px-2 py-1">등록완료</span>
									</c:when>
									<c:otherwise>
										<span class="badge bg-secondary bg-opacity-10 text-secondary border border-secondary px-2 py-1">미등록</span>
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${dto.homeScore != null && dto.awayScore != null}">
										<button type="button" class="btn btn-xs btn-outline-primary py-0 px-2" 
											onclick="selectMatchForEdit('${dto.matchNum}', '${dto.matchDate}', '${dto.stadiumName}', '${dto.homeClubName}', '${dto.awayClubName}', '${dto.homeScore}', '${dto.awayScore}', '${dto.awayClubLogo}')">
											수정</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn btn-xs btn-primary py-0 px-2 fw-bold" 
											onclick="selectMatchForRegister('${dto.matchNum}', '${dto.matchDate}', '${dto.stadiumName}', '${dto.homeClubName}', '${dto.awayClubName}', '${dto.awayClubLogo}')">
											성적 등록</button>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>

					<c:if test="${empty matchList}">
						<tr>
							<td colspan="6" class="py-5 text-center text-muted">
								<i class="bi bi-journal-x fs-1 d-block mb-2 text-secondary opacity-50"></i>
								진행된 경기 이력이 존재하지 않습니다.
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>

	</div>
</div>