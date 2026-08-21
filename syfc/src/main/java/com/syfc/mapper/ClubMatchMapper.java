package com.syfc.mapper;

import java.util.List;
import java.util.Map;

import com.syfc.dto.ClubOwnerMatchDTO;

public interface ClubMatchMapper {

	List<ClubOwnerMatchDTO> selectAllMatchList(Map<String, Object> map);
}
