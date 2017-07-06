package com.itmaster.tanoshi.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;

import com.itmaster.tanoshi.vo.Board;
import com.itmaster.tanoshi.vo.Planning;

public interface BoardDAO {

	public int insertBoard(Board b) throws Exception;

	public Board getBoard(int board_id) throws Exception;

	public String getInputDate(int board_id) throws Exception;

	public int getBoardId(Map<String, String> getBId) throws Exception;

	public int deleteBoard(int board_id) throws Exception;

	public int updateBoard(Board b) throws Exception;

	// 게시글 조회수 업데이트
	public void upHits(int board_id) throws Exception;

	public void upReplyCount(int board_id) throws Exception;

	public void downReplyCount(int board_id) throws Exception;

	// 페이징 처리
	public int getTotalPosts(Map<String, Object> getNum) throws Exception;

	// public ArrayList<Board> getBoards(String catofposts) throws Exception;

	// 조회값이 있을 때 게시글 리스트
	public ArrayList<Board> getBoards(Map<String, Object> search) throws Exception;

	public int insertPlanning(Planning plan) throws Exception;
}