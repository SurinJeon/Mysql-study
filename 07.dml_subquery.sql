select user(), database();

-- p164
-- 박영권과 같은 직급을 갖는 모든 사원들의 이름과 직급을 검색하라
select empname, title
  from employee
 where title in (select title from employee where empname = '박영권');
 
-- p165
-- 사원정보와 해당 사원의 부서별 평균 급여를 검색하시오
select empno, empname, title, manager, salary, dno, 
	   (select avg(salary) from employee e1 where e2.dno = e1.dno)
  from employee e2;
  
select * from employee;

-- 좀 더 효율적으로 접근
select dno, avg(salary)
  from employee
 group by dno;
 
select empno, empname, title, manager, e2.dno, avgsal 
  from employee e2, (select dno, avg(salary) as avgsal
  				       from employee
 				      group by dno) e1
 where e2.dno = e1.dno;

-- p166
-- 1번 부서에 소속된 사원의 사원명 및 부서명을 검색하시오
select e.empname, d.deptname
  from employee e, (select deptno, deptname from department where deptno = 1) d 
 where e.dno = d.deptno;
 
-- p167
-- 부서별 급여의 평균이 사원의 평균 급여보다 많은 부서의 부서번호, 평균급여, 부서명을 검색하시오
select dno, avg(salary), deptname
  from employee e join department d on e.dno = d.deptno
 group by dno
having avg(salary) > (select avg(salary) from employee);

-- p168
-- 사번 1007, 관리자 4377 1500000 개발부서인 서현진 사원을 추가하시오
insert
  into employee
values (1007, '서현진', '사원', 4377, 1500000, (select deptno from department where deptname = '개발'))

select * from employee;

-- p170~ 172
select * 
  from employee
 where salary in (select salary from employee where dno = 1);

select *
  from employee
 where salary > any(select salary from employee where dno = 1);

select *
  from employee
 where salary > all(select salary from employee where dno = 1);

-- p173
-- 영업부나 개발부에 근무하는 사원들의 이름을 검색하라
select empname
  from employee
 where dno in (select deptno from department where deptname in ('영업', '개발'));

-- p174
-- 영업부나 개발부에 근무하는 사원들의 이름을 검색하라
select empname
  from employee e
 where exists
 		(select * from department d where e.dno = d.deptno and deptname in ('영업', '개발'));

-- p175
-- 자신이 속한 부서의 사원들의 평균급여보다 많은 급여를 받는 사원들에 대하여 이름, 부서번호, 급여를 검색하라
select empname, dno, salary
  from employee e
 where salary > (select avg(salary) from employee where dno = e.dno);
 
-- p178
select * 
  from (select empname, title, dno from employee) t
 where t.dno in (select deptno from department where deptname = '개발');
 
-- p179
create table rank_tb1(
	name char(1),
	score integer
);

insert
  into rank_tb1
values ('F', 60), ('E', 80), ('D', 80),
	   ('C', 90), ('B', 100), ('A', 100);
	
desc rank_tb1;
select * from rank_tb1;

select name, score, (select count(*) + 1 from rank_tb1 where score > t.score) as 'rank'
  from rank_tb1 t
 order by 'rank' asc;

-- p181
-- 급여를 많이 받는 사원 순으로 순위를 검색하라
select empname, salary, (select count(*) + 1 from employee where salary > e.salary)as 'rank'
  from employee e
 order by rank asc;

-- p182 Pivot 구현
create table pivotTest(
	uName char(3),
	season char(2),
	amount int
);

insert
  into pivotTest
values ('김범수', '겨울', 10), ('윤종신', '여름', 15), ('김범수', '가을', 25),
       ('김범수', '봄', 4), ('김범수', '봄', 40), ('윤종신', '겨울', 40),
       ('김범수', '여름', 15), ('김범수', '겨울', 22), ('윤종신', '여름', 65);

select * from pivotTest;

select * from pivotTest order by uName, field(season, '봄', '여름', '가을', '겨울'); -- 계절간 중복이 존재... 어떻게 제거할까?

-- p183
select uName,
	if(season = '봄', amount, 0) as '봄',
	if(season = '여름', amount, 0) as '여름',
	if(season = '가을', amount, 0) as '가을',
	if(season = '겨울', amount, 0) as '겨울'
  from pivotTest
 order by uName;

