package com.syfc.dto;

/*
 * =========================================================
 * 관리자 - 구단 관리 DTO
 * =========================================================
 *
 * 관리자가 구단 목록을 조회하고
 * 구단의 운영/정지 상태를 관리할 때 사용한다.
 *
 * clubStatus
 * 1 : 운영
 * 0 : 정지
 */
public class AdminClubDTO {
	private long clubOwnerKey;
	private String clubName;
	private String clubLogo;
	private String clubRegion;
	private int clubStatus;
	private String clubCreated;
	private String clubContent;
	
	// clubOwner → member1에서 가져올 구단주 정보
	private long memberIdx;
	private String userId;
	private String userName;
	
	public long getClubOwnerKey() {
		return clubOwnerKey;
	}
	public void setClubOwnerKey(long clubOwnerKey) {
		this.clubOwnerKey = clubOwnerKey;
	}
	public String getClubName() {
		return clubName;
	}
	public void setClubName(String clubName) {
		this.clubName = clubName;
	}
	public String getClubLogo() {
		return clubLogo;
	}
	public void setClubLogo(String clubLogo) {
		this.clubLogo = clubLogo;
	}
	public String getClubRegion() {
		return clubRegion;
	}
	public void setClubRegion(String clubRegion) {
		this.clubRegion = clubRegion;
	}
	public int getClubStatus() {
		return clubStatus;
	}
	public void setClubStatus(int clubStatus) {
		this.clubStatus = clubStatus;
	}
	public String getClubCreated() {
		return clubCreated;
	}
	public void setClubCreated(String clubCreated) {
		this.clubCreated = clubCreated;
	}
	public String getClubContent() {
		return clubContent;
	}
	public void setClubContent(String clubContent) {
		this.clubContent = clubContent;
	}
	public long getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(long memberIdx) {
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
}
