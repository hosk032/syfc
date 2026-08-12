package com.syfc.service;

import com.syfc.dto.PlayerProfileDTO;

public interface PlayerProfileService {
	PlayerProfileDTO findProfile(long memberIdx);
	
	public void updateProfile(PlayerProfileDTO dto) throws Exception;
}
