package com.syfc.service;

import java.util.List;

import com.syfc.dto.PlayerProfileDTO;

public interface PlayerService {
	public List<PlayerProfileDTO> findPlayer(long memberIdx);
}
