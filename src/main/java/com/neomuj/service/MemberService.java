package com.neomuj.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.neomuj.domain.MemberVO;
import com.neomuj.domain.OrderDetailListVO;
import com.neomuj.domain.OrderVO;
import com.neomuj.domain.UserInfoVO;
import com.neomuj.dto.Criteria;
import com.neomuj.dto.LoginDTO;
import com.neomuj.dto.MyOrderDTO;

public interface MemberService {

	//회원가입 저장
	public void join(MemberVO vo) throws Exception;
	
	public int checkIdDuplicate(String mem_id) throws Exception;
	
	public MemberVO login_ok(LoginDTO dto) throws Exception;
	
	// 회원수정 폼
	public MemberVO member_info(String mem_id) throws Exception;
	
	//회원수정 저장
	public boolean modifyPOST(MemberVO vo) throws Exception;
	
	//회원삭제
	public void member_delete(String mem_id) throws Exception;
	
	//아이디 찾기 : 화면출력
	public String find_id(String mem_name) throws Exception;
	
	//비밀번호 찾기
	public MemberVO find_pwd(String mem_id, String mem_name) throws Exception;
	
	public List<UserInfoVO> userinfo_list() throws Exception;
	
	public void pw_search(LoginDTO dto) throws Exception;
	
	public int modify_pw(MemberVO vo) throws Exception;
	
//	public List<OrderVO> myOrderInfo_list(Criteria cri) throws Exception;
//	
//	// 주문 상품 개수 (페이징 기능에 사용)
//	public int getTotalCountOrder(Criteria cri) throws Exception;
//
//	public List<OrderDetailListVO> myOrder_detail_list(long odr_code) throws Exception;
}
