<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"  %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>쌍용축구예약 - 선수 목록</title>
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/clubinfoply/playerList.css" />
</head>
<body>

	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

		<div class="club-container my-4">
			<section class="club-content-area">
				<div class="club-top d-flex justify-content-between align-items-center">
					<h3>선수 목록</h3>
					<span class="text-muted fs-6">총 ${dataCount}명 선수</span>
				</div>
				
				<div class="player-table-responsive">
					<table class="table table-hover player-table align-middle">
					<thead>
					    <tr>
					        <th width="120">선수명</th>
					        <th>구단명</th>
					        <th width="100">포지션</th>
					        <th width="100">등번호</th>
					        <th width="110">키</th>
					        <th width="110">몸무게</th>
					        <th width="170">생년월일</th>
					        <th> 
					    </tr>
					</thead>
					
					<tbody class="">
					    <c:choose>
							<c:when test="${not empty list}">
							<c:forEach var="dto" items="${list}">
							<tr class=club-center>
								<td class="col-name">
								    <strong>
								        <c:out value="${dto.userName}"/>
								    </strong>
								</td>
								<!-- 구단 -->
								<td class="col-club">
								    <c:out value="${dto.club_name}"/>
								</td>
								<!-- 포지션 -->
								<td class="col-position">
								    <span class="position-badge">
								        <c:out value="${dto.position != null ? dto.position : '-'}"/>
								    </span>
								</td>
					
								<!-- 등번호 -->
								<td class="col-number">
								    <span class="number-badge">
								        <c:out value="${dto.uniform_no != null ? dto.uniform_no : '-'}"/>
								    </span>
								</td>
					
					
								<!-- 키 -->
								<td class="col-height">
								    <c:out value="${dto.height != null ? dto.height : '-'}"/> cm
								</td>
					
								<!-- 몸무게 -->
								<td class="col-weight">
								    <c:out value="${dto.weight != null ? dto.weight : '-'}"/> kg
								</td>
					
								<!-- 생년월일 -->
								<td class="col-birth">
								    <c:out value="${dto.birth != null ? dto.birth : '-'}"/>
								</td>
							</tr>
								</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="8" class="player-empty">
											등록된 선수 정보가 없습니다.
										</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>

			
			<div class="row board-list-footer">
				<div class="col">
					<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/clubinfoply/playerList';" title="새로고침">
						<i class="bi bi-arrow-counterclockwise"></i>
					</button>
				</div>
				<div class="col-6 d-flex justify-content-center">
					<form class="row" name="searchForm">
						<div class="col-auto p-1">
							<select name="schType" class="form-select">
								<option value="all" ${schType=="all"?"selected":""}>선수명+구단명</option>
								<option value="userName" ${schType=="userName"?"selected":""}>선수명</option>
								<option value="club_name" ${schType=="club_name"?"selected":""}>구단명</option>
							</select>
						</div>
						<div class="col-auto p-1">
							<input type="text" name="kwd" value="${kwd}" class="form-control" placeholder="검색어 입력">
						</div>
						<div class="col-auto p-1">
							<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
						</div>
					</form>
				</div>
				
				<div class="col text-end"></div>
			</div>
			
			<!-- 페이징 -->
			<div class="board-number d-flex justify-content-center align-items-center w-100 text-center">
			    ${dataCount == 0 ? "" : paging}
			</div>
		</section>
	</div>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', () => {
	const inputEL = document.querySelector('form input[name=kwd]'); 
	if(inputEL) {
		inputEL.addEventListener('keydown', function (evt) {
			if(evt.key === 'Enter') {
				evt.preventDefault();
				searchList();
			}
		});
	}
});

function searchList() {
	const f = document.searchForm;
	if(! f.kwd.value.trim()) {
		return;
	}
	
	const formData = new FormData(f);
	let params = new URLSearchParams(formData).toString();
	
	let url = '${pageContext.request.contextPath}/clubinfoply/playerList';
	location.href = url + '?' + params;
}
</script>

	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

</body>
</html>