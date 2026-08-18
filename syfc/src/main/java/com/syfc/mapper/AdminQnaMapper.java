package com.syfc.mapper;

import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminQnaDTO;

public interface AdminQnaMapper {
	
	// 문의/신고 전체 개수
	public int dataCount(Map<String, Object> map);
	
	// 문의/신고 목록
	public List<AdminQnaDTO> listQna(Map<String, Object> map);
	
	// 문의/신고 한 건 조회
	public AdminQnaDTO findById(long qnaNum);
	
	// 관리자 답변 등록
	public int updateAnswer(AdminQnaDTO dto);
	
	// 문의/신고 글 삭제
	public int deleteQna(Map<String, Object> map);
}
