package com.syfc.mapper;

import java.util.List;

import com.syfc.dto.BallDTO;

public interface BallMapper {
	public BallDTO findMainBall(long memberIdx);
	
	public BallDTO findBallByIdx(long ball_idx);
	
	List<BallDTO> findEligibleBalls(int playedMatchCount);
}