select uName,
	sum(if(season = '봄', amount, 0)) as '봄',
	sum(if(season = '여름', amount, 0)) as '여름',
	sum(if(season = '가을', amount, 0)) as '가을',
	sum(if(season = '겨울', amount, 0)) as '겨울',
	sum(amount) as '합계'
  from pivotTest
 group by uName; -- 빼먹지 말기!

-- 반대로 돌려보기
select season,
  	sum(if(uName = '김범수', amount, 0)) as '김범수',
  	sum(if(uName = '윤종신', amount, 0)) as '윤종신',
  	sum(amount) as '합계'
  from pivotTest
 group by season
union
select '합계',
	   sum(if(uName = '김범수', amount, 0)) as '김범수',
  	   sum(if(uName = '윤종신', amount, 0)) as '윤종신',
  	   sum(amount)
  from pivotTest
 order by field(season, '봄', '여름', '가을', '겨울', '합계');

-- order by 랑 group by 구분하기 제발~!

-- p184
select uName,
	count(if(season = '봄', 1, 0)) as '봄',
	count(if(season = '여름', 1, 0)) as '여름',
	count(if(season = '가을', 1, 0)) as '가을',
	count(if(season = '겨울', 1, 0)) as '겨울',
    count(amount) as '합계'
  from pivottest
 group by uName;

-- p185
select season,
	count(if(uName = '김범수', 1, 0)) as '김범수',
	count(if(uName = '윤종신', 1, 0)) as '윤종신',
	count(amount) as '합계'
  from pivotTest
 group by season
 union
select '합계',
	count(if(uName = '김범수', 1, 0)) as '김범수',
	count(if(uName = '윤종신', 1, 0)) as '윤종신',
	count(amount) 
  from pivotTest
 order by field(season, '봄', '여름', '가을', '겨울');

-- p186
select '급여별 인원수',
	count(if(salary between 4000000 and 9999999, 1, 0)) as '400 이상',
	count(if(salary between 3000000 and 3999999, 1, 0)) as '300 이상',
	count(if(salary between 2000000 and 2999999, 1, 0)) as '200 이상',
	count(if(salary between 0 and 1999999, 1, 0)) as '그 외',
	count(salary) as '합계'
  from employee;
	
-- p187
create table grade(
	grade int,
	low int,
	high int
);	

insert
  into grade
values(4, 4000000, 9999999), (3, 3000000, 3999999),
	  (2, 2000000, 2999999), (1, 0, 1999999);
	 
select * from grade;

select '급여별 인원수',
 	count(if(grade = 4, 1, 0)) as '400 이상',
 	count(if(grade = 3, 1, 0)) as '300 이상',
 	count(if(grade = 2, 1, 0)) as '200 이상',
 	count(if(grade = 1, 1, 0)) as '그 외',
 	count(salary) as '합계'
  from employee e, grade s
 where salary between s.low and s.high;

select * from employee;

select ifnull(deptname, '부서없음') as 부서별,
	count(if(grade = 4, 1, null)) as '400 이상',
 	count(if(grade = 3, 1, null)) as '300 이상',
 	count(if(grade = 2, 1, null)) as '200 이상',
 	count(if(grade = 1, 1, null)) as '그 외',
 	count(salary) as '합계'
  from employee e left join department d on e.dno = d.deptno, grade
 where salary between low and high
 group by dno
 union
select '전체',
	count(if(grade = 4, 1, null)) as '400 이상',
 	count(if(grade = 3, 1, null)) as '300 이상',
 	count(if(grade = 2, 1, null)) as '200 이상',
 	count(if(grade = 1, 1, null)) as '그 외',
 	count(salary) as '합계'
  from employee, grade
 where salary between low and high;
 	
-- roll up
select title, sum(salary)
  from employee
 group by title;

select ifnull(title, '총계') 직책, sum(salary) 급여합계
  from employee
 group by title with rollup;

select ifnull(deptname, '모든부서') as '부서',
	   ifnull(title, '모든직책') as '직책',
	   count(*) as '사원수',
	   sum(salary) as '급여합계'
  from employee e join department d on e.dno = d.deptno
 group by deptname, title with rollup;




















	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
