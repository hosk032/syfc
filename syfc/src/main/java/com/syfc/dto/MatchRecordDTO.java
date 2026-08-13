package com.syfc.dto;

// 내 경기 성적 컬럼: 성적번호, 평점, 득점, 도움, 옐로카드, 레드카드, 자책골, 경기번호, 선수번호
// 경기일, 경기명, 평점, 득점, 도움, 자책골, 옐로카드, 레드카드
// 선수성적 테이블: Player_Record
public class MatchRecordDTO {
	private long recordId;
	private int rating;
	private int goal;
	private int assist;
	private int yellow;
	private int red;
	private int ownGoal;
	private long matchNum;
	private long clubJoinNum;
	private String matchDate;
	
	public String getMatchDate() {
		return matchDate;
	}
	public void setMatchDate(String matchDate) {
		this.matchDate = matchDate;
	}
	public long getRecordId() {
		return recordId;
	}
	public void setRecordId(long recordId) {
		this.recordId = recordId;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public int getGoal() {
		return goal;
	}
	public void setGoal(int goal) {
		this.goal = goal;
	}
	public int getAssist() {
		return assist;
	}
	public void setAssist(int assist) {
		this.assist = assist;
	}
	public int getYellow() {
		return yellow;
	}
	public void setYellow(int yellow) {
		this.yellow = yellow;
	}
	public int getRed() {
		return red;
	}
	public void setRed(int red) {
		this.red = red;
	}
	public int getOwnGoal() {
		return ownGoal;
	}
	public void setOwnGoal(int ownGoal) {
		this.ownGoal = ownGoal;
	}
	public long getMatchNum() {
		return matchNum;
	}
	public void setMatchNum(long matchNum) {
		this.matchNum = matchNum;
	}
	public long getClubJoinNum() {
		return clubJoinNum;
	}
	public void setClubJoinNum(long clubJoinNum) {
		this.clubJoinNum = clubJoinNum;
	}
	
	
	
}
