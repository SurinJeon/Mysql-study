select user(), database();

desc department;

-- 새롭게 작업
show tables;

drop table department;
drop table employee;

create table department(
   deptno int(11) not null,
   deptname char(20),
   floor int(11) default 1
);

create table employee(
   empno int(11) not null,
   empname varchar(20) unique,
   title varchar(10) default '사원',
   manager int(11),
   salary int(11),
   dno int(11) default 1
);

show tables;

desc employee;

insert
  into employee
values (4377, '이성래', '사장', null, 5000000, 2),
       (3426, '박영권', '과장', 4377, 3000000, 1),
       (1003, '조민희', '과장', 4377, 3000000, 2),
       (3011, '이수민', '부장', 4377, 4000000, 3),
       (1365, '김상원', '사원', 3426, 1500000, 1),
       (2106, '김창섭', '대리', 1003, 2500000, 2),
       (3427, '최종철', '사원', 3011, 1500000, 3);
       
desc department;

insert
  into department
values (1, '영업', 8),
       (2, '기획', 10),
       (3, '개발', 9),
       (4, '총무', 7);
       
select * 
  from employee;
  
select *
  from department;
  
alter table department add constraint primary key (deptno);
alter table employee add constraint primary key (empno);
alter table employee add constraint fk_employee_manager
  foreign key (manager) references employee(empno);
alter table employee add constraint fk_employee_dno
  foreign key (dno) references department(deptno);  
  
desc employee;
desc department;

-- 새로운 table인 department2 생성
create table department2(
    deptno int not null primary key,
    deptname char(20),
    floor int
);

desc department2

insert
  into department2
values (1, '마케팅', 80);

select *
  from department; -- 본사

select *
  from department2; -- 지사
  
-- p90 subQuery를 이용한 insert
select count(*) + 1
  from department;
 
insert
  into department 
  select 5, deptname, floor from department2;

delete
  from department
 where deptno = 5; -- 하드코딩이라 지움
 
insert
  into department(deptno, deptname, floor)
  select(select count(*) + 1 from department)
       , deptname
       , floor 
    from department2;
 
-- department2에 더 추가해보기
insert
  into department2
values (2, '인사', 80);

insert
  into department2
values (3, '홍보', 80);
 
select * from department2;

-- p91 subQuery를 이용한 테이블 생성 (값을 복사함)
create table department3
    as
select *
  from department;
 
select * from department3;

-- p92
insert
  into department3(deptno, deptname)
values (6, '연구');

-- p94
create table subscribers(
 	id int primary key auto_increment,
 	email varchar(50) not null unique
);

desc subscribers;

insert
  into subscribers(email) 
values ('baduck.kim@gmail.com');

select * from subscribers;

insert
  into subscribers(email)
values ('baduck.kim@gmail.com'),
	   ('goyoung.kim@gmail.com');
	  
insert ignore
  into subscribers(email)
values ('baduck.kim@gmail.com'),
	   ('goyoung.kim@gmail.com');










  





  
  
  
  
  