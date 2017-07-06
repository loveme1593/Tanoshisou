package com.itmaster.tanoshi.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itmaster.tanoshi.repository.HouseRepository;
import com.itmaster.tanoshi.repository.MemberDetailRepository;
import com.itmaster.tanoshi.repository.MemberRepository;
import com.itmaster.tanoshi.vo.House;
import com.itmaster.tanoshi.vo.HouseFile;
import com.itmaster.tanoshi.vo.Member;
import com.itmaster.tanoshi.vo.MemberDetail;
import com.itmaster.tanoshi.util.DownloadService;
import com.itmaster.tanoshi.util.Evaluator;
import com.itmaster.tanoshi.util.FileService;

@RequestMapping(value = "house/")

@Controller
public class HouseController {
	@Autowired
	HouseRepository houseRep;
	@Autowired
	MemberRepository memberRep;
	@Autowired
	HttpSession session;
	@Autowired
	MemberDetailRepository memberdetailRep;

	private House house;
	private static final Logger logger = LoggerFactory.getLogger(HouseController.class);

	@RequestMapping(value = "", method = RequestMethod.GET)
	public String main(String id, Model model) {
		ArrayList<String> listFileName = new ArrayList<String>();
		house = houseRep.getHouse(id);
		ArrayList<HouseFile> resultHouseFile = new ArrayList<HouseFile>();
		resultHouseFile = houseRep.getHouseImageFile(id);
		String fullPath = null;
		for (HouseFile houseFile : resultHouseFile) {
			fullPath = Configuration.HOUSEPATH + "/" + houseFile.getHouse_file_id();
			fullPath = houseFile.getHouse_file_id();
			listFileName.add(fullPath);
		}
		if (house == null)
			return "home";
		session.setAttribute("houseInfo", house);
		model.addAttribute("houseFileList", resultHouseFile);
		// session.setAttribute("house_id", id);
		logger.info(house.getHouse_name() + "의 정보를 가져옵니다");
		return "house/home";
	}

	@RequestMapping(value = "search", method = RequestMethod.GET)
	public String searchPage(@RequestParam(defaultValue = "") String keyword, Model model) {
		model.addAttribute("keyword", keyword);
		return "house/map";
	}

	/* 메인페이지에서 요청한 검색어로 쉐어하우스 검색하여 출력(AJAX 방식) */
	@RequestMapping(value = "find")
	public @ResponseBody ArrayList<House> searchHouse(@RequestParam(defaultValue = "") String keyword, Model model) {
		logger.info("search::keyword: " + keyword);
		ArrayList<House> list = houseRep.searchHouses(keyword);
		// logger.info(list.toString());
		if (!keyword.equals("")) {
			model.addAttribute("keyword", keyword);
		}
		model.addAttribute("results", list);
		return list;
	}

	// searchDetail jsp 출력하기
	@RequestMapping(value = "detail", method = RequestMethod.GET)
	public String detail() {
		return "house/searchDetail";
	}

	/* 세부검색 결과 출력 */
	@RequestMapping(value = "detail", method = RequestMethod.POST)
	public String searchDetailedHouse(Model model, House house) {
		logger.info("희망 면적: " + house.getHouse_area());
		logger.info("희망 연령대: " + house.getHouse_age());
		logger.info("선택사항: " + house.getHouse_option());
		ArrayList<House> list = houseRep.searchDetailedHouses(house);
		model.addAttribute("results", list);
		model.addAttribute("keyword", house);
		return "house/detailedResult";
	}

	@RequestMapping(value = "checkHouseID", method = RequestMethod.POST)
	public @ResponseBody boolean checkID(String house_id) {
		if (houseRep.checkID(house_id))
			return true;
		else
			return false;
	}

	@RequestMapping(value = "getImage", method = RequestMethod.GET)
	public void getImage(@RequestParam String id, HttpServletResponse response) {
		// response를 통해서 수동으로 데이터를 내보냄
		// 사용자 측에서 다운로드 받도록 response 객체의 헤더를 조작함
		House house = houseRep.getHouse(id);
		String fullpath = Configuration.HOUSEPATH + id + "/" + house.getHouse_file_id();
		String original = house.getHouse_upload_file_name();
		// 서버에 저장된 전체 경로
		DownloadService.download(response, original, fullpath);

	}

	/* 쉐어하우스 데이터 업데이트 페이지 호출 */
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String getHouse(String id, Model model) {
		logger.info("update id: " + id);
		House house = houseRep.getHouse(id);
		model.addAttribute("house", house);
		return "house/update";
	}

	/* 쉐어하우스 데이터 업데이트 수행 */
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateHouse(House house, ArrayList<MultipartFile> files, Model model) {
		Member member = (Member) session.getAttribute("loginInfo");
		String owner = member.getMember_id();
		house.setHouse_owner(owner);
		logger.info(house.toString());
		if (!files.isEmpty()) {
			// 기존 파일은 수정하고 새로운 파일을 저장한다
			String fullpath = Configuration.HOUSEPATH + house.getHouse_id() + "/" + house.getHouse_file_id();
			// 실제 파일 삭제
			FileService.deleteFile(fullpath);
			houseRep.deleteFile(house.getHouse_id()); // DB에서 파일 삭제
			houseRep.insertFile(files, house.getHouse_id());
		}
		houseRep.updateHouse(house);
		houseRep.setHouseAge(house.getHouse_id());
		model.addAttribute("result", "success");
		return "house/update";
	}

