package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminQnaDTO;
import com.syfc.mapper.AdminQnaMapper;
import com.syfc.mybatis.support.MapperContainer;

public class AdminQnaServiceImpl implements AdminQnaService {
	private AdminQnaMapper mapper = MapperContainer.get(AdminQnaMapper.class);
	
	// 문의/신고 전체 개수
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

	// 문의/신고 목록
	@Override
	public List<AdminQnaDTO> listQna(Map<String, Object> map) {
		List<AdminQnaDTO> list = null;
		
		try {
			list = mapper.listQna(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	// 문의/신고 한 건 조회
	@Override
	public AdminQnaDTO findById(long qnaNum) {
		AdminQnaDTO dto = null;
		
		try {
			dto = mapper.findById(qnaNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	// 관리자 답변 등록
	@Override
	public void updateAnswer(AdminQnaDTO dto) throws Exception {
		try {
			mapper.updateAnswer(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}		
	}
	
	// 문의/신고 글 삭제
	@Override
	public void deleteQna(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteQna(map);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}
	
}
