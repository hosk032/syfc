package com.syfc.service;

import com.syfc.dto.ClubInfoDTO;
import com.syfc.mapper.MyClubInfoMapper;
import com.syfc.mybatis.support.MapperContainer;

public class MyClubInfoServiceImpl implements MyClubInfoService{
	private MyClubInfoMapper mapper = MapperContainer.get(MyClubInfoMapper.class);
	
	@Override
	public ClubInfoDTO MyClubInfo(long memberIdx) {

		return mapper.MyClubInfo(memberIdx);
	}

}
