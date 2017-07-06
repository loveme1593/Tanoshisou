package com.itmaster.tanoshi.vo;

import java.util.ArrayList;
import java.util.Arrays;

public class House {

	String house_id;

	int house_num;
	String house_name;
	String house_address;
	String house_phone;

	int house_available_room;
	String house_introduce;
	String house_available_email;
	String house_status;
	String house_owner;
	String house_file_id;
	String house_upload_file_name;
	double house_GPS_X;
	double house_GPS_Y;

	double house_area; // 쉐어하우스 면적
	String[] house_option; // 쉐어하우스 옵션
	double house_age; // 쉐어하우스 구성원 평균 연령

	double house_score_personal;
	double house_score_clean;
	double house_score_active;

	public double getHouse_score_personal() {
		return house_score_personal;
	}

	public void setHouse_score_personal(double house_score_personal) {
		this.house_score_personal = house_score_personal;
	}

	public double getHouse_score_clean() {
		return house_score_clean;
	}

	public void setHouse_score_clean(int house_score_clean) {
		this.house_score_clean = house_score_clean;
	}

	public double getHouse_score_active() {
		return house_score_active;
	}

	public void setHouse_score_active(int house_score_active) {
		this.house_score_active = house_score_active;
	}

	public double getHouse_age() {
		return house_age;
	}

	public void setHouse_age(double house_age) {
		this.house_age = house_age;
	}

	public String getHouse_option() {
		if (house_option == null)
			return null;
		StringBuffer result = new StringBuffer();
		for (String s : house_option) {
			result.append(s + ",");
		}
		result.deleteCharAt(result.length() - 1);
		return result.toString();
	}

	public String[] getOptionArray() {
		return house_option;
	}

	public void setHouse_option(String house_option) {
		this.house_option = house_option.split(",");
	}

	public double getHouse_area() {
		return house_area;
	}

	public void setHouse_area(double house_area) {
		this.house_area = house_area;
	}

	public House() {
		super();
	}

	@Override
	public String toString() {
		return "[아이디: " + house_id + "\n번호: " + house_num + "\n이름: " + house_name + "\n주소: " + house_address + "\n연락처: "
				+ house_phone + "\n 입주 가능한 방: " + house_available_room + "\n소개: " + house_introduce + "\n이메일: "
				+ house_available_email + "\n현재 상태: " + house_status + "\n소유자: " + house_owner + "\nhouse_file_id="
				+ house_file_id + ", house_upload_file_name=" + house_upload_file_name + "\nhouse_GPS_X=" + house_GPS_X
				+ ", house_GPS_Y=" + house_GPS_Y + "\n면적: " + house_area + "\n옵션: " + Arrays.toString(house_option)
				+ "\n평균연령: " + house_age + "\n개인성 점수: " + house_score_personal + "\n청결도: " + house_score_clean + "\n활동성"
				+ house_score_active + "]";
	}

	public String getHouse_id() {
		return house_id;
	}

	public void setHouse_id(String house_id) {
		this.house_id = house_id;
	}

	public int getHouse_num() {
		return house_num;
	}

	public void setHouse_num(int house_num) {
		this.house_num = house_num;
	}

	public String getHouse_name() {
		return house_name;
	}

	public void setHouse_name(String house_name) {
		this.house_name = house_name;
	}

	public String getHouse_address() {
		return house_address;
	}

	public void setHouse_address(String house_address) {
		this.house_address = house_address;
	}

	public String getHouse_phone() {
		return house_phone;
	}

	public void setHouse_phone(String house_phone) {
		this.house_phone = house_phone;
	}

	public int getHouse_available_room() {
		return house_available_room;
	}

	public void setHouse_available_room(int house_available_room) {
		this.house_available_room = house_available_room;
	}

	public String getHouse_introduce() {
		return house_introduce;
	}

	public void setHouse_introduce(String house_introduce) {
		this.house_introduce = house_introduce;
	}

	public String getHouse_available_email() {
		return house_available_email;
	}

	public void setHouse_available_email(String house_available_email) {
		this.house_available_email = house_available_email;
	}

	public String getHouse_status() {
		return house_status;
	}

	public void setHouse_status(String house_status) {
		this.house_status = house_status;
	}

	public String getHouse_owner() {
		return house_owner;
	}

	public void setHouse_owner(String house_owner) {
		this.house_owner = house_owner;
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

	public double getHouse_GPS_X() {
		return house_GPS_X;
	}

	public void setHouse_GPS_X(double house_GPS_X) {
		this.house_GPS_X = house_GPS_X;
	}

	public double getHouse_GPS_Y() {
		return house_GPS_Y;
	}

	public void setHouse_GPS_Y(double house_GPS_Y) {
		this.house_GPS_Y = house_GPS_Y;
	}
}
