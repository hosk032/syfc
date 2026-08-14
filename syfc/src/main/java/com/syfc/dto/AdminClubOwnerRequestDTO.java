package com.syfc.dto;

/*
 * =========================================================
 * 관리자 - 구단주 신청 관리 DTO
 * =========================================================
 *
 * ClubOwnerRequest 테이블의 구단주 신청정보와
 * member1, member2 테이블에서 가져온 회원정보를 담는 객체
 *
 * ★ 관리자 화면에서 신청자 정보와 신청 상태를 출력할 때 사용
 */
public class AdminClubOwnerRequestDTO {

	// 구단주 신청번호(PK)
	private long requestNum;

	// 구단주 신청사유
	private String content;

	// 신청일
	private String requestDate;

	/*
	 * 구단주 신청 상태
	 * 2 : 대기
	 * 1 : 승인
	 * 0 : 반려
	 */
	private int status;

	// 신청한 회원의 회원번호
	private long memberIdx;

	// =========================
	// 회원정보
	// =========================

	// 신청자 아이디
	private String userId;

	// 신청자 이름
	private String userName;

	// 신청자 연락처
	private String tel;

	/*
	 * 회원 등급
	 * 1   : 일반회원
	 * 10  : 선수
	 * 50  : 구단주
	 * 100 : 관리자
	 */
	private int userLevel;

	public long getRequestNum() {
		return requestNum;
	}

	public void setRequestNum(long requestNum) {
		this.requestNum = requestNum;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRequestDate() {
		return requestDate;
	}

	public void setRequestDate(String requestDate) {
		this.requestDate = requestDate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
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

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public int getUserLevel() {
		return userLevel;
	}

	public void setUserLevel(int userLevel) {
		this.userLevel = userLevel;
	}
}