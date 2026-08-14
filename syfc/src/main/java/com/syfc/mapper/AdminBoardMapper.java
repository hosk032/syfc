package com.syfc.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminBoardDTO;

/*
 * =========================================================
 * 관리자 - 자유게시판 관리 Mapper
 * =========================================================
 *
 * adminBoardMapper.xml의 SQL과 연결되는 인터페이스
 *
 * ★ 관리자 기능
 * 1. 자유게시판 목록 조회
 * 2. 블라인드 / 블라인드 해제
 * 3. 게시글 실제 삭제
 */
public interface AdminBoardMapper {
	
	// 검색조건에 맞는 자유게시판 글 개수
	public int dataCount(Map<String, Object> map);
	
	// 자유게시판 목록
	public List<AdminBoardDTO> listBoard(Map<String, Object> map);
	
	// 블라인드 / 블라인드 해제
	public void updateBlock(Map<String, Object> map) throws SQLException;
	
	// 자유게시판 글 실제 삭제
	public void deleteBoard(Map<String, Object> map) throws SQLException;
	
	
}
