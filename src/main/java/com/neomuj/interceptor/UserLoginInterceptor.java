package com.neomuj.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.lang.Nullable;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;

@Log4j
public class UserLoginInterceptor extends HandlerInterceptorAdapter {
	
//	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	private static final String LOGIN = "loginStatus";
	
	
	// Object handler : URL Mapping 주소에 해당하는 메서드 자체를 가리키는 의미 
	@Override															
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		

		return true;
	}

	// 컨트롤러 매핑주소 - /member/loginPost  postHandle 메서드 실행 후 뷰 (jsp) 화면처리 작업이 진행됨. 
	// ModelAndView : (Model + view) 
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			@Nullable ModelAndView modelAndView) throws Exception {
		
		/*
		MemberVO vo = new MemberVO();
		modelAndView.setViewName("member");
		modelAndView.addObject("memberVO", vo);
		*/
		
		// 로그인 인증처리 하기 위한 세션 객체 확보 
		HttpSession session = request.getSession();
		
		// 로그인시 Model 정보를 참조하는 작업 
		ModelMap modelMap = modelAndView.getModelMap();
		Object memberVO = modelMap.get("memberVO");
		
		if(memberVO != null) {
			log.info("로그인 성공");
			session.setAttribute(LOGIN, memberVO);
			
			Object targetUrl = session.getAttribute("targetUrl");
			
			
			response.sendRedirect(targetUrl != null ? (String) targetUrl : "/"); 
		}
		
//		response.sendRedirect("/");  이 위치에서는 지원이 안 됨
		// ajax 요청시 인터셉터는 정상 작동 되지 않음. 
		
	}
	

}