	/* 주소 api 팝업창 출력 */
	@RequestMapping(value = "jusoPopup", method = RequestMethod.GET)
	public String juso() {
		return "house/jusoPopup";
	}

	/* 쉐어 하우스 만들기 양식 출력 */
	@RequestMapping(value = "insert", method = RequestMethod.GET)
	public String insertHouseForm(Model model) {
		// 쉐어하우스 생성 시 memberDetail 정보 없으면 신청 안되도록 수정
		Member member = (Member) session.getAttribute("loginInfo");
		MemberDetail detail = memberdetailRep.getMemberDetail(member.getMember_id());
		if (!member.getMember_belongto().equals("General"))
			return "redirect:../";
		if (detail == null) {
			model.addAttribute("detailNullCheck", "null");
			return "member/detail";
		}

		return "house/insert";
	}

	/* 쉐어 하우스 만들기 */
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public String insertHouse(Model model, House house, ArrayList<MultipartFile> files) {
		logger.info("하우스 생성");
		Member member = (Member) session.getAttribute("loginInfo");
		MemberDetail detail = memberdetailRep.getMemberDetail(member.getMember_id());
		// 하우스 주인 및 하우스 초기 점수 설정
		house.setHouse_owner(member.getMember_id());
		house.setHouse_score_clean(detail.getScore_clean());
		house.setHouse_score_active(detail.getScore_active());
		house.setHouse_score_personal(detail.getScore_personal());
		for (MultipartFile file : files) {
			logger.info(file.getOriginalFilename());
		}
		int result = houseRep.insertHouse(house);
		if (result != 0) {
			if (files != null)
				houseRep.insertFile(files, house.getHouse_id());
			// 하우스 등록이 성공했을 때 멤버 타입이 변하도록
			if (!member.getMember_type().equals("Manager")) {
				// Manager 일 경우 하우스 만들어도 Pending 상태는 안되도록
				member.setMember_type("Pending");
				memberRep.insertHouse(house);
			}
			logger.info(member.toString());
			model.addAttribute("insertResult", "success");
		} else {
			model.addAttribute("insertResult", "fail");
		}
		return "house/insert";
	}

	/* 주소 api에서 받은 전체 주소를 다시 서버로 받아옴 */
	@RequestMapping(value = "jusoPopup", method = RequestMethod.POST)
	public String juso2(@RequestParam String roadFullAddr, Model model) {
		logger.info(roadFullAddr);
		model.addAttribute("juso", roadFullAddr);
		return "house/jusoCheck";
	}

	// 하우스 이미지 파일 불러오기
	@RequestMapping(value = "houseImage", method = RequestMethod.GET)
	public void getImageFile(String fileNameList, HttpServletResponse response, Model model) {
		if (!fileNameList.equals("")) {
			try {
				response.setHeader("Content-Disposition",
						"attachment;filename=" + URLEncoder.encode(fileNameList, "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			String fullpath = Configuration.HOUSEPATH + "/" + fileNameList;
			ServletOutputStream fileout = null;
			FileInputStream filein = null;
			try {
				fileout = response.getOutputStream();
				filein = new FileInputStream(fullpath);
				FileCopyUtils.copy(filein, fileout);
			} catch (IOException e) {
				logger.info("파일이 없습니다! : " + fullpath);
			} finally {
				try {
					if (fileout != null)
						fileout.close();
					if (filein != null)
						filein.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@RequestMapping(value = "getHouseInfo", method = RequestMethod.POST)
	public @ResponseBody ArrayList<House> getHouseInfo() {
		ArrayList<House> list = houseRep.getAcceptedHouses();
		return list;
	}

	/* 쉐어하우스에 입주신청 하기 */
	@RequestMapping(value = "apply", method = RequestMethod.POST)
	public String applyHouse(Model model) {
		logger.info("입주신청 들어옴");
		House house = (House) session.getAttribute("houseInfo");
		String house_id = house.getHouse_id();
		Member member = (Member) session.getAttribute("loginInfo");
		String member_id = member.getMember_id();
		// member/detail 정보 없으면 정보 등록 페이지로 가도록 수정
		MemberDetail detail = memberdetailRep.getMemberDetail(member.getMember_id());
		if (detail == null) {
			model.addAttribute("detailNullCheck", "null");
			return "member/detail";
		} else {
			if (memberRep.applyHouse(member_id, house_id)) {
				logger.info("입주신청:성공");
				session.setAttribute("loginInfo", memberRep.getMember(member_id));
				model.addAttribute("applyResult", "success");
				return "redirect:./?id=" + house_id;
			} else {
				return "redirect:./?id=" + house_id;
			}
		}
	}

}