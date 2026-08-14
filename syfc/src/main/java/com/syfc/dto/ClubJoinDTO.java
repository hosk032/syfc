package com.syfc.dto;

public class ClubJoinDTO {

	private Long clubJoinNum; // 입단신청번호 (PK)
	private Long memberIdx;	// 회원 고유번호 (FK)
	private Long clubOwnerKey;	// 구단주번호 (FK)
	private String clubJoinContent; // 신청사유
	private String clubJoinDate;	// 신청일
	private Integer clubJoinResult;	// 신청결과 ( 대기 2 / 승인 1 / 반려 0 )
	private String clubJoinIntro;	// 자기소개
	private String clubJoinPosition;	// 선호포지션
	private String clubJoinReason;	// 반려사유
	
	private String userName; 	// 입단신청회원 이름

	public Long getClubJoinNum() {
		return clubJoinNum;
	}

	public void setClubJoinNum(Long clubJoinNum) {
		this.clubJoinNum = clubJoinNum;
	}

	public Long getMemberIdx() {
		return memberIdx;
	}

	public void setMemberIdx(Long memberIdx) {
		this.memberIdx = memberIdx;
	}

	public Long getClubOwnerKey() {
		return clubOwnerKey;
	}

	public void setClubOwnerKey(Long clubOwnerKey) {
		this.clubOwnerKey = clubOwnerKey;
	}

	public String getClubJoinContent() {
		return clubJoinContent;
	}

	public void setClubJoinContent(String clubJoinContent) {
		this.clubJoinContent = clubJoinContent;
	}

	public String getClubJoinDate() {
		return clubJoinDate;
	}

	public void setClubJoinDate(String clubJoinDate) {
		this.clubJoinDate = clubJoinDate;
	}

	public Integer getClubJoinResult() {
		return clubJoinResult;
	}

	public void setClubJoinResult(Integer clubJoinResult) {
		this.clubJoinResult = clubJoinResult;
	}

	public String getClubJoinIntro() {
		return clubJoinIntro;
	}

	public void setClubJoinIntro(String clubJoinIntro) {
		this.clubJoinIntro = clubJoinIntro;
	}

	public String getClubJoinPosition() {
		return clubJoinPosition;
	}

	public void setClubJoinPosition(String clubJoinPosition) {
		this.clubJoinPosition = clubJoinPosition;
	}

	public String getClubJoinReason() {
		return clubJoinReason;
	}

	public void setClubJoinReason(String clubJoinReason) {
		this.clubJoinReason = clubJoinReason;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
}
