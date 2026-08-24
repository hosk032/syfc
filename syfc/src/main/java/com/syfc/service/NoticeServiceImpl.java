package com.syfc.service;

import java.util.List;

import com.syfc.dto.NoticeDTO;
import com.syfc.mapper.NoticeMapper;
import com.syfc.mybatis.support.MapperContainer;

public class NoticeServiceImpl implements NoticeService {

    private NoticeMapper mapper = MapperContainer.get(NoticeMapper.class);

    @Override
    public List<NoticeDTO> listNotice(int memberIdx) {
        return mapper.listNotice(memberIdx);
    }

    @Override
    public int updateRead(NoticeDTO dto) {
        return mapper.updateRead(dto);
    }
    
    @Override
    public int insertNotice(NoticeDTO dto) {
        return mapper.insertNotice(dto);
    }
}