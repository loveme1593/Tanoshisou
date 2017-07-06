package com.itmaster.tanoshi.vo;

public class HouseFile {

	private String house_id;                // 하우스 아이디
	private String house_file_id;           // 하우스 파일 아이디
	private String house_upload_file_name;  // 하우스 업로드 파일 아이디
	
	//생성자
	public HouseFile() {
	}

	public HouseFile(String house_id, String house_file_id, String house_upload_file_name) {
		super();
		this.house_id = house_id;
		this.house_file_id = house_file_id;
		this.house_upload_file_name = house_upload_file_name;
	}

	public String getHouse_id() {
		return house_id;
	}

	public void setHouse_id(String house_id) {
		this.house_id = house_id;
	}

	public String getHouse_file_id() {
		return house_file_id;
	}

	public void setHouse_file_id(String house_file_id) {
		this.house_file_id = house_file_id;
	}

	public String getHouse_upload_file_name() {
		return house_upload_file_name;
	}

	public void setHouse_upload_file_name(String house_upload_file_name) {
		this.house_upload_file_name = house_upload_file_name;
	}

	@Override
	public String toString() {
		return "House_file [house_id=" + house_id + ", house_file_id=" + house_file_id + ", house_upload_file_name="
				+ house_upload_file_name + "]";
	}
	
}
