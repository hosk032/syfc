package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminStadiumDTO;
import com.syfc.mapper.AdminStadiumMapper;
import com.syfc.mybatis.support.MapperContainer;

public class AdminStadiumServiceImpl implements AdminStadiumService {
	private AdminStadiumMapper mapper = MapperContainer.get(AdminStadiumMapper.class);
	
	// 경기장 전체 개수
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
	
	// 경기장 목록
	@Override
	public List<AdminStadiumDTO> listStadium(Map<String, Object> map) {
		List<AdminStadiumDTO> list = null;
		
		try {
			list = mapper.listStadium(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	// 경기장 한 건 조회
	@Override
	public AdminStadiumDTO findById(long stadiumId) {
		AdminStadiumDTO dto = null;
		
		try {
			dto = mapper.findById(stadiumId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	// 경기장 등록
	@Override
	public void insertStadium(AdminStadiumDTO dto) throws Exception {
		try {
			int result = mapper.insertStadium(dto);
			
			if(result == 0) {
				throw new Exception("경기장 등록에 실패했습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	// 경기장 수정
	@Override
	public void updateStadium(AdminStadiumDTO dto) throws Exception {
		try {
			int result = mapper.updateStadium(dto);
			
			if(result == 0) {
				throw new Exception("경기장 수정에 실패했습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
