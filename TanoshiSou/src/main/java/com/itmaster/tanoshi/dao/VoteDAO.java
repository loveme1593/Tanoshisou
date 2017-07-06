package com.itmaster.tanoshi.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.itmaster.tanoshi.vo.Planning;
import com.itmaster.tanoshi.vo.Vote;

/**
 * @author brian
 *
 */
public interface VoteDAO {

	/**
	 * 1)투표&참석 조회
	 * @param map
	 * @return
	 * @throws Exception
	 */
	public ArrayList<Vote> listVote(HashMap<String, Object> map) throws Exception;

	/**
	 * 2)투표&참석 저장 
	 * @param vote 
	 * @return
	 * @throws Exception
	 */
	public int saveVote(Vote vote) throws Exception;
	
	
	/**
	 * 3)투표여부 체크 -이미 한것인가 아닌가 
	 * @param vote
	 * @return
	 * @throws Exception
	 */
	public int checkVote(Vote vote) throws Exception;
	/**
	 * 4)투표한것 삭제
	 * @param vote
	 * @return
	 * @throws Exception
	 */
	public int deleteVote(Vote vote) throws Exception;
	
	public int clearVote(String member_id) throws Exception;
}
