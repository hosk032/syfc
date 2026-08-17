package com.syfc.service;

import java.util.List;

import com.syfc.dto.ClubOwnerHistoryDTO;
import com.syfc.mapper.ClubOwnerHistoryMapper;
import com.syfc.mybatis.support.MapperContainer;

public class ClubOwnerHistoryServiceImpl implements ClubOwnerHistoryService{
	private ClubOwnerHistoryMapper mapper = MapperContainer.get(ClubOwnerHistoryMapper.class);
	
	@Override
	public List<ClubOwnerHistoryDTO> clubOwnerRequestHistory(long memberIdx) {
		
		return mapper.listClubOwnerHistory(memberIdx);
	}

}
