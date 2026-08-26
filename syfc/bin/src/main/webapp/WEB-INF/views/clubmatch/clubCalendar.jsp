<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"  %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>쌍용축구예약 - 구단 경기기록 및 일정</title>
	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/clubmatch/clubCalendar.css" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="board-container my-4">
	<section class="board-list-area">
		<div class="match-table-responsive">
			<div class="board-top mb-3">
				<h3>구단 경기기록 및 일정</h3>
			</div>

			<!-- 1. 캘린더 컨트롤러 헤더 -->
			<div class="calendar-header d-flex justify-content-between align-items-center">
				<div class="d-flex align-items-center gap-2">
					<button type="button" class="btn btn-sm btn-outline-secondary" id="btnPrevMonth">
						<i class="bi bi-chevron-left"></i>
					</button>
					<h5 class="m-0 fw-bold px-2" id="calendarTitle">2026년 08월</h5>
					<button type="button" class="btn btn-sm btn-outline-secondary" id="btnNextMonth">
						<i class="bi bi-chevron-right"></i>
					</button>
					<button type="button" class="btn btn-sm btn-light border ms-2" id="btnToday">오늘</button>
				</div>
				<div class="calendar-legend d-flex gap-2 small text-muted">
					<span><i class="bi bi-calendar-event me-1"></i>경기일정 (구단 vs 구단)</span>
				</div>
			</div>

			<!-- 2. 메인 캘린더 그리드 -->
			<table class="calendar-table">
				<thead>
					<tr>
						<th class="text-danger" width="14.28%">일</th>
						<th width="14.28%">월</th>
						<th width="14.28%">화</th>
						<th width="14.28%">수</th>
						<th width="14.28%">목</th>
						<th width="14.28%">금</th>
						<th class="text-primary" width="14.28%">토</th>
					</tr>
				</thead>
				<tbody id="calendarBody">
					<!-- JavaScript에서 동적으로 생성 -->
				</tbody>
			</table>

			<!-- 3. 하단 검색 및 새로고침 영역 -->
			<div class="row align-items-center gx-2 mx-0 w-100 mt-3">
				<div class="col-auto p-0">
					<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/clubmatch/clubCalendar';" title="새로고침">
						<i class="bi bi-arrow-counterclockwise"></i>
					</button>
				</div>

				<div class="col d-flex justify-content-center px-0">
					<form class="row g-1 m-0 align-items-center" name="searchForm" onsubmit="return false;">
						<div class="col-auto">
							<select name="schType" class="form-select">
								<option value="club_name" ${schType=="club_name"?"selected":""}>구단명</option>
							</select>
						</div>
						<div class="col-auto">
							<input type="text" name="kwd" value="${kwd}" class="form-control" placeholder="검색어 입력">
						</div>
						<div class="col-auto">
							<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
						</div>
					</form>
				</div>

				<div class="col-auto p-0" style="visibility: hidden;" aria-hidden="true">
					<button type="button" class="btn btn-light"><i class="bi bi-arrow-counterclockwise"></i></button>
				</div>
			</div>
		</div>
	</section>
</div>

<script type="text/javascript">
let currentDate = new Date();

