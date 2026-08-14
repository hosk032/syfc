package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminNoticeDTO;

/*
 * =========================================================
 * 관리자 - 공지사항 Service
 * =========================================================
 *
 * Controller에서 사용할 공지사항 기능을 정의한다.
 *
 * ★ board.b_Type
 * 0 : 자유게시판
 * 1 : 공지사항
 */
public interface AdminNoticeService {

	// 공지사항 등록
	public void insertNotice(AdminNoticeDTO dto) throws Exception;

	// 검색조건에 맞는 공지사항 개수
	public int dataCount(Map<String, Object> map);

	// 공지사항 목록
	public List<AdminNoticeDTO> listNotice(Map<String, Object> map);

	// 공지사항 상세보기
	public AdminNoticeDTO findById(long num);

	// 이전 공지사항
	public AdminNoticeDTO findByPrev(Map<String, Object> map);

	// 다음 공지사항
	public AdminNoticeDTO findByNext(Map<String, Object> map);

	// 조회수 증가
	public void updateHitCount(long num) throws Exception;

	// 공지사항 수정
	public void updateNotice(AdminNoticeDTO dto) throws Exception;

	// 공지사항 실제 삭제
	public void deleteNotice(long num) throws Exception;
}