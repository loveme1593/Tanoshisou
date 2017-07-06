package com.itmaster.tanoshi.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.itmaster.tanoshi.repository.MemberRepository;
import com.itmaster.tanoshi.vo.House;
import com.itmaster.tanoshi.vo.Member;


public class adminInterceptor extends HandlerInterceptorAdapter{
	@Autowired
	MemberRepository memberRep;
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("loginInfo");
		if (member == null) {
			response.sendRedirect(request.getContextPath() + "/member/login");
			return false;
		}
		House house = (House) session.getAttribute("houseInfo");
		String type = member.getMember_type();
		if (!type.equals("Manager")) {
			response.sendRedirect(request.getContextPath());
			return false;
		}
		return super.preHandle(request, response, handler);
	}
}
