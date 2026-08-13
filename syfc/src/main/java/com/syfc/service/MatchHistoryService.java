package com.syfc.service;

import java.util.List;

import com.syfc.dto.MatchHistoryDTO;

public interface MatchHistoryService {
	List<MatchHistoryDTO> listMatchHistory(long memberIdx);
}
