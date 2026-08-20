package com.syfc.service;

import java.util.List;

import com.syfc.dto.BallDTO;

public interface BallService {
	public BallDTO findMainBall(long memberIdx);
	
	public BallDTO findBallByIdx(long ball_idx);
	
	List<BallDTO> findEligibleBalls(int playedMatchCount);
}
