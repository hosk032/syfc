package com.syfc.mapper;

import java.util.List;

import com.syfc.dto.NoticeDTO;

public interface NoticeMapper {

    public List<NoticeDTO> listNotice(int memberIdx);

    public int updateRead(long notice_id, int memberIdx);
    
    public int insertNotice(NoticeDTO dto);
}