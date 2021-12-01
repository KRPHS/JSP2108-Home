show tables;

create table pds (
	idx int not null auto_increment,
	mid varchar(20) not null,
	nickName varchar(20) not null,
	fName varchar(200) not null,
	fSName varchar(200) not null,
	fSize int,
	title varchar(100) not null,
	part varchar(20) not null,
	pwd varchar(100) not null,
	fDate datetime default now(),
	downNum int default 0,
	openSw char(6) default '공개',
	content text,
	primary key (idx)
);

desc pds;

select * from pds order by idx desc;