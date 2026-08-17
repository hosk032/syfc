package com.syfc.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.syfc.dto.ReplyBoardDTO;

public interface ReplyBoardMapper {
	public void insertReply(ReplyBoardDTO dto) throws SQLException;
	public void updateReply(ReplyBoardDTO dto) throws SQLException;
	public void deleteReply(Map<String, Object> map) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<ReplyBoardDTO> listReply(Map<String, Object> map);
	public ReplyBoardDTO findById(long reply_num);
}
