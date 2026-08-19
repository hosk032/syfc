package com.syfc.mapper;

import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubOwnerMatchDTO;
import com.syfc.dto.ClubOwnerResultDTO;

public interface ClubOwnerMatchMapper {

	// -- 경기 이력 조회 메서드 --
    // 1. 전체 조회용
    List<ClubOwnerMatchDTO> selectClubMatchList(Long clubOwnerKey);

    // 2. 동적 검색용
    List<ClubOwnerMatchDTO> selectClubMatchListByMap(Map<String, Object> map);
	// -- 경기 이력 조회 메서드 --
    
    // -- 구단 경기 성적 등록 / 수정 / 삭제 메서드 --
    // 1. 구단의 전체 매치 목록 조회 ( 성적 등록 , 미등록 상태 포함 )
    List<ClubOwnerResultDTO> selectClubMatchResultList(Long clubNum);
    
    // 2. 선택한 경기의 성적(스코어) 등록 및 수정
    int updateMatchScore(Map<String,Object>paraMap);
    
    // 3. 등록된 성적(스코어) 삭제
    int deleteMatchScore(Long matchNum);
    
    
    // -- 구단 경기 성적 등록 / 수정 / 삭제 메서드 --
}