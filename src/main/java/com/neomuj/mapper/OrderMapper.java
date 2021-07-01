package com.neomuj.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.neomuj.domain.OrderDetailListVO;
import com.neomuj.domain.OrderDetailVO;
import com.neomuj.domain.OrderVO;
import com.neomuj.dto.ChartDTO;
import com.neomuj.dto.Criteria;
import com.neomuj.dto.OrderSaleDTO;

public interface OrderMapper {
	
	// 주문정보
	public void order_add(OrderVO vo) throws Exception;
	
	// 주문 상세정보 (주문내역)
	public void orderDetail_add(@Param("odr_code") long odr_code, @Param("mem_id") String mem_id) throws Exception;
	
	public void orderDirect_add(OrderDetailVO vo) throws Exception;
	
	// 주문 리스트 
	public List<OrderVO> orderInfo_list(Criteria cri) throws Exception;
	
	// 주문 상품 개수 (페이징 기능에 사용)
	public int getTotalCountOrder(Criteria cri) throws Exception;
	
	// public List<OrderDetailVO> order_detail_info(long odr_code) throws Exception;
	
	public List<OrderDetailListVO> order_detail_list(long odr_code) throws Exception;
	
	public List<OrderSaleDTO> order_sale(@Param("startDate") String startDate, @Param("endDate") String endDate) throws Exception;
	
	public List<ChartDTO> salesChart() throws Exception;
	
}
