package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.AdminNoticeDTO;
import com.syfc.mapper.AdminNoticeMapper;
import com.syfc.mybatis.support.MapperContainer;

/*
 * =========================================================
 * 관리자 - 공지사항 Service 구현 클래스
 * =========================================================
 *
 * Mapper를 이용해서 실제 공지사항 DB 처리를 담당한다.
 *
 * ★ 상단고정 기능은 사용하지 않으므로
 * listNoticeTop() 관련 코드는 제거한다.
 */
public class AdminNoticeServiceImpl implements AdminNoticeService {

	private AdminNoticeMapper mapper = MapperContainer.get(AdminNoticeMapper.class);

	// =========================================================
	// 공지사항 등록
	// =========================================================
	@Override
	public void insertNotice(AdminNoticeDTO dto) throws Exception {
		try {
			mapper.insertNotice(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	// =========================================================
	// 공지사항 개수
	// =========================================================
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

	// =========================================================
	// 공지사항 목록
	// =========================================================
	@Override
	public List<AdminNoticeDTO> listNotice(Map<String, Object> map) {
		List<AdminNoticeDTO> list = null;

		try {
			list = mapper.listNotice(map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// =========================================================
	// 공지사항 한 건 조회
	// =========================================================
	@Override
	public AdminNoticeDTO findById(long bNum) {
		AdminNoticeDTO dto = null;

		try {
			dto = mapper.findById(bNum);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	// =========================================================
	// 이전 공지사항
	// =========================================================
	@Override
	public AdminNoticeDTO findByPrev(Map<String, Object> map) {
		AdminNoticeDTO dto = null;

		try {
			dto = mapper.findByPrev(map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	// =========================================================
	// 다음 공지사항
	// =========================================================
	@Override
	public AdminNoticeDTO findByNext(Map<String, Object> map) {
		AdminNoticeDTO dto = null;

		try {
			dto = mapper.findByNext(map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	// =========================================================
	// 조회수 증가
	// =========================================================
	@Override
	public void updateHitCount(long bNum) throws Exception {
		try {
			mapper.updateHitCount(bNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	// =========================================================
	// 공지사항 수정
	// =========================================================
	@Override
	public void updateNotice(AdminNoticeDTO dto) throws Exception {
		try {
			mapper.updateNotice(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	// =========================================================
	// 공지사항 삭제
	//
	// ★ 공지사항은 블라인드가 아니라 실제 DELETE
	// =========================================================
	@Override
	public void deleteNotice(long bNum) throws Exception {
		try {
			mapper.deleteNotice(bNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}