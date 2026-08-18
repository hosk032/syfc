package com.syfc.dto;

public class AdminQnaDTO {
	private long qnaNum;
	private String title;
	private String question;
	private String regDate;
	private String answer;
	private String answerRegDate;
	private long memberIdx;
	private int type;
	
	private String userId;
	private String userName;
	
	public long getQnaNum() {
		return qnaNum;
	}
	public void setQnaNum(long qnaNum) {
		this.qnaNum = qnaNum;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getAnswerRegDate() {
		return answerRegDate;
	}
	public void setAnswerRegDate(String answerRegDate) {
		this.answerRegDate = answerRegDate;
	}
	public long getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(long memberIdx) {
		this.memberIdx = memberIdx;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
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
