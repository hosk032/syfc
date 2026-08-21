package com.syfc.service;

import java.util.List;
import com.syfc.dto.ClubOwnerPlayerRecordDTO;

public interface ClubOwnerPlayerRecordService {
    List<ClubOwnerPlayerRecordDTO> getPlayerRecordList(Long clubOwnerKey) throws Exception;
    void insertPlayerRecord(ClubOwnerPlayerRecordDTO dto) throws Exception;
    void updatePlayerRecord(ClubOwnerPlayerRecordDTO dto) throws Exception;
    void deletePlayerRecord(Long recordId) throws Exception;
}