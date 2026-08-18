package com.syfc.mapper;

import com.syfc.dto.PlayerMypageDTO;

// 쿼리를 사용할 수 있게 연결만 해주는 곳(1대1)
public interface PlayerProfileMapper {
	PlayerMypageDTO findByMemberIdx(long memberIdx);
	
	public void updateProfile(PlayerMypageDTO dto);

	PlayerMypageDTO selectProfile(long memberIdx);
	
	public void updateSelectProfile(PlayerMypageDTO dto);

	public void updateName(PlayerMypageDTO dto);
}

