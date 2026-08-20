package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubInfoPlyDTO;

public interface ClubInfoPlyservice {
	public List<ClubInfoPlyDTO> listClubInfoPly(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	
	public ClubInfoPlyDTO findById(long clubowner_key);
	public List<ClubInfoPlyDTO> listPlayer(long clubowner_key);
	public String findClubOwner(long clubowner_key);
	
	public List<ClubInfoPlyDTO> listPlayerInfo(long clubowner_key);
	public Long getclubowner(long memberIdx);
}
