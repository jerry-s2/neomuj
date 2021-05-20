package com.neomuj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.neomuj.domain.CartVO;
import com.neomuj.domain.CartVOList;
import com.neomuj.dto.CartDTO;

public interface CartMapper {

	// 장바구니 추가
	public void add_cart(CartVO vo) throws Exception;
	
	// 장바구니 리스트
	public List<CartVOList> list_cart (String mem_id) throws Exception;

	// 전체삭제 (구매 후 사라짐)					
	public void cartAll_delete(String mem_id) throws Exception;
	
	// 개별 삭제
	public void cart_clean(long cart_code) throws Exception;
	
	// 수량 변경
	public void cart_modify(@Param("cart_amount") int cart_amount, @Param("cart_code") long cart_code) throws Exception;
	
	public void cart_check_delete(List<Integer> checkArr) throws Exception;
	
	public List<CartDTO> cart_money() throws Exception;
	
	public void cart_not_check_delete(List<Integer> checkArr) throws Exception;
	
	
}
