package com.syfc.dto;

import java.io.Serializable;

// 구단주 - 구단 경기 이력 및 성적 조회용 DTO
public class ClubOwnerMatchDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	// 1. 경기 / 결과 테이블 (Match)
	private Long matchNum; // 경기 번호(PK)
	private String matchDate; // 경기 날짜 (YYYY-MM-DD)
	private int matchTime; // 경기 시간 (1: 오전 / 2: 오후 등)
	private int homeScore; // 홈팀 점수
	private int awayScore; // 원정팀 점수
	private Long applyId; // 경기 신청 번호(FK)

	// 2. 경기장 테이블 (Stadium)
	private String stadiumName; // 경기장 이름
	private String stadiumImg; // 경기장 사진 (모달/상세용)

	// 3. 구단 테이블 (Club) - 홈/원정 구분
	private Long homeClubOwnerKey; // 홈 구단주 고유번호(PK)
	private String homeClubName; // 홈 구단 이름
	private String homeClubLogo; // 홈 구단 로고

	private Long awayClubOwnerKey; // 원정 구단주 고유번호(PK)
	private String awayClubName; // 원정 구단 이름
	private String awayClubLogo; // 원정 구단 로고

	// 4. 화면 출력용 가공 데이터
	private String matchResult; // 경기 결과 (승리 / 무승부 / 패배)

	/*
	 * [추후 기능 구현 예정 - 모달 상세조회 전용] 
	 * - 경기장 사진 , 경기장 위치 , 홈팀 사진 , 원정팀 사진 ,
	 * - 득점 시간대 , 득점 선수 , 경기날짜 
	 */

	// 기본 생성자
	public ClubOwnerMatchDTO() {
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

	public Long getApplyId() {
		return applyId;
	}

	public void setApplyId(Long applyId) {
		this.applyId = applyId;
	}

	public String getStadiumName() {
		return stadiumName;
	}

	public void setStadiumName(String stadiumName) {
		this.stadiumName = stadiumName;
	}

	public String getStadiumImg() {
		return stadiumImg;
	}

	public void setStadiumImg(String stadiumImg) {
		this.stadiumImg = stadiumImg;
	}

	public Long getHomeClubOwnerKey() {
		return homeClubOwnerKey;
	}

	public void setHomeClubOwnerKey(Long homeClubOwnerKey) {
		this.homeClubOwnerKey = homeClubOwnerKey;
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

	public Long getAwayClubOwnerKey() {
		return awayClubOwnerKey;
	}

	public void setAwayClubOwnerKey(Long awayClubOwnerKey) {
		this.awayClubOwnerKey = awayClubOwnerKey;
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

	public String getMatchResult() {
		return matchResult;
	}

	public void setMatchResult(String matchResult) {
		this.matchResult = matchResult;
	}
}