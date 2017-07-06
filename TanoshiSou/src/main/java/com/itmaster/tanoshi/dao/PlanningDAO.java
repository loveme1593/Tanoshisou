package com.itmaster.tanoshi.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.itmaster.tanoshi.vo.Planning;

public interface PlanningDAO {

	// 1)일정조회(월별)
	public ArrayList<Planning> listCal(HashMap<String, Object> map) throws Exception;

	// 1-2)일정조회(년)///이놈필요없음
	// public ArrayList<Planning> listCalYr(String date) throws Exception;
	// 2)일정 저장
	public int saveCal(Planning planning) throws Exception;

	// 3)일정 삭제
	public int delCal(int calId) throws Exception;

	// 아이디에 해당하는 이벤트 존재여부 구하기 (수정/등록 분기처리시 사용)
	public Planning selectEvent(String id) throws Exception;

	// 일정 수정
	public int updateEvent(Planning vo) throws Exception;

	// 최신글번호 구하기 (반복등록시 필요)
	public String selectLatestEventNum() throws Exception;

	// 날짜 구하기 (반복등록시 필요)
	public String selectNextDate(String current_date) throws Exception;

	// 아이디에 해당하는 알림시간 얻기
	public String selectAlarmTime(String id) throws Exception;

	// 퇴거 시 해당 입주자의 일정 전부 삭제
	public int clearPlanning(String member_id) throws Exception;
}
