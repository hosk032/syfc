package com.syfc.dto;

public interface PlayerMapper {
	// 로그인 세션에서 회원번호로 정보를 가져옴
	PlayerMypageDTO findPlayerProfile(long memberIdx);
}
