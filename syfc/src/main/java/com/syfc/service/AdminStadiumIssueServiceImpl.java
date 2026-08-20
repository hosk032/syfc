package com.syfc.service;

import java.util.List;

import com.syfc.dto.AdminStadiumIssueDTO;
import com.syfc.mapper.AdminStadiumIssueMapper;
import com.syfc.mybatis.support.MapperContainer;

public class AdminStadiumIssueServiceImpl implements AdminStadiumIssueService {
	private AdminStadiumIssueMapper mapper = MapperContainer.get(AdminStadiumIssueMapper.class);
	
	// 경기장 선택 목록
	@Override
	public List<AdminStadiumIssueDTO> listStadiumOption() {
		List<AdminStadiumIssueDTO> list = null;
		
		try {
			list = mapper.listStadiumOption();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	// 경기장 이슈 등록
	@Override
	public void insertIssue(AdminStadiumIssueDTO dto)
			throws Exception {

		try {
			int result = mapper.insertIssue(dto);

			if(result == 0) {
				throw new Exception("경기장 이슈 등록에 실패했습니다.");
			}

		} catch (Exception e) {
			e.printStackTrace();

			throw e;
		}
	}
	
	// 등록된 경기장 이슈 목록
	@Override
	public List<AdminStadiumIssueDTO> listIssue() {
		List<AdminStadiumIssueDTO> list = null;

		try {
			list = mapper.listIssue();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	// 경기장 이슈 한 건 조회
	@Override
	public AdminStadiumIssueDTO findIssue(long issueId) {
		AdminStadiumIssueDTO dto = null;
		
		try {
			dto = mapper.findIssue(issueId);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	// 경기장 이슈 수정
	@Override
	public void updateIssue(AdminStadiumIssueDTO dto) throws Exception {
		try {
			int result = mapper.updateIssue(dto);

			if(result == 0) {
				throw new Exception("경기장 이슈 수정에 실패했습니다.");
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	// 영향 받는 경기 목록
	@Override
	public List<AdminStadiumIssueDTO> listAffectedMatch(long issueId) {
		List<AdminStadiumIssueDTO> list = null;
		
		try {
			list = mapper.listAffectedMatch(issueId);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	// 경기 반려
	@Override
	public void rejectMatch(long applyId)
			throws Exception {

		try {
			int result = mapper.rejectMatch(applyId);

			if(result == 0) {
				throw new Exception("경기 신청 반려에 실패했습니다.");
			}

		} catch (Exception e) {
			e.printStackTrace();

			throw e;
		}
	}
}
