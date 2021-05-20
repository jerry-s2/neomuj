package com.neomuj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neomuj.domain.OrderDetailVO;
import com.neomuj.domain.OrderVO;
import com.neomuj.domain.OrderDetailListVO;
import com.neomuj.dto.Criteria;
import com.neomuj.dto.OrderSaleDTO;
import com.neomuj.mapper.CartMapper;
import com.neomuj.mapper.OrderMapper;

import lombok.Setter;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Setter(onMethod_ = @Autowired)
	private OrderMapper orderMapper;
	
	@Setter(onMethod_ = @Autowired) 
	private CartMapper cartMapper;
	
	// 트랜잭션처리
	@Transactional
	@Override
	public void order_buy(OrderVO vo, String mem_id) throws Exception {
		// TODO Auto-generated method stub
		orderMapper.order_add(vo);
		orderMapper.orderDetail_add(vo.getOdr_code(), mem_id);
		cartMapper.cartAll_delete(mem_id);
		
	}

	@Transactional
	@Override					// 주문 		주문 상세
	public void orderDirect_buy(OrderVO vo, OrderDetailVO vo2) throws Exception {
		// TODO Auto-generated method stub
		orderMapper.order_add(vo);	// 파라미터가 참조형(주소값)으로 전달되기 때문에 
		vo2.setOdr_code(vo.getOdr_code());
		orderMapper.orderDirect_add(vo2);
		
	}

	@Override
	public List<OrderVO> orderInfo_list(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.orderInfo_list(cri);
	}

	@Override
	public int getTotalCountOrder(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.getTotalCountOrder(cri);
	}

	@Override
	public List<OrderDetailListVO> order_detail_list(long odr_code) throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.order_detail_list(odr_code);
	}

	@Override
	public List<OrderSaleDTO> order_sale(String startDate, String endDate) throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.order_sale(startDate, endDate);
	}


//	@Override
//	public List<OrderDetailVO> order_detail_info(String odr_code) throws Exception {
//		// TODO Auto-generated method stub
//		return orderMapper.order_detail_info(odr_code);
//	}

	



}
