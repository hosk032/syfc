package com.syfc.service;

import java.util.List;

import com.syfc.dto.AdminStadiumIssueDTO;

public interface AdminStadiumIssueService {

	// 경기장 선택 목록
	public List<AdminStadiumIssueDTO> listStadiumOption();

	// 경기장 이슈 등록
	public void insertIssue(AdminStadiumIssueDTO dto) throws Exception;
	
	// 등록된 경기장 이슈 목록
	public List<AdminStadiumIssueDTO> listIssue();
	
	// 경기장 이슈 한 건 조회
	public AdminStadiumIssueDTO findIssue(long issueId);

	// 영향 받는 경기 목록
	public List<AdminStadiumIssueDTO> listAffectedMatch(long issueId);

	// 경기 반려
	public void rejectMatch(long applyId) throws Exception;
}