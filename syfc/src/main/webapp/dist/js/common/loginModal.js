document.addEventListener("DOMContentLoaded", function() {
    const form = document.querySelector("#loginForm");
    const modalElement = document.querySelector("#signupModal");

    // [핵심] 배경 검은막(.modal-backdrop) 및 스크롤 고정 강제 해제 함수
    function forceCloseModal() {
        // 1. 잔상으로 남은 어두운 배경 막 전부 삭제
        document.querySelectorAll('.modal-backdrop').forEach(el => el.remove());
        
        // 2. body 태그의 모달 고정 상태 해제
        document.body.classList.remove('modal-open');
        document.body.style.overflow = '';
        document.body.style.paddingRight = '';
        
        // 3. 모달 요소 숨기기
        if (modalElement) {
            modalElement.classList.remove('show');
            modalElement.style.display = 'none';
            modalElement.setAttribute('aria-hidden', 'true');
        }
    }

    // 1. X 버튼 및 그 안의 아이콘 클릭 이벤트 처리
    const closeBtn = document.querySelector(".btn-close-custom");
    if (closeBtn) {
        closeBtn.addEventListener("click", function(e) {
            e.preventDefault();
            e.stopPropagation();
            forceCloseModal();
        });
    }

    // 2. 모달 바깥 영역 클릭 처리
    if (modalElement) {
        modalElement.addEventListener("click", function(e) {
            if (e.target === modalElement) {
                forceCloseModal();
            }
        });

        // Bootstrap 고유 hidden 이벤트 감지 시 안전장치
        modalElement.addEventListener('hidden.bs.modal', function () {
            forceCloseModal();
        });
    }

    // 3. 로그인 폼 제출(Submit) 유효성 검사
    if (form) {
        form.addEventListener("submit", function(e) {
            const userId = form.userId.value.trim();
            const userPwd = form.userPwd.value.trim();

            if (!userId) {
                e.preventDefault();
                alert("아이디를 입력해주세요.");
                form.userId.focus();
                return;
            }

            if (!userPwd) {
                e.preventDefault();
                alert("비밀번호를 입력해주세요.");
                form.userPwd.focus();
                return;
            }
        });
    }
});