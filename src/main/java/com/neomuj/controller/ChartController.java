package com.neomuj.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.neomuj.dto.CartDTO;
import com.neomuj.service.CartService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@AllArgsConstructor
@RequestMapping("/chart/*")
public class ChartController {
	
	private CartService cartService;
	
	/*
	@ResponseBody
	@GetMapping("/chart_example")
	public ResponseEntity<String[][]> getChartDate(){
		
		ResponseEntity<String[][]> entity = null;
		
		String[][] chartData = null;
		
		try {
			
			// 장바구니 더미데이터 준비해서 실행
//			List<CartDTO> items = cartService.cart_money();
			
			// 데이터가 준비가 안 되어, 코드로 샘플 데이터 작업
			List<CartDTO> items = new ArrayList<CartDTO>();
			
			Random random = new Random();
			
			for(int i=0; i<5; i++) {
				CartDTO cart = new CartDTO();
				int price = random.nextInt(10000 - 1000 + 1) + 1000;
				cart.setAmount(price);
				cart.setPdt_name("전자제품" + i);
				
				items.add(cart);
			}
				
			
			
			JSONArray row = new JSONArray();
			
			JSONObject name = new JSONObject();
			name.put("상품명", "가격");
			
			row.add(name);
			
			for(CartDTO dto : items) {
				JSONObject cell = new JSONObject();
				cell.put(dto.getPdt_name(), dto.getAmount());
				
				row.add(cell);
			}
			
			for(int i=0; i<row.size(); i++) {
				
			}
			
			
			
			
			entity = new ResponseEntity<String[][]> (chartData, HttpStatus.OK);
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String[][]>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
	}
	*/
	
	@ResponseBody
	@GetMapping("/chart_example")
	public ResponseEntity<String> getChartDate2(){
		
		ResponseEntity<String> entity = null;
		
		List<CartDTO> items = new ArrayList<CartDTO>();
		
		Random random = new Random();
		
		for(int i=1; i<=5; i++) {
			CartDTO cart = new CartDTO();
			int price = random.nextInt(10000 - 1000 + 1) + 1000;
			cart.setAmount(price);
			cart.setPdt_name("전자제품" + i);
			
			items.add(cart);
			
		}
		
		/*
		 [
		  ['상품명', '가격'],
          ['전자제품1', 15000],
          ['전자제품2', 25000],
          ['전자제품3', 18000],
          ['전자제품4', 16500],
          ['전자제품5', 25000]
         ]
		 */
		
		String str = "[";
		str += "['상품명', '가격']";
		for(CartDTO dto : items) {
			str += "['";
			str += dto.getPdt_name();
			str += "',";
			str += dto.getAmount();
			str += "]";
		}
		
		str += "]";
		
		log.info(str);
		
		entity = new ResponseEntity<String>(str, HttpStatus.OK);
		
		
		return entity;
	
	}
	
	@GetMapping("/chart") // /chart/chart (뷰)
	public ModelAndView chart() {
		
		/*
		ModelAndView mv = new ModelAndView();
		mv.setViewName("jsp 파일명"); // 뷰
		mv.addObject("memberVO", "db에서 불러온 데이터"); // 모델작업
		
		return mv;
		*/
		
		return new ModelAndView("/chart/chart");
		
	}
	

}



