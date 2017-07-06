-- Database Reference

/* 유저 생성 */

create user tanoshi identified by tanoshi;
<<<<<<< HEAD
grant dba to tanoshi;


create sequence board_seq;
create sequence member_seq;
create sequence reply_seq;
create sequence house_seq;

/* Create Tables */

CREATE TABLE board
(
	-- 쉐어하우스 아이디
	house_id varchar2(50) NOT NULL,
	-- 메인 게시판 아이디
	board_Id number NOT NULL,
	-- 메인 게시판 넘버
	board_num number NOT NULL UNIQUE,
	-- 메인 게시판 제목
	board_title varchar2(300) NOT NULL,
	-- 메인 게시판 사용자 닉네임
	board_nickname varchar2(50) NOT NULL,
	-- 메인 게시판 날짜
	board_inputdate date DEFAULT sysdate NOT NULL,
	-- 메인 게시판 내용
	board_content varchar2(2000),
	-- 메인 게시판 비교할 아이디
	board_member_id varchar2(50) NOT NULL,
	PRIMARY KEY (board_Id)
);


CREATE TABLE board_file
(
	-- 메인 게시판 아이디
	board_Id number NOT NULL,
	-- 게시판 파일 이름
	board_file_id varchar2(10) DEFAULT 'noFile' NOT NULL,
	-- 게시판 파일 저장 이름
	board_save_file_name varchar2(300) DEFAULT 'nofile',
	-- 게시판 업로드 파일 이름
	board_upload_file_name varchar2(300) DEFAULT 'nofile',
	PRIMARY KEY (board_file_id)
);


CREATE TABLE board_info
(
	-- 메인 게시판 아이디
	board_Id number NOT NULL,
	-- 사진첩_ 게시판_카테고리
	photo_and_board_category varchar2(50) NOT NULL
);


CREATE TABLE house
(
	-- 쉐어하우스 아이디
	house_id varchar2(50) NOT NULL,
	-- 쉐어하우스 넘버
	house_num number NOT NULL UNIQUE,
	-- 쉐어하우스 집명
	house_name varchar2(100) NOT NULL,
	-- 쉐어하우스 주소
	house_address varchar2(300) NOT NULL,
	-- 쉐어하우스 전화번호
	house_phone varchar2(20),
	-- 쉐어하우스 가능한 방
	house_available_room number NOT NULL,
	-- 쉐어하우스 집소개
	house_introduce varchar2(2000) NOT NULL,
	-- 쉐어하우스 집주인 연락 가능한 이메일
	house_available_email varchar2(100),
	-- 쉐어하우스 등록 상태
	house_status varchar2(20) NOT NULL,
	-- 쉐어하우스 관리자 아이디
	house_owner varchar2(20) NOT NULL,
	PRIMARY KEY (house_id)

);


CREATE TABLE house_file
(
	-- 하우스 파일 아이디
	house_id varchar2(50) NOT NULL,
	-- 쉐어하우스 파일 아이디
	house_file_id varchar2(10) DEFAULT 'noFile' NOT NULL,
	-- 쉐어 하우스 파일 저장 이름
	house_save_file_name varchar2(300) DEFAULT 'nofile',
	-- 쉐어하우스 업로드 파일 이름
	house_upload_file_name varchar2(300) DEFAULT 'nofile',
	PRIMARY KEY (house_file_id)
);


CREATE TABLE member
(
	-- 회원 번호
	member_num number NOT NULL UNIQUE,
	-- 회원아이디
	member_id varchar2(20) NOT NULL,
	-- 이름
	member_name varchar2(20) NOT NULL,
	-- 닉네임
	member_nickname varchar2(50) NOT NULL UNIQUE,
	-- 비밀번호
	member_password varchar2(20) NOT NULL,
	-- 멤버 타입
	member_type varchar2(10) DEFAULT 'general' NOT NULL,
	-- 전화번호
	member_phone varchar2(20) NOT NULL UNIQUE,
	-- 이메일
	member_email varchar2(50) UNIQUE,
	-- 소속되어 있은 하우스 이름
	member_belongto varchar2(200) DEFAULT 'none' NOT NULL,
	-- 비밀번호 찾기 질문
	member_password_check_Q number NOT NULL,
	-- 질문의 답
	member_password_check_A varchar2(200) NOT NULL,
	PRIMARY KEY (member_id)
);


