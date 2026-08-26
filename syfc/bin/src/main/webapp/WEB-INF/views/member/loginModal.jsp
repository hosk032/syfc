<%@ page contentType="text/html; charset=UTF-8"%>

<!-- 로그인 모달 -->
<div class="member-login-modal" id="singupModal" aria-hidden="true">
    <div class="member-login-modal__dialog">
        <div class="member-login-modal__content">

            <div class="member-login-modal__header">
                <h4>로그인</h4>
                <button type="button" class="btn-close-custom"
                        aria-label="닫기"
                        onclick="document.getElementById('singupModal').classList.remove('is-open');">
                    ×
                </button>
            </div>

            <div class="member-login-modal__body">
                <input type="text" class="custom-input" placeholder="아이디">
                <input type="password" class="custom-input" placeholder="비밀번호">
            </div>

            <div class="member-login-modal__footer">
                <button type="button" class="btn-submit">로그인</button>
            </div>

        </div>
    </div>
</div>
