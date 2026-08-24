package com.syfc.dto;

// 구단주 신청
public class ClubOwnerRequestDTO {
	private long cor_request_num;
	private String cor_content;
	private String cor_requestdate;
	private int cor_status;
	private long memberIdx;
	
	public long getCor_request_num() {
		return cor_request_num;
	}
	public void setCor_request_num(long cor_request_num) {
		this.cor_request_num = cor_request_num;
	}
	public String getCor_content() {
		return cor_content;
	}
	public void setCor_content(String cor_content) {
		this.cor_content = cor_content;
	}
	public String getCor_requestdate() {
		return cor_requestdate;
	}
	public void setCor_requestdate(String cor_requestdate) {
		this.cor_requestdate = cor_requestdate;
	}
	public int getCor_status() {
		return cor_status;
	}
	public void setCor_status(int cor_status) {
		this.cor_status = cor_status;
	}
	public long getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(long memberIdx) {
		this.memberIdx = memberIdx;
	}
	
	
}
