// 승인/거절/제적 자바스크립트 간단 처리 예시
  function approvePlayer(name) {
      if(confirm(`${name} 선수의 입단을 승인하시겠습니까?`)) {
          alert('입단 승인이 완료되었습니다.');
          // AJAX 요청 후 목록 새로고침 로직 들어갈 위치
      }
  }

  function rejectPlayer(name) {
      if(confirm(`${name} 선수의 입단 신청을 거절하시겠습니까?`)) {
          alert('거절 처리되었습니다.');
      }
  }

  function removePlayer(name) {
      if(confirm(`정말로 ${name} 선수를 구단에서 제적(강퇴)하시겠습니까?`)) {
          alert('제적 처리되었습니다.');
      }
  }