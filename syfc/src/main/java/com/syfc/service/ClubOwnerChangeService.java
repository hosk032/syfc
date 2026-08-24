package com.syfc.service;

import java.util.List;
import java.util.Map;
import com.syfc.dto.ClubOwnerChangeDTO;

public interface ClubOwnerChangeService {
    // 1. 차기 구단주 선택용 선수 목록 조회
    public List<ClubOwnerChangeDTO> listTransferCandidates(Map<String, Object> map);

    // 2. 구단주 권한 위임 실행
    public boolean transferClubOwner(ClubOwnerChangeDTO dto) throws Exception;
}