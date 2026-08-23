package com.syfc.service;

import java.util.List;

import com.syfc.dto.NoticeDTO;

public interface NoticeService {

    public List<NoticeDTO> listNotice(int memberIdx);

    public int updateRead(long notice_id, int memberIdx);
    
    public int insertNotice(NoticeDTO dto);
}
