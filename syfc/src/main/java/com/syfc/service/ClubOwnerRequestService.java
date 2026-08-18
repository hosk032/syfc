package com.syfc.service;

import java.util.List;

import com.syfc.dto.ClubOwnerRequestDTO;

public interface ClubOwnerRequestService {
	public int insertClubOwnerRequest(ClubOwnerRequestDTO dto);

	List<ClubOwnerRequestDTO> listClubOwnerRequest(long memberIdx);
	
	public int deleteClubOwnerRequest(ClubOwnerRequestDTO dto);
}
