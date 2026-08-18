package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminClubDTO;

public interface AdminClubService {
	
	// 구단 전체 개수
	public int dataCount(Map<String, Object> map);
	
	// 구단 목록
	public List<AdminClubDTO> listClub(Map<String, Object> map);
	
	// 구단 한 건 조회
	public AdminClubDTO findById(long clubOwnerKey);
	
	// 구단 상태 변경
	// 1 : 운영 / 0 : 정지
	public void updateClubStatus(long clubOwnerKey, int clubStatus) throws Exception;
}
