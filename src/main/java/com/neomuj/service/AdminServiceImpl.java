package com.neomuj.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neomuj.domain.AdminVO;
import com.neomuj.mapper.AdminMapper;

import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Setter(onMethod_ = @Autowired)
	private AdminMapper adminMapper;

	@Override
	public AdminVO login_check(AdminVO vo) throws Exception {
		
		AdminVO adVO = adminMapper.login_check(vo);
		
		if(adVO != null) {
			adminMapper.login_update(vo.getAdmin_id()); // 로그인 시간 업데이트 
		}
		
		return adVO; // 이전 로그인 시간 정보 
	}

}
