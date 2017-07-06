package com.itmaster.tanoshi.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.StringTokenizer;

import javax.imageio.ImageIO;

import org.springframework.web.multipart.MultipartFile;

/**
 * 파일 관련 유틸 업로드한 파일의 저장 & 서버에 저장된 파일 삭제 등의 기능 제공
 */
public class FileService {

	/**
	 * 업로드 된 파일을 지정된 경로에 저장하고, 저장된 파일명을 리턴
	 * 
	 * @param mfile
	 *            업로드된 파일
	 * @param path
	 *            저장할 경로
	 * @return 저장된 파일명
	 */
	public static String saveFile(String member_id, MultipartFile mfile, String uploadPath) {
		// 프로필 파일 저장
		// 업로드된 파일이 없거나 크기가 0이면 저장하지 않고 null을 리턴
		if (mfile == null || mfile.isEmpty() || mfile.getSize() == 0) {
			return null;
		}

		// 저장 폴더가 없으면 생성
		File path = new File(uploadPath);
		if (!path.isDirectory()) {
			path.mkdirs();
		}

		// 원본 파일명
		String originalFilename = mfile.getOriginalFilename();

		// 저장할 파일명을 오늘 날짜의 년월일로 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		// String savedFilename = sdf.format(new Date());
		String savedFilename = sdf.format(new Date());

		// 원본 파일의 확장자
		String ext;
		int lastIndex = originalFilename.lastIndexOf('.');
		// 확장자가 없는 경우
		if (lastIndex == -1) {
			ext = "";
		}
		// 확장자가 있는 경우(확장자 이름 뽑아내기)
		else {
			ext = "." + originalFilename.substring(lastIndex + 1);
		}

		// 저장할 전체 경로를 포함한 File 객체
		File serverFile = null;

		// 파일 가로, 세로사이즈 정하기
		// int thumbnail_width = 450;
		// int thumbnail_height = 250;

		// 같은 이름의 파일이 있는 경우의 처리
		while (true) {
			serverFile = new File(uploadPath + "/" + savedFilename + ext);
			// 같은 이름의 파일이 없으면 나감.
			if (!serverFile.isFile())
				break;
			// 같은 이름의 파일이 있으면 이름 뒤에 long 타입의 시간정보를 덧붙임.
			savedFilename = savedFilename + new Date().getTime();
		}

		// 파일 저장
		try {
			mfile.transferTo(serverFile);
		} catch (Exception e) {
			savedFilename = null;
			e.printStackTrace();
		}

		return savedFilename + ext;
	}

	public static String saveFile(String member_id, MultipartFile mfile, String uploadPath, int filenum) {
		// 프로필 파일 저장
		// 업로드된 파일이 없거나 크기가 0이면 저장하지 않고 null을 리턴
		if (mfile == null || mfile.isEmpty() || mfile.getSize() == 0) {
			return null;
		}

		// 저장 폴더가 없으면 생성
		File path = new File(uploadPath);
		if (!path.isDirectory()) {
			path.mkdirs();
		}

		// 원본 파일명
		String originalFilename = mfile.getOriginalFilename();

		// 저장할 파일명을 오늘 날짜의 년월일로 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		// String savedFilename = sdf.format(new Date());
		String savedFilename = sdf.format(new Date()) + filenum;

		// 원본 파일의 확장자
		String ext;
		int lastIndex = originalFilename.lastIndexOf('.');
		// 확장자가 없는 경우
		if (lastIndex == -1) {
			ext = "";
		}
		// 확장자가 있는 경우(확장자 이름 뽑아내기)
		else {
			ext = "." + originalFilename.substring(lastIndex + 1);
		}

		// 저장할 전체 경로를 포함한 File 객체
		File serverFile = null;

		// 파일 가로, 세로사이즈 정하기
		// int thumbnail_width = 450;
		// int thumbnail_height = 250;

		// 같은 이름의 파일이 있는 경우의 처리
		while (true) {
			serverFile = new File(uploadPath + "/" + savedFilename + ext);
			// 같은 이름의 파일이 없으면 나감.
			if (!serverFile.isFile())
				break;
			// 같은 이름의 파일이 있으면 이름 뒤에 long 타입의 시간정보를 덧붙임.
			savedFilename = savedFilename + new Date().getTime();
		}

		// 파일 저장
		try {
			mfile.transferTo(serverFile);
		} catch (Exception e) {
			savedFilename = null;
			e.printStackTrace();
		}

		return savedFilename + ext;
	}

