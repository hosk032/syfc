package com.syfc.mapper;

import com.syfc.dto.ClubDTO;
import com.syfc.dto.TeamRecordDTO;


public interface ClubOwnerMapper {

	// 1. 회원번호(memberIdx) 로 구단주 키(clubOwnerKey) 조회
	public Long findClubOwnerKeyByMemberIdx(Long memberIdx);
	
	// 2. 구단주 키로 내가 소속한 구단 정보 조회
	public ClubDTO selectClubInfo(Long clubOwnerKey);
	
	// 3. 구단 정보 수정
	public int updateClubInfo(ClubDTO dto);
	
	// 4. 구단 팀 성적 조회
	public TeamRecordDTO selectTeamRecord(Long clubOwnerkey);
}
