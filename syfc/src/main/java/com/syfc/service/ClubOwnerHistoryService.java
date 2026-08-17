package com.syfc.service;

import java.util.List;

import com.syfc.dto.ClubOwnerHistoryDTO;

public interface ClubOwnerHistoryService {
	public List<ClubOwnerHistoryDTO> clubOwnerRequestHistory(long memberIdx);
}
