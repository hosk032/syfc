package com.syfc.dto;

/*
 * =========================================================
 * 관리자 - 자유게시판 관리 DTO
 * =========================================================
 *
 * 관리자가 자유게시판 목록을 조회하고
 * 블라인드 및 삭제 처리할 때 사용하는 객체
 *
 * ★ board 테이블
 * b_Type = 0 : 자유게시판
 * b_Type = 1 : 공지사항
 *
 * ★ b_Block
 * 0 : 정상
 * 1 : 블라인드
 */
public class AdminBoardDTO {
	private long num;		 // 게시글 번호
	private String subject;  // 제목
	private String content;  // 내용
	private int hitCount;    // 조회수
	private String regDate;  // 작성일
	private int block;	  	 // 블라인드 여부
	private long memberIdx;  // 작성 회원 번호
	private String userName; // 작성자 이름
	
	public long getNum() {
		return num;
	}
	public void setNum(long num) {
		this.num = num;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public int getBlock() {
		return block;
	}
	public void setBlock(int block) {
		this.block = block;
	}
	public long getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(long memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
}
