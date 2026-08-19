package com.syfc.dto;

/*
 * =========================================================
 * 관리자 - 경기장 이슈 관리 DTO
 * =========================================================
 *
 * Stadium_Issue 테이블의 정보와
 * 이슈 때문에 영향을 받는 경기 정보를 담는 DTO
 *
 * Match_Apply status
 * 4 : 반려
 * 3 : 매칭실패
 * 2 : 신청
 * 1 : 매칭
 * 0 : 취소
 */
public class AdminStadiumIssueDTO {

	// Stadium_Issue
	private long issueId;
	private String startDate;
	private String endDate;
	private String issueType;
	private String reason;
	private long stadiumId;

	// 경기장 정보
	private String stadiumName;
	private String region;

	// Match_Apply 정보
	private long applyId;
	private String applyDate;
	private int applyStatus;

	// 구단 이름
	private String homeClubName;
	private String awayClubName;


	public long getIssueId() {
		return issueId;
	}

	public void setIssueId(long issueId) {
		this.issueId = issueId;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getIssueType() {
		return issueType;
	}

	public void setIssueType(String issueType) {
		this.issueType = issueType;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public long getStadiumId() {
		return stadiumId;
	}

	public void setStadiumId(long stadiumId) {
		this.stadiumId = stadiumId;
	}

	public String getStadiumName() {
		return stadiumName;
	}

	public void setStadiumName(String stadiumName) {
		this.stadiumName = stadiumName;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public long getApplyId() {
		return applyId;
	}

	public void setApplyId(long applyId) {
		this.applyId = applyId;
	}

	public String getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}

	public int getApplyStatus() {
		return applyStatus;
	}

	public void setApplyStatus(int applyStatus) {
		this.applyStatus = applyStatus;
	}

	public String getHomeClubName() {
		return homeClubName;
	}

	public void setHomeClubName(String homeClubName) {
		this.homeClubName = homeClubName;
	}

	public String getAwayClubName() {
		return awayClubName;
	}

	public void setAwayClubName(String awayClubName) {
		this.awayClubName = awayClubName;
	}
}