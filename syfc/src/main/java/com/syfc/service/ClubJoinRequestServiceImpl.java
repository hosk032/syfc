package com.syfc.service;

import com.syfc.dto.ClubJoinDTO;
import com.syfc.mapper.ClubJoinMapper;
import com.syfc.mybatis.support.MapperContainer;

public class ClubJoinRequestServiceImpl implements ClubJoinRequestService{
	private ClubJoinMapper mapper = MapperContainer.get(ClubJoinMapper.class);
	
	@Override
	public int clubJoinRequest(ClubJoinDTO clubJoinDTO) {
		
		return mapper.clubJoinRequest(clubJoinDTO);
	}

}
