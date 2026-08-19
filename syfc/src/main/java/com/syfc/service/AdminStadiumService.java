package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminStadiumDTO;

public interface AdminStadiumService {

	// 경기장 전체 개수
	public int dataCount(Map<String, Object> map);

	// 경기장 목록
	public List<AdminStadiumDTO> listStadium(Map<String, Object> map);

	// 경기장 한 건 조회
	public AdminStadiumDTO findById(long stadiumId);

	// 경기장 등록
	public void insertStadium(AdminStadiumDTO dto) throws Exception;

	// 경기장 수정
	public void updateStadium(AdminStadiumDTO dto) throws Exception;
}