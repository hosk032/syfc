package com.syfc.dto;

public class ClubOwnerPlayerRecordDTO {
    private Long recordId;        // 기록 ID (RECORD_ID)
    private Double rating;        // 평점 (RATING)
    private Integer goal;         // 득점 (GOAL)
    private Integer assist;       // 도움 (ASSIST)
    private Integer yellow;       // 경고 (YELLOW)
    private Integer red;          // 퇴장 (RED)
    private Integer ownGoal;      // 자책골 (OWN_GOAL)
    private Long matchNum;        // 매치 번호 (MATCH_NUM)
    private Long clubJoinNum;     // 소속 선수 번호 (CLUBJOIN_NUM)

    // 조인 및 화면 출력용 추가 필드
    private String userName;      // 선수명
    private String position;      // 포지션
    private String matchDate;     // 경기 날짜
    private String memo;          // 코멘트/메모

    public ClubOwnerPlayerRecordDTO() {}

    public Long getRecordId() { return recordId; }
    public void setRecordId(Long recordId) { this.recordId = recordId; }
    public Double getRating() { return rating; }
    public void setRating(Double rating) { this.rating = rating; }
    public Integer getGoal() { return goal; }
    public void setGoal(Integer goal) { this.goal = goal; }
    public Integer getAssist() { return assist; }
    public void setAssist(Integer assist) { this.assist = assist; }
    public Integer getYellow() { return yellow; }
    public void setYellow(Integer yellow) { this.yellow = yellow; }
    public Integer getRed() { return red; }
    public void setRed(Integer red) { this.red = red; }
    public Integer getOwnGoal() { return ownGoal; }
    public void setOwnGoal(Integer ownGoal) { this.ownGoal = ownGoal; }
    public Long getMatchNum() { return matchNum; }
    public void setMatchNum(Long matchNum) { this.matchNum = matchNum; }
    public Long getClubJoinNum() { return clubJoinNum; }
    public void setClubJoinNum(Long clubJoinNum) { this.clubJoinNum = clubJoinNum; }
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }
    public String getMatchDate() { return matchDate; }
    public void setMatchDate(String matchDate) { this.matchDate = matchDate; }
    public String getMemo() { return memo; }
    public void setMemo(String memo) { this.memo = memo; }
}