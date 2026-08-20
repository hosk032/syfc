package com.syfc.service;

import java.util.List;

import com.syfc.dto.ClubOwnerPlayerDTO;
import com.syfc.mapper.ClubOwnerPlayerMapper;
import com.syfc.mybatis.support.MapperContainer;

public class ClubOwnerPlayerServiceImpl implements ClubOwnerPlayerService {

	private ClubOwnerPlayerMapper mapper = MapperContainer.get(ClubOwnerPlayerMapper.class);

	@Override
	public List<ClubOwnerPlayerDTO> getClubPlayerList(ClubOwnerPlayerDTO params) {
		List<ClubOwnerPlayerDTO> list = null;
		try {
			if (params != null && params.getClubOwner_key() != null) {
				list = mapper.getClubPlayerList(params);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int removePlayer(Long clubJoinNum) {
		int result = 0;
		try {
			if (clubJoinNum != null) {
				result = mapper.deletePlayer(clubJoinNum);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Double getClubAverageRating(Long clubOwnerKey) throws Exception {
		Double avgRating = 0.0;
		try {
			avgRating = mapper.getClubAverageRating(clubOwnerKey);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 평점 데이터가 없거나 null일 경우 안전하게 0.0 반환
		return avgRating != null ? avgRating : 0.0;
	}
}