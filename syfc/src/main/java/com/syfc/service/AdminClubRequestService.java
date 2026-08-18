package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminClubRequestDTO;

public interface AdminClubRequestService {
	
	// 구단 창설 신청 전체 개수
	public int dataCount(Map<String, Object> map);
	
	// 구단 창설 신청 목록
	public List<AdminClubRequestDTO> listRequest(Map<String, Object> map);
	
	// 구단 창설 신청 한 건 조회
	public AdminClubRequestDTO findById(long requestId);
	
	// 구단 창설 신청 승인
	public void approveRequest(long requestId) throws Exception;
	
	// 구단 창설 신청 거절
	public void rejectRequest(long requestId) throws Exception;
	
}
