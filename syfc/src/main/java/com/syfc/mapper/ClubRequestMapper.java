package com.syfc.mapper;

import com.syfc.dto.ClubRequestDTO;

public interface ClubRequestMapper {
	public int insertClubRequest(ClubRequestDTO dto);
	public ClubRequestDTO findByMemberIdx(long memberIdx);
}