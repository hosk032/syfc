package com.syfc.mapper;

import java.util.List;

import com.syfc.dto.ClubOwnerHistoryDTO;

public interface ClubOwnerHistoryMapper {
	List<ClubOwnerHistoryDTO> listClubOwnerHistory(long memberIdx);
}
