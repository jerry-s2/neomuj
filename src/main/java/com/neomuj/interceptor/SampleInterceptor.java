package com.neomuj.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.lang.Nullable;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


// 롬복 작동 안 함

// HandlerInterceptor 는 특정한 URI 호출을 '가로채는' 역할! 이를 이용하여 기존 컨트롤러의 로직을 수정하지 않고도, 사전이나 사후 제어가 가능
// HandlerInterceptor 인터페이스를 구현하기 위해서는 preHandle() , postHandle() , afterCompletion() 메서드를 구현해야 함
public class SampleInterceptor extends HandlerInterceptorAdapter {
	
	// 인터셉터 기능을 갖는 클래스를 만드려면, HandlerInterceptorAdapter 추상 클래스를 상속 받아야 한다.
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		System.out.println("preHandle...");
		
		// return false; -> 진행될 경우에는 컨트롤러로 제어가 넘어가지 않음
		// return true; -> 진행될 경우에는 컨트롤러로 제어가 넘어갔다가 다시 postHandle 로 넘어감
		
		return true; 
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			@Nullable ModelAndView modelAndView) throws Exception {
		
		System.out.println("postHandle...");
		
		super.postHandle(request, response, handler, modelAndView);
	}




}
