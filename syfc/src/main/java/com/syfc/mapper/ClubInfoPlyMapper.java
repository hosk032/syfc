package com.syfc.mapper;

import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubInfoPlyDTO;

public interface ClubInfoPlyMapper {

	public List<ClubInfoPlyDTO> listClubInfoPly(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	
	public ClubInfoPlyDTO findById(long clubowner_key);
	public List<ClubInfoPlyDTO> listPlayer(long clubowner_key);
}
