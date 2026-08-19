package com.syfc.dto;

public class ClubOwnerResultDTO {

	// 1. 경기 기본 정보
	private Long matchNum; // 경기 번호 (PK)
	private String matchDate; // 경기 날짜
	private String stadiumName; // 경기장 이름

	// 2. 홈팀 (우리팀) 정보
	private String homeClubName; // 홈팀 구단명
	private Integer homeScore; // 홈팀 점수 (null 허용을 위해 Integer)

	// 3. 원정팀 (상대팀) 정보
	private String awayClubName; // 원정팀 구단명
	private String awayClubLogo; // 원정팀 엠블럼 이미지 파일명
	private Integer awayScore; // 원정팀 점수 (null 허용을 위해 Integer)

	// 기본 생성자
	public ClubOwnerResultDTO() {
	}

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

	public Integer getHomeScore() {
		return homeScore;
	}

	public void setHomeScore(Integer homeScore) {
		this.homeScore = homeScore;
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

	public Integer getAwayScore() {
		return awayScore;
	}

	public void setAwayScore(Integer awayScore) {
		this.awayScore = awayScore;
	}
}