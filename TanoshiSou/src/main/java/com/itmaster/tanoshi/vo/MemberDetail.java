package com.itmaster.tanoshi.vo;

import java.util.Date;

public class MemberDetail {

	String member_id;
	String detail_gender;
	String detail_birthday;
	String detail_job_title;
	String detail_hobby;
	String detail_address;
	String detail_bloodtype;
	String detail_introduce;
	String detail_religion;
	int score_personal=9999;
	int score_clean=9999;
	int score_active=9999;

	public String getDetail_bloodtype() {
		return detail_bloodtype;
	}

	public void setDetail_bloodtype(String detail_bloodtype) {
		this.detail_bloodtype = detail_bloodtype;
	}

	public MemberDetail() {
	}

	public int getScore_personal() {
		return score_personal;
	}

	public void setScore_personal(int score_personal) {
		this.score_personal = score_personal;
	}

	public int getScore_clean() {
		return score_clean;
	}

	public void setScore_clean(int score_clean) {
		this.score_clean = score_clean;
	}

	public int getScore_active() {
		return score_active;
	}

	public void setScore_active(int score_active) {
		this.score_active = score_active;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getDetail_gender() {
		return detail_gender;
	}

	public void setDetail_gender(String detail_gender) {
		this.detail_gender = detail_gender;
	}

	public String getDetail_birthday() {
		return detail_birthday;
	}

	public void setDetail_birthday(String detail_birthday) {
		this.detail_birthday = detail_birthday;
	}

	public String getDetail_job_title() {
		return detail_job_title;
	}

	public void setDetail_job_title(String detail_job_title) {
		this.detail_job_title = detail_job_title;
	}

	public String getDetail_hobby() {
		return detail_hobby;
	}

	public void setDetail_hobby(String detail_hobby) {
		this.detail_hobby = detail_hobby;
	}

	public String getDetail_address() {
		return detail_address;
	}

	public void setDetail_address(String detail_address) {
		this.detail_address = detail_address;
	}

	public String getDetail_introduce() {
		return detail_introduce;
	}

	public void setDetail_introduce(String detail_introduce) {
		this.detail_introduce = detail_introduce;
	}

	@Override
	public String toString() {
		return "[id=" + member_id + "\n성별: " + detail_gender + "\n생일: " + detail_birthday + "\n직업: " + detail_job_title
				+ "\n취미: " + detail_hobby + "\n주소: " + detail_address + "\n혈액형: " + detail_bloodtype + "\n종교: "
				+ detail_religion + "\n자기소개: " + detail_introduce + "\n성격:" + score_personal + "\n청결도: " + score_clean
				+ "\n활동성: " + score_active;
	}

	public String getDetail_religion() {
		return detail_religion;
	}

	public void setDetail_religion(String detail_religion) {
		this.detail_religion = detail_religion;
	}

	public boolean hasScore() {
		if (score_personal != 9999 && score_active != 9999 && score_clean != 9999)
			return true;
		else
			return false;
	}
}