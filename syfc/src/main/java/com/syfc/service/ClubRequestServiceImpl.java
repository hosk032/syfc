package com.syfc.service;

import com.syfc.dto.ClubRequestDTO;
import com.syfc.mapper.ClubRequestMapper;
import com.syfc.mybatis.support.MapperContainer;

public class ClubRequestServiceImpl implements ClubRequestService {
	private ClubRequestMapper mapper = MapperContainer.get(ClubRequestMapper.class);

	@Override
	public int insertClubRequest(ClubRequestDTO dto) {
		try {
			return mapper.insertClubRequest(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public ClubRequestDTO findByMemberIdx(long memberIdx) {
		try {
			return mapper.findByMemberIdx(memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}