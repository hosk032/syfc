<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="tab-pane fade" id="player-rating-manage">
	<div class="card border-0 shadow-sm rounded-4 p-4">

		<!-- 1. 상단 타이틀 헤더 -->
		<div
			class="d-flex justify-content-between align-items-center pb-3 mb-4 border-bottom">
			<div>
				<h5 class="fw-bold mb-1">⭐ 선수 평점 & 경기 성적 관리</h5>
				<p class="text-muted small mb-0">경기에 참가한 소속 선수들의 개인 성적(득점/도움/카드)
					및 평점을 등록하고 수정합니다.</p>
			</div>
		</div>

		<!-- 2. 성적 등록 & 수정 입력 폼 카드 -->
		<div class="card bg-light border-0 rounded-3 p-3 mb-4">
			<div class="d-flex align-items-center mb-3">
				<i class="bi bi-pencil-square text-primary me-2 fs-5"></i>
				<h6 class="fw-bold mb-0 text-dark" id="ratingFormTitle">경기 성적
					등록 / 수정</h6>
			</div>

			<form id="playerRatingForm">
				<!-- 히든 데이터 (수정 모드 전환 시 활용) -->
				<input type="hidden" id="recordIdx" value="">

				<div class="row g-3 mb-3">
					<!-- 경기 일자 -> 경기 목록 선택으로 변경 -->
					<div class="col-md-4">
						<label for="matchNum"
							class="form-label extra-small fw-bold text-muted">경기 선택</label> <select
							class="form-select form-select-sm fw-bold" id="matchNum" required>
							<option value="" selected disabled data-homescore="0">경기를
								선택하세요</option>
							<c:forEach var="match" items="${matchList}">
								<!-- 💡 data-homescore 속성 추가 및 스코어 표시 -->
								<option value="${match.matchNum}"
									data-homescore="${match.homeScore != null ? match.homeScore : 0}">
									${match.matchDate} (vs ${match.awayClubName})
									[${match.homeScore}:${match.awayScore}]</option>
							</c:forEach>
						</select>
					</div>

					<!-- 대상 선수 -> 소속 선수 목록 선택으로 변경 -->
					<div class="col-md-4">
						<label for="ratingPlayerSelect"
							class="form-label extra-small fw-bold text-muted">대상 선수</label> <select
							class="form-select form-select-sm fw-bold"
							id="ratingPlayerSelect" required>
							<option value="" selected disabled>선수를 선택하세요</option>
							<c:forEach var="player" items="${playerList}">
								<option value="${player.clubJoin_num}">${player.userName}
									(${player.position})</option>
							</c:forEach>
						</select>
					</div>

					<!-- 평점 부여 -->
					<div class="col-md-4">
						<label for="playerRatingScore"
							class="form-label extra-small fw-bold text-muted">경기 평점</label> <select
							class="form-select form-select-sm text-warning fw-bold"
							id="playerRatingScore">
							<option value="5.0" selected>⭐ 5.0 (최고)</option>
							<option value="4.5">⭐ 4.5</option>
							<option value="4.0">⭐ 4.0</option>
							<option value="3.5">⭐ 3.5</option>
							<option value="3.0">⭐ 3.0 (보통)</option>
							<option value="2.5">⭐ 2.5</option>
							<option value="2.0">⭐ 2.0</option>
							<option value="1.0">⭐ 1.0 (아쉬움)</option>
						</select>
					</div>
				</div>

				<div class="row g-3 mb-3">
					<!-- 득점 / 도움 / 자책골 수치 입력 -->
					<div class="col-md-3">
						<label for="statGoal"
							class="form-label extra-small fw-bold text-primary">⚽ 득점</label>
						<input type="number" class="form-control form-control-sm"
							id="statGoal" min="0" value="0">
					</div>
					<div class="col-md-3">
						<label for="statAssist"
							class="form-label extra-small fw-bold text-success">👟 도움</label>
						<input type="number" class="form-control form-control-sm"
							id="statAssist" min="0" value="0">
					</div>
					<div class="col-md-3">
						<label for="statOwnGoal"
							class="form-label extra-small fw-bold text-danger">⚠️ 자책골</label>
						<input type="number" class="form-control form-control-sm"
							id="statOwnGoal" min="0" value="0">
					</div>
					<div class="col-md-3">
						<label class="form-label extra-small fw-bold text-muted">경고
							/ 퇴장</label>
						<div class="d-flex align-items-center gap-2 pt-1">
							<div class="form-check me-2">
								<input class="form-check-input" type="checkbox"
									id="statYellowCard"> <label
									class="form-check-input-label extra-small fw-bold text-warning"
									for="statYellowCard">🟨 경고</label>
							</div>
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="statRedCard">
								<label
									class="form-check-input-label extra-small fw-bold text-danger"
									for="statRedCard">🟥 퇴장</label>
							</div>
						</div>
					</div>
				</div>

				<!-- 평가 코멘트 / 메모 -->
				<div class="mb-3">
					<label for="statComment"
						class="form-label extra-small fw-bold text-muted">평가 코멘트
						(선택)</label> <input type="text" class="form-control form-control-sm"
						id="statComment" placeholder="예: 왕성한 활동량, 골 결정력 탁월">
				</div>

				<!-- 버튼 영역 -->
				<div class="text-end">
					<button type="button"
						class="btn btn-sm btn-light fw-bold me-1 d-none"
						id="btnCancelEdit" onclick="resetRatingForm()">취소</button>
					<button type="button" class="btn btn-sm btn-primary fw-bold px-3"
						id="btnSubmitRating" onclick="saveMatchRecord()">
						<i class="bi bi-check-lg me-1"></i>성적 저장하기
					</button>
				</div>
			</form>
		</div>

		<!-- 3. 최근 등록된 성적 이력 목록 테이블 -->
		<div class="d-flex justify-content-between align-items-center mb-2">
			<h6 class="fw-bold mb-0 text-dark">최근 등록된 성적 목록</h6>
			<span class="text-muted extra-small">최근 성적순</span>
		</div>

		<div class="table-responsive">
			<table class="table table-hover align-middle mb-0">
				<thead class="table-light extra-small text-muted text-center">
					<tr>
						<th style="width: 14%;">경기일</th>
						<th style="width: 12%;">선수명</th>
						<th style="width: 10%;">평점</th>
						<th style="width: 16%;">득점 / 도움</th>
						<th style="width: 14%;">카드 / 기타</th>
						<th>평가 메모</th>
						<th class="text-end pe-3 text-nowrap" style="width: 18%;">관리</th>
					</tr>
				</thead>
				<tbody class="small text-center" id="matchRecordListBody">
					<c:forEach var="record" items="${recordList}">
						<tr id="record-row-${record.recordId}"
							data-match="${record.matchNum}"
							data-player="${record.clubJoinNum}" data-score="${record.rating}"
							data-goal="${record.goal}" data-assist="${record.assist}"
							data-owngoal="${record.ownGoal}" data-yellow="${record.yellow}"
							data-red="${record.red}" data-comment="${record.memo}">

							<td class="text-muted">${record.matchDate}</td>
							<td class="fw-bold text-dark">${record.userName}</td>
							<td><span class="fw-bold text-warning">⭐
									${record.rating}</span></td>
							<td><span class="text-primary fw-bold">${record.goal}득점</span>
								/ <span class="text-success fw-bold">${record.assist}도움</span></td>
							<td><c:choose>
									<c:when test="${record.yellow > 0}">
										<span class="badge bg-warning text-dark px-2 py-1">🟨
											경고</span>
									</c:when>
									<c:when test="${record.red > 0}">
										<span class="badge bg-danger text-white px-2 py-1">🟥
											퇴장</span>
									</c:when>
									<c:otherwise>
										<span class="text-muted">-</span>
									</c:otherwise>
								</c:choose></td>
							<td class="text-muted text-truncate max-width-150"
								title="${record.memo}">${record.memo}</td>
							<td class="text-end pe-3 text-nowrap">
								<div class="d-inline-flex gap-1">
									<button
										class="btn btn-sm btn-outline-primary extra-small fw-bold px-2 py-1"
										onclick="editMatchRecord(${record.recordId})">수정</button>
									<button
										class="btn btn-sm btn-outline-danger extra-small fw-bold px-2 py-1"
										onclick="deleteMatchRecord(${record.recordId})">삭제</button>
								</div>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>