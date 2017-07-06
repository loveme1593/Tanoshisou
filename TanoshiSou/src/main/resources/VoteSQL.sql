drop table VOTE;

drop SEQUENCE VOTE_SEQ;

create table VOTE(
 VOTEID NUMBER not null primary key, --보트 데이터 번호
 data_type VARCHAR2(30) not null, 
 pid NUMBER not null,
 member_id varchar2(20) REFERENCES member(member_id) on delete cascade,
 decision VARCHAR2(30) not null
 );
 
 CREATE SEQUENCE VOTE_SEQ;
 
 
 insert into Vote(
 	voteid,
 	data_type,
 	pid,
 	member_id,
 	decision
 )values (
 	vote_seq.nextval
 	, #{data_type}
 	, #{pid}
 	, #{member_id}
 	, #{decision}
 );
 
 select * from Vote
where data_type = #{data_type} and pid=#{pid}