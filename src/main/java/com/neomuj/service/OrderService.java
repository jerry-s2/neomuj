package com.neomuj.service;

import java.util.List;

import com.neomuj.domain.OrderDetailListVO;
import com.neomuj.domain.OrderDetailVO;
import com.neomuj.domain.OrderVO;
import com.neomuj.dto.Criteria;
import com.neomuj.dto.OrderSaleDTO;


public interface OrderService {
	
	public void order_buy(OrderVO vo, String mem_id) throws Exception;
	
	public void orderDirect_buy(OrderVO vo, OrderDetailVO vo2) throws Exception;
	
	// 주문 리스트 
	public List<OrderVO> orderInfo_list(Criteria cri) throws Exception;
	
	// 주문 상품 개수 (페이징 기능에 사용)
	public int getTotalCountOrder(Criteria cri) throws Exception;

//	public List<OrderDetailVO> order_detail_info(String odr_code) throws Exception;
	
	public List<OrderDetailListVO> order_detail_list(long odr_code) throws Exception;
	
	public List<OrderSaleDTO> order_sale(String startDate, String endDate) throws Exception;
	

}
