package com.itmaster.tanoshi.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.itmaster.tanoshi.repository.MemberDetailRepository;
import com.itmaster.tanoshi.repository.MemberRepository;
import com.itmaster.tanoshi.vo.Member;
import com.itmaster.tanoshi.vo.MemberDetail;

public class scoreInterceptor extends HandlerInterceptorAdapter {
	@Autowired
	MemberDetailRepository detailRep;
	private static final Logger logger = LoggerFactory.getLogger(scoreInterceptor.class);

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
		String member_id = member.getMember_id();
		MemberDetail detail = detailRep.getMemberDetail(member_id);
		// detail 자체가 없으면 상세정보 등록창으로 보냄
		if (detail == null) {
			logger.info("상세 정보 등록 화면으로 보냅니다");
			response.setContentType("text/html; charset=utf-8");
			request.setAttribute("ifNeedDetail", true);
			request.getRequestDispatcher("/member/detail").forward(request, response);
			return false;
		}
		// 점수가 없으면 시험화면으로 진행
		if(!detail.hasScore())
		{
			logger.info("점수가 없습니다!");
			request.setAttribute("ifNeedScore", true);
			request.getRequestDispatcher("/recommend/test").forward(request, response);
			return false;
		}
		return super.preHandle(request, response, handler);
	}

}
