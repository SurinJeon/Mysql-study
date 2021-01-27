select user(), database();

show tables;

-- 1. employee(empno, empname, title, manager, salary, dno) table 생성
--    기본키 : empno
--    외래키 : tno(title.tno), manager(employee.empno), dno(department.deptno)

-- 2. title(tno, tname) 테이블 생성 (1, '사장')(2, '부장')...
--    기본키 : tno

-- 3. department(deptno, deptname, floor) 테이블 생성
--    기본키 : deptno

-- 4. 테이블에 데이터 insert
-- 5. 모든 사원에 대하여 결과가 아래와 같이 나와야함
-- empno, empname, 직책명(직책번호), 직속상사명(직속상사번호), salary, 부서명(부서번호)

create table title(
	tno int(11),
	tname varchar(20),
	primary key (tno)
);

create table department (
   deptno int(11),
   deptname char(20),
   floor int(11),
   primary key (deptno)
);

create table employee (
   empno int(11) not null,
   empname varchar(20) unique,
   tno int(11),
   manager int(11),
   salary int(11),
   dno int(11),
   primary key (empno),
   foreign key (tno) references title(tno),
   foreign key (manager) references employee(empno),
   foreign key (dno) references  department(deptno)
 );

show tables;

insert
  into title(tno, tname)
values (1, '사장'),
	   (2, '부장'),
	   (3, '과장'),
	   (4, '대리'),
	   (5, '사원');


insert 
  into department
values (1, '영업', 8),
       (2, '기획', 10),
       (3, '개발', 9),
       (4, '총무', 7);
      
insert
  into employee
values (4377, '이성래', 1, null, 5000000, 2),
       (3426, '박영권', 3, 4377, 3000000, 1),
       (1003, '조민희', 3, 4377, 3000000, 2),
       (3011, '이수민', 2, 4377, 4000000, 3),
       (1365, '김상원', 5, 3426, 1500000, 1),
       (2106, '김창섭', 4, 1003, 2500000, 2),
       (3427, '최종철', 5, 3011, 1500000, 3);
            
select * from title;
select * from employee;
select * from department;

select e.empno,
       e.empname,
       concat(t.tname, '(', e.tno, ')') as '직책명(직책번호)',
       ifnull(concat(m.empname, '(', e.manager, ')'), '없음') as '직속상사명(직속상사번호)',
       e.salary,
       concat(d.deptname, '(', e.dno,')') as '부서명(부서번호)'
  from (employee e left join title t on e.tno = t.tno) 
    left join employee m on e.manager = m.empno 
    join department d on e.dno = d.deptno;