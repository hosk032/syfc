package com.syfc.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.syfc.dto.ReplyBoardDTO;

public interface ReplyBoardService {
	public void insertReply(ReplyBoardDTO dto) throws Exception;
	public void updateReply(ReplyBoardDTO dto) throws Exception;
	public void deleteReply(Map<String, Object> map) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<ReplyBoardDTO> listReply(Map<String, Object> map);
	public ReplyBoardDTO findById(long reply_num);
	
}
