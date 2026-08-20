package com.syfc.service;

import java.util.List;

import com.syfc.dto.BallDTO;
import com.syfc.dto.MemberBallmainDTO;

public interface BallService {
	public BallDTO findMainBall(long memberIdx);
	
	public BallDTO findBallByIdx(long ball_idx);
	
	List<BallDTO> findEligibleBalls(int playedMatchCount);
	
	public int insertProfileBall(MemberBallmainDTO dto);
	
	public int updateProfileBall(MemberBallmainDTO dto);
}
