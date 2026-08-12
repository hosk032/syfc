package com.syfc.dto;

public class BoardDTO {
	private long bNum;
	private String b_Subject;
	private String b_Content;
	private String b_HitCount;
	private String b_Reg_date;
	private int b_Block;
	private int b_Type;
	
	private long memberIdx;
	
	private long reply_Num;
	private String r_Content;
	private String r_Reg_date;
	private int r_Block;
	
	
	public long getbNum() {
		return bNum;
	}
	public void setbNum(long bNum) {
		this.bNum = bNum;
	}
	public String getB_Subject() {
		return b_Subject;
	}
	public void setB_Subject(String b_Subject) {
		this.b_Subject = b_Subject;
	}
	public String getB_Content() {
		return b_Content;
	}
	public void setB_Content(String b_Content) {
		this.b_Content = b_Content;
	}
	public String getB_HitCount() {
		return b_HitCount;
	}
	public void setB_HitCount(String b_HitCount) {
		this.b_HitCount = b_HitCount;
	}
	public String getB_Reg_date() {
		return b_Reg_date;
	}
	public void setB_Reg_date(String b_Reg_date) {
		this.b_Reg_date = b_Reg_date;
	}
	public int getB_Block() {
		return b_Block;
	}
	public void setB_Block(int b_Block) {
		this.b_Block = b_Block;
	}
	public int getB_Type() {
		return b_Type;
	}
	public void setB_Type(int b_Type) {
		this.b_Type = b_Type;
	}
	public long getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(long memberIdx) {
		this.memberIdx = memberIdx;
	}
	public long getReply_Num() {
		return reply_Num;
	}
	public void setReply_Num(long reply_Num) {
		this.reply_Num = reply_Num;
	}
	public String getR_Content() {
		return r_Content;
	}
	public void setR_Content(String r_Content) {
		this.r_Content = r_Content;
	}
	public String getR_Reg_date() {
		return r_Reg_date;
	}
	public void setR_Reg_date(String r_Reg_date) {
		this.r_Reg_date = r_Reg_date;
	}
	public int getR_Block() {
		return r_Block;
	}
	public void setR_Block(int r_Block) {
		this.r_Block = r_Block;
	}
	

}
