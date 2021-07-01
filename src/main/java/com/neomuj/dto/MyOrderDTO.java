package com.neomuj.dto;

import java.util.Date;

import lombok.Data;

@Data
public class MyOrderDTO {
	
	private String mem_id;
	private long pdt_num;
	private long odr_code;
	private String pdt_img;
	private String pdt_name;
	private int odr_price;
	private int odr_amount;
	private Date odr_date;
	
	
}
