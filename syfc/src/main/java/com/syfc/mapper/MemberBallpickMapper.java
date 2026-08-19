package com.syfc.mapper;

import java.util.List;

import com.syfc.dto.BallDTO;
import com.syfc.dto.MemberBallpickDTO;

public interface MemberBallpickMapper {
	public int insertMemberBallPick(MemberBallpickDTO dto);
	public int countTodayPick(long memberIdx);
	public List<BallDTO> findMemberBallCollection(long memberIdx);
}
