package com.syfc.service;

import java.util.Map;
import com.syfc.dto.MemberDTO;
import com.syfc.mapper.MemberMapper;
import com.syfc.mybatis.support.MapperContainer;
import com.syfc.mybatis.support.SqlSessionManager;

public class MemberServiceImpl implements MemberService {

	private MemberMapper mapper = MapperContainer.get(MemberMapper.class);

	@Override
	public MemberDTO loginMember(Map<String, Object> map) {
		MemberDTO dto = null;
		
		try {
			dto = mapper.loginMember(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return dto;
	}

	@Override
	public void insertMember(MemberDTO dto) throws Exception {
		try {
			
			mapper.insertMember1(dto);
			mapper.insertMember2(dto);
			
		} catch (Exception e) {
			// 트랜잭션 처리
			SqlSessionManager.setRollbackOnly();

			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateMember(MemberDTO dto) throws Exception {
		try {
			mapper.updateMember1(dto);
			mapper.updateMember2(dto);
		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();

			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateMemberLevel(Map<String, Object> map) throws Exception {
		try {
			mapper.updateMemberLevel(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteProfilePhoto(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteProfilePhoto(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteMember(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteMember1(map);
			mapper.deleteMember2(map);
		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();

			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public MemberDTO findById(String userId) {
		MemberDTO dto = null;
		
		dto = mapper.findById(userId);
		
		return dto;
	}
}
