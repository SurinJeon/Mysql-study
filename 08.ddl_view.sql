select user(), database();

use mysql_study;

/*
view 생성

create view view이름(속성명,...) <<만약 attribute 이름 다르게 하고싶다면!
    as
select - list
[with check option]
*/

create view vw_employee_dno3
    as
select empno, empname, title, dno
  from employee
 where dno = 3;
 
select * from vw_employee_dno3;

drop view vw_employee_dno3;

create view vw_employee_dno3(eno, ename, title, dept)
    as
select empno, empname, title, dno
  from employee
 where dno = 3;


select *
  from information_schema.VIEWS
 where table_schema = 'mysql_study';

create view emp_planning
    as
select empname, title, salary
  from employee e join department d on e.dno = d.deptno
 where deptname = '기획';

select *
  from emp_planning;
 
-- by Subquery
create view emp_planning_subquery
    as
select empname, title, salary
  from employee e, (select deptno, deptname from department where deptname = '기획') d
 where e.dno = d.deptno;

select *
  from emp_planning_subquery;

select *
  from vw_employee_dno3
 where title = '사원';
 
select empno, empname, title, dno
  from employee
 where dno = 3 and title = '사원';
 
select *
  from vw_employee_dno3;
 
update vw_employee_dno3 
   set dept = 2
 where eno = 3427;

select *
  from employee;
  
update employee
   set dno = 3
 where empno = 3427;
 

drop view vw_employee_dno3;

create view vw_employee_dno3
    as 
select empno, empname, title, dno
  from employee
 where dno = 3
  with check option;
  
select *
  from vw_employee_dno3;
  
update vw_employee_dno3
   set dno = 2
 where empno = 3427;


select *
  from employee;
 
create table copy_employee
    as
select *
  from employee;
 
create table emp1
    as
select empno, empname, salary
  from employee;
 
create table emp2
    as
select empno, title, manager, dno
  from employee;
 

select *
  from copy_employee;
  
drop table copy_employee;

select emp1.empno, empname, title, manager, salary, dno
  from emp1 join emp2 on emp1.empno = emp2.empno;
  
create view copy_employee
    as
select emp1.empno, empname, title, manager, salary, dno
  from emp1 join emp2 on emp1.empno = emp2.empno;
  
select *
  from vw_employee_dno3;
  
desc employee;

insert
  into vw_employee_dno3
values (1008, '김바둑', '사원', 3);

select * 
  from employee;
 
create view vw_test
    as
select empname, dno
  from employee;
 
select *
  from vw_test;
 
/* 
insert
  into vw_test
values('김까망', 3);

해당 문장은 실행 불가능
primary key가 포함되지 않음
*/