CREATE TABLE member_detail
(
	-- 회원아이디
	member_id varchar2(20) NOT NULL,
	-- 세부사항 직업
	detail_job_title varchar2(80),
	-- 세부사항 생일
	detail_birthday date,
	-- 세부사항 성별
	detail_Gender varchar2(10),
	-- 세부사항 주소
	detail_address varchar2(300),
	-- 세부사항 선호하는 집
	detail_prefer_house varchar2(30),
	-- 세부사항 취미
	detail_hobby varchar2(100),
	-- 세부사항 자기소개
	detail_introduce varchar2(1000),
	-- 세부사항 좋아하는 것들(단어로)
	detail_prefered_things varchar2(200),
	-- 세부사항  회원 성격
	detail_character varchar2(100),
	-- 세부사항 회원이 선호하는 사람 성격
	detail_favorite_people_type varchar2(100)
);


CREATE TABLE member_file
(
	-- 회원아이디
	member_id varchar2(20) NOT NULL,
	-- 회원 프로필 파일 아이디
	member_file_id varchar2(10) DEFAULT 'noFile' NOT NULL,
	-- 회원 프로필 파일 저장이름
	member_save_file_name varchar2(300) DEFAULT 'nofile',
	-- 회원 프로필 파일 업로드 이름
	member_upload_file_name varchar2(300) DEFAULT 'nofile',
	PRIMARY KEY (member_file_id)
);


CREATE TABLE payment
(
	-- 메인 게시판 아이디
	board_Id number NOT NULL,
	-- 운영비 카테고리
	pay_category varchar2(10) NOT NULL,
	-- 운영비 총 액
	pay_amont number(10,2) NOT NULL,
	-- 운영비 사항 내용
	pay_text varchar2(2000) NOT NULL,
	-- 운영비 구분 년도
	pay_year number NOT NULL,
	-- 운영비 구분 년수
	pay_month number NOT NULL,
	-- 운영비 설정 시 날짜 지정
	pay_selected_date date
);


CREATE TABLE planning
(
	-- 메인 게시판 아이디
	board_Id number NOT NULL,
	-- 일정 끝나는 날짜
	plan_end_date date,
	-- 일정  시작날짜
	plan_start_date date NOT NULL,
	-- 일정 카테고리
	plan_category varchar2(50),
	-- 일정  참가자
	plan_joined_member varchar2(1000),
	-- 일정 동의 인원
	plan_vote_agree number DEFAULT 0,
	-- 일정 반대 인원
	plan_vote_disagree number DEFAULT 0,
	-- 일정  모임 주소
	plan_address varchar2(1000)
);


CREATE TABLE reply
(
	-- 메인 게시판 아이디
	board_Id number NOT NULL,
	-- 리플라이 넘버
	reply_num number NOT NULL,
	-- 댓글 닉네임
	reply_nickname varchar2(50) NOT NULL,
	-- 댓글 내용
	reply_text varchar2(1500) NOT NULL,
	-- 댓글 날짜
	reply_inputdate date DEFAULT sysdate NOT NULL,
	PRIMARY KEY (reply_num)
);



/* Create Foreign Keys */

ALTER TABLE board_file
	ADD FOREIGN KEY (board_Id)
	REFERENCES board (board_Id)
;


ALTER TABLE board_info
	ADD FOREIGN KEY (board_Id)
	REFERENCES board (board_Id)
;


ALTER TABLE payment
	ADD FOREIGN KEY (board_Id)
	REFERENCES board (board_Id)
;


ALTER TABLE planning
	ADD FOREIGN KEY (board_Id)
	REFERENCES board (board_Id)
;


ALTER TABLE reply
	ADD FOREIGN KEY (board_Id)
	REFERENCES board (board_Id)
;


ALTER TABLE board
	ADD FOREIGN KEY (house_id)
	REFERENCES house (house_id)
;


ALTER TABLE house_file
	ADD FOREIGN KEY (house_id)
	REFERENCES house (house_id)
;


ALTER TABLE member_detail
	ADD FOREIGN KEY (member_id)
	REFERENCES member (member_id)
;


