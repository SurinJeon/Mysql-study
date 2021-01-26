select user(), database();

show tables;

create table employee2
    as
select *
  from employee;
  
select *
  from employee2;
  
--  사원번호가 2106인 사원의 소속부서를 3번 부서로 옮기고 급여를 5% 올려라
update employee2
   set dno = 3, salary = salary*1.05
 where empno = 2106;
 
-- employee에 tuple 추가하기
select * from employee;

insert
  into employee
values (1005, '김바둑', '사원', 4377, 2000000, 1);

select * from department;

insert
  into department
values (4, '총무', 12);

-- 사원번호가 1005인 사원의 소속부서를 '총무' 부서로 변경하시오
-- subquery
update employee
   set dno = (select deptno from department where deptname = '총무')
 where empno = 1005;
 
select * from employee;

-- join으로 확인해보기
select *
  from employee e
  join department d on e.dno = d.deptno;
  
-- 급여 400 이상일 때 3시 퇴근, 300 이상일 때 5시 퇴근
-- 200 이상일 때 7시 퇴근, 나머지 야근
select empname, title,
  case
    when salary >= 4000000 then '3시 퇴근'
    when salary >= 3000000 then '5시 퇴근'
    when salary >= 2000000 then '7시 퇴근'
    else '야근'
   end as '퇴근시간'
  from employee;
 
drop table employee2;

create table employee2
    as
select *
  from employee;
 
desc employee2;

select * from employee2;

delete
  from employee2
 where empno = 1005;

alter table employee2 add column leaveoffice varchar(10);

update employee2
   set leaveoffice =
     case left(empno, 1)
      when 4 then '3시 퇴근'
      when 3 then '5시 퇴근'
      when 2 then '7시 퇴근'
     else '야근'
     end;
 