package com.itmaster.tanoshi.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.itmaster.tanoshi.vo.House;
import com.itmaster.tanoshi.vo.Member;
import com.itmaster.tanoshi.vo.MemberDetail;
import com.itmaster.tanoshi.vo.MemberFile;

public interface MemberDAO {
	/**
	 * 회원 가입
	 * 
	 * @param member
	 * @return
	 * @throws Exception
	 */
	public int insertMember(Member member) throws Exception;

	/**
	 * 회원 프로필 파일
	 * 
	 * @param memberFile
	 * @return
	 * @throws Exception
	 */
	public int insertMemberProFile(MemberFile memberFile) throws Exception;

	/**
	 * 로그인
	 * 
	 * @param member_id
	 * @param password
	 * @return
	 * @throws Exception
	 */
	public Member login(String login_id, String loginPassword) throws Exception;

	/**
	 * 아이디 체크
	 * 
	 * @param member_id
	 * @return
	 * @throws Exception
	 */
	public String checkMemberId(String member_id) throws Exception;

	public String checkMemberEmail(String member_email) throws Exception;

	public String checkMemberPhone(String member_phone) throws Exception;

	/**
	 * 회원 정보
	 * 
	 * @param member_id
	 * @return
	 * @throws Exception
	 */
	public Member getMember(String member_id) throws Exception;

	/**
	 * 멤버 프로파일 호출
	 * 
	 * @param member_id
	 * @return
	 * @throws Exception
	 */
	public MemberFile getMemberProfile(String member_id) throws Exception;

	// 맴버 업데이트
	public int updateMember(Member member) throws Exception;

	// 맴버 파일 지우기
	public int deleteMemberProfile(String member_file_id) throws Exception;

	// 해당 이용자의 쉐어하우스 입주 신청
	public int applyHouse(String member_id, String house_id) throws Exception;

	// 입주 신청 승인
	public int grantResident(String member_id) throws Exception;

	// 입주 신청 거절
	public int declineResident(String member_id) throws Exception;

	// 하우스 생성 시 회원 상태 승인 대기로 변경
	public int insertHouse(House house) throws Exception;

	// 현재 쉐어하우스 입주 신청을 한 사용자 불러오기
	public ArrayList<Member> getPendingMembers(String house_id) throws Exception;

	// 쉐어하우스 개설 승인 후 회원정보 업데이트
	public int acceptHouse(String house_id, String house_owner) throws Exception;

	public ArrayList<Member> getResidents(String house_id) throws Exception;

	// 멤버 디테일 부분
	// 정보 불러오기
	public MemberDetail getMemberDetail(String member_id) throws Exception;

	// 정보 저장
	public int insertMemberDetail(MemberDetail memberDetail) throws Exception;

	// 정보 업데이트
	public int updateMemberDetail(MemberDetail memberDetail) throws Exception;

	// email 찾기
	public Member getMemberEmail(String member_id, String member_password_check_a, int member_password_check_q)
			throws Exception;

	// id 찾기
	// public String getMemberId(String member_phone, String member_name) throws
	// Exception;
	public String getMemberId(String member_phone, String member_name) throws Exception;

}