ALTER TABLE member_files
	ADD FOREIGN KEY (member_id)
	REFERENCES member (member_id)
;



/* Comments */

COMMENT ON COLUMN board.house_id IS '쉐어하우스 아이디';
COMMENT ON COLUMN board.board_Id IS '메인 게시판 아이디';
COMMENT ON COLUMN board.board_num IS '메인 게시판 넘버';
COMMENT ON COLUMN board.board_title IS '메인 게시판 제목';
COMMENT ON COLUMN board.board_nickname IS '메인 게시판 사용자 닉네임';
COMMENT ON COLUMN board.board_inputdate IS '메인 게시판 날짜';
COMMENT ON COLUMN board.board_content IS '메인 게시판 내용';
COMMENT ON COLUMN board.board_member_id IS '메인 게시판 비교할 아이디';
COMMENT ON COLUMN board_file.board_Id IS '메인 게시판 아이디';
COMMENT ON COLUMN board_file.board_file_id IS '게시판 파일 이름';
COMMENT ON COLUMN board_file.board_save_file_name IS '게시판 파일 저장 이름';
COMMENT ON COLUMN board_file.board_upload_file_name IS '게시판 업로드 파일 이름';
COMMENT ON COLUMN board_info.board_Id IS '메인 게시판 아이디';
COMMENT ON COLUMN board_info.photo_and_board_category IS '사진첩_ 게시판_카테고리';
COMMENT ON COLUMN house.house_id IS '쉐어하우스 아이디';
COMMENT ON COLUMN house.house_num IS '쉐어 하우스 넘버';
COMMENT ON COLUMN house.house_name IS '쉐어 하우스 집명';
COMMENT ON COLUMN house.house_address IS '쉐어하우스 주소';
COMMENT ON COLUMN house.house_phone IS '쉐어하우스 전화번호';
COMMENT ON COLUMN house.house_available_room IS '쉐어 하우스 가능한 방';
COMMENT ON COLUMN house.house_introduce IS '쉐어 하우스 집소개';
COMMENT ON COLUMN house.house_available_email IS '쉐어 하우스 집주인 연락 가능한 이메일';
COMMENT ON COLUMN house_file.house_id IS '하우스 파일 아이디';
COMMENT ON COLUMN house_file.house_file_id IS '쉐어하우스 파일 아이디';
COMMENT ON COLUMN house_file.house_save_file_name IS '쉐어 하우스 파일 저장 이름';
COMMENT ON COLUMN house_file.house_upload_file_name IS '쉐어하우스 업로드 파일 이름';
COMMENT ON COLUMN member.member_num IS '회원 번호';
COMMENT ON COLUMN member.member_id IS '회원아이디';
COMMENT ON COLUMN member.member_name IS '이름';
COMMENT ON COLUMN member.member_nickname IS '닉네임';
COMMENT ON COLUMN member.member_password IS '비밀번호';
COMMENT ON COLUMN member.member_type IS '멤버 타입';
COMMENT ON COLUMN member.member_phone IS '전화번호';
COMMENT ON COLUMN member.member_email IS '이메일';
COMMENT ON COLUMN member.member_belongto IS '소속되어 있은 하우스 이름';
COMMENT ON COLUMN member.member_password_check_Q IS '비밀번호 찾기 질문';
COMMENT ON COLUMN member.member_password_check_A IS '질문의 답';
COMMENT ON COLUMN member_detail.member_id IS '회원아이디';
COMMENT ON COLUMN member_detail.detail_job_title IS '세부사항 직업';
COMMENT ON COLUMN member_detail.detail_birthday IS '세부사항 생일';
COMMENT ON COLUMN member_detail.detail_Gender IS '세부사항 성별';
COMMENT ON COLUMN member_detail.detail_address IS '세부사항 주소';
COMMENT ON COLUMN member_detail.detail_prefer_house IS '세부사항 선호하는 집';
COMMENT ON COLUMN member_detail.detail_hobby IS '세부사항 취미';
COMMENT ON COLUMN member_detail.detail_introduce IS '세부사항 자기소개';
COMMENT ON COLUMN member_detail.detail_prefered_things IS '세부사항 좋아하는 것들(단어로)';
COMMENT ON COLUMN member_detail.detail_character IS '세부사항  회원 성격';
COMMENT ON COLUMN member_detail.detail_favorite_people_type IS '세부사항 회원이 선호하는 사람 성격';
COMMENT ON COLUMN member_files.member_id IS '회원아이디';
COMMENT ON COLUMN member_files.member_file_id IS '회원 프로필 파일 아이디';
COMMENT ON COLUMN member_files.member_save_file_name IS '회원 프로필 파일 저장이름';
COMMENT ON COLUMN member_files.member_upload_file_name IS '회원 프로필 파일 업로드 이름';
COMMENT ON COLUMN payment.board_Id IS '메인 게시판 아이디';
COMMENT ON COLUMN payment.pay_category IS '운영비 카테고리';
COMMENT ON COLUMN payment.pay_amont IS '운영비 총 액';
COMMENT ON COLUMN payment.pay_text IS '운영비 사항 내용';
COMMENT ON COLUMN payment.pay_year IS '운영비 구분 년도';
COMMENT ON COLUMN payment.pay_month IS '운영비 구분 년수';
COMMENT ON COLUMN payment.pay_selected_date IS '운영비 설정 시 날짜 지정';
COMMENT ON COLUMN planning.board_Id IS '메인 게시판 아이디';
COMMENT ON COLUMN planning.plan_end_date IS '일정 끝나는 날짜';
COMMENT ON COLUMN planning.plan_start_date IS '일정  시작날짜';
COMMENT ON COLUMN planning.plan_category IS '일정 카테고리';
COMMENT ON COLUMN planning.plan_joined_member IS '일정  참가자';
COMMENT ON COLUMN planning.plan_vote_agree IS '일정 동의 인원';
COMMENT ON COLUMN planning.plan_vote_disagree IS '일정 반대 인원';
COMMENT ON COLUMN planning.plan_address IS '일정  모임 주소';
COMMENT ON COLUMN reply.board_Id IS '메인 게시판 아이디';
COMMENT ON COLUMN reply.reply_num IS '리플라이 넘버';
COMMENT ON COLUMN reply.reply_nickname IS '댓글 닉네임';
COMMENT ON COLUMN reply.reply_text IS '댓글 내용';
COMMENT ON COLUMN reply.reply_inputdate IS '댓글 날짜';
=======
grant connect, dba to tanoshi;


