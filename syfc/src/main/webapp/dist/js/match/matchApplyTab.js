$(function () {
    initMatchSubTab();
});

// 경기 매칭 하위 탭 초기화
function initMatchSubTab() {
    $("#matchSubTab").on("click", "[data-match-tab]", function () {
        const target = $(this).data("match-tab");
        switchMatchSubTab(target);
    });

    // 페이지 처음 들어왔을 때 경기 매칭 개설 탭만 표시
    switchMatchSubTab("create");
}

// 경기 매칭 하위 탭 전환

function switchMatchSubTab(target) {

    // 1. 모든 탭 메뉴 비활성화
    $("#matchSubTab .nav-link").removeClass("active");

    // 2. 모든 페이지 숨기기
    $(".match-sub-pane").hide();

    // 3. 선택한 탭 활성화
    $('#matchSubTab [data-match-tab="' + target +'"]').addClass("active");


    // 4. 선택한 페이지 표시
    switch (target) {
        case "create":
            $("#match-create-pane").show();
            break;

        case "board":
            $("#match-board-pane").show();

            // 게시판을 열었을 때
            if (typeof loadMatchBoardList === "function") {
                loadMatchBoardList();
            }
            break;

        case "history":
            $("#match-history-pane").show();

            // 이력 탭을 열었을 때
            if (typeof loadMyMatchApply === "function") {
                loadMyMatchApply();
            }
            break;
    }

}