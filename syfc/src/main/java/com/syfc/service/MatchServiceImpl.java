package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubMatchBoardDTO;
import com.syfc.dto.MatchApplyDTO;
import com.syfc.dto.StadiumDTO;
import com.syfc.mapper.MatchMapper;
import com.syfc.mybatis.support.MapperContainer;
import com.syfc.mybatis.support.SqlSessionManager;

public class MatchServiceImpl implements MatchService {
	private MatchMapper mapper = MapperContainer.get(MatchMapper.class);

	@Override
	public List<String> selectRegions() {
		return mapper.selectRegions();
	}

	@Override
	public List<StadiumDTO> selectAvailableStadiums(Map<String, Object> param) {
		 return mapper.selectAvailableStadiums(param);
	}
	
    public void insertMatchPost(ClubMatchBoardDTO dto) throws Exception {
    	// 경기 참가 선수 모집글 + Match_Apply 등록
        Long clubOwnerKey = mapper.findClubOwnerKey( dto.getMemberIdx() );
        if (clubOwnerKey == null) {
            throw new Exception(
                "구단주 정보를 찾을 수 없습니다."
            );
        }
        try {
			
        	dto.setClubOwner_key(clubOwnerKey);
            int boardResult = mapper.insertClubMatchBoard(dto);
            if (boardResult != 1) {
                throw new Exception(
                    "경기 참가 선수 모집글 등록 실패"
                );
            }

            int applyResult = mapper.insertMatchApply(dto);
            if (applyResult != 1) {
                throw new Exception(
                    "경기 신청 정보 등록 실패"
                );
            }
			
		} catch (Exception e) {
			// 트랜잭션 처리
			SqlSessionManager.setRollbackOnly();

			e.printStackTrace();
			throw e;
		}
        
    }
    
    @Override
    public List<ClubMatchBoardDTO> listMatchBoard(Map<String, Object> map) {
        return mapper.listMatchBoard(map);
    }

    @Override
    public ClubMatchBoardDTO findMatchBoardDetail(Long cmb_num) {
        return mapper.findMatchBoardDetail(cmb_num);
    }

    @Override
    public int updateHitCount(Long cmb_num) {
        return mapper.updateHitCount(cmb_num);
    }
    
    @Override
    public List<MatchApplyDTO> listWaitingMatches(Map<String, Object> param) {
        return mapper.listWaitingMatches(param);
    }

    @Override
    public List<ClubMatchBoardDTO> listApplicants(Long cmb_num) {
        return mapper.listApplicants(cmb_num);
    }

    @Override
    public int countApplicants(Long cmb_num) {
        return mapper.countApplicants(cmb_num);
    }

    @Override
    public ClubMatchBoardDTO findMyRequest(Map<String, Object> map) {
        return mapper.findMyRequest(map);
    }

    @Override
    public int insertMatchRequest(Map<String, Object> map) {
        return mapper.insertMatchRequest(map);
    }

    @Override
    public int deleteMatchRequest(Map<String, Object> map) {
        return mapper.deleteMatchRequest(map);
    }

    @Override
    public int approveMatchRequest(Map<String, Object> map) {
        return mapper.approveMatchRequest(map);
    }

    @Override
    public int rejectMatchRequest(Map<String, Object> map) {
        return mapper.rejectMatchRequest(map);
    }

    @Override
    public int cancelMatchByOwner(Map<String, Object> map) {
        return mapper.cancelMatchByOwner(map);
    }
    
    @Override
    public Long findClubJoinNumByMemberIdx(int memberIdx) {
        return mapper.findClubJoinNumByMemberIdx(memberIdx);
    }

    @Override
    public Long findClubOwnerByMemberIdx(int memberIdx) {
        return mapper.findClubOwnerByMemberIdx(memberIdx);
    }

    @Override
    public Long findBoardOwner(Long cmb_num) {
        return mapper.findBoardOwner(cmb_num);
    }
    
    @Override
    public Long findClubOwnerKeyByMemberIdx(int memberIdx) {
        return mapper.findClubOwnerKeyByMemberIdx(memberIdx);
    }

    @Override
    public Long findOwnerKeyByMemberIdx(int memberIdx) {
        return mapper.findOwnerKeyByMemberIdx(memberIdx);
    }

    @Override
    public List<MatchApplyDTO> listMatchHistory(Map<String, Object> map) {
        return mapper.listMatchHistory(map);
    }

