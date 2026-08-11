document.addEventListener('DOMContentLoaded', () => {
     const playerList = document.getElementById('playerList');
     const btnAddPlayer = document.getElementById('btnAddPlayer');
     const clubLogo = document.getElementById('clubLogo');
     const previewBox = document.getElementById('previewBox');
     const logoPreview = document.getElementById('logoPreview');
     const form = document.querySelector('.writeForm');

     const clubNameInput = document.getElementById('clubName');
     const btnCheckClubName = document.getElementById('btnCheckClubName');
     const clubNameMsg = document.getElementById('clubNameMsg');

     let isClubNameChecked = false;
     const existingClubs = ['FC 쌍용', 'FC 서울', 'FC 바르셀로나', '토트넘'];

     // 중복 확인
     btnCheckClubName.addEventListener('click', () => {
       const value = clubNameInput.value.trim();

       if (!value) {
         clubNameMsg.textContent = '구단명을 입력해 주세요.';
         clubNameMsg.className = 'checkMsg error';
         isClubNameChecked = false;
         return;
       }

       const isDuplicate = existingClubs.some(name => name.toLowerCase() === value.toLowerCase());

       if (isDuplicate) {
         clubNameMsg.textContent = '이미 사용 중인 구단명입니다.';
         clubNameMsg.className = 'checkMsg error';
         isClubNameChecked = false;
       } else {
         clubNameMsg.textContent = '사용 가능한 구단명입니다.';
         clubNameMsg.className = 'checkMsg success';
         isClubNameChecked = true;
       }
     });

     clubNameInput.addEventListener('input', () => {
       isClubNameChecked = false;
       clubNameMsg.textContent = '';
       clubNameMsg.className = 'checkMsg';
     });

     // 로고 미리보기
     clubLogo.addEventListener('change', (e) => {
       const file = e.target.files[0];
       if (file) {
         const reader = new FileReader();
         reader.onload = (event) => {
           logoPreview.src = event.target.result;
           previewBox.style.display = 'block';
         };
         reader.readAsDataURL(file);
       } else {
         logoPreview.src = '';
         previewBox.style.display = 'none';
       }
     });

     // 폼 제출 검증
     form.addEventListener('submit', (e) => {
       if (!isClubNameChecked) {
         e.preventDefault();
         alert('구단명 중복 확인을 진행해 주세요.');
         clubNameInput.focus();
       }
     });

     form.addEventListener('reset', () => {
       logoPreview.src = '';
       previewBox.style.display = 'none';
       clubNameMsg.textContent = '';
       clubNameMsg.className = 'checkMsg';
       isClubNameChecked = false;
     });

     // 선수 동적 생성
     function createPlayerRow(number) {
       const playerRow = document.createElement('div');
       playerRow.className = 'playerRow';
       playerRow.innerHTML = `
         <span class="playerNum">${number}</span>
         <input type="text" name="playerName[]" class="formControl playerInput" placeholder="선수명 (예: 홍길동)" required />
         <select name="playerPosition[]" class="formControl selectControl playerSelect">
           <option value="FW">FW (공격수)</option>
           <option value="MF" selected>MF (미드필더)</option>
           <option value="DF">DF (수비수)</option>
           <option value="GK">GK (골키퍼)</option>
         </select>
         ${number > 11 ? '<button type="button" class="btnRemovePlayer"><i class="bi bi-trash"></i> 삭제</button>' : ''}
       `;

       const removeBtn = playerRow.querySelector('.btnRemovePlayer');
       if (removeBtn) {
         removeBtn.addEventListener('click', () => {
           playerRow.remove();
           reorderPlayerNumbers();
         });
       }

       return playerRow;
     }

     function reorderPlayerNumbers() {
       const rows = playerList.querySelectorAll('.playerRow');
       rows.forEach((row, index) => {
         row.querySelector('.playerNum').textContent = index + 1;
       });
     }

     // 기본 11명 세팅
     for (let i = 1; i <= 11; i++) {
       playerList.appendChild(createPlayerRow(i));
     }

     btnAddPlayer.addEventListener('click', () => {
       const currentTotal = playerList.querySelectorAll('.playerRow').length;
       playerList.appendChild(createPlayerRow(currentTotal + 1));
     });
   });