create sequence board_seq;
create sequence member_seq;
create sequence reply_seq;
create sequence house_seq;

/* Create Tables */

CREATE TABLE board
(
	-- 쉐어하우스 아이디
	house_id varchar2(50) NOT NULL,
	-- 메인 게시판 아이디
	board_Id number NOT NULL,
	-- 메인 게시판 넘버
	board_num number NOT NULL UNIQUE,
	-- 메인 게시판 제목
	board_title varchar2(300) NOT NULL,
	-- 메인 게시판 사용자 닉네임
	board_nickname varchar2(50) NOT NULL,
	-- 메인 게시판 날짜
	board_inputdate date DEFAULT sysdate NOT NULL,
	-- 메인 게시판 내용
	board_content varchar2(2000),
	-- 메인 게시판 비교할 아이디
	board_member_id varchar2(50) NOT NULL,
	PRIMARY KEY (board_Id)
);


CREATE TABLE board_file
(
	-- 메인 게시판 아이디
	board_Id number NOT NULL,
	-- 게시판 파일 이름
	board_file_id varchar2(10) DEFAULT 'noFile' NOT NULL,
	-- 게시판 파일 저장 이름
	board_save_file_name varchar2(300) DEFAULT 'nofile',
	-- 게시판 업로드 파일 이름
	board_upload_file_name varchar2(300) DEFAULT 'nofile',
	PRIMARY KEY (board_file_id)
);


CREATE TABLE board_info
(
	-- 메인 게시판 아이디
	board_Id number NOT NULL,
	-- 사진첩_ 게시판_카테고리
	photo_and_board_category varchar2(50) NOT NULL
);


