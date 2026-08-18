package com.syfc.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminClubDTO;
import com.syfc.mapper.AdminClubMapper;
import com.syfc.mybatis.support.MapperContainer;

public class AdminClubServiceImpl implements AdminClubService {
	private AdminClubMapper mapper = MapperContainer.get(AdminClubMapper.class);
	
	// 구단 전체 개수
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
	
	// 구단 목록
	@Override
	public List<AdminClubDTO> listClub(Map<String, Object> map) {
		List<AdminClubDTO> list = null;
		
		try {
			list = mapper.listClub(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	// 구단 한 건 조회
	@Override
	public AdminClubDTO findById(long clubOwnerKey) {
		AdminClubDTO dto = null;
		
		try {
			dto = mapper.findById(clubOwnerKey);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	// 구단 정지 / 활성화
	@Override
	public void updateClubStatus(long clubOwnerKey, int clubStatus) throws Exception {
		
		// 구단 정보 확인
		AdminClubDTO dto = mapper.findById(clubOwnerKey);
		
		if(dto == null) {
			throw new Exception("존재하지 않는 구단입니다.");
		}
		
		// 상태값은 0 또는 1만 허용
		if(clubStatus != 0 && clubStatus != 1) {
			throw new Exception("잘못된 구단 상태값입니다.");
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("clubOwnerKey", clubOwnerKey);
		map.put("clubStatus", clubStatus);
		
		int result = mapper.updateClubStatus(map);
		
		if(result == 0) {
			throw new Exception("구단 상태 변경에 실패했습니다.");
		}
		
	}
	
}
