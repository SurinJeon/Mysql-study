select user(), database();

/*
 * 새로운 사원이 입사할 때마다 사원의 급여가 1500000 미만인 경우에는
 * 급여를 10% 인상하는 트리거를 작성하라. 여기서 이벤트는 새로운 사원 투플이 삽입될 때,
 * 조건은 급여<1500000, 동작은 급여를 10% 인상하는 것이다.
 */
delimiter $$
create trigger raise_salary
	before insert on employee
	for each row
 begin
	 if (new.salary < 1500000) then
	 	set new.salary = new.salary * 1.1;
	 end if;
 end $$
delimiter ;

select * from employee;

insert 
  into employee
values (4000, '박유리', '사원', 3011, 1400000, 2); -- 10% 인상해서 들어가있음

select * from employee;

/*
 * 새로운 사원이 입사할 때마다, 사원의 급여가 3000000 초과할 경우 
 * high_salary에 empname, salary, title 정보를 추가하는
 * trigger를 작성하시오
 */
-- high_salary table 생성
create table high_salary
    as
select empname, salary, title
  from employee
 where salary > 3000000;

select * from high_salary; -- 3000000 넘는 직원들 들어가있음

delimiter $$
create trigger tri_employee_after_insert_high_salary
	after insert on employee
	for each row 
 begin
	 if(new.salary > 3000000) then
	 	insert into high_salary
	 	values (new.empname, new.salary, new.title);
	 end if;
 end $$
delimiter ;

select * from employee;

insert
  into employee
values (1006, '정재헌', '과장', 3011, 3100000, 3);

select * from high_salary; -- 정재헌 추가

-- 이같은 내용 모두 employee_auidt에 반영되어 있을 것
select * from employee_audit;

/* 
 * 사원이 수정될 경우 high_salary 정보를 수정하거나 삭제하는
 * trigger를 작성하시오
 */

delimiter $$
create trigger tri_employee_after_update_high_salary
	after update on employee
	for each row 
 begin
	 if(new.salary > 3000000) then
		update high_salary
	 	set title = new.title, salary = new.salary
	 	where empname = new.empname;
	 else
	 	delete from high_salary
	 	where empname = new.empname;
	 end if;
 end $$
delimiter ;


select * from employee;

update employee
   set salary = 2900000
 where empno = 1006;
 
select * from high_salary; -- 정재헌 사라짐

/*
 * 사원이 수정될 경우 high_salary 조건에 만족한다면 
 * 해당 사항을 반영하는 trigger를 작성하시오.
 */
delimiter $$
create trigger tri_employee_before_update_high_salary
	before update on employee
	for each row
 begin
	 if(new.salary > 3000000) then
	 	insert
	 	  into high_salary
	 	values (new.empname, new.salary, new.title);
	 end if;
 end $$
delimiter ;

update employee
   set salary = 3900000
 where empno = 1006;

-- 다시 급여 300만 넘어가도록 바꾼 정재헌이 high_salary에 올라와있는지 확인
select * from high_salary; -- 들어감

/*
 * 사원이 수정될 경우 high_salary 정보를 조건에 따라
 * 수정되거나 삭제 및 추가하는 trigger를 작성하시오.
 */

drop trigger tri_employee_after_update_high_salary;
drop trigger tri_employee_before_update_high_salary;

delimiter $$
create trigger tri_employee_after_update_high_salary
	after update on employee
	for each row
 begin
	 if(new.salary >= 3000000) then
	 	if(old.salary < 3000000) then
	 		insert
	 		  into high_salary
	 		values (new.empname, new.salary, new.title);
	 	else 
	 		update high_salary
	 		   set title = new.title, salary = new.salary
	 		 where empname = new.empname;
	 	end if;
	 else
	 	delete
	 	  from high_salary
	 	 where empname = new.empname;
	 end if;
 end $$
delimiter ;
	
-- testing
select * from employee;

-- 1. 
insert
  into employee
values (1004, '서이경', '과장', 3011, 3100000, 3);

select * from employee;
select * from high_salary; -- 서이경 들어감

-- 2.
update employee
   set salary = 2900000
 where empno = 1004;

select * from employee;
select * from high_salary; -- 서이경 사라짐

-- 3.
update employee
   set salary = 3100000
 where empno = 1004;

select * from employee;
select * from high_salary; -- 서이경 다시 들어감

-- 4.
update employee
   set salary = 3900000
 where empno = 1005;

select * from employee;
select * from high_salary; -- 이은혁 들어감

-- 5.
update employee
  set salary = 2000000
 where empno = 1004;

select * from employee;
select * from high_salary; -- 서이경 다시 빠짐

/*
 * 사원이 삭제될 경우 high_salary 정보를
 * 삭제하는 trigger를 삭제하시오
 */

delimiter $$
create trigger tri_employee_after_delete_high_salary
	after delete on employee
	for each row
 begin
	 delete
	   from high_salary
	  where empname = old.empname;
 end $$
delimiter ;

select * from high_salary;

select * from employee;

delete
  from employee
 where empno = 1005;

select * from high_salary; -- 이은혁 삭제됨

-- trigger 검색하는 법
select *
  from information_schema.triggers
 where trigger_schema = 'mysql_study';

select *
  from information_schema.triggers
 where trigger_schema = 'mysql_study'
	   and trigger_name = 'before_update_employee';

select *
  from information_schema.triggers
 where trigger_schema = 'mysql_study'
       and event_object_table = 'employee';
	
show triggers;

show triggers from mysql_study;
	
show triggers from mysql_study where `table` = 'employee';
	
	
	
	
	