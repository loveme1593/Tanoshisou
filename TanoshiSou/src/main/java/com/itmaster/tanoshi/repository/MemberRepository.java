package com.itmaster.tanoshi.repository;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itmaster.tanoshi.dao.MemberDAO;
import com.itmaster.tanoshi.vo.House;
import com.itmaster.tanoshi.vo.Member;
import com.itmaster.tanoshi.vo.MemberDetail;
import com.itmaster.tanoshi.vo.MemberFile;

@Repository
public class MemberRepository {

	@Autowired
	SqlSession sqlSession;

	MemberDAO dao;
	private static final Logger logger = LoggerFactory.getLogger(MemberRepository.class);

	// 회원 가입
	public int insertMember(Member member) {
		int result = 0;
		dao = sqlSession.getMapper(MemberDAO.class);
		try {
			result = dao.insertMember(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// 회원 사진 등록
	public int insertMemberProfile(MemberFile memberfile) {
		int result = 0;
		dao = sqlSession.getMapper(MemberDAO.class);

		try {
			result = dao.insertMemberProFile(memberfile);
		} catch (Exception e) {
			e.printStackTrace();

		}
		return result;
	}
		
	// 로그인
	public Member login(String login_id, String login_password) {
		Member loginMember = null;
		dao = sqlSession.getMapper(MemberDAO.class);
		try {
			loginMember = dao.login(login_id, login_password);
			if (loginMember == null) {
				loginMember = null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return loginMember;
	}

	// 아이디 체크
	public String checkMemberId(String member_id) {
		String checkIdResult = null;
		dao = sqlSession.getMapper(MemberDAO.class);
		try {
			checkIdResult = dao.checkMemberId(member_id);
			if (checkIdResult == null) {
				checkIdResult = "";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checkIdResult;
	}

	// 아이디 이메일
	public String checkMemberEmail(String member_email) {
		String checkIdResult = null;
		dao = sqlSession.getMapper(MemberDAO.class);
		try {
			checkIdResult = dao.checkMemberEmail(member_email);
			if (checkIdResult == null) {
				checkIdResult = "";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checkIdResult;
	}

	// 아이디 전화번호
	public String checkMemberPhone(String member_phone) {
		String checkIdResult = null;
		dao = sqlSession.getMapper(MemberDAO.class);
		try {
			checkIdResult = dao.checkMemberPhone(member_phone);
			if (checkIdResult == null) {
				checkIdResult = "";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checkIdResult;
	}

	// 회원 정보 가져오기
	public Member getMember(String member_id) {
		Member checkIdResult = null;
		dao = sqlSession.getMapper(MemberDAO.class);
		try {
			checkIdResult = dao.getMember(member_id);
			if (checkIdResult == null) {
				checkIdResult = null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return checkIdResult;
	}

	// 유저 프로필 불러오기
	public MemberFile getMemberProfile(String member_id) {
		MemberFile memberfile = null;
		dao = sqlSession.getMapper(MemberDAO.class);
		try {
			memberfile = dao.getMemberProfile(member_id);
			if (memberfile == null) {
				memberfile = null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memberfile;
	}

	// 유저 업데이트
	public int updateMember(Member member) {
		int uploadResult = 0;
		dao = sqlSession.getMapper(MemberDAO.class);
		System.out.println(member.toString() + "//////");
		try {
			uploadResult = dao.updateMember(member);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return uploadResult;

	}

	public int deleteMemberProfile(String member_file_id) {
		int deleteLoadResult = 0;
		if (member_file_id == null) {
			return deleteLoadResult;
		}
		dao = sqlSession.getMapper(MemberDAO.class);
		try {
			deleteLoadResult = dao.deleteMemberProfile(member_file_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return deleteLoadResult;
	}

	public boolean applyHouse(String member_id, String house_id) {
		dao = sqlSession.getMapper(MemberDAO.class);
		int result = 0;
		try {
			result = dao.applyHouse(member_id, house_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (result != 0)
			return true;
		else
			return false;
	}

	// 입주 신청 승인
	public boolean grantResident(String member_id) {
		dao = sqlSession.getMapper(MemberDAO.class);
		int result = 0;
		try {
			result = dao.grantResident(member_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (result != 0)
			return true;
		else
			return false;
	}

	// 입주 신청 거절
	public boolean declineResident(String member_id) {
		dao = sqlSession.getMapper(MemberDAO.class);
		int result = 0;
		try {
			result = dao.declineResident(member_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (result != 0)
			return true;
		else
			return false;
	}

	// 하우스 생성 시 회원 상태 승인 대기로 변경
	public boolean insertHouse(House house) {
		dao = sqlSession.getMapper(MemberDAO.class);
		int result = 0;
		try {
			result = dao.insertHouse(house);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (result != 0)
			return true;
		else
			return false;
	}

	// 현재 쉐어하우스 입주 신청을 한 사용자 불러오기
	public ArrayList<Member> getPendingMembers(String house_id) {
		dao = sqlSession.getMapper(MemberDAO.class);
		ArrayList<Member> list = null;
		try {
			list = dao.getPendingMembers(house_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	// 쉐어하우스 개설 승인 후 회원정보 업데이트
	public boolean acceptHouse(String house_id, String house_owner) {
		dao = sqlSession.getMapper(MemberDAO.class);
		int result = 0;
		try {
			result = dao.acceptHouse(house_id, house_owner);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (result != 0)
			return true;
		else
			return false;
	}
	/* 해당 쉐어하우스의 거주자를 전부 가져옴 */
	public ArrayList<Member> getResidents(String house_id) {
		dao = sqlSession.getMapper(MemberDAO.class);
		ArrayList<Member> result = null;
		try {
			result = dao.getResidents(house_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public String getMemberId(String member_phone, String member_name) {
		String resultId = null;
		dao = sqlSession.getMapper(MemberDAO.class);
		try {
			resultId = dao.getMemberId(member_phone, member_name);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resultId;
	}
	
}