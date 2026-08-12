package com.syfc.mapper;

import java.util.List;
import java.util.Map;

import com.syfc.dto.BoardDTO;

public interface BoardMapper {
	public long boardDetailSeq();

	public void insertboard(BoardDTO dto) throws Exception;
	public void upadteboard(BoardDTO dto) throws Exception;
	public void deleteboard(BoardDTO dto) throws Exception;
	public void deleteListboard(List<Long> list) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	
	public BoardDTO findById(long num);
	public BoardDTO findByPrev(Map<String, Object> map);
	public BoardDTO findByNext(Map<String, Object> map);
	public void updateHitCount(long num) throws Exception;
	
	public void deleteboardFile(Map<String, Object> map) throws Exception;
	public List<BoardDTO> listboardFile(long num);
	public BoardDTO findByFileId(long fileNum);
}
