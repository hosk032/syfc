package com.syfc.service;

import com.syfc.dto.BallDTO;

public interface BallService {
	public BallDTO findMainBall(long memberIdx);
	public BallDTO findBallByIdx(long ball_idx);
}
