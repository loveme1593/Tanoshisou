drop TABLE planning;

drop SEQUENCE planning_seq;


create table planning(
  plan_id number not null primary key, --플랜아이디(플랜시퀀스)
  house_id varchar2(50) REFERENCES house(house_id) on delete cascade, --쉐어하우스 아이디
  member_id varchar2(20) REFERENCES member(member_id) on delete cascade, --멤버아이디
  start_date date, --시작날짜
  end_date date, --종료날짜
  text varchar2(500), --제목
  content varchar2(2000), --내용
  repeat_type varchar2(50), --반복타입
  repeat_end_date date, --반복 종료날짜
  is_dbdata char(1), -- 디비에 존재 유무 확인용
  alarm_yn char(1) DEFAULT 'F' NOT NULL, --일정 알람 존재유무
  alarm_val number, -- 알람 선택값
  category varchar2(30), -- 카테고리 
  inputdate date default sysdate
);
create sequence planning_seq;
--
--	private String house_id; // shareHouseID 쉐어하우스id
--	private String member_id; // board_member_id 유저id	
--	private String plan_id; //일정 plan sequence 에 대한 아이디 	
--	private String start_date; //시작날짜
--	private String end_date;
--	private String text; //plan 제목
--	private String content; //plan 내용
--	private String repeat_type; //plan 반복타입
--	private String repeat_end_date; //plan 반복 종료날짜
--	private String is_dbdata; //디비에 존재 유무 확인용
--	private String alarm_yn; //일정알람 존재여부
--	private String alarm_val; //일정알람 선택값
--	private String category; //일정의 카테고리 
--	private String inputdate;//일정 생성일
--	

