package com.syfc.service;

import com.syfc.dto.PlayerProfileDTO;
import com.syfc.mapper.PlayerMapper;
import com.syfc.mybatis.support.MapperContainer;

public class PlayerServiceImpl implements PlayerService {
	private PlayerMapper mapper = MapperContainer.get(PlayerMapper.class);
	
	public PlayerProfileDTO findPlayer(long memberIdx) {
		
		return mapper.findPlayer(memberIdx);
	}
}
