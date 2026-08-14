package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminBoardDTO;
import com.syfc.mapper.AdminBoardMapper;
import com.syfc.mybatis.support.MapperContainer;

/*
 * =========================================================
 * 관리자 - 자유게시판 관리 Service 구현 클래스
 * =========================================================
 *
 * Mapper를 이용하여 자유게시판 목록 조회,
 * 블라인드 처리 및 실제 삭제를 담당한다.
 */
public class AdminBoardServiceImpl implements AdminBoardService {
	private AdminBoardMapper mapper = MapperContainer.get(AdminBoardMapper.class);
	
	// 자유게시판 글 개수
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
	
	// 자유게시판 목록
	@Override
	public List<AdminBoardDTO> listBoard(Map<String, Object> map) {
		List<AdminBoardDTO> list = null;
		
		try {
			list = mapper.listBoard(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	// 블라인드 / 블라인드 해제
	@Override
	public void updateBlock(Map<String, Object> map) throws Exception {
		try {
			mapper.updateBlock(map);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}
	
	// 자유게시판 글 실제 삭제
	@Override
	public void deleteBoard(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteBoard(map);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

}
