package com.syfc.service;

import java.util.List;
import java.util.Map;
import com.syfc.dto.ClubOwnerChangeDTO;
import com.syfc.mapper.ClubOwnerChangeMapper;
import com.syfc.mybatis.support.MapperContainer;

public class ClubOwnerChangeServiceImpl implements ClubOwnerChangeService {
    private ClubOwnerChangeMapper mapper = MapperContainer.get(ClubOwnerChangeMapper.class);

    @Override
    public List<ClubOwnerChangeDTO> listTransferCandidates(Map<String, Object> map) {
        try {
            return mapper.listTransferCandidates(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean transferClubOwner(ClubOwnerChangeDTO dto) throws Exception {
        try {
            // 1. 현재 구단주 비밀번호 검증
            String realPwd = mapper.getOwnerPassword(dto.getMemberIdx());
            if (realPwd == null || !realPwd.equals(dto.getUserPwd())) {
                return false;
            }

            // 2. 권한 위임 3단계 실행
            mapper.updateClubOwner(dto);        // clubOwner 테이블 주인 교체
            mapper.updateOwnerToMember(dto);    // 기존 구단주 -> 일반회원(1)
            mapper.updatePlayerToOwner(dto);   // 신규 구단주 -> 구단주(50)

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}