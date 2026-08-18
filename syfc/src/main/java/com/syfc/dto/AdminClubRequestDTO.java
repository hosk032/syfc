package com.syfc.dto;

/*
 * =========================================================
 * 관리자 - 구단 창설 신청 DTO
 * =========================================================
 *
 * Club_Request 테이블의 구단 창설 신청 정보를 담는다.
 *
 * requestStatus
 * 2 : 신청대기
 * 1 : 승인
 * 0 : 거절
 */
public class AdminClubRequestDTO {
	private long requestId;
	private String requestDate;
	private String approveDate;
	private int requestStatus;
	private long memberIdx;
	private String content;
	
	// member1 테이블에서 가져올 신청자 정보
	private String userId;
	private String userName;
	
	public long getRequestId() {
		return requestId;
	}
	public void setRequestId(long requestId) {
		this.requestId = requestId;
	}
	public String getRequestDate() {
		return requestDate;
	}
	public void setRequestDate(String requestDate) {
		this.requestDate = requestDate;
	}
	public String getApproveDate() {
		return approveDate;
	}
	public void setApproveDate(String approveDate) {
		this.approveDate = approveDate;
	}
	public int getRequestStatus() {
		return requestStatus;
	}
	public void setRequestStatus(int requestStatus) {
		this.requestStatus = requestStatus;
	}
	public long getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(long memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
}
