package com.syfc.service;

import java.util.List;

import com.syfc.dto.MatchRecordDTO;
import com.syfc.mapper.MatchRecordMapper;
import com.syfc.mybatis.support.MapperContainer;

public class MatchRecordServiceImpl implements MatchRecordService{
	private MatchRecordMapper mapper = MapperContainer.get(MatchRecordMapper.class);

	@Override
	public List<MatchRecordDTO> listMatchRecord(long memberIdx) {
		
		return mapper.listMatchRecord(memberIdx);
	}
	
	
}
