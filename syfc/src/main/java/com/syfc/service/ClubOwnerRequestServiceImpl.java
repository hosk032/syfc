package com.syfc.service;

import java.util.List;

import com.syfc.dto.ClubOwnerRequestDTO;
import com.syfc.mapper.ClubOwnerRequestMapper;
import com.syfc.mybatis.support.MapperContainer;

public class ClubOwnerRequestServiceImpl implements ClubOwnerRequestService{
	private ClubOwnerRequestMapper mapper = MapperContainer.get(ClubOwnerRequestMapper.class);
	
	@Override
	public int insertClubOwnerRequest(ClubOwnerRequestDTO dto) {
		
		return mapper.insertClubOwnerRequest(dto);
	}

	@Override
	public List<ClubOwnerRequestDTO> listClubOwnerRequest(long memberIdx) {
		
		return mapper.listClubOwnerRequest(memberIdx);
	}

	@Override
	public int deleteClubOwnerRequest(ClubOwnerRequestDTO dto) {
		
		return mapper.deleteClubOwnerRequest(dto);
	}

}
