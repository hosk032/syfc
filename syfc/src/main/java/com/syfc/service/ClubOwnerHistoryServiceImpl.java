package com.syfc.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubOwnerHistoryDTO;
import com.syfc.mapper.ClubOwnerHistoryMapper;
import com.syfc.mybatis.support.MapperContainer;

public class ClubOwnerHistoryServiceImpl implements ClubOwnerHistoryService{
	private ClubOwnerHistoryMapper mapper = MapperContainer.get(ClubOwnerHistoryMapper.class);
	
	
	@Override
	public List<ClubOwnerHistoryDTO> clubOwnerRequestHistory(long memberIdx) {
		   
		return mapper.listClubOwnerHistory(memberIdx);
	}

	@Override
	public int cancelClubOwnerRequest(long clubJoin_num, long memberIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("clubJoin_num", clubJoin_num);
		map.put("memberIdx", memberIdx);
		
		return mapper.cancelClubOwnerRequest(map);
	}

}
