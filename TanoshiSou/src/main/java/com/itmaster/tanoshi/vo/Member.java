package com.itmaster.tanoshi.vo;

public class Member {
	private int member_num; // 회원번호
	private String member_id; // 회원 아이디
	private String member_name; // 회원 이름
	private String member_nickname; // 회원 별칭
	private String member_password; // 회원 비밀번호
	private String member_type; // 회원 타입(일반,입주민,집관리자,웹관리자)
	private String member_phone; // 회원 전화번호
	private String member_email; // 회원 이메일
	private String member_emailLIst;
	private String member_belongto; // 회원 소속(집 - 일반회원 - general)
	private int member_password_check_q; // 회원 비밀번호 찾기 질문(콤보박스에 질문 번호로 저장)
	private String member_password_check_a; // 회원 비밀번호 찾기 답

	// 생성자
	public Member() {
	}

	public Member(int member_num, String member_id, String member_name, String member_nickname, String member_password,
			String member_type, String member_phone, String member_email, String member_belongto,
			int member_password_check_q, String member_password_check_a, String member_emailLIst) {
		super();
		this.member_num = member_num;
		this.member_id = member_id;
		this.member_name = member_name;
		this.member_nickname = member_nickname;
		this.member_password = member_password;
		this.member_type = member_type;
		this.member_phone = member_phone;
		this.member_email = member_email;
		this.member_belongto = member_belongto;
		this.member_password_check_q = member_password_check_q;
		this.member_password_check_a = member_password_check_a;
		this.member_emailLIst = member_emailLIst;
	}

	// Getter And Setter
	public int getMember_num() {
		return member_num;
	}

	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_nickname() {
		return member_nickname;
	}

	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}

	public String getMember_password() {
		return member_password;
	}

	public void setMember_password(String member_password) {
		this.member_password = member_password;
	}

	public String getMember_type() {
		return member_type;
	}

	public void setMember_type(String member_type) {
		this.member_type = member_type;
	}

	public String getMember_phone() {
		return member_phone;
	}

	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}

	public String getMember_email() {
		return member_email;
	}

	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}

	public String getMember_belongto() {
		return member_belongto;
	}

	public void setMember_belongto(String member_belongto) {
		this.member_belongto = member_belongto;
	}

	public int getMember_password_check_q() {
		return member_password_check_q;
	}

	public void setMember_password_check_q(int member_password_check_q) {
		this.member_password_check_q = member_password_check_q;
	}

	public String getMember_password_check_a() {
		return member_password_check_a;
	}

	public void setMember_password_check_a(String member_password_check_a) {
		this.member_password_check_a = member_password_check_a;
	}

	public String getMember_emailLIst() {
		return member_emailLIst;
	}

	public void setMember_emailLIst(String member_emailLIst) {
		this.member_emailLIst = member_emailLIst;
	}

	@Override
	public String toString() {
		return "Member [member_num=" + member_num + ", member_id=" + member_id + ", member_name=" + member_name
				+ ", member_nickname=" + member_nickname + ", member_password=" + member_password + ", member_type="
				+ member_type + ", member_phone=" + member_phone + ", member_email=" + member_email
				+ ", member_belongto=" + member_belongto + ", member_password_check_q=" + member_password_check_q
				+ ", member_password_check_a=" + member_password_check_a + ", member_emailLIst=" + member_emailLIst
				+ "]";
	}

}
