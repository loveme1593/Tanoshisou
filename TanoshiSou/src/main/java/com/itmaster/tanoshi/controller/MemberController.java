package com.itmaster.tanoshi.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.itmaster.tanoshi.dao.HouseDAO;
import com.itmaster.tanoshi.repository.HouseRepository;
import com.itmaster.tanoshi.repository.MemberDetailRepository;
import com.itmaster.tanoshi.repository.MemberRepository;
import com.itmaster.tanoshi.util.Evaluator;
import com.itmaster.tanoshi.util.FileService;
import com.itmaster.tanoshi.util.SendMail;
import com.itmaster.tanoshi.vo.House;
import com.itmaster.tanoshi.vo.Member;
import com.itmaster.tanoshi.vo.MemberDetail;
import com.itmaster.tanoshi.vo.MemberFile;
import com.itmaster.tanoshi.vo.Payment;

@Controller
@RequestMapping(value = "member/")
public class MemberController {

	@Autowired
	MemberRepository memberRep;

	@Autowired
	MemberDetailRepository memberdetailRep;

	@Autowired
	HouseRepository houseRep;

	@Autowired
	HttpSession session;

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@RequestMapping(value = "join", method = RequestMethod.GET)
	public String joinForm() {
		Member member = (Member) session.getAttribute("loginInfo");
		if (member != null)
			return "home";
		return "member/join";
	}

	// 회원 가입
	@RequestMapping(value = "join", method = RequestMethod.POST)
	public String memberJoin(Member member, MultipartFile uploadFile, Model model) {
		String eMail = member.getMember_email() + "@" + member.getMember_emailLIst();
		/* 이메일 주소 전부 붙여주는 작업 */
		member.setMember_email(eMail); // 이메일 주소 다시 셋해줌
		memberRep.insertMember(member); // 회원정보 등록
		if (!uploadFile.isEmpty()) { // 회원프로필 파일 저장
			String saveFile = FileService.saveFile(member.getMember_id(), uploadFile, Configuration.MEMBERPATH);
			MemberFile memberFile = new MemberFile(member.getMember_id(), saveFile, uploadFile.getOriginalFilename());
			memberRep.insertMemberProfile(memberFile);
		}
		// join 성공 시 login 화면으로 돌아가 join 성공했다는 메세지 띄워줌
		model.addAttribute("joinResult", "success");
		return "member/login";
	}

	// 로그인
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String memberLogin(String login_id, String login_password, Model model) {
		Member loginMember = null;
		loginMember = memberRep.login(login_id, login_password);
		if (loginMember == null) {
			loginMember = null;
		}
		if (loginMember != null) {
			if (loginMember.getMember_type().equals("general")) {
				return "member/login";
			}
		} else if (loginMember == null) {
			model.addAttribute("loginResult", "fail");
			return "member/login";
		}
		MemberFile profile = memberRep.getMemberProfile(loginMember.getMember_id());
		MemberDetail loginDetail = memberdetailRep.getMemberDetail(loginMember.getMember_id());
		session.setAttribute("loginInfo", loginMember);
		// 홈 화면에 프로필 사진 띄우기 위한 작업
		session.setAttribute("memberProfile", profile);
		// Detail 도
		session.setAttribute("detailInfo", loginDetail);
		return "redirect:../";
	}

	// 로그 아웃
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String memberLogout() {
		session.removeAttribute("loginInfo");
		session.removeAttribute("memberProfile");
		session.removeAttribute("house_id");
		session.invalidate();
		return "redirect:../";
	}

	// 로그인 화면
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String memberLogin() {
		Member member = (Member) session.getAttribute("loginInfo");
		if (member != null)
			return "home";
		return "member/login";
	}

	// id 확인
	@RequestMapping(value = "checkMemberID", method = RequestMethod.POST)
	public @ResponseBody String checkMemberID(String member_id) {
		String idCheckResult = memberRep.checkMemberId(member_id);
		return idCheckResult;
	}

	// 회원정보 업데이트 화면 출력
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String memberUpdateForm(Model model) {
		Member member = (Member) session.getAttribute("loginInfo");
		String id = member.getMember_id();
		ArrayList<House> houseList = new ArrayList<House>();
		MemberFile profile = memberRep.getMemberProfile(id);
		houseList = houseRep.showHouseListAtUpdate();
		model.addAttribute("memberIn", member);
		model.addAttribute("memberProfile", profile);
		model.addAttribute("houseList", houseList);
		return "member/update";
	}

