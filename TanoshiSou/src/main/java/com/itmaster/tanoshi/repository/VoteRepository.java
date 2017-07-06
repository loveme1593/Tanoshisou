package com.itmaster.tanoshi.repository;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itmaster.tanoshi.dao.VoteDAO;
import com.itmaster.tanoshi.vo.Vote;

@Repository
public class VoteRepository {
	@Autowired
	SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(PlanningRepository.class);

	/**
	 * 투표&참서 조회
	 * 
	 * @param map
	 *            (type, pid가 들어옴)
	 * @return
	 */
	public ArrayList<Vote> listVote(HashMap<String, Object> map) {
		VoteDAO mapper = sqlSession.getMapper(VoteDAO.class);
		ArrayList<Vote> result = null;
		try {
			result = mapper.listVote(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 투표&참석 저장
	 * 
	 * @param vote
	 * @return
	 */
	public int saveVote(Vote vote) {
		VoteDAO mapper = sqlSession.getMapper(VoteDAO.class);
		int result = -1;
		int check = 0;
		try {
			if (mapper.checkVote(vote) != 0) {
				mapper.deleteVote(vote);
			}
			result = mapper.saveVote(vote);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	public boolean clearVote(String member_id) {
		VoteDAO mapper = sqlSession.getMapper(VoteDAO.class);
		int result = 0;
		try {
			result = mapper.clearVote(member_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(result!=0)
			return true;
		else return false;
	}
}
