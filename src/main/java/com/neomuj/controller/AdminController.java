package com.neomuj.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.neomuj.domain.AdminVO;
import com.neomuj.service.AdminService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
public class AdminController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminService adminservice;


	@GetMapping("/")
	public String admin_main() {
		
		return "/admin/admin_login";
	}
	
	
	@PostMapping("/admin_check")
	public String admin_ok(AdminVO vo, HttpSession session ,RedirectAttributes rttr) throws Exception{
		
		log.info("admin_check" + vo);
		
		AdminVO adVO = null;
		
		// 암호화작업 여기서 vo.getMem_id 이런 거
		adVO = adminservice.login_check(vo);
		
		if(adVO == null) {
			
			rttr.addFlashAttribute("msg", "Fail");
			return "redirect:/admin/";
		}
		
		// 사용자와 세션이 같으면 안 된다 .. 
		session.setAttribute("adLoginStatus", adVO);
		
		return "redirect:/admin/admin_process";
	}
	
	// 얘가 admin_process.jsp 파일을 열게 된다.
	@GetMapping("/admin_process")
	public String  admin_process(HttpSession session) {
		
		log.info("admin_login");
		
		String url = "";
		
		if(session.getAttribute("adLoginStatus") == null) {
			url = "redirect:/admin/"; // 관리자 로그인 주소
		}else {
			url = "/admin/admin_process"; // 관리자 메뉴 뷰(view) 
		}
		
		return  url; // 
	}
	
	@PostMapping("/admin_logout")
	public String admin_logout(HttpSession session, RedirectAttributes rttr) {
		
		session.invalidate();
		
		rttr.addAttribute("msg", "logout");
		
		return "redirect:/admin/";
	}
}
