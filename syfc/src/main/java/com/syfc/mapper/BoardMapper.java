package com.syfc.mapper;

import java.sql.SQLException;
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
	public List<BoardDTO> listBoard(Map<String, Object> map);
	
	public BoardDTO findById(long bnum);
	public BoardDTO findByPrev(Map<String, Object> map);
	public BoardDTO findByNext(Map<String, Object> map);
	public void updateHitCount(long bnum) throws Exception;
	
	public BoardDTO hasUserBoardLiked(Map<String, Object> map);
	public void insertBoardLike(Map<String, Object> map) throws SQLException;
	public void deleteBoardLike(Map<String, Object> map) throws SQLException;
	public int boardLikeCount(long bnum);
	
	public void deleteboardFile(Map<String, Object> map) throws Exception;
	public List<BoardDTO> listboardFile(long bnum);
	public BoardDTO findByFileId(long filebnum);
}