	@RequestMapping(value = "getPhoto", method = RequestMethod.GET)
	public void getMemberPhoto(String file_id, HttpServletResponse response, Model model) {
		if (!file_id.equals("") || file_id != null) {
			try {
				response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(file_id, "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			String fullpath = Configuration.MEMBERPATH + "/" + file_id;
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

	/* 회원 업데이트 수행 */
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String memberUpdate(Model model, Member member, MultipartFile uploadFile, String member_file_name) {
		System.out.println(member.toString());
		String fullpath = Configuration.MEMBERPATH + "/" + member_file_name;
		int deleteResult = 0;
		if (member.getMember_email().length() != 0) {
			member.setMember_email(member.getMember_email());
		}else if(member.getMember_emailLIst().length() != 0){
			member.setMember_email(member.getMember_email()+"@"+member.getMember_emailLIst());
		}
		memberRep.updateMember(member);
		houseRep.setHouseAge(member.getMember_belongto());
		if (uploadFile.getOriginalFilename().length() != 0) {
			FileService.deleteFile(fullpath);
			deleteResult = memberRep.deleteMemberProfile(member_file_name);
			String savename = FileService.saveFile(member.getMember_id(), uploadFile, Configuration.MEMBERPATH);
			MemberFile saveFile = new MemberFile(member.getMember_id(), savename, uploadFile.getOriginalFilename());
			memberRep.insertMemberProfile(saveFile);
		}
		model.addAttribute("result", "success");
		return "member/update";
	}

	@RequestMapping(value = "checkMemberEmail", method = RequestMethod.POST)
	public @ResponseBody String checkingEmail(String memberEmail, String emailLIst) {
		String emailCheckResult = memberRep.checkMemberEmail(memberEmail + "@" + emailLIst);
		logger.info(emailCheckResult);
		return emailCheckResult;
	}

	// 전화번호 확인
	@RequestMapping(value = "checkMemberPhone", method = RequestMethod.POST)
	public @ResponseBody String checkPhone(String memberPhone) {
		String phoneCheckResult = memberRep.checkMemberPhone(memberPhone);
		return phoneCheckResult;
	}

	// --------------------- 멤버 디테일 쪽---------------------------

	// member detail form 가기
	@RequestMapping(value = "detail", method = RequestMethod.GET)
	public String memberDetailForm(Model model) {
		MemberDetail detail = (MemberDetail) session.getAttribute("detailInfo");
		if (detail == null)
			model.addAttribute("ifNeedDetail", true);
		logger.info("ifNeedDetail::"+detail);
		return "member/detail";
	}

	// 처음에는 update로 실행해서 실패하면 insert로 실행 시켜서 저장함.
	@RequestMapping(value = "memberDetailUpdate", method = RequestMethod.POST)
	public String memberDetailUpdate(MemberDetail memberDetail, Model model) {
		Member member = (Member) session.getAttribute("loginInfo");
		String id = member.getMember_id();
		String house_id = member.getMember_belongto();
		MemberDetail detail = memberdetailRep.getMemberDetail(id);
		if (detail == null) // 등록 시행
			memberdetailRep.insertMemberDetail(memberDetail);
		else // 업데이트 시행
			memberdetailRep.updateMemberDetail(memberDetail);
		houseRep.setHouseAge(house_id);
		model.addAttribute("result", "success");
		session.setAttribute("detailInfo", memberDetail);
		return "member/detail";
	}

	/* 회원 정보 보기 */
	@RequestMapping(value = "profile", method = RequestMethod.POST)
	public String showProfile(String id, Model model) {
		Member member = memberRep.getMember(id);
		model.addAttribute("memberInfo", member);
		return "member/profile";
	}

	@RequestMapping(value = "findInfo", method = RequestMethod.GET)
	public String findInfo() {
		return "member/findInfo";
	}

	@RequestMapping(value = "findEmail", method = RequestMethod.POST)
	public String sendEmailAction(String member_id, String member_password_check_a, int member_password_check_q,
			Model model, HttpServletRequest http) {
		Member EmailResult = null;
		logger.info("findEmail 들어옴::" + member_id);
		// EmailResult = memberRep.getMemberEmail(member_id,
		// member_password_check_a, member_password_check_q);
		EmailResult = memberRep.getMember(member_id);
		String Webaddress = http.getRequestURL().toString();
		Webaddress = Webaddress.substring(0,30);
		if (EmailResult != null && EmailResult.getMember_password_check_q() == member_password_check_q
				&& EmailResult.getMember_password_check_a().equals(member_password_check_a)) {
			String title = member_id + "님의 비밀번호 찾기에 대한 이메일 안내입니다.";
			String message = member_id + "님의 비밀번호는 : " + EmailResult.getMember_password() + " 입니다. <br>"
					+ "앞으로도"+"<a href = '"+Webaddress+"'> 楽しい荘   </a>많은 이용 부탁드립니다.<br>" + "감사합니다.";
			SendMail mailService = new SendMail(EmailResult.getMember_email(), title, message);
			model.addAttribute("findResult", "success");
			return "member/login";
		} else {
			model.addAttribute("findResult", "fail");
			return "member/findInfo";
		}
	}

	@RequestMapping(value = "findId", method = RequestMethod.POST)
	public String findId(String member_phone, String member_name, Model model) {
		String findIdresult = null;
		findIdresult = memberRep.getMemberId(member_phone, member_name);
		if (findIdresult == null) {
			findIdresult = "fail";
			model.addAttribute("idResult", findIdresult);
			return "member/findInfo";
		} else {
			findIdresult = findIdresult.substring(0, 3) + "*****";
			model.addAttribute("idResult", findIdresult);
			return "member/login";
		}
	}

	@RequestMapping(value = "ShowProfile", method = RequestMethod.GET)
	public @ResponseBody HashMap<String, Object> showProfile1(String id) {
		logger.info("ShowProfile 들어옴:: " + id);
		HashMap<String, Object> result = new HashMap<>();
		Member member = memberRep.getMember(id);
		MemberDetail detail = memberdetailRep.getMemberDetail(id);
		MemberFile file = memberRep.getMemberProfile(id);
		// null 인 경우 터져서 프로필 안나오는 문제 수정
		if (detail == null) {
			detail = new MemberDetail();
			detail.setDetail_gender("미 등록");
		}
		if (file == null) {
			file = new MemberFile();
			file.setMember_file_id("null");
		}
		result.put("memberA", member);
		result.put("memberD", detail);
		result.put("memberP", file);
		return result;
	}

	@RequestMapping(value = "getResidents", method = RequestMethod.POST)
	public @ResponseBody ArrayList<Member> getResidents(String house_id) {
		logger.info("아이디: " + house_id);
		ArrayList<Member> list = memberRep.getResidents(house_id);
		return list;
	}
}
