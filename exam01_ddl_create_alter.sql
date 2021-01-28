select user(), database();

create table product(
	code char(4) not null primary key,
	name varchar(20)
);

create table sale(
	no int not null auto_increment primary key,
	code char(4),
	price int,
	saleCnt int,
	marginRate int
);

create table sale_detail(
	no int not null,
	sale_price int,
	addTax int,
	supply_price int,
	marginPrice int
);

alter table sale
  add constraint foreign key (code) references product(code);
alter table sale_detail 
  add constraint foreign key (no) references sale(no)
  on delete cascade;
 
desc product;
desc sale;
desc sale_detail;









