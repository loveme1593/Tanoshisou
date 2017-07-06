package com.itmaster.tanoshi.repository;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import com.itmaster.tanoshi.dao.BoardDAO;
import com.itmaster.tanoshi.vo.Board;
import com.itmaster.tanoshi.vo.Planning;

@Repository
public class BoardRepository {

	private static final Logger logger = LoggerFactory.getLogger(BoardRepository.class);

	@Autowired
	SqlSession sqlSession;

	BoardDAO dao;

	public int insertBoard(Board board) {
		dao = sqlSession.getMapper(BoardDAO.class);
		int result = 0;
		try {
			result = dao.insertBoard(board);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public Board getBoard(int board_id) {
		dao = sqlSession.getMapper(BoardDAO.class);
		Board board = null;
		try {
			board = dao.getBoard(board_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return board;
	}

	public String getInputDate(int board_id) {
		dao = sqlSession.getMapper(BoardDAO.class);
		String board_inputdate = "";
		try {
			board_inputdate = dao.getInputDate(board_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return board_inputdate;
	}

	public int getBoardId(String house_id, String board_member_id) {
		dao = sqlSession.getMapper(BoardDAO.class);
		int board_id = -1;
		Map<String, String> getBId = new HashMap<String, String>();
		getBId.put("house_id", house_id);
		getBId.put("board_member_id", board_member_id);
		try {
			board_id = dao.getBoardId(getBId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return board_id;
	}

	public int deleteBoard(int board_id) {
		dao = sqlSession.getMapper(BoardDAO.class);
		int result = 0;
		try {
			// board 테이블 지우기
			result = dao.deleteBoard(board_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public int updateBoard(Board b) {
		dao = sqlSession.getMapper(BoardDAO.class);
		int result = 0;
		try {
			result = dao.updateBoard(b);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	// 게시글 조회수 올리기
	public void upHits(int board_id) {
		dao = sqlSession.getMapper(BoardDAO.class);
		try {
			dao.upHits(board_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 게시글 댓글수 올리기
	public void upReplyCount(int board_id) {
		dao = sqlSession.getMapper(BoardDAO.class);
		try {
			dao.upReplyCount(board_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 댓글 삭제 시 댓글 수 내리기
	public void downReplyCount(int board_id) {
		dao = sqlSession.getMapper(BoardDAO.class);
		try {
			dao.downReplyCount(board_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 페이징 처리:: 전체 포스트 수 구하기
	public int getTotalPosts(String house_id, String category,
			@RequestParam(value = "searchCombo", defaultValue = "null") String searchType,
			@RequestParam(value = "searchText", defaultValue = "null") String searchText) {
		dao = sqlSession.getMapper(BoardDAO.class);
		System.out.println("bRepository:: searchCombo::" + searchType + " , searchText::" + searchText);
		int result = 0;
		Map<String, Object> getNum = new HashMap();
		getNum.put("house_id", house_id);
		// db 컬럼명과 맞춘것
		getNum.put("board_category", category);
		getNum.put("searchType", searchType);
		getNum.put("searchText", searchText);
		try {
			result = dao.getTotalPosts(getNum);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	// 공지, 자유 게시판 분류에 따른 페이징 처리:: 게시글들 페이징 수에 맞게 가져오기
	public ArrayList<Board> getBoards(String house_id, String category, int startPage, int endPage,
			@RequestParam(value = "searchType", defaultValue = "") String searchType,
			@RequestParam(value = "searchText", defaultValue = "") String searchText) {
		dao = sqlSession.getMapper(BoardDAO.class);
		Map<String, Object> getBMap = new HashMap<String, Object>();
		getBMap.put("house_id", house_id);
		// db 컬럼명과 맞춘 것
		getBMap.put("board_category", category);
		getBMap.put("searchType", searchType);
		getBMap.put("searchText", searchText);
		ArrayList<Board> getBoards1 = new ArrayList<Board>();
		try {
			getBoards1 = dao.getBoards(getBMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ArrayList<Board> getBoards = new ArrayList<Board>();
		if (getBoards1.size() == 0) {
			return getBoards1;
		} else {
			if (getBoards1.size() <= endPage) {
				endPage = getBoards1.size() - 1;
			}
			for (int a = startPage; a <= endPage; a++) {
				getBoards.add(getBoards1.get(a));
			}
			return getBoards;
		}
	}

	public void insertPlanning(Planning plan) {
		dao = sqlSession.getMapper(BoardDAO.class);
		try {
			dao.insertPlanning(plan);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}