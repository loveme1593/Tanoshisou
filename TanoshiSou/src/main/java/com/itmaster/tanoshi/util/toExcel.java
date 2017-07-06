package com.itmaster.tanoshi.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;
import javax.swing.text.Document;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.io.IOUtils;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.itmaster.tanoshi.controller.Configuration;
import com.itmaster.tanoshi.controller.PaymentController;
import com.itmaster.tanoshi.vo.*;

public class toExcel {

	@Autowired
	static HttpSession session;
	private static final Logger logger = LoggerFactory.getLogger(toExcel.class);
	private String samplePath = "";

	public String getSamplePath() {
		return samplePath;
	}

	public void setSamplePath(String samplePath) {
		this.samplePath = samplePath;
	}

	public static void makeXls(Member member, House house, ArrayList<Payment> thisMonth, ArrayList<Payment> lastMonth) {
		int month = thisMonth.get(0).getPay_month();
		int year = thisMonth.get(0).getPay_year();
		File sample = null;
		XSSFWorkbook wb = null;
		try {
			sample = new File(Configuration.EXCELPATH);
			wb = new XSSFWorkbook(new FileInputStream(sample));
		} catch (IOException e1) {
			System.out.println("파일이 없습니다!");
		}
		// 샘플 엑셀 파일 오픈

		// http://jlblog.me/56 [JLBlog]
		// 사용법: http://zero-gravity.tistory.com/237

		XSSFSheet manageExpense = wb.getSheetAt(0);
		// 제목을 넣을 행과 열의 위치를 지정
		XSSFCell cell = null;

		cell = manageExpense.getRow(0).getCell(1);
		switch (member.getMember_type()) {
		case "Host":
			cell.setCellValue(house.getHouse_name() + " 관리비 보고서 (" + year + "년 " + month + "월)");
			break;
		case "Resident":
			cell.setCellValue(house.getHouse_name() + " 관리비 내역 (" + year + "년 " + month + "월)");
			break;
		}
		// 입주자 성명을 넣을 셀 지정
		cell = manageExpense.getRow(1).getCell(1);
		switch (member.getMember_type()) {
		case "Host":
			cell.setCellValue("관리자 성명: " + member.getMember_name());
			break;
		case "Resident":
			cell.setCellValue("입주자 성명: " + member.getMember_name());
			break;
		}
		// Create a row and put some cells in it. Rows are 0 based.
		// Create a cell and put a value in it.
		int rowIndex = 3;
		int colIndex = 1;
		int unpaid = 0;
		int thisTotal = 0;
		for (Payment thisPayment : thisMonth) {
			if (thisPayment.getPay_category().equals("미납액")) {
				unpaid = thisPayment.getPay_amount();
				continue;
			}
			int thisAmount = 0, lastAmount = 0;
			colIndex = 1;
			// 관리비 항목
			cell = manageExpense.getRow(rowIndex).getCell(colIndex);
			cell.setCellValue(thisPayment.getPay_category());
			colIndex++;
			// 당월 관리비 금액
			cell = manageExpense.getRow(rowIndex).getCell(colIndex);
			thisAmount = thisPayment.getPay_amount();
			thisTotal += thisAmount;
			cell.setCellValue(thisAmount);
			colIndex++;
			// 전월 관리비 금액
			cell = manageExpense.getRow(rowIndex).getCell(colIndex);
			for (Payment lastPayment : lastMonth) {
				if (thisPayment.getPay_category().equals(lastPayment.getPay_category())) {
					lastAmount = lastPayment.getPay_amount();
					cell.setCellValue(lastAmount);
					break;
				}
				lastAmount = 0;
				cell.setCellValue(lastAmount);
			}
			colIndex++;
			// 증감액
			cell = manageExpense.getRow(rowIndex).getCell(colIndex);
			cell.setCellValue(thisAmount - lastAmount);
			rowIndex++;
		}
		// 합산 내역 입력하기
		cell = manageExpense.getRow(3).getCell(7);
		cell.setCellValue(unpaid);
		cell = manageExpense.getRow(4).getCell(7);
		cell.setCellValue(thisTotal);
		cell = manageExpense.getRow(5).getCell(7);
		cell.setCellValue(thisTotal + unpaid);

		// 연락처 지정하기
		cell = manageExpense.getRow(7).getCell(6);
		String text = cell.getStringCellValue();
		text += house.getHouse_name() + " (" + house.getHouse_phone() + ")";
		cell.setCellValue(text);
		// 입력한 관리비 파일 출력하기
		FileOutputStream fileOut = null;
		try {
			fileOut = new FileOutputStream(Configuration.TEMPFILE);
			wb.write(fileOut);
			fileOut.close();
		} catch (FileNotFoundException e) {
			System.out.println("파일없음");
		} catch (IOException e) {
			System.out.println("입출력오류");
		}

	}
}
