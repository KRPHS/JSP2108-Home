/* board.sql */

show tables;
drop table board;
create table board(
	idx				int						not null			auto_increment, /* 게시글의 고유번호 */
	nickName	varchar(20)		not null,											/* 게시글 작성자의 닉네임 */
	title			varchar(100)	not null,											/* 게시글의 글 제목 */
	email			varchar(50),																/* 게시글 작성자의 이메일 */
	homePage	varchar(50),																/* 작성자의 홈페이지 */
	content		text					not null,											/* 글 내용 */
	wDate			datetime			not null 			default now(),	/* 글 작성 날짜 */
	readNum		int						default 0,										/* 게시글 조회수 */
	hostIp		varchar(50)		not null,											/* 게시자의 아이피 */
	good			int						default 0,										/* 좋아요 */
	mid				varchar(20)		not null,											/* 회원 아이디(게시글 조회시 사용) */
	primary		key(idx)
);

select * from board;

select * from board where idx = 8;
select * from board where idx < 8 order by idx desc limit 1;
select * from board where idx > 8 limit 1;

insert into board values (default,'관리맨','게시판 서비스를 시작합니다','qgt0310@naver.com','naver.com', '이곳은 게시판입니다. 좋은글 많이 부탁드려요',default,default,'218.236.203.146',default,'admin')