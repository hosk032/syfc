package com.syfc.service;

import com.syfc.dto.PlayerProfileDTO;
import com.syfc.mapper.PlayerProfileMapper;
import com.syfc.mybatis.support.MapperContainer;

public class PlayerProfileServiceImpl implements PlayerProfileService {
	private PlayerProfileMapper mapper = MapperContainer.get(PlayerProfileMapper.class);
	
	@Override
	public PlayerProfileDTO findProfile(long memberIdx) {
		
		return mapper.findByMemberIdx(memberIdx);
	}

	@Override
	public void updateProfile(PlayerProfileDTO dto) throws Exception {
		try {
			mapper.updateProfile(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

}
