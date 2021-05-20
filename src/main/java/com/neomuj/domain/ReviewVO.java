package com.neomuj.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {
	
	private long rv_num;
	private String mem_id;
	private long pdt_num;
	private String rv_content;
	private int rv_score;
	private Date rv_date_reg;

}
