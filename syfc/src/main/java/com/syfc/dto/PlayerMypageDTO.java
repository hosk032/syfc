package com.syfc.dto;

// mypage 컬럼: memberIdx, email, birth, profile_photo, tel,
//		zip, addr1, addr2, gender, pref_position
public class PlayerMypageDTO {
	private long memberIdx;
	private String email;
	private String birth;
	private String profile_photo;
	private String tel;
	private String zip;
	private String addr1;
	private String addr2;
	private String gender;
	private int pref_position;

	
	public long getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(long memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getProfile_photo() {
		return profile_photo;
	}
	public void setProfile_photo(String profile_photo) {
		this.profile_photo = profile_photo;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getPref_position() {
		return pref_position;
	}
	public void setPref_position(int pref_position) {
		this.pref_position = pref_position;
	}
	
	
}
