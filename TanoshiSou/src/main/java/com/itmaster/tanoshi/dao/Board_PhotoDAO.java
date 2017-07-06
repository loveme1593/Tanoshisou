package com.itmaster.tanoshi.dao;

import java.util.ArrayList;
import java.util.Map;

import com.itmaster.tanoshi.vo.Board;

//사진첩 관리를 위한 dao
public interface Board_PhotoDAO {

	// 사진 전부를 불러오기
	public ArrayList<Board> getPhotos(String house_id) throws Exception;

	// 사진 하나만 불러오기
	// 일반 게시판이랑 다르게 파일 경로까지 가져와야함
	public Board getPhoto(int board_id) throws Exception;

	// 사진첩 작성
	public int insertPhoto(Board photo) throws Exception;

	public int insertBoard_files(Board board) throws Exception;

	// 사진첩 삭제
	public int deletePhoto_files(int board_id) throws Exception;

	// 사진첩 업데이트
	public int updatePhotoFile(Board photo) throws Exception;

	public int updatePhoto(Board photo) throws Exception;

}