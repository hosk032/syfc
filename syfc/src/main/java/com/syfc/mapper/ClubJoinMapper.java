package com.syfc.mapper;

import java.util.List;

import com.syfc.dto.ClubJoinDTO;

public interface ClubJoinMapper {
	List<ClubJoinDTO> insertClubJoin(long memberIdx);
}