CREATE TABLE house
(
	-- 쉐어하우스 아이디
	house_id varchar2(50) NOT NULL,
	-- 쉐어 하우스 넘버
	house_num number NOT NULL UNIQUE,
	-- 쉐어 하우스 집명
	house_name varchar2(100) NOT NULL,
	-- 쉐어하우스 주소
	house_address varchar2(300) NOT NULL,
	-- 쉐어하우스 전화번호
	house_phone varchar2(20),
	-- 쉐어 하우스 가능한 방
	house_available_room number NOT NULL,
	-- 쉐어 하우스 집소개
	house_introduce varchar2(2000) NOT NULL,
	-- 쉐어 하우스 집주인 연락 가능한 이메일
	house_available_email varchar2(100),
	PRIMARY KEY (house_id)
);


CREATE TABLE house_file
(
	-- 하우스 파일 아이디
	house_id varchar2(50) NOT NULL,
	-- 쉐어하우스 파일 아이디
	house_file_id varchar2(10) DEFAULT 'noFile' NOT NULL,
	-- 쉐어 하우스 파일 저장 이름
	house_save_file_name varchar2(300) DEFAULT 'nofile',
	-- 쉐어하우스 업로드 파일 이름
	house_upload_file_name varchar2(300) DEFAULT 'nofile',
	PRIMARY KEY (house_file_id)
);


CREATE TABLE member
(
	-- 회원 번호
	member_num number NOT NULL UNIQUE,
	-- 회원아이디
	member_id varchar2(20) NOT NULL,
	-- 이름
	member_name varchar2(20) NOT NULL,
	-- 닉네임
	member_nickname varchar2(50) NOT NULL UNIQUE,
	-- 비밀번호
	member_password varchar2(20) NOT NULL,
	-- 멤버 타입
	member_type varchar2(10) DEFAULT 'general' NOT NULL,
	-- 전화번호
	member_phone varchar2(20) NOT NULL UNIQUE,
	-- 이메일
	member_email varchar2(50) UNIQUE,
	-- 소속되어 있은 하우스 이름
	member_belongto varchar2(200) DEFAULT 'none' NOT NULL,
	-- 비밀번호 찾기 질문
	member_password_check_Q number NOT NULL,
	-- 질문의 답
	member_password_check_A varchar2(200) NOT NULL,
	PRIMARY KEY (member_id)
);


CREATE TABLE member_detail
(
	-- 회원아이디
	member_id varchar2(20) NOT NULL,
	-- 세부사항 직업
	detail_job_title varchar2(80),
	-- 세부사항 생일
	detail_birthday date,
	-- 세부사항 성별
	detail_Gender varchar2(10),
	-- 세부사항 주소
	detail_address varchar2(300),
	-- 세부사항 선호하는 집
	detail_prefer_house varchar2(30),
	-- 세부사항 취미
	detail_hobby varchar2(100),
	-- 세부사항 자기소개
	detail_introduce varchar2(1000),
	-- 세부사항 좋아하는 것들(단어로)
	detail_prefered_things varchar2(200),
	-- 세부사항  회원 성격
	detail_character varchar2(100),
	-- 세부사항 회원이 선호하는 사람 성격
	detail_favorite_people_type varchar2(100)
);


CREATE TABLE member_file
(
	-- 회원아이디
	member_id varchar2(20) NOT NULL,
	-- 회원 프로필 파일 아이디
	member_file_id varchar2(10) DEFAULT 'noFile' NOT NULL,
	-- 회원 프로필 파일 저장이름
	member_save_file_name varchar2(300) DEFAULT 'nofile',
	-- 회원 프로필 파일 업로드 이름
	member_upload_file_name varchar2(300) DEFAULT 'nofile',
	PRIMARY KEY (member_file_id)
);


CREATE TABLE payment
(
	-- 메인 게시판 아이디
	board_Id number NOT NULL,
	-- 운영비 카테고리
	pay_category varchar2(10) NOT NULL,
	-- 운영비 총 액
	pay_amont number(10,2) NOT NULL,
	-- 운영비 사항 내용
	pay_text varchar2(2000) NOT NULL,
	-- 운영비 구분 년도
	pay_year number NOT NULL,
	-- 운영비 구분 년수
	pay_month number NOT NULL,
	-- 운영비 설정 시 날짜 지정
	pay_selected_date date
);


