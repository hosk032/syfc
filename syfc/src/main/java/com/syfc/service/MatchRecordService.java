package com.syfc.service;

import java.util.List;

import com.syfc.dto.MatchRecordDTO;

public interface MatchRecordService {
	List<MatchRecordDTO> listMatchRecord(long memberIdx);
}
