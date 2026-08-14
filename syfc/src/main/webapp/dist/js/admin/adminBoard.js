/*
 * =========================================================
 * 관리자 게시판 관리
 * =========================================================
 *
 * 1. 공지사항
 * 2. 자유게시판
 * 3. 문의 / 신고
 */


/* =========================================================
   1. 공지사항 관리
   ========================================================= */

// 공지사항 등록 모달 열기
function openNoticeModal() {
	const modal = new bootstrap.Modal(document.getElementById('noticeWriteModal'));
	modal.show();
}

/*
 * ★ 공지사항 등록
 * 제목/내용을 확인한 뒤 noticeForm을 submit한다.
 * 실제 저장은 POST /admin/notice/write Controller가 처리한다.
 */
function saveNotice() {
	const subject = document.getElementById('noticeSubject').value.trim();
	const content = document.getElementById('noticeContent').value.trim();

	if (!subject) {
		alert('공지 제목을 입력해주세요.');
		document.getElementById('noticeSubject').focus();
		return;
	}

	if (!content) {
		alert('공지 내용을 입력해주세요.');
		document.getElementById('noticeContent').focus();
		return;
	}

	if (!confirm('공지사항을 등록하시겠습니까?')) {
		return;
	}

	document.getElementById('noticeForm').submit();
}

/*
 * ★ 공지사항 실제 삭제
 * JSP body의 data-context-path에서 contextPath를 가져와
 * 기존 GET /admin/notice/delete Controller로 이동한다.
 */
function deleteNotice(num) {
	if (!confirm('공지사항을 삭제하시겠습니까?')) {
		return;
	}

	const cp = document.body.dataset.contextPath;
	location.href = cp + '/admin/notice/delete?num=' + num;
}


/* =========================================================
   2. 자유게시판 관리
   ========================================================= */

// 자유게시판 게시글 강제 삭제 / 블라인드
// 아직 화면 디자인용 함수이며 다음 단계에서 DB 기능과 연결한다.
function deleteFreeBoard(num) {
	if (confirm(num + '번 게시글을 강제 삭제(블라인드) 처리하시겠습니까?')) {
		alert('삭제 처리되었습니다.');
	}
}


/* =========================================================
   3. 문의 / 신고 관리
   ========================================================= */

// 문의 / 신고 상세 모달 열기
function openReportDetail(id, title, user, content) {
	document.getElementById('modalReportTitle').innerText = title;
	document.getElementById('modalReportUser').innerText = user;
	document.getElementById('modalReportContent').innerText = content;

	const modal = new bootstrap.Modal(document.getElementById('reportDetailModal'));
	modal.show();
}

// 문의 / 신고 답변 및 처리
function submitReportReply() {
	const text = document.getElementById('adminReplyText').value.trim();

	if (!text) {
		alert('답변 내용을 입력해 주세요.');
		return;
	}

	if (confirm('답변 및 처리 조치를 저장하시겠습니까?')) {
		alert('처리가 완료되었습니다.');
		location.reload();
	}
}
