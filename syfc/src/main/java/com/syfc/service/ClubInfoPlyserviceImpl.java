package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubInfoPlyDTO;
import com.syfc.mapper.ClubInfoPlyMapper;
import com.syfc.mybatis.support.MapperContainer;
import com.syfc.util.MyUtil;

public class ClubInfoPlyserviceImpl implements ClubInfoPlyservice {
	private ClubInfoPlyMapper mapper = MapperContainer.get(ClubInfoPlyMapper.class);
	private MyUtil util = new MyUtil();
	
	@Override
	public List<ClubInfoPlyDTO> listClubInfoPly(Map<String, Object> map) {
		List<ClubInfoPlyDTO> list = null;
		
		try {
			list = mapper.listClubInfoPly(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public ClubInfoPlyDTO findById(long clubowner_key) {
		ClubInfoPlyDTO dto = null;
		
		try {
			dto = mapper.findById(clubowner_key);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public List<ClubInfoPlyDTO> listPlayer(long clubowner_key) {
	    List<ClubInfoPlyDTO> list = null;

	    try {
	        list = mapper.listPlayer(clubowner_key);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
		
	}

	@Override
	public String findClubOwner(long clubowner_key) {
		String ownerName = null;
		
		try {
			ownerName = mapper.findClubOwner(clubowner_key);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return ownerName;
	}

	@Override
	public List<ClubInfoPlyDTO> listPlayerInfo(long clubowner_key) {
		List<ClubInfoPlyDTO> list = null;

		try {
			list = mapper.listPlayerInfo(clubowner_key);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Long getclubowner(long memberIdx) {
		
		try {
			return mapper.getclubowner(memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
