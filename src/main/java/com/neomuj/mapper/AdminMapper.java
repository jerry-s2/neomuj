package com.neomuj.mapper;

import com.neomuj.domain.AdminVO;

public interface AdminMapper {
	
	public AdminVO login_check(AdminVO vo) throws Exception;
	
	public void login_update(String admin_id) throws Exception;
	
	

}
