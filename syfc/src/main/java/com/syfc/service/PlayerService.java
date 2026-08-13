package com.syfc.service;

import com.syfc.dto.PlayerProfileDTO;

public interface PlayerService {
	public PlayerProfileDTO findPlayer(long memberIdx);
}
