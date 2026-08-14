// JavaScript
const userIdInput = document.querySelector('#userId');
const rememberMeCheckbox = document.querySelector('#rememberMe');
const loginBtn = document.querySelector('#loginBtn');

// 1. 페이지 로드 시 저장된 아이디가 있으면 표시
window.addEventListener('DOMContentLoaded', () => {
  const savedId = localStorage.getItem('savedUserId');
  if (savedId) {
    userIdInput.value = savedId;
    rememberMeCheckbox.checked = true;
  }
});

// 2. 로그인 버튼 클릭 시 처리
loginBtn.addEventListener('click', () => {
  if (rememberMeCheckbox.checked) {
    // 체크되어 있으면 로컬 스토리지에 저장
    localStorage.setItem('savedUserId', userIdInput.value);
  } else {
    // 체크 해제되어 있으면 삭제
    localStorage.removeItem('savedUserId');
  }
});
