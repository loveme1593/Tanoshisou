package com.itmaster.tanoshi.vo;

public class Board {
	private String house_id;
	private int board_id;
	private String board_title;
	private String board_nickname;
	private String board_inputdate;
	private String board_content;
	private String board_member_id;
	private String board_category;
	private String board_file_id;
	private String board_save_file_name;
	private String board_upload_file_name;
	private int board_hits;
	private int board_reply_num;

	public Board() {
		super();
	}

	public Board(String house_id, int board_id, String board_title, String board_nickname, String board_inputdate,
			String board_content, String board_member_id, String board_category, String board_file_id,
			String board_save_file_name, String board_upload_file_name, int board_hits, int board_reply_num) {
		super();
		this.house_id = house_id;
		this.board_id = board_id;
		this.board_title = board_title;
		this.board_nickname = board_nickname;
		this.board_inputdate = board_inputdate;
		this.board_content = board_content;
		this.board_member_id = board_member_id;
		this.board_category = board_category;
		this.board_file_id = board_file_id;
		this.board_save_file_name = board_save_file_name;
		this.board_upload_file_name = board_upload_file_name;
		this.board_hits = board_hits;
		this.board_reply_num = board_reply_num;
	}

	public int getBoard_hits() {
		return board_hits;
	}

	public void setBoard_hits(int board_hits) {
		this.board_hits = board_hits;
	}

	public int getBoard_reply_num() {
		return board_reply_num;
	}

	public void setBoard_reply_num(int board_reply_num) {
		this.board_reply_num = board_reply_num;
	}

	public String getHouse_id() {
		return house_id;
	}

	public void setHouse_id(String house_id) {
		this.house_id = house_id;
	}

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}

	public String getBoard_title() {
		return board_title;
	}

	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

	public String getBoard_nickname() {
		return board_nickname;
	}

	public void setBoard_nickname(String board_nickname) {
		this.board_nickname = board_nickname;
	}

	public String getBoard_inputdate() {
		return board_inputdate;
	}

	public void setBoard_inputdate(String board_inputdate) {
		this.board_inputdate = board_inputdate;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public String getBoard_member_id() {
		return board_member_id;
	}

	public void setBoard_member_id(String board_member_id) {
		this.board_member_id = board_member_id;
	}

	public String getBoard_category() {
		return board_category;
	}

	public void setBoard_category(String board_category) {
		this.board_category = board_category;
	}

	public String getBoard_file_id() {
		return board_file_id;
	}

	public void setBoard_file_id(String board_file_id) {
		this.board_file_id = board_file_id;
	}

	public String getBoard_save_file_name() {
		return board_save_file_name;
	}

	public void setBoard_save_file_name(String board_save_file_name) {
		this.board_save_file_name = board_save_file_name;
	}

	public String getBoard_upload_file_name() {
		return board_upload_file_name;
	}

	public void setBoard_upload_file_name(String board_upload_file_name) {
		this.board_upload_file_name = board_upload_file_name;
	}

	@Override
	public String toString() {
		return "house_id=" + house_id + ", board_id=" + board_id + ", board_title=" + board_title + ", board_nickname="
				+ board_nickname + ", board_inputdate=" + board_inputdate + ", board_content=" + board_content
				+ ", board_member_id=" + board_member_id + ", board_category=" + board_category + ", board_file_id="
				+ board_file_id + ", board_save_file_name=" + board_save_file_name + ", board_upload_file_name="
				+ board_upload_file_name + ", board_hits=" + board_hits + ", board_reply_num=" + board_reply_num;
	}

}