package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminBoardDTO;

/*
 * =========================================================
 * 관리자 - 자유게시판 관리 Service
 * =========================================================
 *
 * Controller에서 사용할 자유게시판 관리 기능을 정의한다.
 */
public interface AdminBoardService {
	
	// 검색조건에 맞는 자유게시판 글 개수
	public int dataCount(Map<String, Object> map);

	// 자유게시판 목록
	public List<AdminBoardDTO> listBoard(Map<String, Object> map);

	// 블라인드 / 블라인드 해제
	public void updateBlock(Map<String, Object> map) throws Exception;

	// 자유게시판 글 실제 삭제
	public void deleteBoard(Map<String, Object> map) throws Exception;
}
