package com.itmaster.tanoshi.util;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;

import org.springframework.web.multipart.MultipartFile;

import com.itmaster.tanoshi.controller.Configuration;
import com.itmaster.tanoshi.vo.Board;
import com.mortennobel.imagescaling.AdvancedResizeOp;
import com.mortennobel.imagescaling.ResampleOp;

public class PhotoThumbNail {

	// multipartfile->file로 변환하기
	public File multipartToFile(MultipartFile multipart) {
		File convFile = new File(multipart.getOriginalFilename());
		try {
			multipart.transferTo(convFile);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return convFile;
	}

	// 썸네일 이미지 만들기
	public void thumbNail(String savedFilename) {
		try {
			// 저장 폴더가 없으면 생성
			File path = new File(Configuration.THUMBPATH);
			if (!path.isDirectory()) {
				path.mkdirs();
			}
			// 썸네일 가로사이즈
			int thumbnail_width = 200;
			// 썸네일 세로사이즈
			int thumbnail_height = 200;
			// 원본이미지파일의 경로+파일명
			File origin_file_name = new File(Configuration.BOARDPATH + savedFilename);
			// 생성할 썸네일파일의 경로+썸네일파일명
			File thumb_file_name = new File(Configuration.THUMBPATH + "/" + savedFilename);

			BufferedImage thImg = ImageIO.read(origin_file_name);

			// BufferedImage buffer_original_image =
			// ImageIO.read(origin_file_name);
			// BufferedImage buffer_thumbnail_image = new
			// BufferedImage(thumbnail_width, thumbnail_height,
			// BufferedImage.TYPE_3BYTE_BGR);
			// Graphics2D graphic = buffer_thumbnail_image.createGraphics();
			// graphic.drawImage(buffer_original_image, 0, 0, thumbnail_width,
			// thumbnail_height, null);
			// ImageIO.write(buffer_thumbnail_image, "jpg", thumb_file_name);

			ResampleOp resampleOp = new ResampleOp(200, 200);
			resampleOp.setUnsharpenMask(AdvancedResizeOp.UnsharpenMask.Soft);
			BufferedImage rescaledImage = resampleOp.filter(thImg, null);
			ImageIO.write(rescaledImage, "jpg", thumb_file_name);

			System.out.println("썸네일 생성완료");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Map<Integer, Object> getPaths(ArrayList<Board> getPhotos) {
		// 합쳐져있는 path 분리하기
		Map<Integer, Object> getPathLists = new HashMap();
		for (int a = 0; a < getPhotos.size(); a++) {
			ArrayList<String> getPaths = new ArrayList();
			int board_id = getPhotos.get(a).getBoard_id();
			String fullPath = getPhotos.get(a).getBoard_file_id();
			String[] paths = FileService.getEachPaths(fullPath);
			for (int b = 0; b < paths.length; b++) {
				getPaths.add(paths[b]);
			}
			getPathLists.put(getPhotos.get(a).getBoard_id(), getPaths);
		}
		return getPathLists;
	}

	public String[] getPath(Board photo) {
		String[] paths = FileService.getEachPaths(photo.getBoard_file_id());
		return paths;
	}

}