document.addEventListener('DOMContentLoaded', () => {
	loadCalendarData(currentDate);

	document.getElementById('btnPrevMonth').addEventListener('click', () => {
		currentDate.setMonth(currentDate.getMonth() - 1);
		loadCalendarData(currentDate);
	});

	document.getElementById('btnNextMonth').addEventListener('click', () => {
		currentDate.setMonth(currentDate.getMonth() + 1);
		loadCalendarData(currentDate);
	});

	document.getElementById('btnToday').addEventListener('click', () => {
		currentDate = new Date();
		loadCalendarData(currentDate);
	});

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

function loadCalendarData(date) {
	const year = date.getFullYear();
	const month = date.getMonth() + 1;
	
	const schType = document.searchForm.schType.value;
	const kwd = document.searchForm.kwd.value.trim();

	let url = '${pageContext.request.contextPath}/clubmatch/monthMatchList';
	url += '?year=' + year + '&month=' + month + '&schType=' + schType + '&kwd=' + encodeURIComponent(kwd);

	fetch(url)
		.then(response => response.json())
		.then(data => {
			if(data.state === "true") {
				renderCalendar(date, data.matchList);
			} else {
				renderCalendar(date, []);
			}
		})
		.catch(error => {
			console.error('Data Fetch Error:', error);
			renderCalendar(date, []);
		});
}

function renderCalendar(date, matchList) {
	const year = date.getFullYear();
	const month = date.getMonth();

	document.getElementById('calendarTitle').innerText = year + '년 ' + String(month + 1).padStart(2, '0') + '월';

	const firstDay = new Date(year, month, 1).getDay();
	const lastDate = new Date(year, month + 1, 0).getDate();
	const prevLastDate = new Date(year, month, 0).getDate();

	const calendarBody = document.getElementById('calendarBody');
	calendarBody.innerHTML = '';

	let row = document.createElement('tr');
	let dayCount = 0;

	// 지난달 이월 날짜
	for (let i = firstDay - 1; i >= 0; i--) {
		const td = document.createElement('td');
		td.className = 'other-month';
		td.innerHTML = '<div class="day-number">' + (prevLastDate - i) + '</div>';
		row.appendChild(td);
		dayCount++;
	}

	// 현재달 날짜
	const today = new Date();
	for (let d = 1; d <= lastDate; d++) {
		if (dayCount === 7) {
			calendarBody.appendChild(row);
			row = document.createElement('tr');
			dayCount = 0;
		}

		const td = document.createElement('td');
		const isToday = (today.getFullYear() === year && today.getMonth() === month && today.getDate() === d);
		if (isToday) td.className = 'today';

		let textColorClass = (dayCount === 0) ? 'text-danger' : ((dayCount === 6) ? 'text-primary' : '');
		let cellContent = '<div class="day-number ' + textColorClass + '">' + d + '</div>';

		const currentDateStr = year + '-' + String(month + 1).padStart(2, '0') + '-' + String(d).padStart(2, '0');

		if (matchList && matchList.length > 0) {
			const dayMatches = matchList.filter(item => item.matchDate === currentDateStr);

			// 투명 스타일 적용 (박스 형태 제거)
			dayMatches.forEach(function(m) {
				var timeStr = (m.matchTime !== null && m.matchTime !== undefined) ? (m.matchTime + '시') : '';
				var homeStr = m.homeClubName ? m.homeClubName : '미정';
				var awayStr = m.awayClubName ? m.awayClubName : '미정';

				cellContent += '<div class="match-item" style="white-space: normal; word-break: break-word; line-height: 1.35; margin-top: 4px; padding: 2px 0; font-size: 0.8rem; background: transparent; border: none; box-shadow: none;">';
				
				// 1. 시간
				if (timeStr) {
					cellContent += '<div style="font-weight: 600; color: #6c757d; font-size: 0.75rem;">' + timeStr + '</div>';
				}
				
				// 2. 구단 대진
				cellContent += '<div style="color: #212529;">' + homeStr + ' vs ' + awayStr + '</div>';

				// 3. 스코어
				if (m.homeScore !== null && m.awayScore !== null && m.homeScore !== undefined && m.awayScore !== undefined) {
					cellContent += '<div style="font-weight: bold; color: #dc3545; margin-top: 1px;">(' + m.homeScore + ' : ' + m.awayScore + ')</div>';
				}
				
				cellContent += '</div>';
			});
		}

		td.innerHTML = cellContent;
		row.appendChild(td);
		dayCount++;
	}

	// 다음달 이월 날짜
	let nextMonthDay = 1;
	while (dayCount < 7) {
		const td = document.createElement('td');
		td.className = 'other-month';
		td.innerHTML = '<div class="day-number">' + nextMonthDay++ + '</div>';
		row.appendChild(td);
		dayCount++;
	}
	calendarBody.appendChild(row);
}

function searchList() {
	loadCalendarData(currentDate);
}
</script>

	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>