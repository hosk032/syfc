package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.ReplyBoardDTO;
import com.syfc.mapper.ReplyBoardMapper;
import com.syfc.mybatis.support.MapperContainer;

public class ReplyBoardServiceImpl implements ReplyBoardService {
	private ReplyBoardMapper mapper = MapperContainer.get(ReplyBoardMapper.class);
	
	@Override
	public void insertReply(ReplyBoardDTO dto) throws Exception {
		try {
			mapper.insertReply(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public void updateReply(ReplyBoardDTO dto) throws Exception {
		try {
			mapper.updateReply(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			
			mapper.deleteReply(map);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int  result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<ReplyBoardDTO> listReply(Map<String, Object> map) {
		List<ReplyBoardDTO> list = null;
		
		try {
			list = mapper.listReply(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public ReplyBoardDTO findById(long reply_num) {
		ReplyBoardDTO dto = null;
		
		try {
			dto = mapper.findById(reply_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
		
	}


}
