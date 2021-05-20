package com.neomuj.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neomuj.domain.OrderDetailListVO;
import com.neomuj.dto.Criteria;
import com.neomuj.dto.PageDTO;
import com.neomuj.service.OrderService;
import com.neomuj.util.FileUploadUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin/order/*")
@Log4j
public class AdOrderController {

	@Setter(onMethod_ = @Autowired)
	private OrderService orderService;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	// 기능 용도에 맞게 주소를 만들어낼 수 있다. 중괄호를 이용해 주소를 여러개 만들 수 있다. "/order_list" -> GET, "/order_detail_list" -> POST
	// @RequestMapping(value = { "/order_list", "/order_detail_list" }, method = {RequestMethod.GET, RequestMethod.POST} )
	@RequestMapping(value = "/order_list", method = {RequestMethod.GET})
	public void order_list(@ModelAttribute("cri") Criteria cri, Model model) throws Exception{
		
		log.info("order_list: " + cri);
		
		model.addAttribute("order_list", orderService.orderInfo_list(cri));
		
		int total = orderService.getTotalCountOrder(cri);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		
	}
	
	@ResponseBody
	@RequestMapping(value="/displayFile", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception{
		
		
		return FileUploadUtils.getFile(uploadPath, fileName);
	}
	
//	@ResponseBody
//	@GetMapping("/order_detail_list/{odr_code}")
//	public ResponseEntity<List<OrderDetailVO>> order_list_detail(@PathVariable("odr_code") String odr_code) throws Exception{
//		
//		ResponseEntity<List<OrderDetailVO>> entity = null;
//
//
//		try {
//			entity = new ResponseEntity<List<OrderDetailVO>>(orderService.order_detail_info(odr_code) ,HttpStatus.OK);
//		}catch(Exception e) {
//			entity = new ResponseEntity<List<OrderDetailVO>>(HttpStatus.BAD_REQUEST);
//		}
//		return entity;
//	
//	}
	
	// ajax 에서 넘어온 주문번호 파라미터를 가지고 주문상세 테이블 쿼리를 구성해야 한다. 
	// 쿼리 : 주문번호 집어넣기 !!! 조인 사용 
	// 쿼리에 조인을 사용하는 이유 : 상세 테이블에 상품명과 상품 이미지가 없기 때문에 join 해줘야 한다.
	// 상품 코드와 상품명, 이미지를 조인해야 한다.상품 코드로 조인 ..! 
	// Postman 사용해서 꼭 확인해보기 ! 

	// Postman 을 안 쓰고 바로 해볼 수 있다. 
	// values produces= {MediaType.APPLICATION_ATOM_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE}
	
	@ResponseBody
	@GetMapping("/order_detail_list")
	public ResponseEntity<List<OrderDetailListVO>> order_detail_list(long odr_code) throws Exception{
		
		ResponseEntity<List<OrderDetailListVO>> entity = null;
		
		try {
			entity = new ResponseEntity<List<OrderDetailListVO>>(orderService.order_detail_list(odr_code), HttpStatus.OK);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		
		
		return entity;
	}
	
	//매출통계
		@GetMapping("/order_sale")
		public void order_sale(Model model, @RequestParam(required = false) Integer year, @RequestParam(required = false) Integer month) throws Exception{
			
			log.info("order_sale");
			
			//월별 시작일, 말일 구하기
			// cal 정보를 확인하면 현재 시간 정보가 나온다.
			Calendar cal = Calendar.getInstance();
			
			log.info(cal);
			
			
			int cur_year;
			int cur_month;
			
			if(year != null && month != null) {
				cur_year = (int) year;
				cur_month = ((int) month) -1; // 클라이언트에서 전송된 값은 4월 선택시 4-1 로 처리를 해야 한다.
				
			}else {
				cur_year = cal.get(Calendar.YEAR);
				cur_month = cal.get(Calendar.MONTH);
			}
			log.info("cur_month" + cur_month);
			
			model.addAttribute("sel_year", cur_year);
			model.addAttribute("sel_month", cur_month+1);
			
			log.info("sel_year" + cur_year);
			log.info("sel_month" + cur_month);
			
		
			cal.set(cur_year, cur_month, 1); // 월 0~11 / 1 월 : 0, 12 월 : 11
			
			log.info("기준날짜: " + cal);
			
			int start_day = cal.getActualMinimum(Calendar.DAY_OF_MONTH);
			int end_day = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
			cal.set(cur_year, cur_month, start_day);
			String startDate = dateFormat.format(cal.getTime());
			cal.set(cur_year, cur_month, end_day);
			String endDate = dateFormat.format(cal.getTime());
			
			log.info("시작일 : " + startDate);
			log.info("말일 : " + endDate);
			
			model.addAttribute("order_salelist", orderService.order_sale(startDate, endDate));
			
		}
}
