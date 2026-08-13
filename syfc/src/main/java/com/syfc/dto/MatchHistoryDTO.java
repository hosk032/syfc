package com.syfc.dto;

// 내 경기 참가 이력
// 컬럼: 경기번호, 경기일, 경기시간, 홈팀점수, 원정팀점수, 신청번호 
public class MatchHistoryDTO {
	private long matchNum;
	private String matchDate;
	private int matchTime;
	private int homeScore;
	private int awayScore;
	private long applyId;
	
	public long getMatchNum() {
		return matchNum;
	}
	public void setMatchNum(long matchNum) {
		this.matchNum = matchNum;
	}
	public String getMatchDate() {
		return matchDate;
	}
	public void setMatchDate(String matchDate) {
		this.matchDate = matchDate;
	}
	public int getMatchTime() {
		return matchTime;
	}
	public void setMatchTime(int matchTime) {
		this.matchTime = matchTime;
	}
	public int getHomeScore() {
		return homeScore;
	}
	public void setHomeScore(int homeScore) {
		this.homeScore = homeScore;
	}
	public int getAwayScore() {
		return awayScore;
	}
	public void setAwayScore(int awayScore) {
		this.awayScore = awayScore;
	}
	public long getApplyId() {
		return applyId;
	}
	public void setApplyId(long applyId) {
		this.applyId = applyId;
	}
	
	
}
