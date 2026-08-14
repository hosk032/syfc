package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminClubOwnerRequestDTO;

/*
 * =========================================================
 * 관리자 - 구단주 신청 관리 Service
 * =========================================================
 *
 * Controller와 Mapper 사이에서 사용할 기능을 정의한다.
 * 실제 처리 내용은 AdminClubOwnerRequestServiceImpl에서 구현한다.
 */
public interface AdminClubOwnerRequestService {

	// 전체 구단주 신청 개수
	public int dataCount(Map<String, Object> map);

	// 구단주 신청 목록
	public List<AdminClubOwnerRequestDTO> listRequest(Map<String, Object> map);

	/*
	 * ★ 구단주 신청 승인
	 *
	 * 승인 시
	 * 1. 신청 상태 → 승인(1)
	 * 2. 회원 등급 → 구단주(50)
	 * 3. clubOwner 테이블 등록
	 */
	public void approveRequest(long requestNum) throws Exception;

	/*
	 * 구단주 신청 반려
	 *
	 * 반려 시 신청 상태만
	 * 대기(2) → 반려(0)로 변경
	 */
	public void rejectRequest(long requestNum) throws Exception;
}