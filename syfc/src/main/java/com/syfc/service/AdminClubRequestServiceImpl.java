package com.syfc.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminClubRequestDTO;
import com.syfc.mapper.AdminClubRequestMapper;
import com.syfc.mybatis.support.MapperContainer;

public class AdminClubRequestServiceImpl implements AdminClubRequestService {

	private AdminClubRequestMapper mapper =
			MapperContainer.get(AdminClubRequestMapper.class);


	// 구단 창설 신청 전체 개수
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


	// 구단 창설 신청 목록
	@Override
	public List<AdminClubRequestDTO> listRequest(Map<String, Object> map) {
		List<AdminClubRequestDTO> list = null;

		try {
			list = mapper.listRequest(map);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}


	// 구단 창설 신청 한 건 조회
	@Override
	public AdminClubRequestDTO findById(long requestId) {
		AdminClubRequestDTO dto = null;

		try {
			dto = mapper.findById(requestId);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}


	/*
	 * =========================================================
	 * 구단 창설 신청 승인
	 * =========================================================
	 *
	 * 처리 순서
	 *
	 * 1. 신청 정보 조회
	 * 2. 현재 신청대기(2) 상태인지 확인
	 * 3. Club_Request 상태를 승인(1)으로 변경
	 * 4. clubOwner 테이블에 신청자 등록
	 * 5. Club 테이블에 기본 구단 레코드 생성
	 */
	@Override
	public void approveRequest(long requestId) throws Exception {

		// 1. 신청 정보 조회
		AdminClubRequestDTO dto =
				mapper.findById(requestId);


		// 신청 정보가 없는 경우
		if(dto == null) {
			throw new Exception(
					"존재하지 않는 구단 창설 신청입니다.");
		}


		/*
		 * 이미 승인 또는 거절된 신청은
		 * 다시 처리하지 않는다.
		 *
		 * 2 = 신청대기
		 * 1 = 승인
		 * 0 = 거절
		 */
		if(dto.getRequestStatus() != 2) {
			throw new Exception(
					"이미 처리된 구단 창설 신청입니다.");
		}


		// 2. 신청 상태를 승인(1)으로 변경
		Map<String, Object> map =
				new HashMap<String, Object>();

		map.put("requestId", requestId);
		map.put("requestStatus", 1);

		int result =
				mapper.updateRequestStatus(map);


		if(result == 0) {
			throw new Exception(
					"구단 창설 신청 승인 처리에 실패했습니다.");
		}


		/*
		 * 3. 신청한 회원을 clubOwner 테이블에 등록
		 *
		 * 새로운 clubOwner_key는
		 * XML에서 clubOwner_key_seq.NEXTVAL로 생성한다.
		 */
		result =
				mapper.insertClubOwner(
						dto.getMemberIdx());


		if(result == 0) {
			throw new Exception(
					"구단주 정보 등록에 실패했습니다.");
		}


		/*
		 * 4. Club 테이블에 기본 구단 생성
		 *
		 * 바로 위에서 생성한
		 * clubOwner_key_seq.CURRVAL을 사용한다.
		 *
		 * 구단명, 로고, 지역, 소개는
		 * 나중에 구단주가 직접 입력한다.
		 */
		result =
				mapper.insertClub();


		if(result == 0) {
			throw new Exception(
					"구단 기본 정보 생성에 실패했습니다.");
		}
	}


	/*
	 * =========================================================
	 * 구단 창설 신청 거절
	 * =========================================================
	 */
	@Override
	public void rejectRequest(long requestId) throws Exception {

		// 신청 정보 조회
		AdminClubRequestDTO dto =
				mapper.findById(requestId);


		if(dto == null) {
			throw new Exception(
					"존재하지 않는 구단 창설 신청입니다.");
		}


		// 대기 상태인 신청만 거절 가능
		if(dto.getRequestStatus() != 2) {
			throw new Exception(
					"이미 처리된 구단 창설 신청입니다.");
		}


		Map<String, Object> map =
				new HashMap<String, Object>();

		map.put("requestId", requestId);

		// 거절 상태 = 0
		map.put("requestStatus", 0);


		int result =
				mapper.updateRequestStatus(map);


		if(result == 0) {
			throw new Exception(
					"구단 창설 신청 거절 처리에 실패했습니다.");
		}
	}
}