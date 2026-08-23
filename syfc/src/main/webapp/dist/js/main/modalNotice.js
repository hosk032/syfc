var contextPath = document.querySelector('meta[name="contextPath"]'
    ).getAttribute("content");

//알림 모달 열기
function openNoticeModal() {
    var modal = document.getElementById("noticeModal");

    if (!modal) { return; }

    modal.classList.add("show");

    loadNoticeList();
}


// 알림 모달 닫기
function closeNoticeModal() {

    var modal = document.getElementById("noticeModal");
    if (!modal) {
        return;
    }
    modal.classList.remove("show");
}


// 알림 목록 Ajax
function loadNoticeList() {

    var listContainer = document.getElementById("noticeList");

    if (!listContainer) {
        return;
    }

    listContainer.innerHTML =
        '<div class="notice-loading">' +
            '알림을 불러오는 중입니다...' +
        '</div>';

    $.ajax({
        url: contextPath + "/notice/list",
        type: "GET",
        dataType: "json",

        success: function(res) {
            if (!res.success) {
                listContainer.innerHTML =
                    '<div class="notice-empty">' +
                        '알림을 불러오지 못했습니다.' +
                    '</div>';
                return;
            }

            renderNoticeList(res.list);
        },

        error: function(xhr, status, error) {
            console.error(
                "알림 목록 조회 실패:",
                error
            );

            listContainer.innerHTML =
                '<div class="notice-empty">' +
                    '알림을 불러오지 못했습니다.' +
                '</div>';
        }

    });
}


// 알림 목록 출력
function renderNoticeList(list) {

    var container = document.getElementById("noticeList");
    if (!container) {
        return;
    }

    if (!list || list.length === 0) {
		
        container.innerHTML =
            '<div class="notice-empty">' +
                '<i class="fa-regular fa-bell-slash"></i>' +
                '<p>' +
                    '새로운 알림이 없습니다.' +
                '</p>' +
            '</div>';
        return;
    }

    var html = "";

    for (var i = 0; i < list.length; i++) {

        var notice = list[i];
        var unread = Number(notice.notice_read) === 0;

        html +=
            '<div class="notice-item ' +
                (unread ? "unread" : "read") +
                '"' +
                ' data-notice-id="' +
                    notice.notice_id +
                '"' +
                ' onclick="readNotice(' +
                    notice.notice_id +
                    ', this)">' +

                '<div class="notice-icon">' +
                    '<i class="fa-regular fa-bell"></i>' +
                '</div>' +

                '<div class="notice-content">' +
                    '<div class="notice-message">' +
                        escapeHtml(
                            notice.notice_content
                        ) +
                    '</div>' +

                    '<div class="notice-date">' +
                        (notice.notice_sendDate
                                ? notice.notice_sendDate : "") +
                    '</div>' +
                '</div>' +

                (unread ? '<span class="notice-dot"></span>' : "") +
            '</div>';
    }

    container.innerHTML = html;
}


// 알림 읽음 처리
function readNotice(noticeId, element) {

    $.ajax({
        url: contextPath + "/notice/read",
        type: "POST",
        data: {
            notice_id: noticeId
        },
        dataType: "json",

        success: function(res) {
            if (!res.success) {
                return;
            }

            // 화면 읽음 상태 변경
            $(element).removeClass("unread").addClass("read");

            // 안 읽음 점 제거
            $(element).find(".notice-dot").remove();
        },

        error: function(xhr, status, error) {
            console.error("알림 읽음 처리 실패:", error);
        }

    });
}


// HTML 특수문자 escape
function escapeHtml(value) {

    if (value == null) {
        return "";
    }
    return String(value)
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}


// 초기 이벤트
$(document).ready(function() {

    // 알림 버튼
    var noticeButton = document.getElementById("noticeBtn");

    // 닫기 버튼
    var closeButton = document.getElementById( "noticeModalClose");

    // 배경
    var overlay = document.querySelector(".notice-modal-overlay");

    // 알림 버튼 클릭
    if (noticeButton) {
        noticeButton.addEventListener("click", openNoticeModal);
    }

    // 닫기 버튼 클릭
    if (closeButton) {
        closeButton.addEventListener( "click",closeNoticeModal);
    }

    // 배경 클릭
    if (overlay) {
        overlay.addEventListener("click", closeNoticeModal);
    }

});