CREATE TABLE planning
(
	-- 메인 게시판 아이디
	board_Id number NOT NULL,
	-- 일정 끝나는 날짜
	plan_end_date date,
	-- 일정  시작날짜
	plan_start_date date NOT NULL,
	-- 일정 카테고리
	plan_category varchar2(50),
	-- 일정  참가자
	plan_joined_member varchar2(1000),
	-- 일정 동의 인원
	plan_vote_agree number DEFAULT 0,
	-- 일정 반대 인원
	plan_vote_disagree number DEFAULT 0,
	-- 일정  모임 주소
	plan_address varchar2(1000)
);


CREATE TABLE reply
(
	-- 메인 게시판 아이디
	board_Id number NOT NULL,
	-- 리플라이 넘버
	reply_num number NOT NULL,
	-- 댓글 닉네임
	reply_nickname varchar2(50) NOT NULL,
	-- 댓글 내용
	reply_text varchar2(1500) NOT NULL,
	-- 댓글 날짜
	reply_inputdate date DEFAULT sysdate NOT NULL,
	PRIMARY KEY (reply_num)
);



/* Create Foreign Keys */

ALTER TABLE board_file
	ADD FOREIGN KEY (board_Id)
	REFERENCES board (board_Id)
;


ALTER TABLE board_info
	ADD FOREIGN KEY (board_Id)
	REFERENCES board (board_Id)
;


ALTER TABLE payment
	ADD FOREIGN KEY (board_Id)
	REFERENCES board (board_Id)
;


ALTER TABLE planning
	ADD FOREIGN KEY (board_Id)
	REFERENCES board (board_Id)
;


ALTER TABLE reply
	ADD FOREIGN KEY (board_Id)
	REFERENCES board (board_Id)
;


ALTER TABLE board
	ADD FOREIGN KEY (house_id)
	REFERENCES house (house_id)
;


ALTER TABLE house_file
	ADD FOREIGN KEY (house_id)
	REFERENCES house (house_id)
;


ALTER TABLE member_detail
	ADD FOREIGN KEY (member_id)
	REFERENCES member (member_id)
;


ALTER TABLE member_file
	ADD FOREIGN KEY (member_id)
	REFERENCES member (member_id)
;



/* Comments */

