//const contextPath = form.dataset.contextPath;

document.addEventListener("DOMContentLoaded", function() {
	const form = document.querySelector("#loginForm");
	
	//로그인 모달이 없는 페이지라면 종료
	if ( !form ) {
		return;
	}
	
	form.addEventListener("submit", function(e) {
		const userId = form.userId.value.trim();
		const userPwd = form.userPwd.value.trim();
		
		//아이디 검사
		if (! userId) {
			e.preventDefault();
			
			alert("아이디를 입력해주세요.");
			form.userId.focus();
			
			return;
		}
		
		if (! userPwd) {
			e.preventDefault();
			
			alert("비밀번호를 입력해주세요.");
			form.userId.focus();
			
			return;
		}
	})
	
})