    @Override
    public int acceptOpponent(Map<String, Object> map) {

        //선택한 상대팀 수락 &같은 cmb_num의 다른 상대팀 신청은 모두 거절 - 하나의 트랜젝션으로
        int result = mapper.acceptOpponent(map);
        if (result > 0) {
            mapper.rejectOtherOpponents(map);
        }
        return result;
    }


    @Override
    public int rejectOpponent(Map<String, Object> map) {
        return mapper.rejectOpponent(map);
    }
    
    @Override
    public MatchApplyDTO findMatchForDecision(Long applyId) {
        return mapper.findMatchForDecision(applyId);
    }

    @Override
    public int cancelMatch(Map<String, Object> map) {
        //cancel_reason은 Controller에서 "구단명 : 취소사유" 형태로 만들어 전달
        return mapper.cancelMatch(map);
    }

    @Override
    public String findClubName(Long clubOwnerKey) {
        return mapper.findClubName(clubOwnerKey);
    }

    @Override
    public Long findHomeOwnerKey(Long applyId) {
        return mapper.findHomeOwnerKey(applyId);
    }

    @Override
    public Long findAwayOwnerKey(Long applyId) {
        return mapper.findAwayOwnerKey(applyId);
    }

    @Override	//원정팀 매칭 신청
    public void applyAwayMatch(Map<String, Object> map) throws Exception {

        int memberIdx = (int) ((Number) map.get("memberIdx")).longValue();
        Long awayClubOwnerKey = mapper.findOwnerKeyByMemberIdx(memberIdx);

        if (awayClubOwnerKey == null) {
            throw new IllegalStateException(
                    "구단주 정보가 존재하지 않습니다."
            );
        }

        map.put("clubOwner_key2", awayClubOwnerKey);//이후 사용할 원정팀 구단주번호

        //기존 홈팀 매칭 조회
        MatchApplyDTO homeMatch = mapper.findMatchForAwayApply(map);
        if (homeMatch == null) {
            throw new IllegalStateException("신청할 수 있는 매칭이 존재하지 않습니다.");
        }      
        
        Long cmb_num = homeMatch.getCmb_num(); // 기존 경기의 모집글 번호
        if (cmb_num == null) {
            throw new IllegalStateException(
                    "해당 경기의 모집글 번호가 존재하지 않습니다."
            );
        }
        map.put("cmb_num", cmb_num); // 이후 countAwayApply()에서 사용할 값

        // 자기 구단이 홈팀인 경기인지 확인
        if (homeMatch.getClubOwner_key().equals(awayClubOwnerKey)) {
            throw new IllegalStateException(
                    "자신의 구단이 개설한 경기에 신청할 수 없습니다."
            );
        }

        //이미 같은 팀이 신청했는지 확인
        int alreadyApplied = mapper.countAwayApply(map);
        if (alreadyApplied > 0) {
            throw new IllegalStateException("이미 해당 경기에 신청했습니다.");
        }

        // 홈팀과 동일한 팀인지 다시 DB 기준으로 확인
        int sameClub = mapper.countSameClubApply(map);
        if (sameClub > 0) {
            throw new IllegalStateException(
                    "자신의 구단이 개설한 경기에는 신청할 수 없습니다."
            );
        }


        // 새 MatchApplyDTO 생성
        MatchApplyDTO dto = new MatchApplyDTO();

        //기존 홈팀 매칭 정보
        dto.setCmb_num(homeMatch.getCmb_num());
        dto.setApply_date(homeMatch.getApply_date());
        dto.setApply_time(homeMatch.getApply_time());
        dto.setStadium_id(homeMatch.getStadium_id());
        dto.setClubOwner_key(homeMatch.getClubOwner_key());
        dto.setMatch_type1(homeMatch.getMatch_type1());
        dto.setMatch_type2(homeMatch.getMatch_type2());
        dto.setStadium_fee(homeMatch.getStadium_fee());

        //신청한 원정팀
        dto.setClubOwner_key2(awayClubOwnerKey);

        //status는 XML에서 2로 set

        // 새 원정 신청 레코드 INSERT
        mapper.insertAwayMatchApply(dto);
    }
    
    @Override
    public List<MatchApplyDTO> listMyMatchApply(Map<String, Object> param) {
        return mapper.listMyMatchApply(param);
    }
    
    @Override
    public List<ClubMatchBoardDTO> listMyMatchRequest(Map<String, Object> param) {
       return mapper.listMyMatchRequest(param);
    }


}
