package com.syfc.dto;

public class ClubInfoPlyDTO {

	public long clubowner_key;
	public String club_name;
	public String club_logo;
	public String club_region;
	public int club_status;
	public String club_created;
	public String club_content;
	
	public long clubjoin_num;
	public String position;
	public int uniform_no;
	public int height;
	public int weight;
	public String join_date;
	public String status;
	
	private String profile_photo;
	private double rating;
	
	private int userLevel;
	
	private String userName;
	public long memberIdx;
	private int email;
	private String birth;
	private String tel;
	private String zip;
	private String addr1;
	private String addr2;
	private String gender;
	
	
	public long getClubowner_key() {
		return clubowner_key;
	}
	public void setClubowner_key(long clubowner_key) {
		this.clubowner_key = clubowner_key;
	}
	public String getClub_name() {
		return club_name;
	}
	public void setClub_name(String club_name) {
		this.club_name = club_name;
	}
	public String getClub_logo() {
		return club_logo;
	}
	public void setClub_logo(String club_logo) {
		this.club_logo = club_logo;
	}
	public String getClub_region() {
		return club_region;
	}
	public void setClub_region(String club_region) {
		this.club_region = club_region;
	}
	public int getClub_status() {
		return club_status;
	}
	public void setClub_status(int club_status) {
		this.club_status = club_status;
	}
	public String getClub_created() {
		return club_created;
	}
	public void setClub_created(String club_created) {
		this.club_created = club_created;
	}
	public String getClub_content() {
		return club_content;
	}
	public void setClub_content(String club_content) {
		this.club_content = club_content;
	}
	public long getClubjoin_num() {
		return clubjoin_num;
	}
	public void setClubjoin_num(long clubjoin_num) {
		this.clubjoin_num = clubjoin_num;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public int getUniform_no() {
		return uniform_no;
	}
	public void setUniform_no(int uniform_no) {
		this.uniform_no = uniform_no;
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
	    if ("활동".equals(status)) {
	        this.status = "1";
	    } else {
	        this.status = status;
	    }
	}
	public String getProfile_photo() {
		return profile_photo;
	}
	public void setProfile_photo(String profile_photo) {
		this.profile_photo = profile_photo;
	}
	public double getRating() {
		return rating;
	}
	public void setRating(double rating) {
		this.rating = rating;
	}
	public int getUserLevel() {
		return userLevel;
	}
	public void setUserLevel(int userLevel) {
		this.userLevel = userLevel;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public long getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(long memberIdx) {
		this.memberIdx = memberIdx;
	}
	public int getEmail() {
		return email;
	}
	public void setEmail(int email) {
		this.email = email;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
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
	
}
