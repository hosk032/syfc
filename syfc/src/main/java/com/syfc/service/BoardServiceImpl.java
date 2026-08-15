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
	public BoardDTO findById(long bnum) {
		BoardDTO dto = null;
		
		try {
			dto = mapper.findById(bnum);
			
			if(dto != null) {
				dto.setUserName(util.nameMasking(dto.getUserName()));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public BoardDTO findByPrev(Map<String, Object> map) {
		BoardDTO dto = null;
		
		try {
			dto = mapper.findByPrev(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public BoardDTO findByNext(Map<String, Object> map) {
		BoardDTO dto = null;
		
		try {
			dto = mapper.findByNext(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public boolean isUserBoardLiked(Map<String, Object> map) {
		boolean result = false;
		
		try {
			BoardDTO dto = mapper.hasUserBoardLiked(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public void insertBoardLike(Map<String, Object> map) throws Exception {
		try {
			mapper.insertBoardLike(map);
		} catch (Exception e) {
			e.printStackTrace();

			throw e;
		}
		
	}
	
	@Override
	public void deleteBoardLike(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteBoardLike(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public int boardLikeCount(long bnum) {
		int result = 0;
		
		try {
			result = mapper.boardLikeCount(bnum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	@Override
	public void updateHitCount(long bnum) throws Exception {
		try {
			mapper.updateHitCount(bnum);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

	@Override
	public void deleteboardFile(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<BoardDTO> listboardFile(long bnum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BoardDTO findByFileId(long filebnum) {
		// TODO Auto-generated method stub
		return null;
	}


	

	

}
