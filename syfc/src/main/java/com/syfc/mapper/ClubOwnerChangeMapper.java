package com.syfc.mapper;

import java.util.List;
import java.util.Map;
import com.syfc.dto.ClubOwnerChangeDTO;

public interface ClubOwnerChangeMapper {
    // 1. 차기 구단주 선택용 선수 목록 조회 (Map 사용)
    public List<ClubOwnerChangeDTO> listTransferCandidates(Map<String, Object> map);

    // 2. 현재 로그인한 구단주의 비밀번호 확인
    public String getOwnerPassword(Long memberIdx);

    // 3. clubOwner 테이블의 주인(memberIdx) 교체
    public void updateClubOwner(ClubOwnerChangeDTO dto) throws Exception;

    // 4-1. 기존 구단주의 등급을 일반회원(1)으로 변경
    public void updateOwnerToMember(ClubOwnerChangeDTO dto) throws Exception;

    // 4-2. 위임받은 선수의 등급을 구단주(50)로 변경
    public void updatePlayerToOwner(ClubOwnerChangeDTO dto) throws Exception;
}
// 셀렉트 : String int 가능  
// void 쓰는 이유 인서트 딜리트 업데이트 
// 자바매퍼에 메서드를 작성하는법 모르겠음
// 메서드명작성법 1+1로직이면 plusNumber 이런식으로 작성하는건 알겠음
// public 도 JS에서 전역변수처럼 자바매퍼를 매퍼XML에서 불러서 메서드를 정의해야하기때문에 public 으로 작성

// 아래는 모르는것들
// 1.List 나 Map 이나 void 이런거 모르겠음 왜써야하는지
// 그리고 public String getOwnerPassword(Long memberIdx); 여기서 void가 아니라 왜 String으로 쓰는지 