package com.syfc.dto;

import java.util.List;

public class ClubMatchDTO {

	// 1. 경기 정보 (Match)
	private Long matchNum;       // 경기 번호
	private String matchDate;    // 경기 날짜 (YYYY-MM-DD)
	private int matchTime;       // 경기 시간 (1: 오전 / 2: 오후 등)
	private Integer homeScore;   // 홈팀 점수
	private Integer awayScore;   // 원정팀 점수
	private int status;			 // 상대팀거절6/매칭실패5/반려4(경기장사정)/매칭대기중3/ 상대팀신청2/ 매칭1/ 취소0

	// 2. 경기장 정보 (Stadium)
	private String stadiumName;  // 경기장 이름

	// 3. 구단 정보 (Club)
	private String homeClubName; // 홈 구단 이름
	private String homeClubLogo; // 홈 구단 로고
	private String awayClubName; // 원정 구단 이름
	private String awayClubLogo; // 원정 구단 로고
	
	// DB 컬럼명 그대로 맞춘 변수 (snake_case)
	private Long clubOwner_key;
	private String club_name;
	private String club_logo;

	// 통계용 변수
	private int totalGames;
	private int winCount;
	private int drawCount;
	private int loseCount;
	private int goalsFor;
	private int goalsAgainst;
	private int goalDifference;
	private List<String> recentResults;
	
	
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
	
	public Long getClubOwner_key() {
		return clubOwner_key;
	}
	public void setClubOwner_key(Long clubOwner_key) {
		this.clubOwner_key = clubOwner_key;
	}
	public String getClub_name() {
		return club_name;
	}
	public void setClub_name(String club_name) {
		this.club_name = club_name;
	}
	public String getClub_logo() {
		return club_logo;
	}
	public void setClub_logo(String club_logo) {
		this.club_logo = club_logo;
	}
	public int getTotalGames() {
		return totalGames;
	}
	public void setTotalGames(int totalGames) {
		this.totalGames = totalGames;
	}
	public int getWinCount() {
		return winCount;
	}
	public void setWinCount(int winCount) {
		this.winCount = winCount;
	}
	public int getDrawCount() {
		return drawCount;
	}
	public void setDrawCount(int drawCount) {
		this.drawCount = drawCount;
	}
	public int getLoseCount() {
		return loseCount;
	}
	public void setLoseCount(int loseCount) {
		this.loseCount = loseCount;
	}
	public int getGoalsFor() {
		return goalsFor;
	}
	public void setGoalsFor(int goalsFor) {
		this.goalsFor = goalsFor;
	}
	public int getGoalsAgainst() {
		return goalsAgainst;
	}
	public void setGoalsAgainst(int goalsAgainst) {
		this.goalsAgainst = goalsAgainst;
	}
	public int getGoalDifference() {
		return goalDifference;
	}
	public void setGoalDifference(int goalDifference) {
		this.goalDifference = goalDifference;
	}
	public List<String> getRecentResults() {
		return recentResults;
	}
	public void setRecentResults(List<String> recentResults) {
		this.recentResults = recentResults;
	}
	
		public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
		// 홈팀 승무패 텍스트 (W / D / L)
		public String getHomeResult() {
			if (homeScore == null || awayScore == null) return "-";
			if (homeScore > awayScore) return "승리";
			if (homeScore.equals(awayScore)) return "무승부";
			return "패배";
		}

		// 홈팀 승무패 CSS 클래스 (win / draw / lose)
		public String getHomeResultClass() {
			if (homeScore == null || awayScore == null) return "";
			if (homeScore > awayScore) return "win";
			if (homeScore.equals(awayScore)) return "draw";
			return "lose";
		}

		// 원정팀 승무패 텍스트 (W / D / L)
		public String getAwayResult() {
			if (homeScore == null || awayScore == null) return "-";
			if (awayScore > homeScore) return "승리";
			if (homeScore.equals(awayScore)) return "무승부";
			return "패배";
		}

		// 원정팀 승무패 CSS 클래스 (win / draw / lose)
		public String getAwayResultClass() {
			if (homeScore == null || awayScore == null) return "";
			if (awayScore > homeScore) return "win";
			if (homeScore.equals(awayScore)) return "draw";
			return "lose";
		}
	
}
