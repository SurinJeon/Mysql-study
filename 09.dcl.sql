select user(), database();

select @@autocommit;

-- autocommit 끄기
set autocommit = off;
set autocommit = false;
set autocommit = 0;

-- autocommit 켜기
set autocommit = on;
set autocommit = true;
set autocommit = 1;

-- p275
select *
  from employee;
  
update employee
   set title = '대리'
 where empno = 1003;
-- 지금은 주기억장치에만 있는 결과(auto commit을 껐기 때문)

rollback;

select * from employee; -- 그대로 과장임을 알 수 있음

select @@autocommit;

select * from employee;

update employee
   set title = '대리'
 where empno = 1003;

commit;

select * from employee; -- 과장에서 대리가 됨

rollback;

select * from employee; -- 계속 대리로 남아있음!

-- 원상복원 시키기 ㅎㅎ..
update employee
   set title = '과장'
 where empno = 1003;

-- transaction 생성 및 실행시키기
select * from employee;
select * from department;

select @@autocommit;

-- procedure 호출
call proc_transaction;

select * from employee; -- 1010에 차현수 추가됨

-- commit 시점 (여러개 설정 가능)
set autocommit = false;
savepoint aa; -- 원래상태

insert
  into employee
values (2004, '이은유', '대리', 4377, 3500000, 3);
savepoint bb; -- 추가까지 커밋

update employee
   set salary = 4000000
 where empno = 2004;
savepoint cc; -- 수정까지 커밋

delete
  from employee
 where empno = 2004;
savepoint dd; -- 삭제까지 커밋

rollback to dd;
select * from employee;

rollback to cc;
select * from employee;

rollback to bb;
select * from employee;

rollback to aa;
select * from employee;

set autocommit = true;

select @@autocommit;















 