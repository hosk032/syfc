package com.syfc.service;

import com.syfc.dto.ClubRequestDTO;

public interface ClubRequestService {
	public int insertClubRequest(ClubRequestDTO dto);

	public ClubRequestDTO findByMemberIdx(long memberIdx);
}