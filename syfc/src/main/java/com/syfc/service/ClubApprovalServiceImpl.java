package com.syfc.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.syfc.dto.ClubApprovalDTO;
import com.syfc.mapper.ClubApprovalMapper;
import com.syfc.mybatis.support.MapperContainer;

public class ClubApprovalServiceImpl implements ClubApprovalService {

    private ClubApprovalMapper mapper = MapperContainer.get(ClubApprovalMapper.class);

    @Override
    public List<ClubApprovalDTO> getPendingApprovalList(Long clubOwnerKey) {
        return mapper.selectPendingApprovalList(clubOwnerKey);
    }

    @Override
    public boolean approvePlayer(Long applyNum) {
        try {
            // 1. 신청 내역 조회 (회원 정보 및 포지션 정보 확인)
            ClubApprovalDTO dto = mapper.selectApprovalByNum(applyNum);
            
            if (dto != null) {
                // 2. 신청 상태를 1(승인)로 변경
                mapper.updateApproveStatus(applyNum);
                
                // 3. 구단 소속 선수(clubPlayer) 테이블에 등록
                mapper.insertClubPlayer(dto);
                
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean rejectPlayer(Long applyNum, String rejectReason) {
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("applyNum", applyNum);
            map.put("rejectReason", rejectReason);
            
            // 상태를 0(반려)으로 변경하고 사유 저장
            return mapper.updateRejectStatus(map) > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}