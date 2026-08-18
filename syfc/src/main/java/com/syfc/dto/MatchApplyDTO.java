package com.syfc.dto;

import java.time.LocalDate;

public class MatchApplyDTO {
    // Match_Apply
    private Long apply_id;
    private LocalDate apply_date;
    private Integer apply_time;
    private Integer status;
    private String cancel_reason;

    private Long stadium_id;
    private Long clubOwner_key;

    private String match_type1;
    private String match_type2;

    private Long clubOwner_key2;

    private Long stadium_fee;

    private Long cmb_num;

    // 경기장
    private String stadiumName;
    private String region;
    private String addr1;
    private String addr2;
    private String zip;
    private Double latitude;
    private Double longitude;

    // 경기장 대관료 ..아마 안쓸듯
    private Long stadiumCost;
  
    // 조회용
    private String stadium_name;
    private String home_club_name;
    private String away_club_name;
    private String cancel_club_name;
    
    private String my_team_type; //HOME인지 AWAY인지
    private Long opponent_clubOwner_key; //현재 구단이 원정팀
    private String opponent_club_name;


	public Long getApply_id() {
		return apply_id;
	}

	public void setApply_id(Long apply_id) {
		this.apply_id = apply_id;
	}

	public LocalDate getApply_date() {
		return apply_date;
	}

	public void setApply_date(LocalDate apply_date) {
		this.apply_date = apply_date;
	}

	public Integer getApply_time() {
		return apply_time;
	}

	public void setApply_time(Integer apply_time) {
		this.apply_time = apply_time;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getCancel_reason() {
		return cancel_reason;
	}

	public void setCancel_reason(String cancel_reason) {
		this.cancel_reason = cancel_reason;
	}

	public Long getStadium_id() {
		return stadium_id;
	}

	public void setStadium_id(Long stadium_id) {
		this.stadium_id = stadium_id;
	}

	public Long getClubOwner_key() {
		return clubOwner_key;
	}

	public void setClubOwner_key(Long clubOwner_key) {
		this.clubOwner_key = clubOwner_key;
	}

	public String getMatch_type1() {
		return match_type1;
	}

	public void setMatch_type1(String match_type1) {
		this.match_type1 = match_type1;
	}

	public String getMatch_type2() {
		return match_type2;
	}

	public void setMatch_type2(String match_type2) {
		this.match_type2 = match_type2;
	}

	public Long getClubOwner_key2() {
		return clubOwner_key2;
	}

	public void setClubOwner_key2(Long clubOwner_key2) {
		this.clubOwner_key2 = clubOwner_key2;
	}

	public Long getStadium_fee() {
		return stadium_fee;
	}

	public void setStadium_fee(Long stadium_fee) {
		this.stadium_fee = stadium_fee;
	}

	public Long getCmb_num() {
		return cmb_num;
	}

	public void setCmb_num(Long cmb_num) {
		this.cmb_num = cmb_num;
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

	public Double getLatitude() {
		return latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	public Double getLongitude() {
		return longitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}

	public Long getStadiumCost() {
		return stadiumCost;
	}

	public void setStadiumCost(Long stadiumCost) {
		this.stadiumCost = stadiumCost;
	}

	public String getStadium_name() {
		return stadium_name;
	}

	public void setStadium_name(String stadium_name) {
		this.stadium_name = stadium_name;
	}

	public String getHome_club_name() {
		return home_club_name;
	}

	public void setHome_club_name(String home_club_name) {
		this.home_club_name = home_club_name;
	}

	public String getAway_club_name() {
		return away_club_name;
	}

	public void setAway_club_name(String away_club_name) {
		this.away_club_name = away_club_name;
	}

	public String getCancel_club_name() {
		return cancel_club_name;
	}

	public void setCancel_club_name(String cancel_club_name) {
		this.cancel_club_name = cancel_club_name;
	}

	public String getMy_team_type() {
		return my_team_type;
	}

	public void setMy_team_type(String my_team_type) {
		this.my_team_type = my_team_type;
	}

	public Long getOpponent_clubOwner_key() {
		return opponent_clubOwner_key;
	}

	public void setOpponent_clubOwner_key(Long opponent_clubOwner_key) {
		this.opponent_clubOwner_key = opponent_clubOwner_key;
	}

	public String getOpponent_club_name() {
		return opponent_club_name;
	}

	public void setOpponent_club_name(String opponent_club_name) {
		this.opponent_club_name = opponent_club_name;
	}
    


}
