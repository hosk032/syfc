package com.syfc.dto;

/*
 * =========================================================
 * 관리자 - 경기장 관리 DTO
 * =========================================================
 *
 * Stadium 테이블의 경기장 정보를 담는다.
 *
 * status
 * 1 : 예약가능
 * 0 : 예약불가
 */
public class AdminStadiumDTO {
	private long stadiumId;
	private String stadiumName;
	private String region;
	private long capacity;
	private int status;
	private long latitude;
	private long longitude;
	private String addr1;
	private String addr2;
	private String zip;
	private long stadiumCost;
	private String stadiumImg;

	public long getStadiumId() {
		return stadiumId;
	}

	public void setStadiumId(long stadiumId) {
		this.stadiumId = stadiumId;
	}

	public String getStadiumName() {
		return stadiumName;
	}

	public void setStadiumName(String stadiumName) {
		this.stadiumName = stadiumName;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public long getCapacity() {
		return capacity;
	}

	public void setCapacity(long capacity) {
		this.capacity = capacity;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public long getLatitude() {
		return latitude;
	}

	public void setLatitude(long latitude) {
		this.latitude = latitude;
	}

	public long getLongitude() {
		return longitude;
	}

	public void setLongitude(long longitude) {
		this.longitude = longitude;
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

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	public long getStadiumCost() {
		return stadiumCost;
	}

	public void setStadiumCost(long stadiumCost) {
		this.stadiumCost = stadiumCost;
	}

	public String getStadiumImg() {
		return stadiumImg;
	}

	public void setStadiumImg(String stadiumImg) {
		this.stadiumImg = stadiumImg;
	}
}