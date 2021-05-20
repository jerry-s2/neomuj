package com.neomuj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neomuj.domain.MemberVO;
import com.neomuj.domain.UserInfoVO;
import com.neomuj.dto.LoginDTO;
import com.neomuj.mapper.MemberMapper;

import lombok.Setter;

@Service // bean name : memberServiceImpl
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Override
	public int checkIdDuplicate(String mem_id) throws Exception {
		// TODO Auto-generated method stub
		return mapper.checkIdDuplicate(mem_id);
	}

	@Override
	public MemberVO login_ok(LoginDTO dto) throws Exception {
		
		return mapper.login_ok(dto);
	}

	@Override
	public MemberVO member_info(String mem_id) throws Exception {
		// TODO Auto-generated method stub
		return mapper.member_info(mem_id);
	}

	@Override
	public boolean modifyPOST(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		return mapper.modifyPOST(vo) == 1;
	}

	@Override
	public void join(MemberVO vo) throws Exception {
		
		mapper.join(vo);		
	}

	@Override
	public MemberVO find_pwd(String mem_id, String mem_name) throws Exception {
		// TODO Auto-generated method stub
		return mapper.find_pwd(mem_id, mem_name);
	}

	@Override
	public String find_id(String mem_name) throws Exception {
		// TODO Auto-generated method stub
		return mapper.find_id(mem_name);
	}

	@Override
	public void member_delete(String mem_id) throws Exception {
		// TODO Auto-generated method stub
		mapper.member_delete(mem_id);
	}

	@Override
	public List<UserInfoVO> userinfo_list() throws Exception {
		// TODO Auto-generated method stub
		return mapper.userinfo_list();
	}

	@Override
	public void pw_search(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
		mapper.pw_search(dto);
		
	}

	@Override
	public int modify_pw(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		return mapper.modify_pw(vo);
	}

}
