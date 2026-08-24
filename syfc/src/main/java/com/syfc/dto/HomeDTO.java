package com.syfc.dto;

public class HomeDTO {
    // 경기 정보
    private Long matchNum;
    private String matchDate;
    private int matchTime;
    private Integer homeScore;
    private Integer awayScore;
    private int status;

    // 경기장
    private String stadiumName;

    // 홈 구단
    private String homeClubName;
    private String homeClubLogo;

    // 원정 구단
    private String awayClubName;
    private String awayClubLogo;
    
	public Long getMatchNum() {
		return matchNum;
	}
	public void setMatchNum(Long matchNum) {
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
	public Integer getHomeScore() {
		return homeScore;
	}
	public void setHomeScore(Integer homeScore) {
		this.homeScore = homeScore;
	}
	public Integer getAwayScore() {
		return awayScore;
	}
	public void setAwayScore(Integer awayScore) {
		this.awayScore = awayScore;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getStadiumName() {
		return stadiumName;
	}
	public void setStadiumName(String stadiumName) {
		this.stadiumName = stadiumName;
	}
	public String getHomeClubName() {
		return homeClubName;
	}
	public void setHomeClubName(String homeClubName) {
		this.homeClubName = homeClubName;
	}
	public String getHomeClubLogo() {
		return homeClubLogo;
	}
	public void setHomeClubLogo(String homeClubLogo) {
		this.homeClubLogo = homeClubLogo;
	}
	public String getAwayClubName() {
		return awayClubName;
	}
	public void setAwayClubName(String awayClubName) {
		this.awayClubName = awayClubName;
	}
	public String getAwayClubLogo() {
		return awayClubLogo;
	}
	public void setAwayClubLogo(String awayClubLogo) {
		this.awayClubLogo = awayClubLogo;
	}
}
