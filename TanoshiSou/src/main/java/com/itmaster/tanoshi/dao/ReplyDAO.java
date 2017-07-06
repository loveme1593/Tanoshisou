package com.itmaster.tanoshi.dao;

import java.util.ArrayList;

import com.itmaster.tanoshi.vo.Reply;

public interface ReplyDAO {
	public ArrayList<Reply> getReplies(int board_id) throws Exception;

	public int getReplyNum(int board_id) throws Exception;

	public int insertReply(Reply r) throws Exception;

	public int deleteReplies(int board_id) throws Exception;

	public int updateReply(Reply r) throws Exception;

	public int deleteReply(int reply_num) throws Exception;

	public int getBoardId(int reply_num) throws Exception;
	
	// ������ ���� ��� �ϳ��� ��������
	public String getReply(int reply_num) throws Exception;

}
