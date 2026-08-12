package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.BoardDTO;
import com.syfc.mapper.BoardMapper;
import com.syfc.mybatis.support.MapperContainer;
import com.syfc.util.MyUtil;

public class BoardServiceImpl implements BoardService {
	private BoardMapper mapper = MapperContainer.get(BoardMapper.class);
	private MyUtil util = new MyUtil();
	
	@Override
	public void insertboard(BoardDTO dto) throws Exception {
		try {
			mapper.insertboard(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

	@Override
	public void upadteboard(BoardDTO dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteboard(BoardDTO dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteListboard(List<Long> list) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<BoardDTO> listBoard(Map<String, Object> map) {
		List<BoardDTO> list = null;
		
		try {
			list = mapper.listBoard(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public BoardDTO findById(long num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BoardDTO findByPrev(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BoardDTO findByNext(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateHitCount(long num) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteboardFile(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<BoardDTO> listboardFile(long num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BoardDTO findByFileId(long fileNum) {
		// TODO Auto-generated method stub
		return null;
	}

	

}
