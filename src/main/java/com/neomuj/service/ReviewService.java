package com.neomuj.service;

import com.neomuj.domain.ReviewVO;
import com.neomuj.dto.Criteria;
import com.neomuj.dto.ReviewPageDTO;

public interface ReviewService {
	
	public ReviewPageDTO getReviewListWithPaging(Criteria cri, int pdt_num) throws Exception;

	public void review_register(ReviewVO vo) throws Exception;
	
	public void review_modify(ReviewVO vo) throws Exception;

	public void review_delete(int rv_num) throws Exception;

}
