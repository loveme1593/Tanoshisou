package com.itmaster.tanoshi.repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itmaster.tanoshi.dao.BoardDAO;
import com.itmaster.tanoshi.dao.Board_PhotoDAO;
import com.itmaster.tanoshi.vo.Board;

//사진첩 관리 위한 repository

@Repository
public class Board_PhotoRepository {

	@Autowired
	SqlSession sqlSession;

	// 전체 글 가져오기
	public ArrayList<Board> getPhotos(String house_id) {
		Board_PhotoDAO dao = sqlSession.getMapper(Board_PhotoDAO.class);
		ArrayList<Board> photos = new ArrayList();
		try {
			photos = dao.getPhotos(house_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return photos;
	}

	// 정해진 범위 내의 글 가져오기
	public ArrayList<Board> getPhotos(String house_id, int startPage, int endPage) {
		Board_PhotoDAO dao = sqlSession.getMapper(Board_PhotoDAO.class);
		ArrayList<Board> getPhotos = new ArrayList<Board>();
		ArrayList<Board> photos = new ArrayList<Board>();
		/*
		 * try { getPhotos = dao.getPhotos(house_id);
		 * 
		 * Iterator it = getPhotos.iterator(); while(it.hasNext()) {
		 * photos.add((Board) it.next()); } } catch (Exception e) { // TODO
		 * Auto-generated catch block e.printStackTrace(); }
		 */
		try {
			getPhotos = dao.getPhotos(house_id);
			if (getPhotos.size() == 0) {
				return getPhotos;
			} else {
				if (getPhotos.size() <= endPage) {
					endPage = getPhotos.size() - 1;
				}
				for (int a = startPage; a <= endPage; a++) {
					photos.add(getPhotos.get(a));
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return photos;
	}

	// 글 하나만 가져오기
	public Board getPhoto(int board_id) {
		Board_PhotoDAO dao = sqlSession.getMapper(Board_PhotoDAO.class);
		Board b = null;
		try {
			b = dao.getPhoto(board_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return b;
	}

	public int insertPhoto(Board b) {
		Board_PhotoDAO dao = sqlSession.getMapper(Board_PhotoDAO.class);
		int result = 0;
		try {
			result = dao.insertPhoto(b);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public int insertBoard_files(Board b) {
		Board_PhotoDAO dao = sqlSession.getMapper(Board_PhotoDAO.class);
		int result = 0;
		try {
			result = dao.insertBoard_files(b);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public int deletePhoto(int board_id) {
		Board_PhotoDAO pdao = sqlSession.getMapper(Board_PhotoDAO.class);
		BoardDAO bdao = sqlSession.getMapper(BoardDAO.class);
		int result = 0;
		try {
			// 상속되어있는 board_info, board_file 먼저 삭제한 후 board 내용 삭제
			pdao.deletePhoto_files(board_id);
			result = bdao.deleteBoard(board_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public int updatePhoto(Board b) {
		Board_PhotoDAO pdao = sqlSession.getMapper(Board_PhotoDAO.class);
		int result = 0;
		try {
			pdao.updatePhotoFile(b);
			result = pdao.updatePhoto(b);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}