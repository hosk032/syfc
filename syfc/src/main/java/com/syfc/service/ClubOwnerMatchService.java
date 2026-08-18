package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubOwnerMatchDTO;

public interface ClubOwnerMatchService {
	List<ClubOwnerMatchDTO> getClubMatchList(Long clubOwnerKey);
	
	List<ClubOwnerMatchDTO> getClubMatchListByMap(Map<String, Object> map);
}
