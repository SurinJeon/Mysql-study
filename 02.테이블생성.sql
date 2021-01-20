select user(), database();

--  테이블 생성하기
create table product(
	code char(4) not null primary key,
	name varchar(20) not null
);

create table sale(
	no int auto_increment,
	code char(4) not null,
	price int not null,
	saleCnt int not null,
	marginRate int not null,
	primary key(no),
	foreign key(code) references product(code)
);

