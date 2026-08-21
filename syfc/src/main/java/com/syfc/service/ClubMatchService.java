package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubOwnerMatchDTO;

public interface ClubMatchService {

	List<ClubOwnerMatchDTO> selectAllMatchList(Map<String, Object> map);
}
