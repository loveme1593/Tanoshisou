package com.itmaster.tanoshi.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.itmaster.tanoshi.repository.MemberRepository;
import com.itmaster.tanoshi.vo.House;
import com.itmaster.tanoshi.vo.Member;

public class houseInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	MemberRepository memberRep;

	/* 하우스 소속 여부를 확인하여 진행 */
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
		if (house == null) {
			response.sendRedirect(request.getContextPath() + "/member/login");
			return false;
		}
		String belong = member.getMember_belongto();
		String house_id = house.getHouse_id();
		if (!belong.equals(house_id)) {
			response.sendRedirect(request.getContextPath() + "/house/?id=" + belong);
			return false;
		}
		return super.preHandle(request, response, handler);
	}
}