package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.MemberDTO;

public interface MemberService {
	public MemberDTO loginMember(Map<String, Object> map);
	
	public void insertMember(MemberDTO dto) throws Exception;
	public void updateMember(MemberDTO dto) throws Exception;	
	public void updateMemberLevel(Map<String, Object> map) throws Exception;
	public void deleteProfilePhoto(Map<String, Object> map) throws Exception;
	public void deleteMember(Map<String, Object> map) throws Exception;
	
	public MemberDTO findById(String userId);	
	public void generatePwd(MemberDTO dto) throws Exception;
	public List<MemberDTO> idFind(Map<String, Object> map);

}
