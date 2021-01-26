select user(), database();

desc department;

-- ���Ӱ� �۾�
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
   title varchar(10) default '���',
   manager int(11),
   salary int(11),
   dno int(11) default 1
);

show tables;

desc employee;

insert
  into employee
values (4377, '�̼���', '����', null, 5000000, 2),
       (3426, '�ڿ���', '����', 4377, 3000000, 1),
       (1003, '������', '����', 4377, 3000000, 2),
       (3011, '�̼���', '����', 4377, 4000000, 3),
       (1365, '����', '���', 3426, 1500000, 1),
       (2106, '��â��', '�븮', 1003, 2500000, 2),
       (3427, '����ö', '���', 3011, 1500000, 3);
       
desc department;

insert
  into department
values (1, '����', 8),
       (2, '��ȹ', 10),
       (3, '����', 9),
       (4, '�ѹ�', 7);
       
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

-- ���ο� table�� department2 ����
create table department2(
    deptno int not null primary key,
    deptname char(20),
    floor int
);

desc department2

insert
  into department2
values (1, '������', 80);

select *
  from department; -- ����

select *
  from department2; -- ����
  
-- p90 subQuery�� �̿��� insert
select count(*) + 1
  from department;
 
insert
  into department 
  select 5, deptname, floor from department2;

delete
  from department
 where deptno = 5; -- �ϵ��ڵ��̶� ����
 
insert
  into department(deptno, deptname, floor)
  select(select count(*) + 1 from department)
       , deptname
       , floor 
    from department2;
 
-- department2�� �� �߰��غ���
insert
  into department2
values (2, '�λ�', 80);

insert
  into department2
values (3, 'ȫ��', 80);
 
select * from department2;

-- p91 subQuery�� �̿��� ���̺� ���� (���� ������)
create table department3
    as
select *
  from department;
 
select * from department3;

-- p92
insert
  into department3(deptno, deptname)
values (6, '����');

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










  





  
  
  
  
  