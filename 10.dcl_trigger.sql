select user(), database();

-- trigger / event condition action
create table employee_audit(
	id int auto_increment primary key,
	empno varchar(40) not null,
	empname varchar(40) not null,
	changedate datetime default null,
	action varchar(20) default null
);

desc employee_audit;

-- trigger 생성
/*
사원의 사원번호, 사원명이 추가된 후에 호출되는 after insert 트리거를 생성하여
employee_audit 체이블에 변경된 정보를 삽입하는 트리거를 생성하시오.
*/

delimiter $$
create trigger tri_after_insert_employee
 	after insert on employee
 	for each row -- 각각 모든 행에 적용하고 결과값 받기
 begin
	 insert into employee_audit
	 values(null, new.empno, new.empname, now(), 'insert');
 end $$
delimiter ;

select * from employee;

insert
  into employee
values (1011, '윤지수', '사원', 4377, 1500000, 1);

select * from employee;

select * from employee_audit;

 /*
사원의 사원번호, 사원명이 변경되기 전에 호출되는 before update 트리거를 생성하여
employee_audit 테이블에 변경된 정보를 삽입하는 트리거를 생성하시오.
*/

delimiter $$
create trigger tri_before_update_employee
	before update on employee
	for each row
 begin
	insert into employee_audit
	values (null, concat(old.empno, '->', new.empno), concat(old.empname, '->', new.empname), now(), 'update');
 end $$
delimiter ;

select * from employee;

update employee
   set empname = '이은혁', empno = 1005
  where empno = 1004;
 
 select * from employee_audit;

delimiter $$
create trigger tri_before_delete_employee
	before delete on employee
	for each row
 begin
	insert into employee_audit
	values (null, old.empno, old.empname, now(), 'delete');
 end $$
delimiter ;

select * from employee;

delete 
  from employee
 where empno = 1007;

select * from employee_audit;

show triggers from mysql_study;

create table product(
	code char(4) not null comment '코드',
	name varchar(20) not null comment '제품명',
	price int(11) not null comment '제품단가',
	primary key (code)
);

desc product;

insert
  into product
values ('a001', '아메리카노', 5000), ('a002', '카푸치노', 3800), ('a003', '헤이즐넛', 5000), ('a004', '에스프레소', 5000), 
       ('b001', '딸기쉐이크', 5200), ('b002', '후르츠와인', 4300), ('b003', '팥빙수', 8000), ('b004', '아이스초코', 7000);
       
select *
  from product;

create table price_logs(
	id int(11) not null auto_increment,
	code char(4) not null,
	price int(11) not null,
	updated_at timestamp not null default current_timestamp
						 on update current_timestamp,
	primary key (id),
	key code (code),
	constraint fk_price_logs foreign key (code) references product (code)
	on delete cascade on update cascade 
);

desc price_logs;

delimiter $$
create trigger before_update_product
	before update on product
	for each row
 begin
	 insert into price_logs(code, price)
	 values (old.code, old.price);
 end $$
delimiter ;

update product
   set price = 4500
 where code = 'a001';

select * from product;

select * from price_logs; -- 바뀌기 전 가격을 기록해놓음

-- 연쇄 trigger
-- 바꾼 사용자도 알 수 있도록 함(price logs 이후 연쇄로 trigger 이어지도록)
create table user_change_logs(
	id int(11) not null auto_increment,
	code char(4) default null,
	updated_at timestamp not null default current_timestamp
						 on update current_timestamp,
	updated_by varchar(30) not null,
	primary key (id),
	key code (code),
	constraint fk_user_change_logs foreign key (code) references product (code)
	on delete cascade
	on update cascade 
);

delimiter $$
create trigger before_update_product2
	before update on product
	for each row follows before_update_product
 begin
	insert into user_change_logs(code, updated_by)
	values (old.code, user());
 end $$
delimiter ;

select * from user_change_logs;

update product
   set price = 6000
 where code = 'a002';

select * from product;
select * from price_logs;
select * from user_change_logs;

show triggers from mysql_study where `table` = 'product';
