<%@ page language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
	uri="jakarta.tags.core"%>

<jsp:include
	page="/WEB-INF/views/layout/headerResources.jsp" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/dist/css/admin/club.css">

<jsp:include
	page="/WEB-INF/views/layout/header.jsp" />


<div class="clubManageContainer">

	<!-- =====================================================
	     구단 관리 제목
	     ===================================================== -->
	<div class="clubManageHeader">

		<h2 class="clubManageTitle">
			구단 관리
		</h2>

		<p class="clubManageDesc">
			구단 창설 신청과 구단 운영 상태를 관리합니다.
		</p>

	</div>


	<!-- =====================================================
	     구단 관리 탭
	     ===================================================== -->
	<div class="clubManageTab">

		<button type="button"
			class="clubTabButton ${activeTab == 'status' ? '' : 'active'}"
			data-bs-toggle="tab"
			data-bs-target="#clubRequestTab"
			onclick="location.href='${pageContext.request.contextPath}/admin/club/list';">

			구단 창설 신청

		</button>


		<button type="button"
			class="clubTabButton ${activeTab == 'status' ? 'active' : ''}"
			data-bs-toggle="tab"
			data-bs-target="#clubStatusTab"
			onclick="location.href='${pageContext.request.contextPath}/admin/clubstatus/list';">

			구단 정지 관리

		</button>

	</div>


	<div class="tab-content">


		<!-- =====================================================
		     1. 구단 창설 신청
		     ===================================================== -->
		<div class="tab-pane fade ${activeTab == 'status' ? '' : 'show active'}"
			id="clubRequestTab">

			<div class="manageBox">

				<div class="manageBoxHeader">

					<div>
						<h4>구단 창설 신청</h4>

						<p>
							구단 창설 신청 내역을 확인하고 승인 또는 거절합니다.
						</p>
					</div>


					<div class="requestCount">
						신청 내역
						<strong>${dataCount}</strong>건
					</div>

				</div>


				<!-- 신청 검색 -->
				<form action="${pageContext.request.contextPath}/admin/club/list"
					method="get"
					class="clubSearch">

					<select name="status"
						class="clubSearchInput"
						style="width: 130px;">

						<option value="2"
							${requestStatus == 2 ? 'selected' : ''}>
							신청대기
						</option>

						<option value="1"
							${requestStatus == 1 ? 'selected' : ''}>
							승인
						</option>

						<option value="0"
							${requestStatus == 0 ? 'selected' : ''}>
							거절
						</option>

					</select>


					<select name="schType"
						class="clubSearchInput"
						style="width: 130px;">

						<option value="all"
							${schType == 'all' ? 'selected' : ''}>
							전체
						</option>

						<option value="userId"
							${schType == 'userId' ? 'selected' : ''}>
							아이디
						</option>

						<option value="userName"
							${schType == 'userName' ? 'selected' : ''}>
							이름
						</option>

					</select>


					<input type="text"
						name="kwd"
						value="${kwd}"
						class="clubSearchInput"
						placeholder="검색어를 입력하세요">


					<button type="submit"
						class="clubSearchButton">
						검색
					</button>

				</form>


				<!-- 구단 창설 신청 목록 -->
				<div class="tableWrap">

					<table class="clubTable">

						<colgroup>
							<col style="width: 8%;">
							<col style="width: 17%;">
							<col style="width: 30%;">
							<col style="width: 15%;">
							<col style="width: 12%;">
							<col style="width: 18%;">
						</colgroup>


						<thead>
							<tr>
								<th>번호</th>
								<th>신청자</th>
								<th>신청 내용</th>
								<th>신청일</th>
								<th>상태</th>
								<th>관리</th>
							</tr>
						</thead>


						<tbody>

							<c:forEach var="dto"
								items="${requestList}">

								<tr>

									<td>
										${dto.requestId}
									</td>


									<td>
										<c:out value="${dto.userName}"/>

										<br>

										<span style="color: #888; font-size: 12px;">
											<c:out value="${dto.userId}"/>
										</span>
									</td>


									<td style="text-align: left;">
										<c:out value="${dto.content}"/>
									</td>


									<td>
										${dto.requestDate}
									</td>


									<td>

										<c:choose>

											<c:when test="${dto.requestStatus == 2}">
												<span style="color: #d28b00; font-weight: 600;">
													대기
												</span>
											</c:when>

											<c:when test="${dto.requestStatus == 1}">
												<span style="color: #198754; font-weight: 600;">
													승인
												</span>
											</c:when>

											<c:otherwise>
												<span style="color: #dc3545; font-weight: 600;">
													거절
												</span>
											</c:otherwise>

										</c:choose>

									</td>


									<td>

										<c:if test="${dto.requestStatus == 2}">

											<form action="${pageContext.request.contextPath}/admin/club/approve"
												method="post"
												style="display: inline;">

												<input type="hidden"
													name="requestId"
													value="${dto.requestId}">

												<button type="submit"
													class="clubSearchButton"
													onclick="return confirm('구단 창설 신청을 승인하시겠습니까?');">

													승인

												</button>

											</form>


											<form action="${pageContext.request.contextPath}/admin/club/reject"
												method="post"
												style="display: inline;">

												<input type="hidden"
													name="requestId"
													value="${dto.requestId}">

												<button type="submit"
													class="clubSearchButton"
													style="background: #dc3545;"
													onclick="return confirm('구단 창설 신청을 거절하시겠습니까?');">

													거절

												</button>

											</form>

										</c:if>


										<c:if test="${dto.requestStatus != 2}">
											<span style="color: #999;">
												처리완료
											</span>
										</c:if>

									</td>

								</tr>

							</c:forEach>


							<c:if test="${empty requestList}">
								<tr>
									<td colspan="6"
										class="emptyClub">

										구단 창설 신청 내역이 없습니다.

									</td>
								</tr>
							</c:if>

						</tbody>

					</table>

				</div>


				<div style="margin-top: 20px; text-align: center;">
					${paging}
				</div>

			</div>

		</div>



		<!-- =====================================================
		     2. 구단 정지 관리
		     ===================================================== -->
		<div class="tab-pane fade ${activeTab == 'status' ? 'show active' : ''}"
			id="clubStatusTab">

			<div class="manageBox">

				<div class="manageBoxHeader">

					<div>
						<h4>구단 정지 관리</h4>

						<p>
							운영 중인 구단을 검색하고 정지 또는 활성화할 수 있습니다.
						</p>
					</div>


					<div class="requestCount">
						구단
						<strong>${clubDataCount}</strong>건
					</div>

				</div>


				<!-- 구단 검색 -->
				<form action="${pageContext.request.contextPath}/admin/clubstatus/list"
					method="get"
					class="clubSearch">

					<!-- 상태 -->
					<select name="status"
						class="clubSearchInput"
						style="width: 130px;">

						<option value="all"
							${clubStatus == 'all' ? 'selected' : ''}>
							전체
						</option>

						<option value="1"
							${clubStatus == '1' ? 'selected' : ''}>
							운영
						</option>

						<option value="0"
							${clubStatus == '0' ? 'selected' : ''}>
							정지
						</option>

					</select>


					<!-- 검색 종류 -->
					<select name="schType"
						class="clubSearchInput"
						style="width: 130px;">

						<option value="all"
							${clubSchType == 'all' ? 'selected' : ''}>
							전체
						</option>

						<option value="clubName"
							${clubSchType == 'clubName' ? 'selected' : ''}>
							구단명
						</option>

						<option value="clubRegion"
							${clubSchType == 'clubRegion' ? 'selected' : ''}>
							지역
						</option>

						<option value="userName"
							${clubSchType == 'userName' ? 'selected' : ''}>
							구단주
						</option>

					</select>


					<input type="text"
						name="kwd"
						value="${clubKwd}"
						class="clubSearchInput"
						placeholder="검색어를 입력하세요">


					<button type="submit"
						class="clubSearchButton">
						검색
					</button>

				</form>


				<!-- 구단 목록 -->
				<div class="tableWrap">

					<table class="clubTable">

						<colgroup>
							<col style="width: 10%;">
							<col style="width: 24%;">
							<col style="width: 17%;">
							<col style="width: 20%;">
							<col style="width: 14%;">
							<col style="width: 15%;">
						</colgroup>


						<thead>
							<tr>
								<th>번호</th>
								<th>구단명</th>
								<th>지역</th>
								<th>구단주</th>
								<th>상태</th>
								<th>관리</th>
							</tr>
						</thead>


						<tbody>

							<c:forEach var="club"
								items="${clubList}">

								<tr>

									<td>
										${club.clubOwnerKey}
									</td>


									<td>

										<c:choose>

											<c:when test="${not empty club.clubName}">
												<c:out value="${club.clubName}"/>
											</c:when>

											<c:otherwise>
												<span style="color: #999;">
													미등록
												</span>
											</c:otherwise>

										</c:choose>

									</td>


									<td>

										<c:choose>

											<c:when test="${not empty club.clubRegion}">
												<c:out value="${club.clubRegion}"/>
											</c:when>

											<c:otherwise>
												-
											</c:otherwise>

										</c:choose>

									</td>


									<td>
										<c:out value="${club.userName}"/>

										<br>

										<span style="color: #888; font-size: 12px;">
											<c:out value="${club.userId}"/>
										</span>
									</td>


									<td>

										<c:choose>

											<c:when test="${club.clubStatus == 1}">
												<span style="color: #198754; font-weight: 600;">
													운영
												</span>
											</c:when>

											<c:otherwise>
												<span style="color: #dc3545; font-weight: 600;">
													정지
												</span>
											</c:otherwise>

										</c:choose>

									</td>


									<td>

										<form action="${pageContext.request.contextPath}/admin/clubstatus/update"
											method="post">

											<input type="hidden"
												name="clubOwnerKey"
												value="${club.clubOwnerKey}">


											<c:choose>

												<c:when test="${club.clubStatus == 1}">
											
													<input type="hidden"
														name="clubStatus"
														value="0">
											
													<button type="submit"
														class="clubSearchButton"
														style="background: #dc3545;"
														onclick="return confirm('이 구단을 정지하시겠습니까?');">
											
														정지
											
													</button>
											
												</c:when>
											
											
												<c:otherwise>
											
													<input type="hidden"
														name="clubStatus"
														value="1">
											
													<button type="submit"
														class="clubSearchButton"
														style="background: #198754;"
														onclick="return confirm('이 구단의 정지를 해제하시겠습니까?');">
											
														활성화
											
													</button>
											
												</c:otherwise>
											
											</c:choose>

										</form>

									</td>

								</tr>

							</c:forEach>


							<c:if test="${empty clubList}">
								<tr>
									<td colspan="6"
										class="emptyClub">

										등록된 구단이 없습니다.

									</td>
								</tr>
							</c:if>

						</tbody>

					</table>

				</div>


				<div style="margin-top: 20px; text-align: center;">
					${clubPaging}
				</div>

			</div>

		</div>

	</div>

</div>


<jsp:include
	page="/WEB-INF/views/layout/footer.jsp" />