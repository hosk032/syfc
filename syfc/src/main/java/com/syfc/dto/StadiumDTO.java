package com.syfc.dto;

public class StadiumDTO {

    private Long stadium_id;
    private String stadium_name;
    private String region;
    private Integer capacity;
    private Integer status; 
    	//예약가능1 /예약불가0 (한시적 issue가 아닌, 장기적 상황. 경기장 폐지 등)

    private Double latitude;
    private Double longitude;

    private String addr1;
    private String addr2;
    private String zip;

    private Long stadium_cost;
    private String stadium_img;


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

    public Integer getCapacity() {
        return capacity;
    }

    public void setCapacity(Integer capacity) {
        this.capacity = capacity;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
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

    public Long getStadium_cost() {
        return stadium_cost;
    }

    public void setStadium_cost(Long stadium_cost) {
        this.stadium_cost = stadium_cost;
    }

    public String getStadium_img() {
        return stadium_img;
    }

    public void setStadium_img(String stadium_img) {
        this.stadium_img = stadium_img;
    }
}

