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