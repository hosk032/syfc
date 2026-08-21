package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubOwnerMatchDTO;
import com.syfc.mapper.ClubMatchMapper;
import com.syfc.mybatis.support.MapperContainer;

public class ClubMatchServiceImpl implements ClubMatchService {
	private ClubMatchMapper mapper = MapperContainer.get(ClubMatchMapper.class);
	
	@Override
	public List<ClubOwnerMatchDTO> selectAllMatchList(Map<String, Object> map) {
		List<ClubOwnerMatchDTO> list = null;
		try {
			list = mapper.selectAllMatchList(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
