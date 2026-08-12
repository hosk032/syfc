package com.syfc.mapper;

import com.syfc.dto.PlayerProfileDTO;

public interface PlayerProfileMapper {
	PlayerProfileDTO findByMemberIdx(long memberIdx);
	
	public void updateProfile(PlayerProfileDTO dto);
}