COMMENT ON COLUMN board.house_id IS '쉐어하우스 아이디';
COMMENT ON COLUMN board.board_Id IS '메인 게시판 아이디';
COMMENT ON COLUMN board.board_num IS '메인 게시판 넘버';
COMMENT ON COLUMN board.board_title IS '메인 게시판 제목';
COMMENT ON COLUMN board.board_nickname IS '메인 게시판 사용자 닉네임';
COMMENT ON COLUMN board.board_inputdate IS '메인 게시판 날짜';
COMMENT ON COLUMN board.board_content IS '메인 게시판 내용';
COMMENT ON COLUMN board.board_member_id IS '메인 게시판 비교할 아이디';
COMMENT ON COLUMN board_file.board_Id IS '메인 게시판 아이디';
COMMENT ON COLUMN board_file.board_file_id IS '게시판 파일 이름';
COMMENT ON COLUMN board_file.board_save_file_name IS '게시판 파일 저장 이름';
COMMENT ON COLUMN board_file.board_upload_file_name IS '게시판 업로드 파일 이름';
COMMENT ON COLUMN board_info.board_Id IS '메인 게시판 아이디';
COMMENT ON COLUMN board_info.photo_and_board_category IS '사진첩_ 게시판_카테고리';
COMMENT ON COLUMN house.house_id IS '쉐어하우스 아이디';
COMMENT ON COLUMN house.house_num IS '쉐어 하우스 넘버';
COMMENT ON COLUMN house.house_name IS '쉐어 하우스 집명';
COMMENT ON COLUMN house.house_address IS '쉐어하우스 주소';
COMMENT ON COLUMN house.house_phone IS '쉐어하우스 전화번호';
COMMENT ON COLUMN house.house_available_room IS '쉐어 하우스 가능한 방';
COMMENT ON COLUMN house.house_introduce IS '쉐어 하우스 집소개';
COMMENT ON COLUMN house.house_available_email IS '쉐어 하우스 집주인 연락 가능한 이메일';
COMMENT ON COLUMN house_file.house_id IS '하우스 파일 아이디';
COMMENT ON COLUMN house_file.house_file_id IS '쉐어하우스 파일 아이디';
COMMENT ON COLUMN house_file.house_save_file_name IS '쉐어 하우스 파일 저장 이름';
COMMENT ON COLUMN house_file.house_upload_file_name IS '쉐어하우스 업로드 파일 이름';
COMMENT ON COLUMN member.member_num IS '회원 번호';
COMMENT ON COLUMN member.member_id IS '회원아이디';
COMMENT ON COLUMN member.member_name IS '이름';
COMMENT ON COLUMN member.member_nickname IS '닉네임';
COMMENT ON COLUMN member.member_password IS '비밀번호';
COMMENT ON COLUMN member.member_type IS '멤버 타입';
COMMENT ON COLUMN member.member_phone IS '전화번호';
COMMENT ON COLUMN member.member_email IS '이메일';
COMMENT ON COLUMN member.member_belongto IS '소속되어 있은 하우스 이름';
COMMENT ON COLUMN member.member_password_check_Q IS '비밀번호 찾기 질문';
COMMENT ON COLUMN member.member_password_check_A IS '질문의 답';
COMMENT ON COLUMN member_detail.member_id IS '회원아이디';
COMMENT ON COLUMN member_detail.detail_job_title IS '세부사항 직업';
COMMENT ON COLUMN member_detail.detail_birthday IS '세부사항 생일';
COMMENT ON COLUMN member_detail.detail_Gender IS '세부사항 성별';
COMMENT ON COLUMN member_detail.detail_address IS '세부사항 주소';
COMMENT ON COLUMN member_detail.detail_prefer_house IS '세부사항 선호하는 집';
COMMENT ON COLUMN member_detail.detail_hobby IS '세부사항 취미';
COMMENT ON COLUMN member_detail.detail_introduce IS '세부사항 자기소개';
COMMENT ON COLUMN member_detail.detail_prefered_things IS '세부사항 좋아하는 것들(단어로)';
COMMENT ON COLUMN member_detail.detail_character IS '세부사항  회원 성격';
COMMENT ON COLUMN member_detail.detail_favorite_people_type IS '세부사항 회원이 선호하는 사람 성격';
COMMENT ON COLUMN member_files.member_id IS '회원아이디';
COMMENT ON COLUMN member_files.member_file_id IS '회원 프로필 파일 아이디';
COMMENT ON COLUMN member_files.member_save_file_name IS '회원 프로필 파일 저장이름';
COMMENT ON COLUMN member_files.member_upload_file_name IS '회원 프로필 파일 업로드 이름';
COMMENT ON COLUMN payment.board_Id IS '메인 게시판 아이디';
COMMENT ON COLUMN payment.pay_category IS '운영비 카테고리';
COMMENT ON COLUMN payment.pay_amont IS '운영비 총 액';
COMMENT ON COLUMN payment.pay_text IS '운영비 사항 내용';
COMMENT ON COLUMN payment.pay_year IS '운영비 구분 년도';
COMMENT ON COLUMN payment.pay_month IS '운영비 구분 년수';
COMMENT ON COLUMN payment.pay_selected_date IS '운영비 설정 시 날짜 지정';
COMMENT ON COLUMN planning.board_Id IS '메인 게시판 아이디';
COMMENT ON COLUMN planning.plan_end_date IS '일정 끝나는 날짜';
COMMENT ON COLUMN planning.plan_start_date IS '일정  시작날짜';
COMMENT ON COLUMN planning.plan_category IS '일정 카테고리';
COMMENT ON COLUMN planning.plan_joined_member IS '일정  참가자';
COMMENT ON COLUMN planning.plan_vote_agree IS '일정 동의 인원';
COMMENT ON COLUMN planning.plan_vote_disagree IS '일정 반대 인원';
COMMENT ON COLUMN planning.plan_address IS '일정  모임 주소';
COMMENT ON COLUMN reply.board_Id IS '메인 게시판 아이디';
COMMENT ON COLUMN reply.reply_num IS '리플라이 넘버';
COMMENT ON COLUMN reply.reply_nickname IS '댓글 닉네임';
COMMENT ON COLUMN reply.reply_text IS '댓글 내용';
COMMENT ON COLUMN reply.reply_inputdate IS '댓글 날짜';



>>>>>>> refs/remotes/origin/EK!
