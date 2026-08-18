package com.syfc.dto;

// 서버 간 전송 / 파일 등에 대비해 세션에 안전하게 저장하기위해 
// Serializable(직렬화) 사용
import java.io.Serializable;

public class ClubDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    // DB 매핑 필드 (7개)
    private Long clubOwner_key; // 구단주 고유번호(PK)
    private String club_name;	// 구단의 이름
    private String club_logo;	// 구단 이미지
    private String club_region;	// 구단 연고지
    private Integer club_status;// 구단의 현재 활동 상태
    private String club_created;// 구단의 창단일
    private String club_content;// 구단 상세 소개

    // 기본 생성자
    public ClubDTO() {}

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
}