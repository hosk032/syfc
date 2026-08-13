package com.syfc.service;

import com.syfc.dto.PlayerMypageDTO;

public interface PlayerProfileService {
	PlayerMypageDTO findProfile(long memberIdx);
	
	public void updateProfile(PlayerMypageDTO dto) throws Exception;
}
