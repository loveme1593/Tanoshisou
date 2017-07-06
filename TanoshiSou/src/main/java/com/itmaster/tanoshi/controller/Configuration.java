package com.itmaster.tanoshi.controller;

public class Configuration {

	public static final String MEMBERPATH = "D:/project/memberImage";
	// 쉐어하우스의 사진이 저장되는 경로
	public static final String HOUSEPATH = "D:/project/houseImage";
	// 회원의 프로필 사진이 저장되는 경로
	public static final int PAGECOUNT = 10;
	// 한 페이지에 표시되는 포스트 수:: 일단 10개로 함
	
	public static String TEMPFILE = "temp.xlsx";
	public static String EXCELPATH;
	public static String getExcelPath() {
		return EXCELPATH;
	}
	public static void setExcelPath(String asdf) {
		Configuration.EXCELPATH = asdf;
	}
	public static String EXCELSAMPLE = "resources/format.xlsx";
	public static final String BOARDPATH = "D:/project/boardImage/";
	public static final String THUMBPATH = "D:/project/thumbnails";
}
