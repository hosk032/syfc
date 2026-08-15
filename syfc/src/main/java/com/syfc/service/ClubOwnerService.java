package com.syfc.service;

import com.syfc.dto.ClubDTO;

public interface ClubOwnerService {
	
	// 회원번호로 구단 정보 조회
	public ClubDTO selectClubInfoByMemberIdx(long memberIdx);
	
	// 구단 정보 수정
	public void updateClubInfo(ClubDTO dto) throws Exception;

}