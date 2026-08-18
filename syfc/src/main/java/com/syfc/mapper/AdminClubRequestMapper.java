package com.syfc.mapper;

import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminClubRequestDTO;

public interface AdminClubRequestMapper {
	// 구단 창설 신청 전체 개수
	public int dataCount(Map<String, Object> map);
	
	// 구단 창설 신청 목록
	public List<AdminClubRequestDTO> listRequest(Map<String, Object> map);
	
	// 신청 한 건 조회
	public AdminClubRequestDTO findById(long requestId);
	
	// 신청 상태 변경 : 대기(2) / 승인(1) / 거절(0)
	public int updateRequestStatus(Map<String, Object> map);
	
	// 승인된 회원을 구단주 테이블에 등록
	public int insertClubOwner(long memberIdx);
	
	// 승인된 구단의 기본 레코드 생성
	public int insertClub();
	
}
