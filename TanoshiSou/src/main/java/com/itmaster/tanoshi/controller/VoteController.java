package com.itmaster.tanoshi.controller;

import java.util.ArrayList;
import java.util.HashMap;
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
import com.itmaster.tanoshi.repository.PlanningRepository;
import com.itmaster.tanoshi.repository.VoteRepository;
import com.itmaster.tanoshi.vo.Member;
import com.itmaster.tanoshi.vo.Planning;
import com.itmaster.tanoshi.vo.Vote;

@Controller
public class VoteController {
	@Autowired
	BoardRepository boardRep;
	@Autowired
	PlanningRepository planningRep;
	@Autowired
	VoteRepository voteRep;
	@Autowired
	HttpSession session;

	private static final Logger logger = LoggerFactory.getLogger(PlanningController.class);
	/**
	 * @param type
	 *            planning or board로 들어와야함
	 * @param pid
	 *            planning 과 board의 id 값
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "voteShow", method = RequestMethod.POST)
	public ArrayList<Vote> getVote(String data_type, int pid) {
		logger.debug(data_type+"/"+pid);
		HashMap<String, Object> map = new HashMap<>();
		map.put("data_type", data_type);
		map.put("pid", pid);
		ArrayList<Vote> list = voteRep.listVote(map);
		logger.info("voteShow::" + list.size());
		return list;
	}

	@ResponseBody
	@RequestMapping(value = "voteSave", method = RequestMethod.POST)
	public int insertVote(Vote vote) {
		int ret = 0;
		Member member = (Member) session.getAttribute("loginInfo");
		vote.setMember_id(member.getMember_id());
		logger.info(vote.toString());
		voteRep.saveVote(vote);
		return ret;
	}

}
