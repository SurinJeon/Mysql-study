select user(), database();

-- 1번
create database company;

show databases;

use company;

select user(), database();

create table employee(
	empno int(11) not null primary key,
	empname varchar(20) not null,
	title varchar(20),
	manager int(11),
	salary int(11),
	dno int(11)
);

create table department(
	deptno int(11) not null primary key,
	deptname char(10) not null,
	floor int(11)
);

alter table employee add constraint foreign key (manager) references employee(empno);
alter table employee add constraint foreign key (dno) references department(deptno);

desc employee;
desc department;

-- 2번
insert
  into department(deptno, deptname, floor)
values (1, '영업', 8),
	   (2, '기획', 10),
	   (3, '개발', 9),
	   (4, '총무', 7);

insert  
  into employee(empno, empname, title, manager, salary, dno)
values (1003, '조민희', '과장', 4377, 3000000, 2),
       (1365, '김상원', '사원', 3426, 1500000, 1),
       (2106, '김창섭', '대리', 1003, 2500000, 2),
       (3011, '이수민', '부장', 4377, 4000000, 3),
       (3426, '박영권', '과장', 4377, 3000000, 1),
       (3427, '최종철', '사원', 3011, 1500000, 3),
       (4377, '이성래', '사장', null, 5000000, 2)

select * from department;
select * from employee;

-- 3번
delete
  from department
 where deptno = 4;

select * from department;

-- 4번
update employee
   set dno = 3
 where empno = 2106;
 
update employee
   set salary = salary * 1.05
 where empno = 2106;
 
select *
  from employee;
  
-- 5번
select empname, title,
   case
     when salary >= 4000000 then '3시 퇴근'
     when salary >= 3000000 then '5시 퇴근'
     when salary >= 2000000 then '7시 퇴근'
     else '야근'
   end as '퇴근시간'
  from employee;
  
-- 6번
select empname, title, dno
 from employee
where left(empname, 1) = '이';

-- 7번
select empname, salary
  from employee
 where title = '과장' and dno = 1;
 
-- 8번
select empname, title, salary
  from employee
 where salary >= 3000000 and salary <= 4500000;
 
-- 9번
select *
  from employee
 where dno in (1, 3);
 
-- 10번
select empname, salary, salary * 1.1 as '인상된 급여'
  from employee
 where title = '과장';
 
-- 11번
select format(avg(salary), 1) as '평균 급여', max(salary) as '최대 급여'
  from employee;
  
-- 12번
select dno, format(avg(salary), 1) as '평균 급여', max(salary) as '최대 급여'
  from employee
 group by dno;
 
-- 13번
select dno, format(avg(salary), 1) as '평균 급여', max(salary) as '최대 급여'
  from employee
 group by dno
having avg(salary) >= 2500000;

select *
  from department;
 
-- 14번
select empname, deptname
  from employee e join department d on e.dno = d.deptno; 
 
-- 15번
select e.empname, m.empname as '직속상사'
  from employee e left join employee m on e.manager = m.empno;

-- 16번
select d.deptname, e.empname, e.title, e.salary
  from employee e left join department d on e.dno = d.deptno
 order by d.deptname, salary desc;
 
-- 17번
select empname, title
  from employee
 where title = (select title from employee where empname = '박영권');
 
-- 18번
select empname
  from employee e left join department d on e.dno = d.deptno
 where d.deptname in ('영업', '개발');

select e.empname
  from employee e, (select deptno from department where deptname in ('영업', '개발')) d
 where e.dno = d.deptno;

-- 24번
grant select, insert, delete, update
   on company.*
   to 'user_company'@'localhost' identified by '123456';