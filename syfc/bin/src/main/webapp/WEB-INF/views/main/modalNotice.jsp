<%@ page contentType="text/html; charset=UTF-8"%>

<div id="noticeModal"
     class="notice-modal">

    <!-- 배경 -->
    <div class="notice-modal-overlay"></div>


    <!-- 모달 -->
    <div class="notice-modal-box">

        <!-- 헤더 -->
        <div class="notice-modal-header">

            <div>

                <h4>알림</h4>

                <p>
                    새로운 알림을 확인해주세요.
                </p>

            </div>


            <button type="button"
                    id="noticeModalClose"
                    class="notice-modal-close">

                <i class="fa-solid fa-xmark"></i>

            </button>

        </div>


        <!-- 알림 목록 -->
        <div id="noticeList"
             class="notice-list">

            <div class="notice-loading">

                알림을 불러오는 중입니다...

            </div>

        </div>

    </div>

</div>