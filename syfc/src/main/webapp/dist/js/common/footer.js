document.addEventListener("DOMContentLoaded", function() {
    const signupBtn = document.querySelector("#singupBtn");
    
    if (signupBtn) {
        signupBtn.addEventListener("click", function() {
            const signupModalEl = document.querySelector("#signupModal");
            if (signupModalEl) {
                const modal = new bootstrap.Modal(signupModalEl);
                modal.show();
            }
        });
    }
});
// 프로필 사진 미리보기 스크립트
function previewProfileImage(input) {
         if (input.files && input.files[0]) {
             const reader = new FileReader();
             reader.onload = function(e) {
                 const previewDiv = document.getElementById('profilePreview');
                 previewDiv.innerHTML = `<img src="${e.target.result}" alt="프로필 미리보기" style="width:100%; height:100%; object-fit:cover;">`;
             };
             reader.readAsDataURL(input.files[0]);
         }
     }