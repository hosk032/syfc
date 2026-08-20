package com.syfc.service;

import java.util.List;

import com.syfc.dto.MatchHistoryDTO;
import com.syfc.mapper.MatchHistoryMapper;
import com.syfc.mybatis.support.MapperContainer;

public class MatchHistoryImpl implements MatchHistoryService{
	private MatchHistoryMapper mapper = MapperContainer.get(MatchHistoryMapper.class);
	
	@Override
	public List<MatchHistoryDTO> listMatchHistory(long memberIdx) {
		
		return mapper.listMatchHistory(memberIdx);
	}

	@Override
	public int countPlayedMatches(long memeberIdx) {
		
		return mapper.countPlayedMatches(memeberIdx);
	}

}
