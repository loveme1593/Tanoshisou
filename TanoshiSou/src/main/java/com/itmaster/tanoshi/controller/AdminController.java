package com.itmaster.tanoshi.controller;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.util.JSONPObject;
import com.fasterxml.jackson.databind.util.JSONWrappedObject;
import com.itmaster.tanoshi.repository.HouseRepository;
import com.itmaster.tanoshi.repository.MemberRepository;
import com.itmaster.tanoshi.vo.House;
import com.itmaster.tanoshi.vo.Member;

@Controller
@RequestMapping(value = "admin/")
public class AdminController {
	@Autowired
	HouseRepository houseRep;

	@Autowired
	MemberRepository memberRep;

	@Autowired
	HttpSession session;

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	/* (관리자용) 쉐어하우스 관리 페이지 호출 */
	@RequestMapping(value = "")
	public String adminMain() {
		return "admin/home";
	}

	/* (관리자용) 쉐어하우스 추가 페이지 호출 */
	@RequestMapping(value = "insert", method = RequestMethod.GET)
	public String insertForm() {
		return "house/insert";
	}

	/* (관리자용) 쉐어하우스 추가 수행 */
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public @ResponseBody String insertHouse(House house, ArrayList<MultipartFile> files) {
		for (MultipartFile file : files) {
			logger.info(file.getOriginalFilename());
		}
		logger.info(house.toString());

		houseRep.insertHouse(house);
		if (files != null)
			houseRep.insertFile(files, house.getHouse_id());
		return "success";
	}

	/* (관리자용) 쉐어하우스 전체 데이터 가져옴 */
	@RequestMapping(value = "getHouses", method = RequestMethod.POST)
	public @ResponseBody ArrayList<House> getHouses() {
		ArrayList<House> house = new ArrayList<House>();
		house = houseRep.getHouses();
		logger.info("getHouses::" + house.size());
		return house;
	}

	/* (관리자용) 쉐어하우스 승인 작업 */
	@RequestMapping(value = "accept", method = RequestMethod.POST)
	public @ResponseBody ArrayList<House> acceptHouse(String house_id, String house_owner) {
		logger.info("쉐어하우스 승인");
		houseRep.acceptHouse(house_id);
		// 하우스 주인이 Manager 인 경우엔 적용하지 않도록 함
		House houseC = houseRep.getHouse(house_id);
		Member member = memberRep.getMember(houseC.getHouse_owner());
		if (!member.getMember_type().equals("Manager")) {
			logger.info("houseAccept::" + houseC.getHouse_owner() + "님은 매니저가 아님");
			memberRep.acceptHouse(house_id, house_owner);
		}
		ArrayList<House> house = houseRep.getHouses();
		return house;
	}

	/* 쉐어하우스 데이터 삭제 실행 */
	/* ajax 쓸 땐 @ResponseBody return타입 적어주고 return 값 넣어주세요-문경 */
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public @ResponseBody ArrayList<House> deleteHouse(String house_id) {
		logger.info("delete id: " + house_id);
		houseRep.deleteHouse(house_id);
		ArrayList<House> house = houseRep.getHouses();
		return house;
	}

}
