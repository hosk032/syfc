package com.syfc.mapper;

import java.util.List;

import com.syfc.dto.MatchHistoryDTO;

public interface MatchHistoryMapper {
	List<MatchHistoryDTO> listMatchHistory(long memberIdx);
	
	public int countPlayedMatches(long memeberIdx);
}
