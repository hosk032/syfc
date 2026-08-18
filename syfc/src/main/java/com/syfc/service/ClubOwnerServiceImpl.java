package com.syfc.service;

import com.syfc.dto.ClubDTO;
import com.syfc.mapper.ClubOwnerMapper;
import com.syfc.mybatis.support.MapperContainer; // 패키지 경로 확인!

public class ClubOwnerServiceImpl implements ClubOwnerService {
	private ClubOwnerMapper mapper = MapperContainer.get(ClubOwnerMapper.class);

	@Override
	public ClubDTO selectClubInfoByMemberIdx(long memberIdx) {
		ClubDTO dto = null;
		
		try {
			// 1. 회원 PK로 구단주 PK 조회
			Long clubOwnerKey = mapper.findClubOwnerKeyByMemberIdx(memberIdx);
			
			// 2. 구단주 PK로 구단 상세 정보 조회
			if (clubOwnerKey != null) {
				dto = mapper.selectClubInfo(clubOwnerKey);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public void updateClubInfo(ClubDTO dto) throws Exception {
		try {
			mapper.updateClubInfo(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

}