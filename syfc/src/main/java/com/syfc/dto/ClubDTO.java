package com.syfc.dto;

public class ClubDTO {
    private Long clubOwner_key;
    private String club_name;
    private String club_logo;
    private String club_region;
    private Integer club_status;
    private String club_created;
    private String club_content;
    
    private String club_time;
    private String club_intro;
    private String club_rules;

    // --- Getter / Setter 직접 작성 ---
    public Long getClubOwner_key() {
        return clubOwner_key;
    }
    public void setClubOwner_key(Long clubOwner_key) {
        this.clubOwner_key = clubOwner_key;
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
    public Integer getClub_status() {
        return club_status;
    }
    public void setClub_status(Integer club_status) {
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
    public String getClub_time() {
        return club_time;
    }
    public void setClub_time(String club_time) {
        this.club_time = club_time;
    }
    public String getClub_intro() {
        return club_intro;
    }
    public void setClub_intro(String club_intro) {
        this.club_intro = club_intro;
    }
    public String getClub_rules() {
        return club_rules;
    }
    public void setClub_rules(String club_rules) {
        this.club_rules = club_rules;
    }
}