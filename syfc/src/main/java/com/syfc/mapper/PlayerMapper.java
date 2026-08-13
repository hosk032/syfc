package com.syfc.mapper;

import com.syfc.dto.PlayerProfileDTO;

public interface PlayerMapper {
	PlayerProfileDTO findPlayer(long memberIdx);
}
