package com.syfc.service;

import com.syfc.dto.BallDTO;
import com.syfc.mapper.BallMapper;
import com.syfc.mybatis.support.MapperContainer;

public class BallServiceImpl implements BallService {
	private BallMapper mapper = MapperContainer.get(BallMapper.class);
	
	@Override
	public BallDTO findMainBall(long memberIdx) {
		
		return mapper.findMainBall(memberIdx);
	}

	@Override
	public BallDTO findBallByIdx(long ball_idx) {
		
		return mapper.findBallByIdx(ball_idx);
	}

}
