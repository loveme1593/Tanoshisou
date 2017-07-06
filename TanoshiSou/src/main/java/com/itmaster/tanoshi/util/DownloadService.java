package com.itmaster.tanoshi.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;

public class DownloadService {

	public static void download(HttpServletResponse response, String original, String fullpath) {
		// 사용자 측에서 다운로드 받도록 response 객체의 헤더를 조작함
		try {
			response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(original, "UTF-8"));
			// 사용자가 받을 때에는 기존 파일명으로 출력해준다
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 서버에 저장된 전체 경로
		ServletOutputStream fileout = null;
		FileInputStream filein = null;
		try {
			filein = new FileInputStream(fullpath);
			fileout = response.getOutputStream();
			// spring에서 제공하는 유틸리티
			FileCopyUtils.copy(filein, fileout);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (filein != null)
				try {
					filein.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			if (fileout != null)
				try {
					fileout.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
		}
	}

}
