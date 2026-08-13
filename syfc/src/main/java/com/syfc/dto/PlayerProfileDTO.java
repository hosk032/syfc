package com.syfc.dto;

// playerProfile 컬럼: memberIdx, clubJoinNum, position, uniformNo, 
//			height, weight, joinDate, status, clubOwnerKey, 
//			reason, leaveDate
public class PlayerProfileDTO {
	private long memberIdx;
	private long clubJoinNum;
	private String position;
	private int uniformNo;
	private int height;
	private int weight;
	private String joinDate;
	private String status;
	private long clubOwnerKey;
	private String reason;
	private String leaveDate;
	
	public long getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(long memberIdx) {
		this.memberIdx = memberIdx;
	}
	public long getClubJoinNum() {
		return clubJoinNum;
	}
	public void setClubJoinNum(long clubJoinNum) {
		this.clubJoinNum = clubJoinNum;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public int getUniformNo() {
		return uniformNo;
	}
	public void setUniformNo(int uniformNo) {
		this.uniformNo = uniformNo;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	public int getWeight() {
		return weight;
	}
	public void setWeight(int weight) {
		this.weight = weight;
	}
	public String getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public long getClubOwnerKey() {
		return clubOwnerKey;
	}
	public void setClubOwnerKey(long clubOwnerKey) {
		this.clubOwnerKey = clubOwnerKey;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getLeaveDate() {
		return leaveDate;
	}
	public void setLeaveDate(String leaveDate) {
		this.leaveDate = leaveDate;
	}
	
	
	
}
