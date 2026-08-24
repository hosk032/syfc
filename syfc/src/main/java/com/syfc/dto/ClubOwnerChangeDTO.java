package com.syfc.dto;

public class ClubOwnerChangeDTO {
	// 1. 위임 변경 요청 처리용 (Form Submit)
	private Long clubOwner_key;    // 구단 키
	private Long memberIdx;        // 로그인한 현재 구단주의 회원 번호
	private Long targetMemberIdx;  // 위임받을 차기 구단주의 회원 번호
	private int userLevel;         // 등급
	private Long clubJoin_num;    // 선택한 선수 식별 번호
	private String userPwd;        // 비밀번호 재확인
	private String reason;         // 양도 사유

	// 2. 차기 구단주 드롭다운 셀렉트박스 표시용 (UI 조회)
	private String userName;       // 선수 이름
	private String join_date;      // 가입일
	private int pref_position;    // 선호 포지션 (숫자 코드)
	private String positionName;   // 포지션명 (예: FW, DF, MF)
	private String tel;            // 전화번호

	public ClubOwnerChangeDTO() {}

	// GETTER / SETTER
	public Long getClubOwner_key() {
		return clubOwner_key;
	}

	public void setClubOwner_key(Long clubOwner_key) {
		this.clubOwner_key = clubOwner_key;
	}

	public Long getMemberIdx() {
		return memberIdx;
	}

	public void setMemberIdx(Long memberIdx) {
		this.memberIdx = memberIdx;
	}

	public Long getTargetMemberIdx() {
		return targetMemberIdx;
	}

	public void setTargetMemberIdx(Long targetMemberIdx) {
		this.targetMemberIdx = targetMemberIdx;
	}

	public int getUserLevel() {
		return userLevel;
	}

	public void setUserLevel(int userLevel) {
		this.userLevel = userLevel;
	}

	public Long getClubJoin_num() {
		return clubJoin_num;
	}

	public void setClubJoin_num(Long clubJoin_num) {
		this.clubJoin_num = clubJoin_num;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getJoin_date() {
		return join_date;
	}

	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}

	public int getPref_position() {
		return pref_position;
	}

	public void setPref_position(int pref_position) {
		this.pref_position = pref_position;
	}

	public String getPositionName() {
		return positionName;
	}

	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}
}