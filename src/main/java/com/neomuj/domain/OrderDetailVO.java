package com.neomuj.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderDetailVO {
	

	

	// odr_code, pdt_num, odr_amount, odr_price
	private long odr_code; // 
	private long pdt_num;
	private int odr_amount;
	private int odr_price;
	
	// 여기에 이미지와 상품 이름 필드를 추가시켜도 되고 새로운 VO 를 만들어도 된다. 
	
//	private String pdt_name;
//	private String pdt_img;

}
