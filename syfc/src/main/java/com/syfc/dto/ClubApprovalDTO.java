package com.syfc.dto;

public class ClubApprovalDTO {
	private Long applyNum; // clubJoin_num (입단신청번호 PK)
	private Long memberIdx; // memberIdx (회원고유번호 FK)
	private Long clubOwner_key; // clubOwner_key (구단주번호 FK)
	private String content; // clubJoin_content (신청사유)
	private String applyDate; // clubJoin_date (신청일)
	private Integer status; // clubJoin_result (신청결과 -> 대기:2 / 승인:1 / 반려:0)
	private String memo; // clubJoin_intro (자기소개)
	private String position; // clubJoin_position (선호포지션)
	private String rejectReason; // clubJoin_reason (반려사유)

	// 화면 표시용 (Member 테이블 JOIN 데이터)
	private String userName; // 신청자 이름
	private Integer userAge; // 신청자 나이

	public Long getApplyNum() {
		return applyNum;
	}

	public void setApplyNum(Long applyNum) {
		this.applyNum = applyNum;
	}

	public Long getMemberIdx() {
		return memberIdx;
	}

	public void setMemberIdx(Long memberIdx) {
		this.memberIdx = memberIdx;
	}

	public Long getClubOwner_key() {
		return clubOwner_key;
	}

	public void setClubOwner_key(Long clubOwner_key) {
		this.clubOwner_key = clubOwner_key;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getRejectReason() {
		return rejectReason;
	}

	public void setRejectReason(String rejectReason) {
		this.rejectReason = rejectReason;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Integer getUserAge() {
		return userAge;
	}

	public void setUserAge(Integer userAge) {
		this.userAge = userAge;
	}
}