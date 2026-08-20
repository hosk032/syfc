package com.syfc.mapper;

import java.util.List;

import com.syfc.dto.AdminStadiumIssueDTO;

public interface AdminStadiumIssueMapper {

	// 이슈 등록 화면에서 경기장 목록 가져오기
	public List<AdminStadiumIssueDTO> listStadiumOption();

	// 경기장 이슈 등록
	public int insertIssue(AdminStadiumIssueDTO dto);
	
	// 등록된 경기장 이슈 목록
	public List<AdminStadiumIssueDTO> listIssue();

	// 등록된 경기장 이슈 한 건 조회
	public AdminStadiumIssueDTO findIssue(long issueId);
	
	// 경기장 이슈 수정
	public int updateIssue(AdminStadiumIssueDTO dto);

	// 해당 이슈의 영향을 받는 경기 목록
	public List<AdminStadiumIssueDTO> listAffectedMatch(long issueId);

	// 경기 신청 반려
	public int rejectMatch(long applyId);
}