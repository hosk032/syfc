package com.syfc.dto;

public class NoticeDTO {

    private long notice_id;
    private String notice_content;
    private int memberIdx;
    private int notice_read;
    private String notice_sendDate;
    private String notice_readDate;


    public long getNotice_id() {
        return notice_id;
    }

    public void setNotice_id(long notice_id) {
        this.notice_id = notice_id;
    }


    public String getNotice_content() {
        return notice_content;
    }

    public void setNotice_content(String notice_content) {
        this.notice_content = notice_content;
    }


    public int getMemberIdx() {
        return memberIdx;
    }

    public void setMemberIdx(int memberIdx) {
        this.memberIdx = memberIdx;
    }


    public int getNotice_read() {
        return notice_read;
    }

    public void setNotice_read(int notice_read) {
        this.notice_read = notice_read;
    }


    public String getNotice_sendDate() {
        return notice_sendDate;
    }

    public void setNotice_sendDate(String notice_sendDate) {
        this.notice_sendDate = notice_sendDate;
    }


    public String getNotice_readDate() {
        return notice_readDate;
    }

    public void setNotice_readDate(String notice_readDate) {
        this.notice_readDate = notice_readDate;
    }
}
