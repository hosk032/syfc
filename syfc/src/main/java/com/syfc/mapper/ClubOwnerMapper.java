package com.syfc.mapper;

import com.syfc.dto.ClubDTO;
import com.syfc.dto.TeamRecordDTO;

public interface ClubOwnerMapper {

	// 1. 회원 PK(memberIdx)로 구단주 PK(clubOwner_key) 조회
	// 로그인한 세션의 memberIdx를 이용해 사용자가 구단주인지 확인하고 PK를 가져옴
	public Long findClubOwnerKeyByMemberIdx(Long memberIdx);
	
	// 2. 구단주 PK로 구단 상세 정보 조회 (화면 데이터 바인딩용)
	// 마이페이지 탭 진입 시 기존에 등록된 구단 정보를 불러와 폼에 뿌려주기 위해 사용
	public ClubDTO selectClubInfo(Long clubOwnerKey);
	
	// 3. 구단주 PK로 구단 정보 조회 (중복 메서드 - 추후 selectClubInfo 하나로 통일 예정)
	ClubDTO selectClubInfoByOwnerKey(Long clubOwnerKey);
	
	// 4. 구단 정보 수정 (이름, 연고지, 로고, 창단일 등)
	// 사용자가 수정 폼에서 입력한 데이터를 DTO로 넘겨 DB를 UPDATE (성공 시 수정된 행 수 반환)
	public int updateClubInfo(ClubDTO dto);
	
	// 5. 구단 팀 성적 조회 (승/무/패, 승률 등)
	// 마이페이지 메인 또는 성적 탭에서 팀의 최근 기록을 보여주기 위해 사용
	public TeamRecordDTO selectTeamRecord(Long clubOwnerkey);

}