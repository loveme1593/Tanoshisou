package com.itmaster.tanoshi.dao;

import java.util.List;

import com.itmaster.tanoshi.vo.MemberDetail;

public interface MemberDetailDAO {

	public int insertMemberDetail(MemberDetail memberdetail) throws Exception;
	
	// 정보 가져오기
	public MemberDetail getMemberDetail(String member_id) throws Exception;
	
	// 정보 업데이트
	public int updateMemberDetail(MemberDetail memberDetail) throws Exception;
	
	// 쉐어하우스 별로 가져오기
	public List<MemberDetail> getMemberDetailByHouse(String house_id) throws Exception;
	
	public int setScore(MemberDetail memberDetail) throws Exception;
}
