package com.syfc.service;

import java.util.ArrayList;
import java.util.List;

import com.syfc.dto.ClubOwnerChangeDTO;
import com.syfc.mapper.ClubOwnerChangeMapper;
import com.syfc.mybatis.support.MapperContainer;

public class ClubOwnerChangeServiceImpl implements ClubOwnerChangeService {
	private ClubOwnerChangeMapper mapper = MapperContainer.get(ClubOwnerChangeMapper.class);

	@Override
	public List<ClubOwnerChangeDTO> listTransferCandidates(ClubOwnerChangeDTO dto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ClubOwnerChangeDTO> transferClubOwner(ClubOwnerChangeDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
}