package com.syfc.mapper;

import com.syfc.dto.PlayerMypageDTO;

public interface PlayerProfileMapper {
	PlayerMypageDTO findByMemberIdx(long memberIdx);
	
	public void updateProfile(PlayerMypageDTO dto);
}

