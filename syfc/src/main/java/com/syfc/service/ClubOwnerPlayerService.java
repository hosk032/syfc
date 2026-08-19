package com.syfc.service;

import java.util.List;
import com.syfc.dto.ClubOwnerPlayerDTO;

public interface ClubOwnerPlayerService {
    // 소속 선수 목록 조회
    List<ClubOwnerPlayerDTO> getClubPlayerList(ClubOwnerPlayerDTO params);

    // 선수 제적(강퇴) 처리
    int removePlayer(Long clubJoinNum);
}