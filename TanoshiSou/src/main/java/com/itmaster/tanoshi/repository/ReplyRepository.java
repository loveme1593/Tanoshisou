package com.itmaster.tanoshi.repository;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itmaster.tanoshi.dao.ReplyDAO;
import com.itmaster.tanoshi.vo.Reply;

@Repository
public class ReplyRepository {

	@Autowired
	SqlSession sqlSession;

	public ArrayList<Reply> getReplies(int board_id) {
		ReplyDAO dao = sqlSession.getMapper(ReplyDAO.class);
		ArrayList<Reply> getReplies = new ArrayList();
		try {
			getReplies = dao.getReplies(board_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return getReplies;
	}

	public int insertReply(Reply reply) {
		ReplyDAO dao = sqlSession.getMapper(ReplyDAO.class);
		int result = 0;
		try {
			result = dao.insertReply(reply);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public int deleteReplies(int board_id) {
		ReplyDAO dao = sqlSession.getMapper(ReplyDAO.class);
		int result = 0;
		try {
			result = dao.deleteReplies(board_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public int deleteReply(int reply_num) {
		ReplyDAO dao = sqlSession.getMapper(ReplyDAO.class);
		int result = 0;
		try {
			result = dao.deleteReply(reply_num);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public int updateReply(Reply reply) {
		ReplyDAO dao = sqlSession.getMapper(ReplyDAO.class);
		int result = 0;
		try {
			result = dao.updateReply(reply);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public int getBoardId(int reply_num) {
		ReplyDAO dao = sqlSession.getMapper(ReplyDAO.class);
		int board_id = 0;
		try {
			board_id = dao.getBoardId(reply_num);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return board_id;
	}
	
	//수정을 위한 댓글 하나만 가져오기
	public String getReply(int reply_num){
		ReplyDAO dao=sqlSession.getMapper(ReplyDAO.class);
		String reply="";
		try {
			reply=dao.getReply(reply_num);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return reply;
	}

}
