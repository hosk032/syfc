package com.syfc.dto;

public class ClubOwnerDTO {

	private Long clubOwnerKey; // 구단주번호 (PK) - NUMBER
	private Long memberIdx; // 회원고유번호 (FK , Unique) - NUMBER
	
	
	public Long getClubOwnerKey() {
		return clubOwnerKey;
	}
	public void setClubOwnerKey(Long clubOwnerKey) {
		this.clubOwnerKey = clubOwnerKey;
	}
	public Long getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(Long memberIdx) {
		this.memberIdx = memberIdx;
	}
	

}
