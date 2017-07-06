package com.itmaster.tanoshi.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itmaster.tanoshi.dao.MemberDetailDAO;
import com.itmaster.tanoshi.vo.MemberDetail;

@Repository
public class MemberDetailRepository {

	MemberDetailDAO dao;

	@Autowired
	SqlSession session;

	public boolean insertMemberDetail(MemberDetail detail) {
		int result = 0;
		dao = session.getMapper(MemberDetailDAO.class);
		try {
			result = dao.insertMemberDetail(detail);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result!=0)
			return true;
		else
			return false;
	}

	// 업데이트
	public boolean updateMemberDetail(MemberDetail memberDetail) {
		dao = session.getMapper(MemberDetailDAO.class);
		int result = 0;
		try {
			result = dao.updateMemberDetail(memberDetail);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result!=0)
			return true;
		else
			return false;
	}

	// 정보 찾기
	public MemberDetail getMemberDetail(String member_id) {
		dao = session.getMapper(MemberDetailDAO.class);
		MemberDetail getResult = null;
		try {
			getResult = dao.getMemberDetail(member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return getResult;
	}

	public List<MemberDetail> getMemberDetailByHouse(String house_id) {
		dao = session.getMapper(MemberDetailDAO.class);
		List<MemberDetail> getResult = null;
		try {
			getResult = dao.getMemberDetailByHouse(house_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return getResult;
	}
	public boolean setScore(MemberDetail detail)
	{
		dao = session.getMapper(MemberDetailDAO.class);
		int result = 0;
		try {
			result = dao.setScore(detail);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result!=0)
			return true;
		else
			return false;		
	}
}
