
package com.neomuj.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.neomuj.domain.MemberVO;
import com.neomuj.dto.EmailDTO;
import com.neomuj.dto.LoginDTO;
import com.neomuj.service.EmailService;
import com.neomuj.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {
	
	
	@Setter(onMethod_ = @Autowired)
	private MemberService service;
	
	@Setter(onMethod_ = @Autowired)
	private EmailService mailService;
	
	
	@Inject
	private BCryptPasswordEncoder cryPassEnc;
	
	
	
	//로그인 폼
	@GetMapping("/login")
	public void login() {
		
		log.info("로그인");
	}
	
	//로그인 인증
	@PostMapping(value = "/loginPost")
	public void login_ok(LoginDTO dto, RedirectAttributes rttr, HttpSession session, Model model) throws Exception {
	
		MemberVO vo = service.login_ok(dto);
		
		if(vo == null) return;
		
		String result = "loginIDFail"; 
		
		if(vo != null) {
			
			if(cryPassEnc.matches(dto.getMem_pw(), vo.getMem_pw())){
//				vo.setMem_pw("");
//				session.setAttribute("loginStatus", vo);//세션정보로 인증상태를 저장
				
				// 인터셉트에서 참조할 모델 작업
				model.addAttribute("memberVO", vo);
				
				
				result = "loginSuccess";
			}else {
				result = "loginPWFail";
				return;
			}
		}
		
		rttr.addFlashAttribute("status", result);
	}
	
	//로그아웃기능 : 메인페이지("/")
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		
		log.info("logout");
		
		session.invalidate();
		
		String result = "logout";
		rttr.addFlashAttribute("status", result);
		
		return "redirect:/";
		
	}
	
	
	//회원가입 폼
	@GetMapping("/join")
	public void join() {
		
		log.info("회원가입");
	}
	
	//회원가입
	@PostMapping("/join")
	public String join(MemberVO vo, RedirectAttributes rttr) throws Exception {
		
		log.info(vo);
		
		vo.setMem_pw(cryPassEnc.encode(vo.getMem_pw()));
		
		String result = "";
		service.join(vo);
		
		result = "insertSuccess";
		
		rttr.addFlashAttribute("status", result);
		
		return "redirect:/";
	}
	
	// 아이디중복체크
	@ResponseBody
	@RequestMapping(value = "/checkIdDuplicate", method=RequestMethod.POST)
	public ResponseEntity<String> checkIdDuplicate(@RequestParam("mem_id") String mem_id) throws Exception {
		
		
		log.info("id check");
		
		ResponseEntity<String> entity = null;
		try {
			int count = service.checkIdDuplicate(mem_id);
			// count 가 0이면 아이디 사용가능, 1 이면 사용 불가능.

			if(count != 0) {
				// 아이디가 존재해서 사용이 불가능.
				entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
			} else {
				// 사용가능한 아이디
				entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST); // 요청이 문제가 있다.
		}
		
		return entity;
	}
	
	/*
	// 인증코드 확인 
	@ResponseBody
	@RequestMapping(value = "checkAuthcode", method=RequestMethod.POST)
	public ResponseEntity<String> checkAuthcode(@RequestParam("code") String code, HttpSession session){
		
		ResponseEntity<String> entity = null;
		
		try {
			// 사용자가 메일로 받은 인증코드와 세션으로 저장해둔 인증코드를 비교하는 구문
			if(code.equals(session.getAttribute("authcode"))) {
				// 인증코드 일치
				entity= new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
				
				session.removeAttribute("authcode"); // 앞에서 했던 작업을 없애주는 작업
				
			} else {
				// 인증코드 불일치
				entity= new ResponseEntity<String>("FAIL", HttpStatus.OK);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			entity= new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	*/
	
	//비밀번호 찾기 폼
	@GetMapping("/find_pwd")
	public void find_pwd() {
		
		log.info("find_pwd");
		
	}
	
	// 비밀번호 찾기 
	// /member/pw_search
	@GetMapping("/pw_search")
	public ResponseEntity<String> pw_search(String id, EmailDTO email_dto) throws Exception{
		
		ResponseEntity<String> entity = null;
		
		LoginDTO dto = new LoginDTO();
		dto.setMem_id(id);
		dto.setMem_pw("");
		
		MemberVO vo = service.login_ok(dto);
		
		String imsi_pw = "";
		
		if(vo != null) {
			
			String email = vo.getMem_email();
			
			
			// 알파벳이 결합된 임시 비번 발급
			for(int i=0; i<12; i++) {
												// 97 : 소문자
				imsi_pw += (char)((Math.random() * 26) + 97);
				
			}
			
			// 비번 암호화 작업
			String enc_pw = cryPassEnc.encode(imsi_pw);
			dto.setMem_pw(enc_pw);
			
			// dto 를 파라미터로 하여, 사용자 아이디에 해당하는 비번변경작업
			// 1) update 회원테이블 set 비번 컬럼명 = 암호화된 비번 where 조건식 (아이디 일치)
			service.pw_search(dto); // 암호화된 비번이 update 되어서 로그인 가능하게 된다.
			
			// 2) 평문 비번을 메일로 전송
			
			email_dto.setReceiveMail(vo.getMem_email());
			email_dto.setSubject("요청하신 임시 비밀번호입니다. 로그인 후 비밀번호를 변경해주세요.");
			email_dto.setMessage(id + " 님의 비밀번호입니다.");
			
			mailService.sendMail(email_dto, imsi_pw);
		
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		}else {
			// SUCCESS 가 되면 아이디가 맞다는 거고 SUCCESS 가 아니면 아이디가 잘못되었다는 뜻
			entity = new ResponseEntity<String>(HttpStatus.OK);
			
		}
		
		
		
		// id 의 존재 유무
		
		/*
		 
		 id  존재하고, 입력했던 email 을 사용하여, 임시비번 전송. 암호화하여 비번 저장 
		 
		 */
		
		// 임의의 임시비번 생성하는 작업 (랜덤)
		
		return entity;
		
	}
	
	// 마이페이지
	@GetMapping("/mypage/mypage")
	public void my_page() {
		log.info("mypage");
	}
	
	
	// 회원수정 폼 : db에서 회원정보를 가져와서 출력
	@GetMapping("/mypage/mypage_modify")
	public void reg_edit(HttpSession session, Model model) throws Exception {
		
		
		
		String mem_id =  ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		
		/*
		MemberVO vo = service.member_info(mem_id);
		model.addAttribute("vo", vo);
		*/
		
		//model.addAttribute(service.member_info(mem_id)); // jsp에 전달되는 데이타의 키? memberVO
		model.addAttribute("vo", service.member_info(mem_id));
		
	}
	
	// 회원수정하기
	@PostMapping("/mypage/mypage_modify")
	public String modifyPOST(MemberVO vo, RedirectAttributes rttr, HttpSession session) throws Exception{
		
		log.info("수정");
		
		String result = "";
		
		String mem_id = ((MemberVO)session.getAttribute("loginStatus")).getMem_id();
		vo.setMem_id(mem_id);
		
		// MemberVO vo 에 회원수정 폼에서 아이디 파라미터가 존재한 경우
		
		
		service.modifyPOST(vo);
		result = "modifySuccess";
		
		rttr.addFlashAttribute("status", result);
		
		return "redirect:/";
	}
	
	// 회원탈퇴 폼
	@GetMapping("/mypage/mypage_delete")
	public void delete() {
		log.info("mypage_delete");
	}
	
	// 회원탈퇴하기
	@GetMapping("/mypage/mypage_delete_mem")
	public ResponseEntity<String> delete(HttpSession session, RedirectAttributes rttr, String mem_id, LoginDTO dto) throws Exception{
		
		log.info("delete");
		
		ResponseEntity<String> entity = null;
		
		String pw =  ((MemberVO) session.getAttribute("loginStatus")).getMem_pw();
		
		log.info(pw);
		
		if(pw == dto.getMem_pw()) {
			service.member_delete(mem_id);
			session.invalidate();
			
			String result = "regdelete";
			
			
			
			rttr.addFlashAttribute("status", result); // 루트(/)주소로 이동시 main.jsp에서 참조
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		}else {
			
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		
		return entity;
	}
	
	
	
	@GetMapping("/mypage/mypage_modify_pw")
	public void my_page_modify_pw() {
		log.info("mypage_modify_pwd");
	}
	

	

	@PostMapping("/mypage/mypage_modify_pw")
	public String modify_pwd(RedirectAttributes rttr, HttpSession session, MemberVO vo) throws Exception{

		String result = "";
		
		String pw =  ((MemberVO) session.getAttribute("loginStatus")).getMem_pw();
		
		String mem_pw = vo.getMem_pw();
		
		String id =  ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
		vo.setMem_id(id);
		
		if(cryPassEnc.matches(mem_pw, pw)) {
			vo.setMem_pw(cryPassEnc.encode(vo.getMem_pw_change()));
			
			log.info(mem_pw);
			
			service.modify_pw(vo);
			result = "modifyPwSuccess";
		}else {
			log.info("일치하지 않음");
		}
		
		rttr.addFlashAttribute("status", result);
		
		return "redirect:/";
		
		
		
	}
	
//	@PostMapping("/pw_update")
//	public String updatePOST(MemberVO vo, RedirectAttributes rttr, HttpSession session) throws Exception {
//
//      String result ="";
//      
//      System.out.println("session에 있는걸 MemberVO에 담기 : " + ((MemberVO) session.getAttribute("loginStatus")));
//      
//      // 1. 세션에 담겨있는 password (암호화되어 있음)
//      String loginPassword = ((MemberVO) session.getAttribute("loginStatus")).getMem_pw();
//      System.out.println("session에 있는 비밀번호 : " + ((MemberVO) session.getAttribute("loginStatus")).getMem_pw());
//      
//      
//      // 2. 화면에서 가져온 password (원본)
//      String mem_pw = vo.getMem_pw();
//      System.out.println("화면에서 가져온 기존비밀번호(원본) : " + mem_pw);
//      
//      
//      // session에 담겨있는 memb_id를 vo에 담기
//      String mem_id = ((MemberVO) session.getAttribute("loginStatus")).getMem_id();
//      vo.setMem_id(mem_id);
//      
//      // 위에 사용한 match를 참고해보니,
//      // matches(기존비밀번호(원본),  세션에 담겨있는 비밀번호(암호화))
//      if(cryPassEnc.matches(mem_pw, loginPassword)){
//         System.out.println("일치함");
//         
//         // vo에서 받아온 비밀번호를 암호화 해서 다시 vo에 담기 
//         vo.setMem_pw(cryPassEnc.encode(vo.getMem_pw1()));
//
//         
//         // 여기에 신규 password update (일단 주석해놓음)
//	         service.pw_search(vo);
//	        
//	         
//	         result = "updateSuccess";
//      } else {
//         System.out.println("불일치함");
//         
//      }
//      
//      rttr.addFlashAttribute("status", result);
//
//      return "redirect:/";

//   }
	
	
}
