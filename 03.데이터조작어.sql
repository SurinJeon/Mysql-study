select user(), database();

show tables;

desc product;
desc sale;

-- product에 데이터 넣기
insert
  into product (code, name)
 values ('A001', '아메리카노');
 
insert
  into product
 values ('A002', '카푸치노'),
        ('A003', '헤이즐넛'),
        ('A004', '에스프레소'),
        ('B001', '딸기쉐이크'),
        ('B002', '후르츠와인'),
        ('B003', '팥빙수'),
        ('B004', '아이스초코');

--  tuple 들어갔는지 확인!
select code, name
  from product;
  
select *
  from sale;
 

-- sale에 데이터 넣기
insert
  into sales(no, code, price, saleCnt, marginRate)
values (null, 'A000', 4500, 10, 10);

-- 위에 필요없는거 날리기 (데이터 삭제)
turncate table sale;
-- 혹은

insert
  into sale(no, code, price, saleCnt, marginRate)
values (null, 'A001', 4500, 150, 10);

insert
  into sale(code, price, saleCnt, marginRate)
values ('A002', 3800, 150, 15),
       ('B001', 5200, 250, 12),
       ('B002', 4300, 110, 11);

-- join
select no, sale.code, name, price, saleCnt, marginRate, price*saleCnt  as '판매금액'
  from sale join product on sale.code = product.code;
 
-- update (수정)
update product
   set name = '아인슈페너'
 where code = 'A003';

-- commit과 rollback (auto-commit 껐을 때 가능~)
insert
  into sale(code, price, saleCnt, marginRate)
 value ('A001', 4500, 250, 10);

select *
  from sale;

 
commit;

rollback;

