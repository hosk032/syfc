package com.syfc.mapper;

import java.util.List;

import com.syfc.dto.PlayerProfileDTO;

public interface PlayerMapper {
	List<PlayerProfileDTO> findPlayer(long memberIdx);
}
