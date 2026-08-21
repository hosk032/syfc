package com.syfc.service;

import java.util.List;

import com.syfc.dto.BallDTO;
import com.syfc.dto.MemberBallmainDTO;
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

	@Override
	public List<BallDTO> findEligibleBalls(int playedMatchCount) {
		
		return mapper.findEligibleBalls(playedMatchCount);
	}

	@Override
	public int insertProfileBall(MemberBallmainDTO dto) {
		
		return mapper.insertProfileBall(dto);
	}

	@Override
	public int updateProfileBall(MemberBallmainDTO dto) {
		
		return mapper.updateProfileBall(dto);
	}


}
