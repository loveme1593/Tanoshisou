package com.itmaster.tanoshi.vo;

public class Planning {
	
	private String house_id; // shareHouseID 쉐어하우스id
	private String member_id; // board_member_id 유저id	
	private String plan_id; //일정 plan sequence 에 대한 아이디 	
	private String start_date; //시작날짜
	private String end_date;
	private String text; //plan 제목
	private String content; //plan 내용
	private String repeat_type; //plan 반복타입
	private String repeat_end_date; //plan 반복 종료날짜
	private String is_dbdata; //디비에 존재 유무 확인용
	private String alarm_yn; //일정알람 존재여부
	private String alarm_val; //일정알람 선택값
	private String category; //일정의 카테고리 
	private String inputdate;//일정 생성일
	
	public Planning() {
		// TODO Auto-generated constructor stub
	}
	
	
	public String getInputdate() {
		return inputdate;
	}


	public void setInputdate(String inputdate) {
		this.inputdate = inputdate;
	}


	public String getHouse_id() {
		return house_id;
	}
	public void setHouse_id(String house_id) {
		this.house_id = house_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getPlan_id() {
		return plan_id;
	}
	public void setPlan_id(String plan_id) {
		this.plan_id = plan_id;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRepeat_type() {
		return repeat_type;
	}
	public void setRepeat_type(String repeat_type) {
		this.repeat_type = repeat_type;
	}
	public String getRepeat_end_date() {
		return repeat_end_date;
	}
	public void setRepeat_end_date(String repeat_end_date) {
		this.repeat_end_date = repeat_end_date;
	}
	public String getIs_dbdata() {
		return is_dbdata;
	}
	public void setIs_dbdata(String is_dbdata) {
		this.is_dbdata = is_dbdata;
	}
	public String getAlarm_yn() {
		return alarm_yn;
	}
	public void setAlarm_yn(String alarm_yn) {
		this.alarm_yn = alarm_yn;
	}
	public String getAlarm_val() {
		return alarm_val;
	}
	public void setAlarm_val(String alarm_val) {
		this.alarm_val = alarm_val;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}


	@Override
	public String toString() {
		return "Planning [house_id=" + house_id + ", member_id=" + member_id + ", plan_id=" + plan_id + ", start_date="
				+ start_date + ", end_date=" + end_date + ", text=" + text + ", content=" + content + ", repeat_type="
				+ repeat_type + ", repeat_end_date=" + repeat_end_date + ", is_dbdata=" + is_dbdata + ", alarm_yn="
				+ alarm_yn + ", alarm_val=" + alarm_val + ", category=" + category + ", inputdate=" + inputdate + "]";
	}
	
	

}