package com.syfc.service;

import java.util.List;

import com.syfc.dto.BallDTO;
import com.syfc.dto.MemberBallpickDTO;
import com.syfc.mapper.MemberBallpickMapper;
import com.syfc.mybatis.support.MapperContainer;

public class MemberBallpickServiceImpl implements MemberBallpickService{
	private MemberBallpickMapper mapper = MapperContainer.get(MemberBallpickMapper.class);

	@Override
	public int insertMemberBallPick(MemberBallpickDTO dto) {

		return mapper.insertMemberBallPick(dto);
	}

	@Override
	public int countTodayPick(long memberIdx) {
		
		return mapper.countTodayPick(memberIdx);
	}

	@Override
	public List<BallDTO> findMemberBallCollection(long memberIdx) {
		
		return mapper.findMemberBallCollection(memberIdx);
	}

}
