package com.syfc.dto;

public class BoardDTO {
	private long bnum;
	private String b_subject;
	private String b_content;
	private String b_hitCount;
	private String b_reg_date;
	private int b_block;
	private int b_type;
	
	private long memberIdx;
	
	private String userName;
	
	private int boardLikeCount;
	
	public long getBnum() {
		return bnum;
	}
	public void setBnum(long bnum) {
		this.bnum = bnum;
	}
	public String getB_subject() {
		return b_subject;
	}
	public void setB_subject(String b_subject) {
		this.b_subject = b_subject;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
	public String getB_hitCount() {
		return b_hitCount;
	}
	public void setB_hitCount(String b_hitCount) {
		this.b_hitCount = b_hitCount;
	}
	public String getB_reg_date() {
		return b_reg_date;
	}
	public void setB_reg_date(String b_reg_date) {
		this.b_reg_date = b_reg_date;
	}
	public int getB_block() {
		return b_block;
	}
	public void setB_block(int b_block) {
		this.b_block = b_block;
	}
	public int getB_type() {
		return b_type;
	}
	public void setB_type(int b_type) {
		this.b_type = b_type;
	}
	public long getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(long memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public int getBoardLikeCount() {
		return boardLikeCount;
	}
	public void setBoardLikeCount(int boardLikeCount) {
		this.boardLikeCount = boardLikeCount;
	}
	
	
	
	
	

}
