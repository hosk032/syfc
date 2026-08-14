// 카카오 주소 스크립트
function execDaumPostcode() {
          new daum.Postcode({
              oncomplete: function(data) {
                  var addr = '';
                  if (data.userSelectedType === 'R') { // 도로명 주소
                      addr = data.roadAddress;
                  } else { // 지번 주소
                      addr = data.jibunAddress;
                  }

                  document.getElementById('zipcode').value = data.zonecode;
                  document.getElementById("address1").value = addr;
                  document.getElementById("address2").focus();
              }
          }).open();
      }
	  
	  
//아이디 중복 체크
document.addEventListener("DOMContentLoaded", function() {

    const userIdInput = document.querySelector("#userId");
    const checkBtn = document.querySelector("#userIdCheckBtn");
    const message = document.querySelector("#userIdMessage");

    checkBtn.addEventListener("click", function() {

        const userId = userIdInput.value.trim();

        if(userId === "") {
            message.textContent = "아이디를 입력해주세요.";
            return;
        }

        fetch(contextPath + "/member/userIdCheck", {
            method: "POST",

            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },

            body: "userId=" + encodeURIComponent(userId)
        })
        .then(response => response.json())
        .then(data => {

            if(data.passed === "true") {
                message.textContent = "사용 가능한 아이디입니다.";
            } else {
                message.textContent = "이미 사용 중인 아이디입니다.";
            }

        })
        .catch(error => {
            console.error(error);
            message.textContent = "중복 확인 중 오류가 발생했습니다.";
        });

    });

});

const userPwd = document.getElementById('userPwd');
const userPwdCheck = document.getElementById('userPwdCheck');
const pwdMatchMessage = document.getElementById('pwdMatchMessage');

function checkPasswordMatch() {
	const pwdValue = userPwd.value;
	const pwdCheckValue = userPwdCheck.value;
	
	if (!pwdValue || !pwdCheckValue) {
		pwdMatchMessage.textContent = '';
		return;
	}
	
	if (pwdValue === pwdCheckValue) {
		pwdMatchMessage.textContent = '비밀번호가 일치합니다.';
		pwdMatchMessage.style.color = 'green';
	} else {
		pwdMatchMessage.textContent = '비밀번호가 일치하지 않습니다.';
		pwdMatchMessage.style.color = 'red';
	}
}

userPwd.addEventListener('input', checkPasswordMatch);
userPwdCheck.addEventListener('input', checkPasswordMatch);

