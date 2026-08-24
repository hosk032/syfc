package com.syfc.dto;

public class ClubRequestDTO {
	private Long request_id;     // 신청번호 (PK)
	private String request_date; // 신청일
	private String approve_date; // 승인일
	private int request_status;  // 상태 (2: 신청/대기, 1: 승인, 0: 거절)
	private Long memberIdx;      // 회원고유번호 (FK)
	private String content;      // 구단설명

	public Long getRequest_id() {
		return request_id;
	}
	public void setRequest_id(Long request_id) {
		this.request_id = request_id;
	}
	public String getRequest_date() {
		return request_date;
	}
	public void setRequest_date(String request_date) {
		this.request_date = request_date;
	}
	public String getApprove_date() {
		return approve_date;
	}
	public void setApprove_date(String approve_date) {
		this.approve_date = approve_date;
	}
	public int getRequest_status() {
		return request_status;
	}
	public void setRequest_status(int request_status) {
		this.request_status = request_status;
	}
	public Long getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(Long memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}