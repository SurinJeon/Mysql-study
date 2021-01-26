select user(), database();

show tables;

create table employee2
    as
select *
  from employee;
  
select *
  from employee2;
  
--  �����ȣ�� 2106�� ����� �ҼӺμ��� 3�� �μ��� �ű�� �޿��� 5% �÷���
update employee2
   set dno = 3, salary = salary*1.05
 where empno = 2106;
 
-- employee�� tuple �߰��ϱ�
select * from employee;

insert
  into employee
values (1005, '��ٵ�', '���', 4377, 2000000, 1);

select * from department;

insert
  into department
values (4, '�ѹ�', 12);

-- �����ȣ�� 1005�� ����� �ҼӺμ��� '�ѹ�' �μ��� �����Ͻÿ�
-- subquery
update employee
   set dno = (select deptno from department where deptname = '�ѹ�')
 where empno = 1005;
 
select * from employee;

-- join���� Ȯ���غ���
select *
  from employee e
  join department d on e.dno = d.deptno;
  
-- �޿� 400 �̻��� �� 3�� ���, 300 �̻��� �� 5�� ���
-- 200 �̻��� �� 7�� ���, ������ �߱�
select empname, title,
  case
    when salary >= 4000000 then '3�� ���'
    when salary >= 3000000 then '5�� ���'
    when salary >= 2000000 then '7�� ���'
    else '�߱�'
   end as '��ٽð�'
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
      when 4 then '3�� ���'
      when 3 then '5�� ���'
      when 2 then '7�� ���'
     else '�߱�'
     end;
 