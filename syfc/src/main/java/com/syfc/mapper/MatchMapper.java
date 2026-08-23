package com.syfc.mapper;

import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubMatchBoardDTO;
import com.syfc.dto.MatchApplyDTO;
import com.syfc.dto.StadiumDTO;

public interface MatchMapper {
		//1단계. 경기 출전 선수 모집 글 올리기
	public List<String> selectRegions(); // 지역 목록 조회
	public List<StadiumDTO> selectAvailableStadiums(Map<String, Object> param);
    // 날짜 + 지역 + 오전1/오후2 조건으로 이용 가능한 경기장 조회

	public Long findClubOwnerKey(int memberIdx);// memberIdx 로 clubOwner_key 찾기

	public int insertClubMatchBoard(ClubMatchBoardDTO dto);//경기 참가선수 모집 게시글 등록
	public int insertMatchApply(ClubMatchBoardDTO dto); // 경기 신청 정보 등록
	public List<MatchApplyDTO> listWaitingMatches(Map<String, Object> param);
    
		//2단계. 출전 선수 모집 게시판, 게시글 상세 페이지
	public List<ClubMatchBoardDTO> listMatchBoard(Map<String, Object> map);//글리스트
	public ClubMatchBoardDTO findMatchBoardDetail(Long cmb_num);//게시글페이지
	public int updateHitCount(Long cmb_num);

	public List<ClubMatchBoardDTO> listApplicants(Long cmb_num); //출전신청선수목록
	public int countApplicants(Long cmb_num);

	public ClubMatchBoardDTO findMyRequest(Map<String, Object> map); //내신청결과

	public int insertMatchRequest(Map<String, Object> map); //선수 참가신청
	public int deleteMatchRequest(Map<String, Object> map); //선수 참가신청 취소

	public int approveMatchRequest(Map<String, Object> map);// 구단주가 신청 선수 승인
	public int rejectMatchRequest(Map<String, Object> map);// 구단주가 신청 선수 반려

	public Long findClubOwnerByMemberIdx(int memberIdx);
		// 현재 로그인한 사용자가 해당 게시글의 구단주인지 확인
	public Long findClubJoinNumByMemberIdx(int memberIdx);
		// 현재 로그인한 사용자의 clubJoin_num 조회
	public Long findBoardOwner(Long cmb_num); // 게시글의 구단주 번호
	public int cancelMatchByOwner(Map<String, Object> map);// 구단주가 자신의 모집글을 취소

	//////////////////////////
    // 3단계 : 우리 구단의 경기 신청 이력  	
	public Long findClubOwnerKeyByMemberIdx(int memberIdx);//선수의 clubOwner_key 조회
	public Long findOwnerKeyByMemberIdx(int memberIdx);//구단주의 clubOwner_key 조회
    	//선수/구단주의 경기 신청 이력 조회
	public List<MatchApplyDTO> listMatchHistory(Map<String, Object> map);
	public MatchApplyDTO findMatchForDecision(Long applyId);

	public int acceptOpponent(Map<String, Object> map);//홈 구단주가 상대팀 신청을 수락
    	//수락한 상대팀을 제외한 나머지 상대팀 신청 거절 (status 6으로 돌리는 것)
	public int rejectOtherOpponents(Map<String, Object> map);
	public int rejectOpponent(Map<String, Object> map);//특정 상대팀 신청 거절
	public int cancelMatch(Map<String, Object> map); //경기매칭취소
	
	public String findClubName(Long clubOwnerKey); //취소처리시 구단명조회
	public Long findHomeOwnerKey(Long applyId);//현재 매칭의 홈 구단주 번호 조회
	public Long findAwayOwnerKey(Long applyId);//현재 매칭의 원정 구단주 번호 조회
    
    	//원정팀 신청에 사용할 기존 매칭 정보 조회
    public MatchApplyDTO findMatchForAwayApply(Map<String, Object> map);
    
    	//이미 해당 매칭에 원정팀으로 신청했는지
    public int countAwayApply(Map<String, Object> map);
    	//기존 홈팀과 동일한 팀이 원정팀으로 신청하는지
    public int countSameClubApply(Map<String, Object> map);
    public int insertAwayMatchApply(MatchApplyDTO dto);//원정팀 매칭 신청
    
    //홈/원정 통합 경기신청 이력
    public List<MatchApplyDTO> listMyMatchApply(Map<String, Object> param);
    
    	//선수 본인의 출전신청 이력
    public List<ClubMatchBoardDTO> listMyMatchRequest(Map<String, Object> param);
    
    //경기일까지 매칭안됐을 시 status 5(매칭실패)로 돌리기
    int cancelExpiredWaitingMatches(); 

}

