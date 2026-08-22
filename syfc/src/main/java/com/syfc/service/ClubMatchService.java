package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubMatchDTO;

public interface ClubMatchService {

	List<ClubMatchDTO> selectAllMatchList(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	
	public int clubDataCount(Map<String, Object> map);
	public List<ClubMatchDTO> selectAllClubList(Map<String, Object> map);
	public List<String> selectClub3Results(Map<String, Object> map);
	public List<ClubMatchDTO> selectMonthMatchList(Map<String, Object> map);
}
