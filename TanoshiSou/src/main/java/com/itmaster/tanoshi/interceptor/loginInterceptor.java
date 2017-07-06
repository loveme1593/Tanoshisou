package com.itmaster.tanoshi.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.itmaster.tanoshi.controller.HouseController;
import com.itmaster.tanoshi.repository.MemberRepository;
import com.itmaster.tanoshi.vo.Member;

public class loginInterceptor extends HandlerInterceptorAdapter {
	
	@Autowired
	MemberRepository memberRep;
	private static final Logger logger = LoggerFactory.getLogger(loginInterceptor.class);
	/* 로그인 여부만 확인하여 진행 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("loginInfo");
		if (member == null) {
			logger.debug("로그인되지 않은 사용자입니다!");
			response.sendRedirect(request.getContextPath() + "/member/login");
			return false;
		}
		logger.debug("로그인 사용자 확인!");
		return super.preHandle(request, response, handler);
	}

}
