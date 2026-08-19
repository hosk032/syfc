package com.syfc.dto;

// 회원별 공 뽑기 이력
public class MemberBallpickDTO {
	private long memberBall_num;
	private String pickBall_date;
	private long memberIdx;
	private long ball_idx;
	
	public long getMemberBall_num() {
		return memberBall_num;
	}
	public void setMemberBall_num(long memberBall_num) {
		this.memberBall_num = memberBall_num;
	}
	public String getPickBall_date() {
		return pickBall_date;
	}
	public void setPickBall_date(String pickBall_date) {
		this.pickBall_date = pickBall_date;
	}
	public long getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(long memberIdx) {
		this.memberIdx = memberIdx;
	}
	public long getBall_idx() {
		return ball_idx;
	}
	public void setBall_idx(long ball_idx) {
		this.ball_idx = ball_idx;
	}
	
	
}
