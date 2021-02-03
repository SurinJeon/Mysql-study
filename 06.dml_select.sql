select user(), database();

-- p113
select *
  from department;
  
update department
   set floor = 7
 where deptno = 4;
 
select *
  from employee;

delete
  from employee
 where empno = 1005;
 
-- p116
-- ;의 위치 잘 보기

-- Join이 곱으로 됨
select empno, empname, title, dno, deptname
  from employee as e, department as d;
 where e.dno = d.deptno
 
-- 정상적인 Join
select empno, empname, title, dno, deptname -- dno 적어도 되고 deptno 적어도 됨
  from employee as e, department as d
 where e.dno = d.deptno;

select empno, empname, title, dno, deptname
  from employee e join department d on e.dno = d.deptno;
 
-- p118
 select distinct title
   from employee;
   
-- p119
select empname, title, dno
  from employee
 where empname like '이%';
  
-- p121
select empname, salary
  from employee
 where title = '과장' and dno = 1;

select empname, salary
  from employee
 where title = '과장' and dno != 1; -- dno <> 1도 됨

-- p122
select empname, title, salary
  from employee
 where salary between 3000000 and 4500000; -- 하거나 salary >=3000000 and salary <= 4500000

-- p123
select *
  from employee
 where dno in(1,3);

-- p124 =를 쓰고싶지만 두개의 값을 받아올 것이라면 사용할 수 없음... in만 가능함
-- use subquery
select *
  from employee
 where dno in (select deptno from department where deptname in ('영업', '개발'));

-- use join
select e.*
  from employee e join department d on e.dno=d.deptno
 where deptname in ('영업', '개발');
-- 둘 다 가능하다면, join을 쓰는 것이 더 좋음 (성능상)

-- p125
select empname, salary, salary * 1.1 as 'newsalary', salary*0.15 as '성과급'
  from employee
 where title = '과장';

-- p129
select salary, title, empname
  from employee
 where dno = 2
 order by salary asc;

-- 부서가 개발인 직원의 급여, 직책, 이름, 부서번호를 급여의 오름차순으로 정렬하라
select salary, title, empname, dno
  from employee
 where dno = (select deptno from department where deptname = '개발')
 order by salary;

select salary, title, empname, dno
  from employee e join department d on e.dno = d.deptno
 where deptname = '개발'
 order by salary asc;

select * from employee;

-- p130
select title, empname, dno, salary
  from employee
 order by dno asc, salary desc;

-- p131
-- 아래처럼 하면 가나다 순서로 뜸...
select *
  from employee
 order by title asc;

-- 이렇게 해야함
-- 꼭 e.title 라고 안 써도 됨(e가 빠져도 됨)
select empno, empname, title, manager, salary, dno
  from employee e
 order by field(e.title, '사장', '부장', '과장', '대리', '사원');

-- p132
create table if not exists items(
    id int auto_increment primary key,
    item_no varchar(255) not null
);


insert
  into items(item_no)
values ('1'), ('1c'), ('10z'), ('2a'), ('2'), ('3c'), ('20d');

-- 이렇게 하면 원하는대로 뜨지 않음
select item_no
  from items
 order by item_no asc;

-- 이렇게 해보기 (item_no에 있는 알파벳을 잠시 부호없는 숫자로 바꾼다는 뜻)
select item_no
  from items
 order by cast(item_no as unsigned), item_no;

select item_no, cast(item_no as unsigned)
  from items;
 
-- p135
truncate table items;

insert
  into items(item_no)
values ('A - 1')
     , ('A - 2')
     , ('A - 3')
     , ('A - 4')
     , ('A - 5')
     , ('A - 10')
     , ('A - 11')
     , ('A - 20')
     , ('A - 30');
    
-- p136
select item_no
  from items
 order by length(item_no), item_no;

-- p138 (format 쓰면 안에 쉼표가 들어가기 때문에 문자열로 뜸)
select format(AVG(salary), 1) as avgsal 
     , MAX(salary) as maxsal
  from employee;

-- p139
select empno, avg(salary)
  from employee;
 
select *
  from employee;

-- p140
select dno, avg(salary) as 'avgsalary', max(salary) as 'maxsalary'
  from employee
 group by dno;
 
-- p142
select dno, avg(salary) as 'avgsalary', max(salary) as 'maxsalary'
  from employee
 group by dno
having avg(salary) >= 2500000;

-- p143
select dno
  from employee
 where empname = '김창섭'
union
select deptno
  from department
 where deptname = '개발';
 
-- p147
create table joinTest1(
		 a int,
		 b varchar(2)
);

insert
  into joinTest1
values (1, 'a')
     , (2, 'b')
     , (3, 'b')
     , (4, 'f');
 
create table joinTest2(
		 b varchar(2),
		 c int(2)
); 

insert
  into joinTest2
values ('a', 1)
     , ('b', 2)
     , ('c', 3)
     , ('d', 4); 

