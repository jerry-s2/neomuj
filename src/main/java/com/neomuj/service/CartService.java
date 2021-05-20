package com.neomuj.service;

import java.util.List;

import org.json.simple.JSONObject;

import com.neomuj.domain.CartVO;
import com.neomuj.domain.CartVOList;
import com.neomuj.dto.CartDTO;

public interface CartService {

	// 장바구니 추가
	public void add_cart(CartVO vo) throws Exception;
	
	public List<CartVOList> list_cart (String mem_id) throws Exception;
	
	// 장바구니 개별 삭제
	public void cart_clean(long cart_code) throws Exception;
	
	// 장바구니 수량 변경
	public void cart_modify(int cart_amount, long cart_code) throws Exception;
	
	public void cartAll_delete(String mem_id) throws Exception;
	
	public void cart_check_delete(List<Integer> checkArr) throws Exception;
	
	public List<CartDTO> cart_money() throws Exception;
	
	public JSONObject getChartData();

	public void cart_not_check_delete(List<Integer> checkArr) throws Exception;
	
}

