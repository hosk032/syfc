package com.syfc.dto;

public class BallDTO {
	private long ball_idx;
	private String ball_name;
	private String ball_image;
	private String ball_grade;
	private int ball_rating;
	private int required_match_count;
	private int is_active;
	private String created_date;
	private String update_date;
	
	// 테이블 목록에 없는 컬럼
	// 도감 조회할때 중복공을 카운트 및 계산해서 만들어 주는 값
	private int pickCount;
	
	public int getPickCount() {
		return pickCount;
	}
	public void setPickCount(int pickCount) {
		this.pickCount = pickCount;
	}
	public long getBall_idx() {
		return ball_idx;
	}
	public void setBall_idx(long ball_idx) {
		this.ball_idx = ball_idx;
	}
	public String getBall_name() {
		return ball_name;
	}
	public void setBall_name(String ball_name) {
		this.ball_name = ball_name;
	}
	public String getBall_image() {
		return ball_image;
	}
	public void setBall_image(String ball_image) {
		this.ball_image = ball_image;
	}
	public String getBall_grade() {
		return ball_grade;
	}
	public void setBall_grade(String ball_grade) {
		this.ball_grade = ball_grade;
	}
	public int getBall_rating() {
		return ball_rating;
	}
	public void setBall_rating(int ball_rating) {
		this.ball_rating = ball_rating;
	}
	public int getRequired_match_count() {
		return required_match_count;
	}
	public void setRequired_match_count(int required_match_count) {
		this.required_match_count = required_match_count;
	}
	public int getIs_active() {
		return is_active;
	}
	public void setIs_active(int is_active) {
		this.is_active = is_active;
	}
	public String getCreated_date() {
		return created_date;
	}
	public void setCreated_date(String created_date) {
		this.created_date = created_date;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	
	
}
