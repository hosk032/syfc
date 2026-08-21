package com.syfc.service;

import java.util.List;
import com.syfc.dto.ClubOwnerPlayerRecordDTO;
import com.syfc.mapper.ClubOwnerPlayerRecordMapper;
import com.syfc.mybatis.support.MapperContainer; // 💡 프로젝트 고유의 매퍼 컨테이너 임포트!

public class ClubOwnerPlayerRecordServiceImpl implements ClubOwnerPlayerRecordService {
    
    // 💡 Null이 발생하지 않도록 MapperContainer를 통해 매퍼 객체를 확실하게 주입받습니다.
    private ClubOwnerPlayerRecordMapper mapper = MapperContainer.get(ClubOwnerPlayerRecordMapper.class);

    @Override
    public List<ClubOwnerPlayerRecordDTO> getPlayerRecordList(Long clubOwnerKey) throws Exception {
        try {
            return mapper.getPlayerRecordList(clubOwnerKey);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void insertPlayerRecord(ClubOwnerPlayerRecordDTO dto) throws Exception {
        try {
            mapper.insertPlayerRecord(dto);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void updatePlayerRecord(ClubOwnerPlayerRecordDTO dto) throws Exception {
        try {
            mapper.updatePlayerRecord(dto);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void deletePlayerRecord(Long recordId) throws Exception {
        try {
            mapper.deletePlayerRecord(recordId);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}