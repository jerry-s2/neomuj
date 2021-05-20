package com.neomuj.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.log4j.Log4j;

@Log4j
public class AdminAuthInterceptor extends HandlerInterceptorAdapter{
	
	private static final String LOGIN = "adLoginStatus";
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();
		
		if(session.getAttribute(LOGIN) == null) {
			
			log.info("로그인이 되어있지 않습니다.");
			
			targetSave(request);
			
			response.sendRedirect("/admin/"); // /member/login -> /member/loginPost(인터셉터 설정)
			return false; // Controller 로 제어가 넘어가지 않음.
			
		}
		
		return true; // Controller 로 제어가 넘어감. 
	}
	
	// 세션이 소멸된 상태이거나 비로그인시 요청한 주소를 저장
	// 사용자가 로그인이 진행이 되고, 요청한 주소가 있으면 그 곳으로 이동 . 없으면 루트로 이동
	
	
	private void targetSave(HttpServletRequest request) {
		
		// /member/modify?userid=jerry
		String uri = request.getRequestURI();
		String queryString = request.getQueryString();
		
		if(queryString == null || queryString.equals("null")) {
			queryString = "";
		}else {
			queryString = "?" + queryString;
		}
		
		if(request.getMethod().equals("GET")) {
			log.info("targetSave: " + (uri + queryString));
			request.getSession().setAttribute("targetUrl", uri + queryString);
		}
	}
	
	
}
