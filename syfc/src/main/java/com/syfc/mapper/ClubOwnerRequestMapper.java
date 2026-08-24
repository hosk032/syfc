package com.syfc.mapper;

import java.util.List;

import com.syfc.dto.ClubOwnerRequestDTO;

public interface ClubOwnerRequestMapper {
	public int insertClubOwnerRequest(ClubOwnerRequestDTO dto);

	List<ClubOwnerRequestDTO> listClubOwnerRequest(long memberIdx);
	
	public int deleteClubOwnerRequest(ClubOwnerRequestDTO dto);
}
