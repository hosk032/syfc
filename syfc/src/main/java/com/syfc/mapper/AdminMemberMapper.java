package com.syfc.mapper;

import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminMemberDTO;

public interface AdminMemberMapper {

	// 전체 회원 수
	public int dataCount(Map<String, Object> map);

	// 회원 목록
	public List<AdminMemberDTO> listMember(Map<String, Object> map);

	// 회원 등급 변경
	public void updateMemberLevel(Map<String, Object> map);

	// 회원 상태 변경
	public void updateMemberStatus(Map<String, Object> map);
}