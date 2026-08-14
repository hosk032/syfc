package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminMemberDTO;
import com.syfc.mapper.AdminMemberMapper;
import com.syfc.mybatis.support.MapperContainer;

/*
 * =========================================================
 * 관리자 - 회원 관리 Service 구현 클래스
 * =========================================================
 *
 * Mapper를 이용하여 회원 목록 조회,
 * 등급 변경 및 회원 상태 변경을 처리한다.
 */
public class AdminMemberServiceImpl implements AdminMemberService {
	private AdminMemberMapper mapper = MapperContainer.get(AdminMemberMapper.class);

	// 회원 수
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

	// 회원 목록
	@Override
	public List<AdminMemberDTO> listMember(Map<String, Object> map) {
		List<AdminMemberDTO> list = null;

		try {
			list = mapper.listMember(map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// 회원 등급 변경
	@Override
	public void updateMemberLevel(Map<String, Object> map) throws Exception {
		try {
			mapper.updateMemberLevel(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	// 회원 상태 변경
	@Override
	public void updateMemberStatus(Map<String, Object> map) throws Exception {
		try {
			mapper.updateMemberStatus(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}