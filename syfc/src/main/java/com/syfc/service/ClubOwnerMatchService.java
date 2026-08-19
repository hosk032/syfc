package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubOwnerMatchDTO;
import com.syfc.dto.ClubOwnerResultDTO;

public interface ClubOwnerMatchService {
    List<ClubOwnerMatchDTO> getClubMatchList(Long clubOwnerKey);
    
    List<ClubOwnerMatchDTO> getClubMatchListByMap(Map<String, Object> map);
    
    List<ClubOwnerResultDTO> getClubMatchResultList(Long clubOwnerKey);

    // 스코어 저장/수정
    int updateMatchScore(Map<String, Object> map);

    // 스코어 삭제
    int deleteMatchScore(Long matchNum);
}