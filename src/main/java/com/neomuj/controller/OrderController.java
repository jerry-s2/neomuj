package com.neomuj.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neomuj.domain.CartVOList;
import com.neomuj.domain.MemberVO;
import com.neomuj.domain.OrderDetailVO;
import com.neomuj.domain.OrderVO;
import com.neomuj.domain.ProductVO;
import com.neomuj.service.CartService;
import com.neomuj.service.OrderService;
import com.neomuj.service.UserProductService;
import com.neomuj.util.FileUploadUtils;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/order/*")
public class OrderController {
	
	@Setter(onMethod_ = @Autowired)
	private CartService cartService;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	
	// 얘를 가져온 이유 UserProductMapper.xml 파일에서 getProductByNum 을 가져와 쓰기 위해서 - 코드의 재사용성
	@Setter(onMethod_ = @Autowired)
	private UserProductService userProductServie;
	
	@Setter(onMethod_ = @Autowired)
	private OrderService orderService;
	
//	@PostMapping("/order")  // 즉시구매 			
//	@GetMapping("/order") // 장바구니 구매			@RequestParam - 넘어오는 파라미터가 같으면 생략 가능
	
	// @RequestParam(required = false) : get 요청에 의한 해당 쿼리 스트링이 존재하지 않아도 처리하고자 할 때 사용.(예외발생이 안 됨)
	// jsp 를 건들지 않고 여기서 모든 작업을 끝낼 수 있다 .. 근데 어떻게 하냐고 ....
	// 이 메서드는 post 방식으로도 지원이 되고 get 방식으로도 지원이 된다.
	// 1) 즉시 구매에서 보여주는 작업 type-1  2) 장바구니 통해서 구매시 보여주는 작업 type-2
	@RequestMapping(value="/order", method=RequestMethod.GET)		// odr_amount 타입으로 참조형 Integer 를 쓴 이유 : null 값을 처리할 수 있다. 
	public void order(HttpSession session, @ModelAttribute("type") String type, @RequestParam(required = false) Long pdt_num, @RequestParam(required = false) Integer odr_amount, Model model) throws Exception{
		
		
		// type : 1 - 즉시 구매, 2- 장바구니 기반으로 구매
		
		//사용자별 장바구니 내역
		// 로그인 해준 상태에서 진행돼야 하기 때문에 사용 
		String mem_id =  ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		
		if(type.equals("1")) {
			
			// 즉시 구매
			log.info("즉시구매" + type);
			
			// 구매 상품에 대한 정보를 표시
			// ((long)pdt_num); - 상품코드를 이용해 상품을 가져온다.
			ProductVO vo = userProductServie.getProductByNum((long)pdt_num);
			
			
			// 즉시 구매시 상품 상세를 폼에 삽입하기 위한 Model 작업
			// 주문 상세에 저장
			model.addAttribute("pdt_num", pdt_num);
			model.addAttribute("odr_amount", odr_amount);
			model.addAttribute("odr_price", vo.getPdt_price());
			
			
			
			
			// 매개변수가 있는 생성자를 만들어서, 디폴트 생성자를 처리해 줄 것. 
			// 수동으로 cartvoList 를 만들어준다.
			CartVOList cartvo = new CartVOList(0, vo.getPdt_img(), vo.getPdt_name(),odr_amount, vo.getPdt_price());
			
			
			List<CartVOList> cartvoList = new ArrayList<CartVOList>();
			cartvoList.add(cartvo);
			
			// 여기까지 밑의 cartService.list_cart(mem_id)) 과 똑같은 모습을 만들어준 것이다 .. 둘 다 리스트 컬렉션

			model.addAttribute("cartVOList", cartvoList);

			
		}else if(type.equals("2")) {
			
			// 장바구니 기반으로 사용 --  @RequestParam(required = false) Long pdt_num, @RequestParam(required = false) Integer odr_amount 받지 않는다.
			
			log.info("장바구니 구매");
			// 구매 상품을 장바구니에서 가져와서 표시
			model.addAttribute("cartVOList", cartService.list_cart(mem_id));
			
			// 사용하지 않는 값이지만, 주문하기 클릭을 하게 되면, OrderDetailVO vo2 파라미터에서 에러 발생이 되므로, 형식만 유지를 했음
			model.addAttribute("pdt_num", 0);
			model.addAttribute("odr_amount", 0);
			model.addAttribute("odr_price", 0);
			
			
		}
		
		// 주문입력폼 구성작업
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/displayFile", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		
		return FileUploadUtils.getFile(uploadPath, fileName);
	}
	
	// order.jsp에서 type 파라미터 정보를 받아와야 즉시 구매, 장바구니 구매를 통한 구매를 분기작업을 할 수가 있다. 
	// OrderDetailVO vo2 : 장바구니 경유에서 주문하기는 사용이 안 된다.
	@PostMapping("/order_buy")
	public String order_buy(OrderVO vo, OrderDetailVO vo2, String type, HttpSession session) throws Exception {
		
		
		String mem_id =  ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		vo.setMem_id(mem_id);
		
		if(type.equals("1")) {
			
			log.info("order : " + vo);
			log.info("orderDetail : " + vo2);
			
			// 장바구니 테이블은 제외 (즉시 구매이므로 장바구니에 상품을 저장 안 함)
			// 주문, 주문상세 테이블 작업 : pdt_num, odr_amuont, odr_price
			orderService.orderDirect_buy(vo, vo2);
		} else if(type.equals("2")) {

			// 주문, 주문상세 (장바구니 참조), 장바구니 삭제
			orderService.order_buy(vo, mem_id); // 즉시 구매한 상품 구성 해줄 것. 
		}
		return "redirect:/";
	}

}
