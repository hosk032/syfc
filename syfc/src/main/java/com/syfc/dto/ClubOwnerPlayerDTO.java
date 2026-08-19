package com.syfc.dto;

public class ClubOwnerPlayerDTO {
	private Long clubJoin_num; // Player 테이블의 PK이자 clubJoin과 연동되는 고유번호
	private String position; // 포지션 (FW, MF, DF, GK)
	private Integer uniform_no; // 등번호
	private Double height; // 키
	private Double weight; // 몸무게
	private String join_date; // 가입일
	private String status; // 선수 상태
	private Long clubOwner_key; // 구단주 번호
	private String reason; // 사유
	private String leave_date; // 탈퇴/제적일

	// 화면 표시용 (JOIN 데이터)
	private String userName; // 선수 이름 (member1.userName)
	private boolean isOwner; // 구단주 여부 확인용
	private Long memberIdx;

	public Long getMemberIdx() {
		return memberIdx;
	}

	public void setMemberIdx(Long memberIdx) {
		this.memberIdx = memberIdx;
	}

	public Long getClubJoin_num() {
		return clubJoin_num;
	}

	public void setClubJoin_num(Long clubJoin_num) {
		this.clubJoin_num = clubJoin_num;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public Integer getUniform_no() {
		return uniform_no;
	}

	public void setUniform_no(Integer uniform_no) {
		this.uniform_no = uniform_no;
	}

	public Double getHeight() {
		return height;
	}

	public void setHeight(Double height) {
		this.height = height;
	}

	public Double getWeight() {
		return weight;
	}

	public void setWeight(Double weight) {
		this.weight = weight;
	}

	public String getJoin_date() {
		return join_date;
	}

	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Long getClubOwner_key() {
		return clubOwner_key;
	}

	public void setClubOwner_key(Long clubOwner_key) {
		this.clubOwner_key = clubOwner_key;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getLeave_date() {
		return leave_date;
	}

	public void setLeave_date(String leave_date) {
		this.leave_date = leave_date;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public boolean isOwner() {
		return isOwner;
	}

	public void setOwner(boolean isOwner) {
		this.isOwner = isOwner;
	}
}
