package com.syfc.mapper;

import java.util.List;
import java.util.Map;

import com.syfc.dto.QnaDTO;

public interface QnaMapper {
	public void insertQna(QnaDTO dto) throws Exception;
	public void updateQna(QnaDTO dto) throws Exception;
	public void deleteQna(Map<String, Object> map) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<QnaDTO> listQna(Map<String, Object> map);
	public QnaDTO findById(long qna_num);
}
