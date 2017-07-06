package com.itmaster.tanoshi.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itmaster.tanoshi.repository.HouseRepository;
import com.itmaster.tanoshi.repository.MemberRepository;
import com.itmaster.tanoshi.repository.PaymentRepository;
import com.itmaster.tanoshi.repository.PlanningRepository;
import com.itmaster.tanoshi.repository.VoteRepository;
import com.itmaster.tanoshi.vo.Member;

@RequestMapping(value = "resident/")
@Controller
public class ResidentController {
	@Autowired
	MemberRepository memberRep;
	@Autowired
	HouseRepository houseRep;
	@Autowired
	PaymentRepository paymentRep;
	@Autowired
	PlanningRepository planningRep;
	@Autowired
	VoteRepository voteRep;
	
	@Autowired
	HttpSession session;

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@RequestMapping(value = "", method = RequestMethod.GET)
	public String home(Model model) {
		Member member = (Member) session.getAttribute("loginInfo");
		String house_id = member.getMember_belongto();
		if (member.getMember_type().equals("Host")) {
			ArrayList<Member> list = memberRep.getPendingMembers(house_id);
			ArrayList<Member> residents = memberRep.getResidents(house_id);
			model.addAttribute("pendingMembers", list);
			model.addAttribute("residents", residents);
			return "house/resident";
		}
		return "home";
	}

	/* 입주 승인 */
	@RequestMapping(value = "grant", method = RequestMethod.POST)
	public @ResponseBody String grantResident(String member_id) {
		Member member = (Member) session.getAttribute("loginInfo");
		String house_id = member.getMember_belongto();
		logger.info(member_id + "의 쉐어하우스 입주를 승인합니다");
		if (memberRep.grantResident(member_id)) {
			// 하우스 점수 재평가
			houseRep.setHouseScore(house_id);
			return "success";
		} else
			return "fail";
	}

	@RequestMapping(value = "decline", method = RequestMethod.POST)
	public @ResponseBody String declineResident(String member_id) {
		logger.info(member_id + "의 쉐어하우스 입주를 거절합니다");
		if (memberRep.declineResident(member_id))
			return "success";
		else
			return "fail";
	}

	/* 입주자 퇴거 */
	@RequestMapping(value = "leave", method = RequestMethod.POST)
	public @ResponseBody String leaveResident(String member_id) {
		Member member = (Member) session.getAttribute("loginInfo");
		String house_id = member.getMember_belongto();
		logger.info(member_id + "가 쉐어하우스를 떠납니다");
		if (memberRep.declineResident(member_id)) {
			houseRep.setHouseScore(house_id);
			paymentRep.clearPayment(member_id);
			planningRep.clearPlanning(member_id);
			voteRep.clearVote(member_id);
			return "success";
		} else
			return "fail";
	}
}
