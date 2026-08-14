package com.syfc.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminClubOwnerRequestDTO;
import com.syfc.mapper.AdminClubOwnerRequestMapper;
import com.syfc.mybatis.support.MapperContainer;

/*
 * =========================================================
 * 관리자 - 구단주 신청 관리 Service 구현 클래스
 * =========================================================
 *
 * Mapper를 이용하여 실제 구단주 신청 승인/반려 처리를 담당한다.
 *
 * ★ 구단주 승인은 신청상태, 회원등급, 구단주정보가
 *   함께 변경되므로 여러 단계로 처리한다.
 */
public class AdminClubOwnerRequestServiceImpl implements AdminClubOwnerRequestService {
	private AdminClubOwnerRequestMapper mapper = MapperContainer.get(AdminClubOwnerRequestMapper.class);

	// 전체 신청 개수
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

	// 구단주 신청 목록
	@Override
	public List<AdminClubOwnerRequestDTO> listRequest(Map<String, Object> map) {
		List<AdminClubOwnerRequestDTO> list = null;

		try {
			list = mapper.listRequest(map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	/*
	 * ★★★ 발표 핵심 ★★★
	 *
	 * 구단주 신청 승인 순서
	 *
	 * 1. 신청정보 조회
	 * 2. 현재 대기상태(2)인지 확인
	 * 3. 신청상태를 승인(1)으로 변경
	 * 4. 회원등급을 구단주(50)로 변경
	 * 5. clubOwner 테이블에 회원 등록
	 */
	@Override
	public void approveRequest(long requestNum) throws Exception {
		// 신청정보 조회
		AdminClubOwnerRequestDTO dto = mapper.findById(requestNum);

		if (dto == null) {
			throw new Exception("존재하지 않는 구단주 신청입니다.");
		}

		// 이미 승인 또는 반려된 신청은 다시 처리하지 않음
		if (dto.getStatus() != 2) {
			throw new Exception("이미 처리된 구단주 신청입니다.");
		}

		// 신청상태 : 대기(2) → 승인(1)
		Map<String, Object> requestMap = new HashMap<>();
		requestMap.put("requestNum", requestNum);
		requestMap.put("status", 1);

		int result = mapper.updateRequestStatus(requestMap);

		if (result == 0) {
			throw new Exception("구단주 신청 승인 처리에 실패했습니다.");
		}

		// 회원등급 : 구단주(50)
		Map<String, Object> memberMap = new HashMap<>();
		memberMap.put("memberIdx", dto.getMemberIdx());
		memberMap.put("userLevel", 50);

		result = mapper.updateMemberLevel(memberMap);

		if (result == 0) {
			throw new Exception("회원 등급 변경에 실패했습니다.");
		}

		// clubOwner 중복 등록 확인
		int count = mapper.clubOwnerCount(dto.getMemberIdx());

		// 이미 등록되지 않은 회원만 추가
		if (count == 0) {
			result = mapper.insertClubOwner(dto.getMemberIdx());

			if (result == 0) {
				throw new Exception("구단주 명단 등록에 실패했습니다.");
			}
		}
	}

	/*
	 * 구단주 신청 반려
	 *
	 * 회원등급과 clubOwner 정보는 변경하지 않고
	 * 신청상태만 대기(2) → 반려(0)로 변경한다.
	 */
	@Override
	public void rejectRequest(long requestNum) throws Exception {
		AdminClubOwnerRequestDTO dto = mapper.findById(requestNum);

		if (dto == null) {
			throw new Exception("존재하지 않는 구단주 신청입니다.");
		}

		if (dto.getStatus() != 2) {
			throw new Exception("이미 처리된 구단주 신청입니다.");
		}

		Map<String, Object> map = new HashMap<>();
		map.put("requestNum", requestNum);
		map.put("status", 0);

		int result = mapper.updateRequestStatus(map);

		if (result == 0) {
			throw new Exception("구단주 신청 반려 처리에 실패했습니다.");
		}
	}
}