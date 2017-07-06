package com.itmaster.tanoshi.vo;

public class Vote {

	private int voteid; // vote table id = vote_seq;
	private String data_type; // planning or board;
	private int pid; // planning or board의 id값
	private String member_id;// member table id 참조
	private String decision; // yes or no로 데이터 저장~
	private String votetitle; // 투표 주제

	public Vote() {
		// TODO Auto-generated constructor stub
	}

	public String getVotetitle() {
		return votetitle;
	}

	public void setVotetitle(String votetitle) {
		this.votetitle = votetitle;
	}

	public int getVoteid() {
		return voteid;
	}

	public void setVoteid(int voteid) {
		this.voteid = voteid;
	}

	public String getData_type() {
		return data_type;
	}

	public void setData_type(String data_type) {
		this.data_type = data_type;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getDecision() {
		return decision;
	}

	public void setDecision(String decision) {
		this.decision = decision;
	}

	@Override
	public String toString() {
		return "Vote [voteid=" + voteid + ", data_type=" + data_type + ", pid=" + pid + ", member_id=" + member_id
				+ ", decision=" + decision + ", votetitle=" + votetitle + "]";
	}
}
