package com.neomuj.domain;

import lombok.Data;

@Data
public class OrderDetailListVO {
	
	private long odr_code;
	private long pdt_num;
	private int odr_amount;
	private int odr_price;
	
	private String pdt_name;
	private String pdt_img;

}
