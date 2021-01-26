select user(), database();

select *
  from department;
  
 -- p95
delete
  from department
 where deptno = 5;
  
show tables;

create table department4
    as
select *
  from department;
  
desc department4;

alter table department4 add constraint primary key (deptno);
alter table department4 modify deptno int not null auto_increment;

select * from department4;

insert
  into department4(deptname, floor)
values ('마케팅', 15);

-- delete/turncate 이후 auto_increment 확인하기
delete
  from department4;

insert
  into department4(deptname, floor)
values ('마케팅', 15);

select * from department4; -- 1부터 들어가지 않음

truncate table department4;

insert
  into department4(deptname, floor)
values ('마케팅', 15);

select * from department4; -- 1부터 들어감