select * from joinTest1;
select * from joinTest2;

-- p148
select *
  from joinTest1 t1
  join joinTest2 t2 on t1.b=t2.b;
 
select *
  from joinTest1 t1
 inner join joinTest2 t2 on t1.b=t2.b;

-- 중복제거
select *
  from joinTest1 t1 inner join joinTest2 t2 using(b);
 
select *
  from joinTest1 t1 natural join joinTest2 t2;
 
-- p149
select *
  from joinTest1 t1 left join joinTest2 t2 on t1.b=t2.b;

-- p150
select *
  from joinTest1 t1 right join joinTest2 t2 on t1.b=t2.b;
 
-- left 와 right join 다 합친 것이(union) full outer join 
select *
  from joinTest1 t1 left join joinTest2 t2 on t1.b=t2.b
 union 
select *
  from joinTest1 t1 right join joinTest2 t2 on t1.b=t2.b;
 
 -- left 와 right join 다 합친 것이(union) full outer join 
select *
  from joinTest1 t1 left join joinTest2 t2 on t1.b=t2.b
 union 
select *
  from joinTest1 t1 right join joinTest2 t2 on t1.b=t2.b;

-- p151
select *
  from joinTest1 t1 left join joinTest2 t2 on t1.b = t2.b;
 
select t1.*
  from joinTest1 t1 left join joinTest2 t2 on t1.b = t2.b
 where t2.b is null;

select *
  from joinTest1 
 where b not in (select b from joinTest2);

-- p152
select *
  from joinTest1 t1 right join joinTest2 t2 on t1.b = t2.b;
 
select t1.*
  from joinTest1 t1 right join joinTest2 t2 on t1.b = t2.b
 where t1.b is null;

select *
  from joinTest2 
 where b not in (select b from joinTest1);

-- p153
select *
  from joinTest1 t1 left join joinTest2 t2 on t1.b = t2.b
 union
select *
  from joinTest1 t1 right join joinTest2 t2 on t1.b = t2.b;
  
 
select * from employee;

insert 
  into employee
values (1004, '이유영', '사원', null, 2000000, null); -- 외래키인 dno에는 null 들어가도 됨(아직 부서가 결정되지 않은 것)

-- left join의 필요성에 대해
select *
  from employee e join department d on e.dno = d.deptno; -- 이렇게하면 이유영은 누락됨...
  
-- 그래서 left join 이 필요함
select *
  from employee e left join department d on e.dno = d.deptno;

-- p155
select empname, deptname
  from employee e, department d
 where e.dno = d.deptno;

select *
  from employee e
 where dno in (select deptno from department);

-- 하지만 위를 실행시키면 이유영은 나오지 않음
-- 이유영을 뽑아내려면 아래를 실행시켜야함
select empname, deptname
  from employee e left join department d on e.dno = d.deptno
 where dno is null;

-- p157
create table sal_grade(
	grade int primary key,
	losal int, -- low salary
	hisal int  -- high salary
);

insert
  into sal_grade
values (1, 0, 1500000),
       (2, 1510000, 2000000),
       (3, 2000001, 3000000),
       (4, 3000001, 4000000),
       (5, 4000001, 9999999);
      
select * from sal_grade;
select * from employee;

-- select* 해도 되는데 나중에 좀 더 알기 쉽도록 깔끔하게 하기 위해서 attribute 이름 적어주는게 좋음
select empno, empname, title, manager, salary, dno,
  case
    when salary <= 1500000 then 1
    when salary <= 2000000 then 2
    when salary <= 3000000 then 3
    when salary <= 4000000 then 4
    else 5
  end as grade
  from employee;
 
-- p158
select e.empno, e.empname, e.salary, g.grade, g.losal, g.hisal
  from employee e, sal_grade g
 where e.salary between g.losal and g.hisal;

-- p159 (join 할 때는 반드시 외래키가 걸려있어야된다는 아님)
select e.empname as '사원', m.empname as '직속 상사'
  from employee e, employee m -- 별칭을 다르게 두는게 중요함
 where e.manager = m.empno;

-- join이 department과 되는데 거기서 dno를 자동으로 오름차순 정렬을 해놨기 때문에 부서가 오름차순으로 정렬됨
select e.empno, 
       e.empname, 
       e.title,
       ifnull(concat(m.empname,'(', e.manager ,')'), '없음') '직속상사',
       e.salary,
       concat(d.deptname, '(', e.dno, ')') '부서'
  from (employee e left join department d on e.dno = d.deptno) join employee m on e.manager = m.empno;


select e.empno, 
       e.empname, 
       e.title,
       e.salary,
       concat(d.deptname, '(', e.dno, ')') '부서'
  from (employee e left join department d on e.dno = d.deptno);
 
 
select m.empname, concat(m.empname,'(', e.manager ,')') '직속상사'
  from employee m, employee e
 where e.manager = m.empno;
 
select * from employee;