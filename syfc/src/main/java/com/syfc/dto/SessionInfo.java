package com.syfc.dto;

public class SessionInfo {
	private int memberIdx;
	private String userId;
	private String userName;
	private int userLevel;//1(일반) 10(선수) 50(구단주) 100(관리자) default 1
	private int status; //회원 상태 default 1 (이용가능) / 정지 2 / 탈퇴 0
	
	private String avatar;

	public int getMemberIdx() {
		return memberIdx;
	}

	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
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

	public int getUserLevel() {
		return userLevel;
	}

	public void setUserLevel(int userLevel) {
		this.userLevel = userLevel;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
}