	public static String saveFile(int board_id, int fileNum, MultipartFile mfile, String uploadPath) {
		// 업로드된 파일이 없거나 크기가 0이면 저장하지 않고 null을 리턴
		if (mfile == null || mfile.isEmpty() || mfile.getSize() == 0) {
			return null;
		}

		// 저장 폴더가 없으면 생성
		File path = new File(uploadPath);
		if (!path.isDirectory()) {
			path.mkdirs();
		}

		// 원본 파일명
		String originalFilename = mfile.getOriginalFilename();

		// 저장할 파일명을 오늘 날짜의 년월일로 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		// String savedFilename = sdf.format(new Date());
		String savedFilename = board_id + "-" + sdf.format(new Date()) + "-" + fileNum;

		// 원본 파일의 확장자
		String ext;
		int lastIndex = originalFilename.lastIndexOf('.');
		// 확장자가 없는 경우
		if (lastIndex == -1) {
			ext = "";
		}
		// 확장자가 있는 경우(확장자 이름 뽑아내기)
		else {
			ext = "." + originalFilename.substring(lastIndex + 1);
		}

		// 저장할 전체 경로를 포함한 File 객체
		File serverFile = null;

		// 파일 가로, 세로사이즈 정하기
		int thumbnail_width = 450;
		int thumbnail_height = 250;

		// 같은 이름의 파일이 있는 경우의 처리
		while (true) {
			serverFile = new File(uploadPath + "/" + savedFilename + ext);
			// 같은 이름의 파일이 없으면 나감.
			if (!serverFile.isFile())
				break;
			// 같은 이름의 파일이 있으면 이름 뒤에 long 타입의 시간정보를 덧붙임.
			savedFilename = savedFilename + new Date().getTime();
		}

		// 파일 저장
		try {
			mfile.transferTo(serverFile);
		} catch (Exception e) {
			savedFilename = null;
			e.printStackTrace();
		}

		return savedFilename + ext;
	}

	/**
	 * 서버에 저장된 파일의 전체 경로를 전달받아, 해당 파일을 삭제
	 * 
	 * @param fullpath
	 *            삭제할 파일의 경로
	 * @return 삭제 여부
	 */
	public static boolean deleteFile(String uploadpath, String fullpath) {
		// 파일 삭제 여부를 리턴할 변수
		boolean result = false;

		// 전달된 전체 경로로 File객체 생성
		File delFile = new File(uploadpath + "/" + fullpath);

		// 해당 파일이 존재하면 삭제
		if (delFile.isFile()) {
			delFile.delete();
			result = true;
		}
		return result;
	}

	public static boolean deleteFile(String fullpath) {
		// 파일 삭제 여부를 리턴할 변수
		boolean result = false;

		// 전달된 전체 경로로 File객체 생성
		File delFile = new File(fullpath);

		// 해당 파일이 존재하면 삭제
		if (delFile.isFile()) {
			delFile.delete();
			result = true;
		}
		return result;
	}

	/**
	 * 파일 내 경로값 각각 뽑아내기(기준:/)
	 */
	public static String[] getEachPaths(String board_upload_file_name) {
		// 스트링 배열로 각각 값 뽑아내기
		String[] txtArr = board_upload_file_name.split("/");
		return txtArr;
	}

}