package com.syfc.service;

import java.util.List;
import com.syfc.dto.ClubApprovalDTO;

public interface ClubApprovalService {
    // 1. 대기 중인 입단 신청 목록 조회
    List<ClubApprovalDTO> getPendingApprovalList(Long clubOwnerKey);
    
    // 2. 입단 승인 처리 (상태 변경 및 선수 테이블 INSERT)
    boolean approvePlayer(Long applyNum);
    
    // 3. 입단 반려 처리 (상태 변경 및 반려 사유 저장)
    boolean rejectPlayer(Long applyNum, String rejectReason);
}