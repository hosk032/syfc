package com.syfc.service;

import java.util.List;

import com.syfc.dto.ClubOwnerChangeDTO;

public interface ClubOwnerChangeService {
	   // 1. 차기 구단주 선택용 선수 목록 조회 (나 자신 제외)
    public List<ClubOwnerChangeDTO> listTransferCandidates(ClubOwnerChangeDTO dto);

    public List<ClubOwnerChangeDTO>transferClubOwner(ClubOwnerChangeDTO dto) throws Exception; 
}
