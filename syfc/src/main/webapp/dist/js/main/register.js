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

// 회원가입 추가 유효성 검사
document.getElementById("joinForm").addEventListener("submit", function(e) {

    const birth = document.getElementById("birth").value;
    const userId = document.getElementById("userId").value.trim();
    const userPwd = document.getElementById("userPwd").value;
    const tel = document.getElementById("tel").value.trim();

    // 1. 만 19세 이상인지 검사
    if (!birth) {
        alert("생년월일을 입력해주세요.");
        e.preventDefault();
        return;
    }

    const today = new Date();
    const birthDate = new Date(birth);

    let age = today.getFullYear() - birthDate.getFullYear();

    const birthdayPassed =
        (today.getMonth() > birthDate.getMonth()) ||
        (today.getMonth() === birthDate.getMonth() &&
         today.getDate() >= birthDate.getDate());

    if (!birthdayPassed) {
        age--;
    }

    if (age < 19) {
        alert("만 19세 이상만 가입할 수 있습니다.");
        e.preventDefault();
        return;
    }

    // 2. 아이디 검사 : 영문자 3개 이상 + 숫자 3개 이상
    const alphabetCount = (userId.match(/[a-zA-Z]/g) || []).length;
    const numberCount = (userId.match(/[0-9]/g) || []).length;

    if (alphabetCount < 3 || numberCount < 3) {
        alert("아이디는 영문자 3개 이상과 숫자 3개 이상을 포함해야 합니다.");
        e.preventDefault();
        return;
    }

    // 3. 비밀번호 검사 : 숫자 3개 이상
    const passwordNumberCount =
        (userPwd.match(/[0-9]/g) || []).length;

    if (passwordNumberCount < 3) {
        alert("비밀번호는 숫자를 3개 이상 포함해야 합니다.");
        e.preventDefault();
        return;
    }

    // 4. 전화번호 검사: 선택사항이므로 비어 있으면 통과
    // 입력했다면 숫자만 11~13자리
    if (tel !== "") {

        if (!/^[0-9]{11,13}$/.test(tel)) {
            alert("전화번호는 숫자만 11~13자리로 입력해주세요.");
            e.preventDefault();
            return;
        }
    }

});