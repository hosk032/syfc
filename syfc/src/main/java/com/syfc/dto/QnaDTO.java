package com.syfc.dto;

public class QnaDTO {
	public long qna_num;
	public String q_title;
	public String q_question;
	public String q_reg_date;
	public String a_answer;
	public String a_reg_date;
	public int memberIdx;
	public int q_type;
	
	public String userName;
	
	public long getQna_num() {
		return qna_num;
	}
	public void setQna_num(long qna_num) {
		this.qna_num = qna_num;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getQ_title() {
		return q_title;
	}
	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}
	public String getQ_question() {
		return q_question;
	}
	public void setQ_question(String q_question) {
		this.q_question = q_question;
	}
	public String getQ_reg_date() {
		return q_reg_date;
	}
	public void setQ_reg_date(String q_reg_date) {
		this.q_reg_date = q_reg_date;
	}
	public String getA_answer() {
		return a_answer;
	}
	public void setA_answer(String a_answer) {
		this.a_answer = a_answer;
	}
	public String getA_reg_date() {
		return a_reg_date;
	}
	public void setA_reg_date(String a_reg_date) {
		this.a_reg_date = a_reg_date;
	}
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public int getQ_type() {
		return q_type;
	}
	public void setQ_type(int q_type) {
		this.q_type = q_type;
	}
	
}
