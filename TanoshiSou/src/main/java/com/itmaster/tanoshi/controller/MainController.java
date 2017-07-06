package com.itmaster.tanoshi.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.ServletInputStream;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.filefilter.PrefixFileFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.util.JSONPObject;
import com.itmaster.tanoshi.repository.HouseRepository;
import com.itmaster.tanoshi.repository.MemberRepository;
import com.itmaster.tanoshi.util.FileService;
import com.itmaster.tanoshi.vo.House;
import com.itmaster.tanoshi.vo.Member;
import com.itmaster.tanoshi.vo.MemberFile;

@Controller
public class MainController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@Autowired
	MemberRepository memberRep; // 회원 리파짓토리
	@Autowired
	HouseRepository houseRep; // 하우스 리파짓토리

	@Autowired
	HttpSession session; // 세션
	/* 쉐어하우스 검색 페이지 */

	// 홈화면
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String Home() {
		return "home";
	}
}
