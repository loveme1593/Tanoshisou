package com.itmaster.tanoshi.vo;

public class Reply {
	private int board_id; // 시퀀스
	private int reply_num; // 시퀀스
	private String reply_nickname;
	private String reply_text;
	private String reply_inputdate;

	public Reply() {
		super();
	}

	public Reply(int board_id, int reply_num, String reply_nickname, String reply_text, String reply_inputdate) {
		super();
		this.board_id = board_id;
		this.reply_num = reply_num;
		this.reply_nickname = reply_nickname;
		this.reply_text = reply_text;
		this.reply_inputdate = reply_inputdate;
	}

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}

	public int getReply_num() {
		return reply_num;
	}

	public void setReply_num(int reply_num) {
		this.reply_num = reply_num;
	}

	public String getReply_nickname() {
		return reply_nickname;
	}

	public void setReply_nickname(String reply_nickname) {
		this.reply_nickname = reply_nickname;
	}

	public String getReply_text() {
		return reply_text;
	}

	public void setReply_text(String reply_text) {
		this.reply_text = reply_text;
	}

	public String getReply_inputdate() {
		return reply_inputdate;
	}

	public void setReply_inputdate(String reply_inputdate) {
		this.reply_inputdate = reply_inputdate;
	}

}
