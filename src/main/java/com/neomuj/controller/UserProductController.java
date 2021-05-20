package com.neomuj.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neomuj.domain.CategoryVO;
import com.neomuj.domain.ProductVO;
import com.neomuj.dto.Criteria;
import com.neomuj.service.UserProductService;
import com.neomuj.util.FileUploadUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/product/*")
public class UserProductController {

	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Setter(onMethod_ = @Autowired)
	private UserProductService userProductServie;
	
	@ResponseBody
	@GetMapping("/subCategoryList/{cg_code}")
	public ResponseEntity<List<CategoryVO>> subCategoryList(@PathVariable("cg_code") String cg_code) throws Exception{
		
		log.info("subCategoryList: " + cg_code);
		
		ResponseEntity<List<CategoryVO>> entity = null;
		
		try {
			entity = new ResponseEntity<List<CategoryVO>>(userProductServie.getSubCategoryList(cg_code), HttpStatus.OK);
		}catch(Exception e) {
			entity = new ResponseEntity<List<CategoryVO>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	//2차카테고리에 의한 상품목록정보
	@GetMapping("/product_list")
	public String productListBysubCate(@ModelAttribute("cri") Criteria cri,String  cg_code, Model model ) throws Exception{
		
		log.info("productListBysubCate: " + cg_code);
		
		log.info("Criteria: " + cri);
		
		cri.setAmount(9); // 상품출력 개수설정.
		
		model.addAttribute("productVOList", userProductServie.getProductListBysubCate(cri, cg_code));
		
		return "/product/product_list";
	}
	
	//상품이미지 뷰
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception{
		
		
		return FileUploadUtils.getFile(uploadPath, fileName);
		
	}
	
	//상품상세설명(상품조회)
	@GetMapping("/product_read")
	public void product_read(@RequestParam("pdt_num") long pdt_num, Model model) throws Exception{
		
		log.info("product_read: " + pdt_num);
		
		ProductVO vo = userProductServie.getProductByNum(pdt_num);
		vo.setPdt_img(FileUploadUtils.thumbToOriginName(vo.getPdt_img()));
		// 기본이미지를 설정작업
		
		model.addAttribute("productVO", vo);
	}
	
	
}
