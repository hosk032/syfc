package com.syfc.mapper;

import java.util.List;

import com.syfc.dto.MatchRecordDTO;

public interface MatchRecordMapper {
	List<MatchRecordDTO> listMatchRecord(long memberIdx);
}
