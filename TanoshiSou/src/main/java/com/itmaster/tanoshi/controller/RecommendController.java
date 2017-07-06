package com.itmaster.tanoshi.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itmaster.tanoshi.repository.BoardRepository;
import com.itmaster.tanoshi.repository.HouseRepository;
import com.itmaster.tanoshi.repository.MemberDetailRepository;
import com.itmaster.tanoshi.repository.PlanningRepository;
import com.itmaster.tanoshi.util.Evaluator;
import com.itmaster.tanoshi.vo.House;
import com.itmaster.tanoshi.vo.Member;
import com.itmaster.tanoshi.vo.MemberDetail;

@RequestMapping(value = "recommend/")
@Controller
public class RecommendController {

	@Autowired
	HttpSession session;
	@Autowired
	BoardRepository boardRep;
	@Autowired
	PlanningRepository planningRep;
	@Autowired
	MemberDetailRepository memberDetailRep;
	@Autowired
	HouseRepository houseRep; // 하우스 리파짓토리

	private static final Logger logger = LoggerFactory.getLogger(RecommendController.class);

	/* 하우스 추천 안내 페이지를 호출한다 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String recommendPage(Model model) {
		MemberDetail detail = (MemberDetail) session.getAttribute("detailInfo");
		// 이미 심리검사 한 사람과 안한사람 구분 위해 수정
		if (detail == null) {
			model.addAttribute("ifNeedDetail", true);
		} else if (detail.hasScore())
			model.addAttribute("needScore", false);
		else
			model.addAttribute("needScore", true);
		return "recommend/home";
	}

	/* 심리검사 페이지 열기 */
	@RequestMapping(value = "test", method = RequestMethod.GET)
	public String getTestPage() {
		MemberDetail detail = (MemberDetail) session.getAttribute("detailInfo");
		// 이미 심리검사 한 사람과 안한사람 구분 위해 수정
		// 혹시나 MemberDetail 정보가 없으면 상세정보 등록 화면으로 이동
		if (detail == null)
			return "member/detail";
		if (detail.hasScore()) {
			logger.info("뿅!");
			return "redirect:../";
		}
		return "recommend/test";
	}

	/* 로딩 화면에서 결과 출력 페이지로 이동 */
	@RequestMapping(value = "result")
	public String resultPage(Model model) {
		// 아이디를 기반으로 해당 사용자의 점수 가져오기
		MemberDetail detail = (MemberDetail) session.getAttribute("detailInfo");
		logger.info(detail.toString());
		// 사용자의 성격 점수(3개)로 3개의 추천 목록 가져오기
		ArrayList<House> result_personal = houseRep.getPersonalResult(detail);
		ArrayList<House> result_clean = houseRep.getCleanResult(detail);
		ArrayList<House> result_active = houseRep.getActiveResult(detail);

		model.addAttribute("result_personal", result_personal);
		model.addAttribute("result_clean", result_clean);
		model.addAttribute("result_active", result_active);
		return "recommend/result";
	}

	// 임시:로딩 화면 확인용
	@RequestMapping(value = "loading", method = RequestMethod.GET)
	public String loading() {
		return "recommend/loading";
	}

	/* 심리검사 점수 받아서 계산 */
	@RequestMapping(value = "getResult", method = RequestMethod.POST)
	public String evaluate(int[] answers) {
		// 점수 값 넘어오는지 test->넘어오는것 확인
		Member member = (Member) session.getAttribute("loginInfo");
		String member_id = member.getMember_id();
		MemberDetail detail = memberDetailRep.getMemberDetail(member_id);
		String name = member.getMember_name();

		int score_personal = Evaluator.getPersonalScore(answers);
		int score_clean = Evaluator.getCleanScore(answers);
		int score_active = Evaluator.getActiveScore(answers);
		logger.info(name + "님의 점수\n청결도: " + score_clean + "\n개인성: " + score_personal + "\n적극성: " + score_active);

		detail.setScore_active(score_active);
		detail.setScore_clean(score_clean);
		detail.setScore_personal(score_personal);

		memberDetailRep.setScore(detail);
		session.setAttribute("detailInfo", detail);
		return "recommend/loading";
	}
}
