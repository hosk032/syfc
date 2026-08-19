package com.syfc.mapper;

import java.util.List;
import com.syfc.dto.ClubOwnerPlayerDTO;

public interface ClubOwnerPlayerMapper {
    // 구단 소속 선수 목록 조회 (검색 및 포지션 필터링 포함)
    List<ClubOwnerPlayerDTO> getClubPlayerList(ClubOwnerPlayerDTO params);

    // 선수 제적(강퇴) 처리
    int deletePlayer(Long clubJoin_num);
}