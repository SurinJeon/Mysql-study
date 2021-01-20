select user(), database();

-- 데이터 생성 및 삭제
create database if not exists mysql_study;
drop database if exists mysql_study;

-- mysql_study 쓰겠다고 명시하는 작업 필요
use mysql_study;

-- 테이블 생성 및 삭제
create table department(
   deptno int(11) not null auto_increment,
   deptname char(20),
   floor int(11) default 1,
   primary key (deptno)
);

create table employee(
   empno int(11) not null,
   empname varchar(20) unique,
   title varchar(10) default '사원',
   manager int(11),
   salary int(11),
   dno int(11) default 1,
   primary key (empno),
   foreign key (manager) references employee(empno),
   foreign key (dno) references department(deptno)
     on delete no action
     on update cascade
);

drop table if exists employee;
drop table if exists department;

-- 테이블 생성 확인 (상세확인은 desc)
show tables;

desc department;
desc employee;

-- 테이블명 변경
alter table employee rename to emp;
alter table emp rename to employee;

-- 테이블 컬럼 추가 및 삭제
alter table employee add column phone char(13);
desc employee;
alter table employee drop column phone;

-- 컬럼 변경
alter table employee add column phone char(13);
alter table employee change phone phone_number varchar(13);
alter table employee modify phone_number char(13);

-- 외래키 옵션 test
drop table if exists employee;
create table employee(
   empno int(11) not null,
   empname varchar(20) unique,
   title varchar(10) default '사원',
   manager int(11),
   salary int(11),
   dno int(11) default 1,
   primary key (empno),
   foreign key (manager) references employee(empno),
   foreign key (dno) references department(deptno)
     on update cascade
);

-- 투플 넣어서 과연 외래키 옵션 적용됐는지 확인하기
desc department;

insert
  into department
values (1, '영업', 8),
       (2, '기획', 10),
       (3, '개발', 9),
       (4, '총무', 7);
       
select *
  from department;
  
desc employee;

insert
  into employee
values (3011, '이수민', '부장', null, 3000000, 1),
       (3012, '최종철', '사원', 3011, 1500000, 1);

select *
  from employee;

update employee
   set manager = null
 where empno = 3012;

-- on delete cascade test 시작 
delete
  from department
 where deptno = 3;

-- on update cascade test 시작
update department
   set deptno = 3
 where deptno = 1;
 
-- 다른 버전으로 테이블 와꾸 짜보자!
drop table if exists employee;
drop table if exists department;

show tables;

create table employee(
   empno int(11) not null,
   empname varchar(20) unique,
   title varchar(10) default '사원',
   manager int(11),
   salary int(11),
   dno int(11) default 1
);

create table department(
   deptno int(11) not null,
   deptname char(20),
   floor int(11) default 1
);

insert
  into employee
values (3011, '이수민', '부장', null, 3000000, 1),
       (3012, '최종철', '사원', null, 1500000, 1);
       
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
  
-- 제약조건을 추가해보자^^,,,
alter table department add constraint primary key (deptno);
alter table employee add constraint primary key (empno);
alter table employee add constraint fk_employee_manager
  foreign key (manager) references employee(empno);
alter table employee add constraint fk_employee_dno
  foreign key (dno) references department(deptno)
  on delete no action
  on update cascade;
  
-- 제약조건을 삭제해보자^^,,
desc employee;
alter table employee drop foreign key fk_employee_dno;
alter table employee drop foreign key fk_employee_manager;

-- 인덱스 생성 (기본적으로 기본키와 외래키는 인덱스가 생성된다~)
create index employee_title_idx on employee(title);
drop index employee_title_idx on employee;

-- constraint는 제약조건이다,,,
select constraint_name, table_schema, table_name, constraint_type
  from information_schema.TABLE_CONSTRAINTS
 where constraint_schema = 'mysql_study';
 
