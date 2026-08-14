package com.syfc.service;

import java.util.List;
import java.util.Map;
import java.util.Random;

import com.syfc.dto.MemberDTO;
import com.syfc.mail.Mail;
import com.syfc.mail.MailSender;
import com.syfc.mapper.MemberMapper;
import com.syfc.mybatis.support.MapperContainer;
import com.syfc.mybatis.support.SqlSessionManager;

public class MemberServiceImpl implements MemberService {

	private MemberMapper mapper = MapperContainer.get(MemberMapper.class);

	@Override
	public MemberDTO loginMember(Map<String, Object> map) {
		MemberDTO dto = null;
		
		try {
			dto = mapper.loginMember(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return dto;
	}

	@Override
	public void insertMember(MemberDTO dto) throws Exception {
		try {
			
			mapper.insertMember1(dto);
			mapper.insertMember2(dto);
			
		} catch (Exception e) {
			// 트랜잭션 처리
			SqlSessionManager.setRollbackOnly();

			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateMember(MemberDTO dto) throws Exception {
		try {
			mapper.updateMember1(dto);
			mapper.updateMember2(dto);
		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();

			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateMemberLevel(Map<String, Object> map) throws Exception {
		try {
			mapper.updateMemberLevel(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteProfilePhoto(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteProfilePhoto(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteMember(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteMember1(map);
			mapper.deleteMember2(map);
		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();

			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public MemberDTO findById(String userId) {
		MemberDTO dto = null;
		
		dto = mapper.findById(userId);
		
		return dto;
	}
	
	@Override
	public void generatePwd(MemberDTO dto) throws Exception {
		//10자리 임시 패스워드 생성
		StringBuilder sb = new StringBuilder();
		Random rnd = new Random();
		MailSender mailSender = new MailSender();
		
		String s = "!@#$%^&*~-+ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghigklmnopqrstuvwxyz";
		for (int i = 0; i < 10; i++) {
			int n = rnd.nextInt(s.length());
			
			sb.append(s.substring(n, n+1));
		}
		
		//새로 만들어진 패스워드를 메일로 전송
		String result;
		result = "<span style='color:mediumblue;'>" + dto.getUserName() + "</span>님의 새로 발급된 임시 패스워드는 <b>"
				+ sb.toString() + "</b> 입니다. <br>" + "로그인 후 반드시 패스워드를 변경하시기 바랍니다.";
		
		Mail mail = new Mail();
		mail.setReceiverEmail(dto.getEmail());
		
		mail.setSenderEmail("zvvcxxz@gmail.com"); // 메일 설정한 이메일
		mail.setSenderName("관리자");
		mail.setSubject("임시 패스워드 발급");
		mail.setContent(result);
		
		boolean b = mailSender.mailSend(mail);
		
		if(b) {
			//테이블의 패스워드 변경
			dto.setUserPwd(sb.toString());
			mapper.updateMember1(dto);
		} else {
			throw new Exception("메일 전송 중 에러가 발생하였습니다.");
		
		}
	}

	@Override
	public List<MemberDTO> idFind(Map<String, Object> map) {
		List<MemberDTO> list = null;
		
		try {
			list = mapper.idFind(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


}
