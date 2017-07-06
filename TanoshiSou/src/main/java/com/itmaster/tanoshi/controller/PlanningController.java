package com.itmaster.tanoshi.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itmaster.tanoshi.repository.BoardRepository;
import com.itmaster.tanoshi.repository.MemberDetailRepository;
import com.itmaster.tanoshi.repository.PlanningRepository;
import com.itmaster.tanoshi.vo.Member;
import com.itmaster.tanoshi.vo.MemberDetail;
import com.itmaster.tanoshi.vo.Planning;

@RequestMapping(value = "planning/")
@Controller
public class PlanningController {
	@Autowired
	BoardRepository boardRep;
	@Autowired
	PlanningRepository planningRep;
	@Autowired
	MemberDetailRepository memberDetailRep;
	@Autowired
	HttpSession session;

	private static final Logger logger = LoggerFactory.getLogger(PlanningController.class);

	@RequestMapping(value = "", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		//return "planning/homeCal";
		return "planning/home";
	}

	@ResponseBody
	@RequestMapping(value = "show", method = RequestMethod.POST)
	public ArrayList<Planning> getSchedule(int thisYear, int thisMonth) {
		Member member = (Member) session.getAttribute("loginInfo");
		String date = "";
		date += thisYear + "-" + String.format("%02d", thisMonth) + "-01";
		System.out.println(date);
		Planning plan = new Planning();
		plan.setInputdate(date);
		plan.setHouse_id(member.getMember_belongto());
		logger.debug("showSchedule!"+ plan.toString());
		HashMap<String, Object> map = new HashMap<>();
		map.put("date", date);
		map.put("house_id", plan.getHouse_id());
		return planningRep.listCal(map);
	}
	
	@ResponseBody
	@RequestMapping(value = "bDay", method = RequestMethod.POST)
	public List<MemberDetail> getBirthDay() {
		Member member = (Member) session.getAttribute("loginInfo");
		//멤버디테일로 하우스에 사는 사람들의 생일 이벤트 생성을 위한 데이터 생성
		List<MemberDetail> bDayList = memberDetailRep.getMemberDetailByHouse(member.getMember_belongto());
		logger.debug("memberDetail!"+bDayList.toString());
		return bDayList;
	}

	@ResponseBody
	@RequestMapping(value = "save", method = RequestMethod.POST)
	public int insertSchedule(Planning plan) {
		int ret = 0;
		Member member = (Member) session.getAttribute("loginInfo");
		System.out.println(member);
		plan.setHouse_id(member.getMember_belongto());
		plan.setMember_id(member.getMember_id());
		logger.info(plan.toString());
		String email = member.getMember_email();
		System.out.println(email);
		planningRep.saveScheduler(plan, email);
		return ret;
	}
	
	@ResponseBody
	@RequestMapping(value="del", method=RequestMethod.POST)
	public String delSchedule(String id) {
		System.out.println("삭제할 게시물 :"+ id);
		planningRep.delCal(id);
		return "";
	}

}
