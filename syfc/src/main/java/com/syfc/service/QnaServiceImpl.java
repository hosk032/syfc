package com.syfc.service;

import java.util.List;
import java.util.Map;

import com.syfc.dto.QnaDTO;
import com.syfc.mapper.QnaMapper;
import com.syfc.mybatis.support.MapperContainer;
import com.syfc.util.MyUtil;

public class QnaServiceImpl implements QnaService {
	private QnaMapper mapper = MapperContainer.get(QnaMapper.class);
	private MyUtil util = new MyUtil();
	
	@Override
	public void insertQna(QnaDTO dto) throws Exception {
		try {
			mapper.insertQna(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

	@Override
	public void updateQna(QnaDTO dto) throws Exception {
		try {
			mapper.updateQna(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}

	@Override
	public void deleteQna(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteQna(map);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
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
	public List<QnaDTO> listQna(Map<String, Object> map) {
		List<QnaDTO> list = null;
		
		try {
			list = mapper.listQna(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public QnaDTO findById(long qna_num) {
		QnaDTO dto = null;
		
		try {
			dto = mapper.findById(qna_num);
			
			if(dto != null) {
				dto.setUserName(util.nameMasking(dto.getUserName()));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

}
