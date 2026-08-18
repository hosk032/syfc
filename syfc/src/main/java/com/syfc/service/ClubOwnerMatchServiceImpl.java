package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubOwnerMatchDTO;
import com.syfc.mapper.ClubOwnerMatchMapper;
import com.syfc.mybatis.support.MapperContainer;

public class ClubOwnerMatchServiceImpl implements ClubOwnerMatchService {

	private ClubOwnerMatchMapper mapper = MapperContainer.get(ClubOwnerMatchMapper.class);

	@Override
	public List<ClubOwnerMatchDTO> getClubMatchList(Long clubOwnerKey) {
		List<ClubOwnerMatchDTO> list = null;
		try {
			if (clubOwnerKey != null) {
				list = mapper.selectClubMatchList(clubOwnerKey);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<ClubOwnerMatchDTO> getClubMatchListByMap(Map<String, Object> map) {
		List<ClubOwnerMatchDTO> list = null;
		try {
			if (map != null && map.get("clubOwnerKey") != null) {
				// selectClubMatchListByMap 호출!
				list = mapper.selectClubMatchListByMap(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}