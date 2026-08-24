package com.syfc.mapper;

import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubOwnerHistoryDTO;

public interface ClubOwnerHistoryMapper {
	List<ClubOwnerHistoryDTO> listClubOwnerHistory(long memberIdx);
	public int cancelClubOwnerRequest(Map<String, Object>map);
}
