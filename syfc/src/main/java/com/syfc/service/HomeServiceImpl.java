package com.syfc.service;

import java.util.List;

import com.syfc.dto.HomeDTO;
import com.syfc.mapper.HomeMapper;
import com.syfc.mybatis.support.MapperContainer;

public class HomeServiceImpl implements HomeService {
	private HomeMapper mapper = MapperContainer.get(HomeMapper.class);
	
	@Override
	public List<HomeDTO> selectHomeMatchList() {
		List<HomeDTO> list = null;

        try {
            list = mapper.selectHomeMatchList();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
	}

}
