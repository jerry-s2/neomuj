package com.neomuj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.neomuj.domain.MemberVO;
import com.neomuj.domain.UserInfoVO;
import com.neomuj.dto.LoginDTO;

public interface MemberMapper {

	//회원가입 저장
	public void join(MemberVO vo) throws Exception;
	
	//아이디 중복체크
	public int checkIdDuplicate(String mem_id) throws Exception;
	
	// 인증
	public MemberVO login_ok(LoginDTO dto) throws Exception;
	
	// 회원수정 폼
	public MemberVO member_info(String mem_id) throws Exception;
	
	//회원수정 저장
	public int modifyPOST(MemberVO vo) throws Exception;
	
	//비밀번호 찾기 : 메일전송
	public MemberVO find_pwd(@Param("mem_id") String mem_id, @Param("mem_name") String mem_name) throws Exception;
	
	//아이디 찾기 : 화면출력
	public String find_id(String mem_name) throws Exception;
	
	// 회원 탈퇴
	public void member_delete(String mem_id) throws Exception;
	
	public List<UserInfoVO> userinfo_list() throws Exception;
	
	// 비밀번호 찾기
	public void pw_search(LoginDTO dto) throws Exception;
	
	// 비밀번호 변경
	public int modify_pw(MemberVO vo) throws Exception;
	
	
}
