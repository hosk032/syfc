<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<div class="tab-pane fade" id="player-list">
	<div class="card border-0 shadow-sm rounded-4 p-4">
		<!-- 헤더 영역 -->
		<div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom">
			<div>
				<h5 class="fw-bold mb-1">소속 선수 목록 & 제적 관리</h5>
				<p class="text-muted small mb-0">우리 팀 소속 선수 목록을 조회하고 필요 시 제적(강퇴) 처리를 진행합니다.</p>
			</div>
			<span class="text-muted small">총 <strong id="totalPlayerCount" class="text-primary fs-6">${empty playerCount ? 0 : playerCount}</strong>명</span>
		</div>

		<!-- 검색 및 필터 영역 -->
		<div class="row g-2 mb-3 justify-content-between align-items-center">
			<div class="col-md-4">
				<div class="input-group input-group-sm">
					<span class="input-group-text bg-light text-muted border-end-0"><i class="bi bi-search"></i></span>
					<input type="text" class="form-control form-control-sm border-start-0 bg-light" id="searchPlayerKeyword" placeholder="선수명 검색..." onkeyup="filterPlayerList()">
				</div>
			</div>
			<div class="col-md-3 text-md-end">
				<select class="form-select form-select-sm fw-bold" id="filterPosition" onchange="filterPlayerList()">
					<option value="" selected>전체 포지션</option>
					<option value="FW">FW (공격수)</option>
					<option value="MF">MF (미드필더)</option>
					<option value="DF">DF (수비수)</option>
					<option value="GK">GK (골키퍼)</option>
				</select>
			</div>
		</div>

		<!-- 선수 목록 테이블 -->
		<div class="table-responsive">
			<table class="table table-hover align-middle mb-0">
				<thead class="table-light extra-small text-muted text-center">
					<tr>
						<th class="text-start ps-4" style="width: 30%;">선수명</th>
						<th style="width: 20%;">포지션</th>
						<th style="width: 30%;">가입일</th>
						<th class="text-end pe-4" style="width: 20%;">관리</th>
					</tr>
				</thead>
				<tbody class="small text-center" id="playerListBody">
					<c:choose>
						<c:when test="${not empty playerList}">
							<c:forEach var="player" items="${playerList}">
								<tr id="player-row-${player.clubJoin_num}" data-name="${player.userName}" data-position="${player.position}">
									<td class="text-start ps-4 fw-bold text-dark">
										${player.userName}
										<%-- 본인(구단주) 여부 판단 (세션 memberIdx와 비교하거나 DTO의 구단주 여부 활용) --%>
										<c:if test="${player.memberIdx == sessionScope.member.memberIdx}">
											<span class="badge bg-warning text-dark extra-small ms-1">구단주</span>
										</c:if>
									</td>
									<td>
										<span class="badge ${player.position == 'FW' ? 'bg-danger-subtle text-danger' : (player.position == 'GK' ? 'bg-warning-subtle text-warning' : 'bg-primary-subtle text-primary')} border px-2.5 py-1">
											${player.position}
										</span>
									</td>
									<td class="text-muted">${player.join_date}</td>
									<td class="text-end pe-4">
										<c:choose>
											<c:when test="${player.memberIdx == sessionScope.member.memberIdx}">
												<button class="btn btn-sm btn-secondary disabled extra-small" disabled>본인</button>
											</c:when>
											<c:otherwise>
												<button class="btn btn-sm btn-outline-danger fw-bold" onclick="removePlayer('${player.userName}', ${player.clubJoin_num})">제적</button>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr class="empty-row">
								<td colspan="4" class="py-5 text-center text-muted">
									<i class="bi bi-people fs-1 d-block mb-2 text-secondary opacity-50"></i>
									소속된 선수가 없습니다.
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</div>
</div>