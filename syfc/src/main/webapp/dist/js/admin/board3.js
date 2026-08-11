document.addEventListener('DOMContentLoaded', () => {
      const stadiumImage = document.getElementById('stadiumImage');
      const previewBox = document.getElementById('previewBox');
      const imagePreview = document.getElementById('imagePreview');
      const form = document.querySelector('.writeForm');

      const statusRadios = document.querySelectorAll('input[name="stadiumStatus"]');
      const statusBadge = document.getElementById('statusBadge');
      const stadiumPriceInput = document.getElementById('stadiumPrice');

      // 금액 3자리 콤마 콤보
      stadiumPriceInput.addEventListener('input', (e) => {
        let value = e.target.value.replace(/[^0-9]/g, '');
        if (value) {
          e.target.value = Number(value).toLocaleString();
        } else {
          e.target.value = '';
        }
      });

      // 라디오 상태 뱃지 스위칭
      statusRadios.forEach(radio => {
        radio.addEventListener('change', (e) => {
          if (e.target.value === 'AVAILABLE') {
            statusBadge.textContent = '경기가능 상태';
            statusBadge.className = 'badgeStatus badgeAvailable';
          } else {
            statusBadge.textContent = '경기불가 상태';
            statusBadge.className = 'badgeStatus badgeUnavailable';
          }
        });
      });

      // 이미지 파일 미리보기
      stadiumImage.addEventListener('change', (e) => {
        const file = e.target.files[0];
        if (file) {
          const reader = new FileReader();
          reader.onload = (event) => {
            imagePreview.src = event.target.result;
            previewBox.style.display = 'block';
          };
          reader.readAsDataURL(file);
        } else {
          imagePreview.src = '';
          previewBox.style.display = 'none';
        }
      });

      // 리셋 시 뱃지 초기화
      form.addEventListener('reset', () => {
        imagePreview.src = '';
        previewBox.style.display = 'none';
        
        setTimeout(() => {
          statusBadge.textContent = '경기가능 상태';
          statusBadge.className = 'badgeStatus badgeAvailable';
        }, 0);
      });
    });

    // 카카오 우편번호 주소검색 연동
    function execDaumPostcode() {
      new daum.Postcode({
        oncomplete: function(data) {
          var addr = (data.userSelectedType === 'R') ? data.roadAddress : data.jibunAddress;
          document.getElementById('stadiumAddress').value = addr;
          document.getElementById('stadiumDetailAddress').focus();
        }
      }).open();
    }