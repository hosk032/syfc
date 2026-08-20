$(function () {

    initMatchSubTab();

});


/*
 * =========================================================
 * 경기 매칭 하위 탭 초기화
 * =========================================================
 */

function initMatchSubTab() {

    const $matchApply = $("#match-apply");

    /*
     * 현재 페이지에 경기 매칭 영역이 없으면 종료
     */

    if ($matchApply.length === 0) {
        return;
    }


    /*
     * ---------------------------------------------------------
     * 하위 탭 클릭 이벤트
     * ---------------------------------------------------------
     *
     * #match-apply 안에서만 이벤트가 발생하도록 제한
     */

    $matchApply.on(
        "click",
        "#matchSubTab [data-match-tab]",
        function () {

            const target = $(this).data("match-tab");

            switchMatchSubTab(target);

        }
    );


    /*
     * ---------------------------------------------------------
     * 최초 진입
     * ---------------------------------------------------------
     *
     * 구단주라면 create
     * 선수라면 result
     *
     * 단, 실제 HTML에 존재하는 탭인지 확인하고
     * 존재하는 첫 번째 탭을 최종 기본값으로 사용
     */

    const $firstButton =
        $matchApply.find(
            "#matchSubTab [data-match-tab]"
        ).first();


    if ($firstButton.length === 0) {
        return;
    }


    const firstTarget =
        $firstButton.data("match-tab");


    switchMatchSubTab(firstTarget);

}


/*
 * =========================================================
 * 경기 매칭 하위 탭 전환
 * =========================================================
 */

function switchMatchSubTab(target) {

    const $matchApply = $("#match-apply");

    /*
     * 경기 매칭 영역이 없으면 종료
     */

    if ($matchApply.length === 0) {
        return;
    }


    /*
     * ---------------------------------------------------------
     * 1. 경기 매칭 내부의 모든 탭 버튼 비활성화
     * ---------------------------------------------------------
     */

    $matchApply
        .find("#matchSubTab .nav-link")
        .removeClass("active");


    /*
     * ---------------------------------------------------------
     * 2. 경기 매칭 내부의 모든 내용 숨기기
     * ---------------------------------------------------------
     *
     * 중요:
     *
     * $(".match-sub-pane")
     *
     * 이렇게 전체 문서에서 찾지 않는다.
     *
     * 반드시 #match-apply 내부에서만 찾는다.
     */

    $matchApply
        .find("#matchSubTabContent .match-sub-pane")
        .hide()
        .removeClass("active");


    /*
     * ---------------------------------------------------------
     * 3. 클릭된 메뉴 활성화
     * ---------------------------------------------------------
     */

    const $button =
        $matchApply.find(
            '#matchSubTab [data-match-tab="' +
            target +
            '"]'
        );


    /*
     * 존재하지 않는 탭이면 종료
     */

    if ($button.length === 0) {
        return;
    }


    $button.addClass("active");


    /*
     * ---------------------------------------------------------
     * 4. 선택한 내용 표시
     * ---------------------------------------------------------
     */

    let paneId = null;


    switch (target) {

        /*
         * ---------------------------------------------
         * 구단주 : 경기 매칭 개설
         * ---------------------------------------------
         */

        case "create":

            paneId = "#match-create-pane";

            break;


        /*
         * ---------------------------------------------
         * 선수 : 출전신청 결과
         * ---------------------------------------------
         */

        case "result":

            paneId = "#match-result-pane";

            break;


        /*
         * ---------------------------------------------
         * 공통 : 모집 게시판
         * ---------------------------------------------
         */

        case "board":

            paneId = "#match-board-pane";

            break;


        /*
         * ---------------------------------------------
         * 공통 : 경기 신청 이력
         * ---------------------------------------------
         */

        case "history":

            paneId = "#match-history-pane";

            break;

    }


    /*
     * ---------------------------------------------------------
     * 5. 해당 pane만 표시
     * ---------------------------------------------------------
     */

    if (paneId === null) {
        return;
    }


    const $pane =
        $matchApply.find(paneId);


    /*
     * 해당 페이지가 실제로 존재하는 경우에만 표시
     */

    if ($pane.length === 0) {
        return;
    }


    $pane
        .addClass("active")
        .show();


    /*
     * ---------------------------------------------------------
     * 6. 필요한 데이터 새로 조회
     * ---------------------------------------------------------
     */

    if (target === "board") {

        if (typeof loadMatchBoardList === "function") {

            loadMatchBoardList();

        }

    }


    if (target === "history") {

        if (typeof loadMyMatchApply === "function") {

            loadMyMatchApply();

        }

    }


    /*
     * 선수의 출전신청 결과를 열었을 때
     */

    if (target === "result") {

        if (typeof loadRequestResult === "function") {

            loadRequestResult();

        }

    }

}
