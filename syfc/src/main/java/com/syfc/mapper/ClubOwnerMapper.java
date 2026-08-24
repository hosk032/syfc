package com.syfc.mapper;

import com.syfc.dto.ClubDTO;
import com.syfc.dto.TeamRecordDTO;

public interface ClubOwnerMapper {

	// 1. 회원 PK(memberIdx)로 구단주 PK(clubOwner_key) 조회
	public Long findClubOwnerKeyByMemberIdx(long memberIdx);
	
	// 2. 구단주 PK로 구단 상세 정보 조회
	public ClubDTO selectClubInfo(Long clubOwnerKey);
	
	// 3. 구단 정보 신규 등록 (추가된 메서드!)
	public void insertClubInfo(ClubDTO dto) throws Exception;
	
	// 4. 구단 정보 수정 (이름, 연고지, 로고, 창단일 등)
	public int updateClubInfo(ClubDTO dto);
	
	// 5. 구단 팀 성적 조회
	public TeamRecordDTO selectTeamRecord(Long clubOwnerkey);

}