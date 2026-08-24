package com.syfc.service;

import com.syfc.dto.ClubDTO;
import com.syfc.mapper.ClubOwnerMapper;
import com.syfc.mybatis.support.MapperContainer;

public class ClubOwnerServiceImpl implements ClubOwnerService {
    private ClubOwnerMapper mapper = MapperContainer.get(ClubOwnerMapper.class);

    @Override
    public ClubDTO selectClubInfoByMemberIdx(long memberIdx) {
        ClubDTO dto = null;
        
        try {
            // 1. 회원 PK로 구단주 PK 조회
            Long clubOwnerKey = mapper.findClubOwnerKeyByMemberIdx(memberIdx);
            
            // 2. 구단주 PK로 구단 상세 정보 조회
            if (clubOwnerKey != null) {
                dto = mapper.selectClubInfo(clubOwnerKey);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return dto;
    }

    @Override
    public void updateClubInfo(ClubDTO dto) throws Exception {
        try {
            // 1. DTO에 clubOwner_key가 없다면 memberIdx로 조회하여 세팅하는 보완 로직
            if (dto.getClubOwner_key() == null) {
                // 만약 DTO에 memberIdx도 필요하다면 컨트롤러에서 전달받은 키를 활용
                throw new IllegalArgumentException("clubOwner_key가 null입니다. 등록할 수 없습니다.");
            }

            // 2. DB에 기존 구단 정보가 있는지 검사
            ClubDTO existing = mapper.selectClubInfo(dto.getClubOwner_key());

            if (existing == null) {
                // 구단 데이터가 없으면 신규 INSERT
                mapper.insertClubInfo(dto);
            } else {
                // 이미 존재하면 UPDATE
                mapper.updateClubInfo(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}