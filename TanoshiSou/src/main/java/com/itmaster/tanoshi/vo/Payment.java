package com.itmaster.tanoshi.vo;

public class Payment {
	public String getPay_for() {
		return pay_for;
	}

	public void setPay_for(String pay_for) {
		this.pay_for = pay_for;
	}

	int pay_id;
	int pay_amount;
	int pay_year;
	int pay_month;
	String house_id;
	String pay_category;
	String pay_for;
	String pay_inputdate;
	String member_name;

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public int getPay_id() {
		return pay_id;
	}

	public void setPay_id(int pay_id) {
		this.pay_id = pay_id;
	}

	public int getPay_amount() {
		return pay_amount;
	}

	public void setPay_amount(int pay_amount) {
		this.pay_amount = pay_amount;
	}

	public int getPay_year() {
		return pay_year;
	}

	public void setPay_year(int pay_year) {
		this.pay_year = pay_year;
	}

	public int getPay_month() {
		return pay_month;
	}

	public void setPay_month(int pay_month) {
		this.pay_month = pay_month;
	}

	public String getHouse_id() {
		return house_id;
	}

	public void setHouse_id(String house_id) {
		this.house_id = house_id;
	}

	public String getPay_category() {
		return pay_category;
	}

	public void setPay_category(String pay_category) {
		this.pay_category = pay_category;
	}

	public String getPay_text() {
		return pay_for;
	}

	public void setPay_text(String pay_text) {
		this.pay_for = pay_text;
	}

	public String getPay_inputdate() {
		return pay_inputdate;
	}

	public void setPay_inputdate(String pay_inputdate) {
		this.pay_inputdate = pay_inputdate;
	}

	@Override
	public String toString() {
		return "관리비\n하우스: " + house_id + "\n고유번호: "+ pay_id + "\n관리비: " + pay_amount + "\n년: " + pay_year + "\n월: "
				+ pay_month + "\n카테고리: " + pay_category + "\n부과대상: " + pay_for
				+ "\n입력일: " + pay_inputdate;
	}

	public Payment() {
		super();
	}
}
