package com.syfc.mapper;

import java.util.List;
import java.util.Map;
import com.syfc.dto.ClubOwnerMatchDTO;

public interface ClubOwnerMatchMapper {

    // 1. 전체 조회용
    List<ClubOwnerMatchDTO> selectClubMatchList(Long clubOwnerKey);

    // 2. 동적 검색용
    List<ClubOwnerMatchDTO> selectClubMatchListByMap(Map<String, Object> map);

}