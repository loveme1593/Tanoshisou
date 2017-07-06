package com.itmaster.tanoshi.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itmaster.tanoshi.repository.HouseRepository;
import com.itmaster.tanoshi.repository.MemberRepository;
import com.itmaster.tanoshi.repository.PaymentRepository;
import com.itmaster.tanoshi.util.toExcel;
import com.itmaster.tanoshi.vo.House;
import com.itmaster.tanoshi.vo.Member;
import com.itmaster.tanoshi.vo.Payment;

@Controller
@RequestMapping(value = "payment/")
public class PaymentController {

	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);

	@Autowired
	PaymentRepository payRep;
	@Autowired
	HouseRepository houseRep;
	@Autowired
	MemberRepository memberRep;

	@Autowired
	HttpSession session;
	@Autowired
	HttpServletRequest request;

	@RequestMapping(value = "", method = RequestMethod.GET)
	public String home(Model model) {
		Member member = (Member) session.getAttribute("loginInfo");
		String type = member.getMember_type();
		switch (type) {
		case "Host":
			return "payment/home_host";
		case "Resident":
			return "payment/home_resident";
		default:
			return "home";
		}

	}

	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public @ResponseBody String insert(Payment payment) {
		Member member = (Member) session.getAttribute("loginInfo");
		payment.setHouse_id(member.getMember_belongto());
		logger.info(payment.toString());
		if (payRep.insertPayment(payment))
			return "success";
		else
			return "fail";

	}

	@RequestMapping(value = "get", method = RequestMethod.POST)
	public @ResponseBody ArrayList<Payment> get(Payment payment) {
		Member member = (Member) session.getAttribute("loginInfo");
		payment.setHouse_id(member.getMember_belongto());
		ArrayList<Payment> list = null;
		switch (member.getMember_type()) {
		case "Host":
			list = payRep.getPaymentsforHost(payment);
			// 쉐어하우스 주인의 경우
			break;
		case "Resident":
			payment.setPay_for(member.getMember_id());
			list = payRep.getPaymentsforResident(payment);
			break;
		default:
			return null;
		}
		return list;
	}

	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public @ResponseBody String deletePayment(int pay_id) {
		if (payRep.deletePayment(pay_id))
			return "success";
		else
			return "fail";
	}

	@RequestMapping(value = "update", method = RequestMethod.POST)
	public @ResponseBody String updatePayment(Payment payment) {
		logger.info(payment.toString());
		if (payRep.updatePayment(payment))
			return "success";
		else
			return "fail";
	}

	@RequestMapping(value = "toExcel", method = RequestMethod.POST)
	public void toXlsx(int year, int month, HttpServletResponse response) {
		String root_path = request.getSession().getServletContext().getRealPath("/resources/format.xlsx");
		System.out.println();	
		logger.info(root_path);
		if (new File(root_path).exists())
			Configuration.setExcelPath(root_path);
		else
			return;
		Member member = (Member) session.getAttribute("loginInfo");
		String member_id = member.getMember_id();
		String house_id = member.getMember_belongto();
		House house = houseRep.getHouse(house_id);
		String filename = ""; // 파일이름 설정
		if (month < 10)
			filename = house_id + "_" + year + "0" + month + ".xlsx";
		else
			filename = house_id + "_" + year + month + ".xlsx";
		// 해당 년월의 관리비 리스트를 가져옴
		Payment thisPay = new Payment();
		//
		thisPay.setHouse_id(house_id);
		thisPay.setPay_year(year);
		thisPay.setPay_month(month);

		Payment lastPay = new Payment();
		lastPay.setHouse_id(house_id);
		if (month == 1) {
			month = 12;
			year = year - 1;
		} else
			month -= 1;
		lastPay.setPay_year(year);
		lastPay.setPay_month(month);

		ArrayList<Payment> thisMonth = null;
		ArrayList<Payment> lastMonth = null;
		switch (member.getMember_type()) {
		case "Host":
			thisMonth = payRep.getPaymentsforReport(thisPay);
			lastMonth = payRep.getPaymentsforReport(lastPay);
			// 쉐어하우스 주인의 경우
			break;
		case "Resident":
			thisPay.setPay_for(member_id);
			lastPay.setPay_for(member_id);
			thisMonth = payRep.getPaymentsforResident(thisPay);
			lastMonth = payRep.getPaymentsforResident(lastPay);
			break;
		default:
			return;
		}
		// 쉐어하우스 정보와 관리비를 바탕으로 엑셀 파일 생성
		toExcel.makeXls(member, house, thisMonth, lastMonth);
		try {
			response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8"));
			// 세팅한 파일 이름으로 엑셀 파일 전송 준비
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ServletOutputStream fileout = null;
		FileInputStream filein = null;
		File temp = null;
		try {
			filein = new FileInputStream(Configuration.TEMPFILE);
			fileout = response.getOutputStream();
			FileCopyUtils.copy(filein, fileout);
			
		} catch (Exception e) {
			
			e.printStackTrace();
		} finally {
			try {
				if (filein != null) {
					filein.close();
				}
				if (fileout != null) {
					fileout.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}

	@RequestMapping(value = "getCategory", method = RequestMethod.POST)
	public @ResponseBody ArrayList<String> getCategory(Payment payment) {
		Member member = (Member) session.getAttribute("loginInfo");
		String house_id = member.getMember_belongto();
		logger.info(payment.getPay_for() + "의 입력된 카테고리를 가져옵니다");
		payment.setHouse_id(house_id);
		ArrayList<String> list = payRep.getInsertedCategory(payment);
		return list;
	}
}
