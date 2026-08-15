package com.syfc.service;

import com.syfc.dto.PlayerMypageDTO;
import com.syfc.mapper.PlayerProfileMapper;
import com.syfc.mybatis.support.MapperContainer;

// 화면에 보여줄 로직 짜는 곳
public class PlayerProfileServiceImpl implements PlayerProfileService {
	private PlayerProfileMapper mapper = MapperContainer.get(PlayerProfileMapper.class);
	
	@Override
	public PlayerMypageDTO findProfile(long memberIdx) {
		
		return mapper.findByMemberIdx(memberIdx);
	}

	@Override
	public void updateProfile(PlayerMypageDTO dto) throws Exception {
		try {
			mapper.updateProfile(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}
	
	@Override
	public PlayerMypageDTO selectProfile(long memberIdx) {
		
		return mapper.selectProfile(memberIdx);
	}

	@Override
	public void updateSelectProfile(PlayerMypageDTO dto) throws Exception {
		try {
			mapper.updateSelectProfile(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

}
