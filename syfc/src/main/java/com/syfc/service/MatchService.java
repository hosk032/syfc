package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubMatchBoardDTO;
import com.syfc.dto.MatchApplyDTO;
import com.syfc.dto.StadiumDTO;

public interface MatchService {
	public List<String> selectRegions(); //지역 목록
	public List<StadiumDTO> selectAvailableStadiums(Map<String, Object> param);
	
	public void insertMatchPost(ClubMatchBoardDTO dto) throws Exception;
	
	public List<ClubMatchBoardDTO> listMatchBoard(Map<String, Object> map);
	public ClubMatchBoardDTO findMatchBoardDetail(Long cmb_num);
	public int updateHitCount(Long cmb_num);
	public List<MatchApplyDTO> listWaitingMatches(Map<String, Object> param);

    // 신청자
	public List<ClubMatchBoardDTO> listApplicants(Long cmb_num);
	public int countApplicants(Long cmb_num);
	public ClubMatchBoardDTO findMyRequest(Map<String, Object> map);

    // 선수 신청
	public int insertMatchRequest(Map<String, Object> map);
	public int deleteMatchRequest(Map<String, Object> map);

    // 구단주 처리
	public int approveMatchRequest(Map<String, Object> map);
	public int rejectMatchRequest(Map<String, Object> map);
	public int cancelMatchByOwner(Map<String, Object> map);
	
	public Long findClubJoinNumByMemberIdx(int memberIdx);
	public Long findClubOwnerByMemberIdx(int memberIdx);
	public Long findBoardOwner(Long cmb_num);
	
	////////////////////////
    
	public Long findClubOwnerKeyByMemberIdx(int memberIdx);
	public Long findOwnerKeyByMemberIdx(int memberIdx);
	public List<MatchApplyDTO> listMatchHistory(Map<String, Object> map);
	public int acceptOpponent(Map<String, Object> map);
	public int rejectOpponent(Map<String, Object> map);
	public int cancelMatch(Map<String, Object> map);
	public String findClubName(Long clubOwnerKey);
	public Long findHomeOwnerKey(Long applyId);
	public Long findAwayOwnerKey(Long applyId);
	public MatchApplyDTO findMatchForDecision(Long applyId);
	
	//원정팀 매칭 신청
	public void applyAwayMatch(Map<String, Object> map) throws Exception;
	public List<MatchApplyDTO> listMyMatchApply(Map<String, Object> map) throws Exception;
	int countMyMatchApply(Map<String, Object> map) throws Exception;
    
	public List<ClubMatchBoardDTO> listMyMatchRequest(Map<String, Object> param);
	
	int cancelExpiredWaitingMatches();
}
