package com.neomuj.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ProductVO {

	/*
pdt_num, cg_code, cg_code_prt, pdt_name, pdt_price, pdt_discount, pdt_company, pdt_detail, pdt_img, pdt_amount, pdt_buy, pdt_date_sub, pdt_date_up 
	 */
	
	private int pdt_num;
	private String cg_code;
	private String cg_code_prt;
	private String pdt_name;
	private int	pdt_price;
	private int pdt_discount;
	private String pdt_company;
	private String pdt_detail;
	private String pdt_img;
	private int pdt_amount;
	private String pdt_buy;
	private Date pdt_date_sub;
	private Date pdt_date_up;
	
	//파일첨부 파라미터작업
	private MultipartFile file1;
}
