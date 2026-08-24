package com.syfc.service;

import java.util.List;

import com.syfc.dto.HomeDTO;

public interface HomeService {
	List<HomeDTO> selectHomeMatchList();
}
