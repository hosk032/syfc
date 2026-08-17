package com.syfc.dto;

public class ReplyBoardDTO {
	private long reply_num;
	private String r_content;
	private String r_reg_date;
	private int r_block;
	private long bnum;
	private long memberIdx;
	
	private String userName;
	
	private String b_subject;
	private String b_content;
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
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

	private int replyCount;

	public long getReply_num() {
		return reply_num;
	}

	public void setReply_num(long reply_num) {
		this.reply_num = reply_num;
	}

	public String getR_content() {
		return r_content;
	}

	public void setR_content(String r_content) {
		this.r_content = r_content;
	}

	public String getR_reg_date() {
		return r_reg_date;
	}

	public void setR_reg_date(String r_reg_date) {
		this.r_reg_date = r_reg_date;
	}

	public int getR_block() {
		return r_block;
	}

	public void setR_block(int r_block) {
		this.r_block = r_block;
	}

	public long getBnum() {
		return bnum;
	}

	public void setBnum(long bnum) {
		this.bnum = bnum;
	}

	public long getMemberIdx() {
		return memberIdx;
	}

	public void setMemberIdx(long memberIdx) {
		this.memberIdx = memberIdx;
	}

	public int getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	
	
	
	
}
