package com.neomuj.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@AllArgsConstructor 	// @AllArgsConstructor 어노테이션은 모든 필드 값을 파라미터로 받는 생성자를 만들어 준다.
@NoArgsConstructor   	// @NoArgsConstructor 어노테이션은 파라미터가 없는 기본 생성자를 생성해준다.
public class CartVOList {
	
	private long cart_code;
	private String pdt_img;
	private String pdt_name;
	private int cart_amount;
	private long pdt_price;

}
