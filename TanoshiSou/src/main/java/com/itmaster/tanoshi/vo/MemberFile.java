package com.itmaster.tanoshi.vo;

public class MemberFile extends Member{

	private String member_id;                // 회원 아이디
	private String member_file_id;            // 회원 프로필 파일 아이디
	private String member_upload_file_name;    // 회원 프로필 업로드 파일 이름
	
	//생성자 
	public MemberFile() {}
	
	
	public MemberFile(String member_id, String member_file_id, String member_upload_file_name) {
		super();
		this.member_id = member_id;
		this.member_file_id = member_file_id;
		this.member_upload_file_name = member_upload_file_name;
	}

	// Getter and Setter
	public String getMember_id() {
		return member_id;
	}


	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}


	public String getMember_file_id() {
		return member_file_id;
	}


	public void setMember_file_id(String member_file_id) {
		this.member_file_id = member_file_id;
	}


	public String getMember_upload_file_name() {
		return member_upload_file_name;
	}


	public void setMember_upload_file_name(String member_upload_file_name) {
		this.member_upload_file_name = member_upload_file_name;
	}


	@Override
	public String toString() {
		return "MemberFile [member_id=" + member_id + ", member_file_id=" + member_file_id
				+ ", member_upload_file_name=" + member_upload_file_name + "]";
	}

}
