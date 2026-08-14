package com.syfc.mapper;

import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminClubOwnerRequestDTO;

/*
 * =========================================================
 * 관리자 - 구단주 신청 관리 Mapper
 * =========================================================
 *
 * adminClubOwnerRequestMapper.xml에 작성한 SQL과 연결되는 인터페이스
 *
 * ★ 메서드 이름과 XML의 id는 반드시 같아야 한다.
 */
public interface AdminClubOwnerRequestMapper {

	// 검색조건과 상태조건에 해당하는 전체 신청 개수
	public int dataCount(Map<String, Object> map);

	// 구단주 신청 목록
	public List<AdminClubOwnerRequestDTO> listRequest(Map<String, Object> map);

	// 신청번호로 구단주 신청 한 건 조회
	public AdminClubOwnerRequestDTO findById(long requestNum);

	// 구단주 신청 상태 변경 : 대기(2) → 승인(1) 또는 반려(0)
	public int updateRequestStatus(Map<String, Object> map);

	// ★ 승인된 회원의 등급을 구단주(50)로 변경
	public int updateMemberLevel(Map<String, Object> map);

	// 해당 회원이 이미 clubOwner 테이블에 존재하는지 확인
	public int clubOwnerCount(long memberIdx);

	// ★ 승인된 회원을 clubOwner 테이블에 등록
	public int insertClubOwner(long memberIdx);
}