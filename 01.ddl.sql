select user(), database();

-- ������ ���� �� ����
create database if not exists mysql_study;
drop database if exists mysql_study;

-- mysql_study ���ڴٰ� ����ϴ� �۾� �ʿ�
use mysql_study;

-- ���̺� ���� �� ����
create table department(
   deptno int(11) not null auto_increment,
   deptname char(20),
   floor int(11) default 1,
   primary key (deptno)
);

create table employee(
   empno int(11) not null,
   empname varchar(20) unique,
   title varchar(10) default '���',
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

-- ���̺� ���� Ȯ�� (��Ȯ���� desc)
show tables;

desc department;
desc employee;

-- ���̺�� ����
alter table employee rename to emp;
alter table emp rename to employee;

-- ���̺� �÷� �߰� �� ����
alter table employee add column phone char(13);
desc employee;
alter table employee drop column phone;

-- �÷� ����
alter table employee add column phone char(13);
alter table employee change phone phone_number varchar(13);
alter table employee modify phone_number char(13);

-- �ܷ�Ű �ɼ� test
drop table if exists employee;
create table employee(
   empno int(11) not null,
   empname varchar(20) unique,
   title varchar(10) default '���',
   manager int(11),
   salary int(11),
   dno int(11) default 1,
   primary key (empno),
   foreign key (manager) references employee(empno),
   foreign key (dno) references department(deptno)
     on update cascade
);

-- ���� �־ ���� �ܷ�Ű �ɼ� ����ƴ��� Ȯ���ϱ�
desc department;

insert
  into department
values (1, '����', 8),
       (2, '��ȹ', 10),
       (3, '����', 9),
       (4, '�ѹ�', 7);
       
select *
  from department;
  
desc employee;

insert
  into employee
values (3011, '�̼���', '����', null, 3000000, 1),
       (3012, '����ö', '���', 3011, 1500000, 1);

select *
  from employee;

update employee
   set manager = null
 where empno = 3012;

-- on delete cascade test ���� 
delete
  from department
 where deptno = 3;

-- on update cascade test ����
update department
   set deptno = 3
 where deptno = 1;
 
-- �ٸ� �������� ���̺� �Ͳ� ¥����!
drop table if exists employee;
drop table if exists department;

show tables;

create table employee(
   empno int(11) not null,
   empname varchar(20) unique,
   title varchar(10) default '���',
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
values (3011, '�̼���', '����', null, 3000000, 1),
       (3012, '����ö', '���', null, 1500000, 1);
       
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
  
-- ���������� �߰��غ���^^,,,
alter table department add constraint primary key (deptno);
alter table employee add constraint primary key (empno);
alter table employee add constraint fk_employee_manager
  foreign key (manager) references employee(empno);
alter table employee add constraint fk_employee_dno
  foreign key (dno) references department(deptno)
  on delete no action
  on update cascade;
  
-- ���������� �����غ���^^,,
desc employee;
alter table employee drop foreign key fk_employee_dno;
alter table employee drop foreign key fk_employee_manager;

-- �ε��� ���� (�⺻������ �⺻Ű�� �ܷ�Ű�� �ε����� �����ȴ�~)
create index employee_title_idx on employee(title);
drop index employee_title_idx on employee;

-- constraint�� ���������̴�,,,
select constraint_name, table_schema, table_name, constraint_type
  from information_schema.TABLE_CONSTRAINTS
 where constraint_schema = 'mysql_study';
 
