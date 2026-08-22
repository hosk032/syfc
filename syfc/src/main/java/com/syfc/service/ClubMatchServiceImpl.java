package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubMatchDTO;
import com.syfc.mapper.ClubMatchMapper;
import com.syfc.mybatis.support.MapperContainer;

public class ClubMatchServiceImpl implements ClubMatchService {
	private ClubMatchMapper mapper = MapperContainer.get(ClubMatchMapper.class);
	
	@Override
	public List<ClubMatchDTO> selectAllMatchList(Map<String, Object> map) {
		List<ClubMatchDTO> list = null;
		try {
			list = mapper.selectAllMatchList(map);
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
	public int clubDataCount(Map<String, Object> map) {
		int result = 0;
        try {
            result = mapper.clubDataCount(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
	}

	@Override
	public List<ClubMatchDTO> selectAllClubList(Map<String, Object> map) {
		List<ClubMatchDTO> list = null;
        try {
            list = mapper.selectAllClubList(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
	}

	@Override
	public List<String> selectClub3Results(Map<String, Object> map) {
		List<String> list = null;
        try {
            list = mapper.selectClub3Results(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
	}

	@Override
	public List<ClubMatchDTO> selectMonthMatchList(Map<String, Object> map) {
		List<ClubMatchDTO> list = null;
		try {
			list = mapper.selectMonthMatchList(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	



}
