package com.syfc.mapper;

import java.util.List;
import java.util.Map;
import com.syfc.dto.ClubApprovalDTO;

public interface ClubApprovalMapper {

    // 1. 구단주 기준 입단 신청 대기 목록 조회 (clubJoin_result = 2)
    List<ClubApprovalDTO> selectPendingApprovalList(Long clubOwnerKey);

    // 2. 단건 신청 정보 조회 (승인 후 소속 선수 등록 시 활용)
    ClubApprovalDTO selectApprovalByNum(Long applyNum);

    // 3. 입단 승인 처리 (clubJoin_result -> 1)
    int updateApproveStatus(Long applyNum);

    // 4. 입단 거절/반려 처리 (clubJoin_result -> 0 및 반려 사유 저장)
    int updateRejectStatus(Map<String, Object> map);

    // 5. 승인된 선수를 구단 소속 선수(clubPlayer) 테이블에 추가
    int insertClubPlayer(ClubApprovalDTO dto);
}