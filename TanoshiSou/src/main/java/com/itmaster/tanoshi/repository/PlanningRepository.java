package com.itmaster.tanoshi.repository;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itmaster.tanoshi.dao.PlanningDAO;
import com.itmaster.tanoshi.util.AlarmCronTrigger;
import com.itmaster.tanoshi.vo.Planning;

@Repository
public class PlanningRepository {
	@Autowired
	SqlSession sqlSession;

	private final String NONE = "none";
	private final String DAILY = "daily";
	private final String MONTHLY = "monthly";
	private final String YEARLY = "yearly";

	private static final Logger logger = LoggerFactory.getLogger(PlanningRepository.class);

	// 1)일정 조회하기(월별)
	public ArrayList<Planning> listCal(HashMap<String, Object> map) {
		PlanningDAO mapper = sqlSession.getMapper(PlanningDAO.class);
		ArrayList<Planning> result = null;
		try {
			result = mapper.listCal(map);
			System.out.println(result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public int saveScheduler(Planning vo, String email) {
		int ret = 0;
		PlanningDAO mapper = sqlSession.getMapper(PlanningDAO.class);

		Planning exist = getEvent(vo.getPlan_id());
		logger.debug("exist: {}", exist);
		logger.debug("email : {}", email);

		if (exist != null) {
			logger.debug("-------------------- event update process start1");
			if (!vo.getRepeat_type().equals("none")) {
				vo.setStart_date(exist.getStart_date());
				vo.setEnd_date(exist.getEnd_date());
				logger.debug("recurring update start & end date setting");
			}
			ret = modifyEvent(vo);
			logger.debug("-------------------- event update process end");
		} else {
			logger.debug("-------------------- event create process start");
			ret = saveCal(vo);
			logger.debug("-------------------- event create process end");
		}

		HashMap<String, Object> param = new HashMap<>();
		// 알림세팅
		if (ret > 0) {
			if (exist != null) {
				if ("T".equals(exist.getAlarm_yn())) {
					logger.debug("-------------------- UPDATE mail sending process start");
					String alarm_time = null;
					try {
						alarm_time = mapper.selectAlarmTime(param.get("id").toString());
					} catch (Exception e) {
						e.printStackTrace();
					}
					logger.debug("alarm at {}", alarm_time);
					System.out.println("수정한 메일 날려날려~~~~~~~!!!!");
					AlarmCronTrigger cron = new AlarmCronTrigger(alarm_time, param.get("id").toString(), email,
							"[알람]" + exist.getText(),
							"<br> 아래 일정이 곧 시작합니다.<hr><br> 제목 - " + exist.getText() + "<br> 내용 - " + exist.getContent()
									+ "<br> 이벤트 시작시간 - " + exist.getStart_date() + "<br> 이벤트 종료시간 - "
									+ exist.getEnd_date() + "<br><hr>©TANOSHISHOU. ");
					cron.deleteJob();
					cron.createJob();
					logger.debug("-------------------- UPDATE mail sending process end");
				}
			} else {
				String latest_id = null;
				try {
					latest_id = mapper.selectLatestEventNum();
				} catch (Exception e) {
					e.printStackTrace();
				}
				Planning latest_vo = getEvent(latest_id);
				if ("T".equals(latest_vo.getAlarm_yn())) {
					logger.debug("-------------------- CREATE mail sending process start");
					String alarm_time = null;
					try {
						alarm_time = mapper.selectAlarmTime(latest_id);
					} catch (Exception e) {
						e.printStackTrace();
					}
					logger.debug("alarm at {}", alarm_time);
					AlarmCronTrigger cron = new AlarmCronTrigger(alarm_time, latest_id, email,
							"[알람]" + latest_vo.getText(),
							"<br> 아래 일정이 곧 시작합니다.<hr><br> 제목 - " + latest_vo.getText() + "<br> 내용 - "
									+ latest_vo.getContent() + "<br> 이벤트 시작시간 - " + latest_vo.getStart_date()
									+ "<br> 이벤트 종료시간 - " + latest_vo.getEnd_date() + "<br><hr>©TANOSHISHOU. ");
					System.out.println("새로만든 메일 날려날려~~~~~~~!!!!");
					cron.deleteJob();
					cron.createJob();
					logger.debug("-------------------- CREATE mail sending process end");
				}
			}
		}

		return ret;
	}

	// 2)일정 저장
	public int saveCal(Planning planning) {
		/*
		 * 무제한 반복이라고 했을때 5년을 치고 컨트롤러로 넘겼을때...
		 * 
		 * .PlanningController - 0 : day DEBUG:
		 * global.sesoc.Planning.CalendarController - 1 : 1 DEBUG:
		 * global.sesoc.calendar.CalendarController - 2 : DEBUG:
		 * global.sesoc.calendar.CalendarController - 3 : DEBUG:
		 * global.sesoc.calendar.CalendarController - 4 : #no
		 * 
		 * 매월 15일로 설정할 경우 CalendarController - start_time: 2017-04-15 00:00:00
		 * DEBUG: global.sesoc.calendar.CalendarController - +++++++++++++
		 * DEBUG: global.sesoc.calendar.CalendarController - end_time:
		 * 2022-04-05 00:05:00 DEBUG: global.sesoc.calendar.CalendarController -
		 * 0 : month DEBUG: global.sesoc.calendar.CalendarController - 1 : 1
		 * DEBUG: global.sesoc.calendar.CalendarController - 2 : DEBUG:
		 * global.sesoc.calendar.CalendarController - 3 : DEBUG:
		 * global.sesoc.calendar.PlanningController - 4 : #no
		 */
		logger.debug("vo : {}", planning);

		int result = -1;
		PlanningDAO mapper = sqlSession.getMapper(PlanningDAO.class);

		switch (planning.getRepeat_type()) {
		case DAILY: // 매일 반복
			planning.setRepeat_type(DAILY);
			break;

		case MONTHLY: // 매월 반복
			planning.setRepeat_type(MONTHLY);
			break;

		case YEARLY: // 매년 반복
			planning.setRepeat_type(YEARLY);
			break;

		default:
			planning.setRepeat_type(NONE);
			break;
		}

		try {
			result = mapper.saveCal(planning);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	// 3)일정 삭제
	public int delCal(String calId) {
		int result = -1;
		PlanningDAO mapper = sqlSession.getMapper(PlanningDAO.class);
		int id = 0;
		try {
			id = Integer.parseInt(calId);
		} catch (NumberFormatException e) {
			String[] sp = calId.split("_");
		}

		try {
			mapper.delCal(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	// 아이디에 해당하는 내용 얻기
	public Planning getEvent(String id) {
		Planning ret = null;
		PlanningDAO mapper = sqlSession.getMapper(PlanningDAO.class);
		try {
			ret = mapper.selectEvent(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}

	public int modifyEvent(Planning vo) {
		int ret = 0;
		PlanningDAO mapper = sqlSession.getMapper(PlanningDAO.class);
		try {
			ret = mapper.updateEvent(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}

	protected int dateCheck(Date a, Date b) {
		logger.debug("dateCheck :: {} - {}", a, b);
		int ret = 0;
		if (a.compareTo(b) > 0) {
			ret = -1; // a가 b보다 느린날짜일때
		} else if (a.compareTo(b) < 0) {
			ret = 1; // a가 b보다 빠른 날짜일때
		}

		logger.debug("dateCheck RET == {}", ret);

		return ret;
	}

	public boolean clearPlanning(String member_id) {
		PlanningDAO mapper = sqlSession.getMapper(PlanningDAO.class);
		int result = 0;
		try {
			result = mapper.clearPlanning(member_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (result != 0)
			return true;
		else
			return false;
	}
}
