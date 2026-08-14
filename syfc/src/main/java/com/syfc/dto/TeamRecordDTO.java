package com.syfc.dto;

public class TeamRecordDTO {

	private Long teamRecordId; // 팀성적번호 (PK) - NUMBER
	private Integer recordYear; // 연도 - NUMBER
	private Integer recordMonth; // 월 - NUMBER
	private Integer win; // 승 - NUMBER
	private Integer draw; // 무 - NUMBER
	private Integer lose; // 패 - NUMBER
	
	
	public Long getTeamRecordId() {
		return teamRecordId;
	}
	public void setTeamRecordId(Long teamRecordId) {
		this.teamRecordId = teamRecordId;
	}
	public Integer getRecordYear() {
		return recordYear;
	}
	public void setRecordYear(Integer recordYear) {
		this.recordYear = recordYear;
	}
	public Integer getRecordMonth() {
		return recordMonth;
	}
	public void setRecordMonth(Integer recordMonth) {
		this.recordMonth = recordMonth;
	}
	public Integer getWin() {
		return win;
	}
	public void setWin(Integer win) {
		this.win = win;
	}
	public Integer getDraw() {
		return draw;
	}
	public void setDraw(Integer draw) {
		this.draw = draw;
	}
	public Integer getLose() {
		return lose;
	}
	public void setLose(Integer lose) {
		this.lose = lose;
	}
}
