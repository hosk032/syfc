package com.syfc.mapper;

import java.util.List;

import com.syfc.dto.HomeDTO;

public interface HomeMapper {
	
	List<HomeDTO> selectHomeMatchList();
}
