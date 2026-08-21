package com.syfc.mapper;

import java.util.List;
import com.syfc.dto.ClubOwnerPlayerRecordDTO;

public interface ClubOwnerPlayerRecordMapper {
    // 구단 소속 선수들의 경기 성적 목록 조회
    List<ClubOwnerPlayerRecordDTO> getPlayerRecordList(Long clubOwnerKey) throws Exception;
    
    // 선수 경기 성적 등록
    void insertPlayerRecord(ClubOwnerPlayerRecordDTO dto) throws Exception;
    
    // 선수 경기 성적 수정
    void updatePlayerRecord(ClubOwnerPlayerRecordDTO dto) throws Exception;
    
    // 선수 경기 성적 삭제
    void deletePlayerRecord(Long recordId) throws Exception;
}