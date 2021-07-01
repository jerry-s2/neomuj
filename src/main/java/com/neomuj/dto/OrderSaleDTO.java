package com.neomuj.dto;

import java.util.Date;

import lombok.Data;


@Data
public class OrderSaleDTO {
	

	private Date dat;
	private String day;
	private int cnt;
	private int price;

}
