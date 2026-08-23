package com.syfc.dto;

import java.time.LocalDate;
import java.util.List;

public class ClubMatchBoardDTO {
	
	 //clubMatchBoard
    private Long cmb_num;
    private String cmb_Subject;
    private String cmb_Content;
    private Long cmb_HitCount;
    private LocalDate cmb_Reg_date;

    private Long clubOwner_key; //session memberidx로 member1+clubOwner 조인해서

    	// clubMatchRequest
    private Long clubJoin_num;
    private LocalDate request_date;
    private Integer request_state;
    private String request_intro;
    private String reject_reason;
    private String request_cancel;
    
	// Session의 memberIdx 받아오려고. clubOwner_key 조회를 위해
    private int memberIdx;
    
    private String playerName; // 선수 이름 등 화면 표시용

    private Integer applicantCount; // 화면 계산용
    private Integer targetCount;

    private List<ClubMatchBoardDTO> applicants;  // 신청자 목록

    	//한 DTO에 필드 수가 너무 많지만 mapper에서 필요해서. stadium, Match_apply 칼럼들
    private Long apply_id;
    private LocalDate apply_date;
    private Integer apply_time;
    private Integer match_status;
    private String cancel_reason;

    private Long stadium_id;
    private String stadium_name;
    private String region;
    private String addr1;
    private String addr2;
    private String zip;
    private Double latitude;
    private Double longitude;
    private Long capacity;
    private Long stadium_cost;

    private Long home_clubOwner_key;
    private String home_clubName;

    private String match_type1;
    private String match_type2;

    private Long away_clubOwner_key;
    private String away_clubName;
    
    private Integer status;
    private Integer stadium_fee;
    private String stadium_img;
    

	public String getStadium_img() {
		return stadium_img;
	}
	public void setStadium_img(String stadium_img) {
		this.stadium_img = stadium_img;
	}
	public Integer getStadium_fee() {
		return stadium_fee;
	}
	public void setStadium_fee(Integer stadium_fee) {
		this.stadium_fee = stadium_fee;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Long getCmb_num() {
		return cmb_num;
	}
	public void setCmb_num(Long cmb_num) {
		this.cmb_num = cmb_num;
	}
	public String getCmb_Subject() {
		return cmb_Subject;
	}
	public void setCmb_Subject(String cmb_Subject) {
		this.cmb_Subject = cmb_Subject;
	}
	public String getCmb_Content() {
		return cmb_Content;
	}
	public void setCmb_Content(String cmb_Content) {
		this.cmb_Content = cmb_Content;
	}
	public Long getCmb_HitCount() {
		return cmb_HitCount;
	}
	public void setCmb_HitCount(Long cmb_HitCount) {
		this.cmb_HitCount = cmb_HitCount;
	}
	public LocalDate getCmb_Reg_date() {
		return cmb_Reg_date;
	}
	public void setCmb_Reg_date(LocalDate cmb_Reg_date) {
		this.cmb_Reg_date = cmb_Reg_date;
	}
	public Long getClubOwner_key() {
		return clubOwner_key;
	}
	public void setClubOwner_key(Long clubOwner_key) {
		this.clubOwner_key = clubOwner_key;
	}
	public Long getClubJoin_num() {
		return clubJoin_num;
	}
	public void setClubJoin_num(Long clubJoin_num) {
		this.clubJoin_num = clubJoin_num;
	}
	public LocalDate getRequest_date() {
		return request_date;
	}
	public void setRequest_date(LocalDate request_date) {
		this.request_date = request_date;
	}
	public Integer getRequest_state() {
		return request_state;
	}
	public void setRequest_state(Integer request_state) {
		this.request_state = request_state;
	}
	public String getRequest_intro() {
		return request_intro;
	}
	public void setRequest_intro(String request_intro) {
		this.request_intro = request_intro;
	}
	public String getReject_reason() {
		return reject_reason;
	}
	public void setReject_reason(String reject_reason) {
		this.reject_reason = reject_reason;
	}
	public String getRequest_cancel() {
		return request_cancel;
	}
	public void setRequest_cancel(String request_cancel) {
		this.request_cancel = request_cancel;
	}
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getPlayerName() {
		return playerName;
	}
	public void setPlayerName(String playerName) {
		this.playerName = playerName;
	}
	public Integer getApplicantCount() {
		return applicantCount;
	}
	public void setApplicantCount(Integer applicantCount) {
		this.applicantCount = applicantCount;
	}
	public Integer getTargetCount() {
		return targetCount;
	}
	public void setTargetCount(Integer targetCount) {
		this.targetCount = targetCount;
	}
	public List<ClubMatchBoardDTO> getApplicants() {
		return applicants;
	}
	public void setApplicants(List<ClubMatchBoardDTO> applicants) {
		this.applicants = applicants;
	}
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
	public Integer getMatch_status() {
		return match_status;
	}
	public void setMatch_status(Integer match_status) {
		this.match_status = match_status;
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
	public String getStadium_name() {
		return stadium_name;
	}
	public void setStadium_name(String stadium_name) {
		this.stadium_name = stadium_name;
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
	public Long getCapacity() {
		return capacity;
	}
	public void setCapacity(Long capacity) {
		this.capacity = capacity;
	}
	public Long getStadium_cost() {
		return stadium_cost;
	}
	public void setStadium_cost(Long stadium_cost) {
		this.stadium_cost = stadium_cost;
	}
	public Long getHome_clubOwner_key() {
		return home_clubOwner_key;
	}
	public void setHome_clubOwner_key(Long home_clubOwner_key) {
		this.home_clubOwner_key = home_clubOwner_key;
	}
	public String getHome_clubName() {
		return home_clubName;
	}
	public void setHome_clubName(String home_clubName) {
		this.home_clubName = home_clubName;
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
	public Long getAway_clubOwner_key() {
		return away_clubOwner_key;
	}
	public void setAway_clubOwner_key(Long away_clubOwner_key) {
		this.away_clubOwner_key = away_clubOwner_key;
	}
	public String getAway_clubName() {
		return away_clubName;
	}
	public void setAway_clubName(String away_clubName) {
		this.away_clubName = away_clubName;
	}
    
}
