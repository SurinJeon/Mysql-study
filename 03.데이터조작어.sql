select user(), database();

show tables;

desc product;
desc sale;

-- product�� ������ �ֱ�
insert
  into product (code, name)
 values ('A001', '�Ƹ޸�ī��');
 
insert
  into product
 values ('A002', 'īǪġ��'),
        ('A003', '�������'),
        ('A004', '����������'),
        ('B001', '���⽦��ũ'),
        ('B002', '�ĸ�������'),
        ('B003', '�Ϻ���'),
        ('B004', '���̽�����');

--  tuple ������ Ȯ��!
select code, name
  from product;
  
select *
  from sale;
 

-- sale�� ������ �ֱ�
insert
  into sales(no, code, price, saleCnt, marginRate)
values (null, 'A000', 4500, 10, 10);

-- ���� �ʿ���°� ������ (������ ����)
turncate table sale;
-- Ȥ��

insert
  into sale(no, code, price, saleCnt, marginRate)
values (null, 'A001', 4500, 150, 10);

insert
  into sale(code, price, saleCnt, marginRate)
values ('A002', 3800, 150, 15),
       ('B001', 5200, 250, 12),
       ('B002', 4300, 110, 11);

-- join
select no, sale.code, name, price, saleCnt, marginRate, price*saleCnt  as '�Ǹűݾ�'
  from sale join product on sale.code = product.code;
 
-- update (����)
update product
   set name = '���ν����'
 where code = 'A003';

-- commit�� rollback (auto-commit ���� �� ����~)
insert
  into sale(code, price, saleCnt, marginRate)
 value ('A001', 4500, 250, 10);

select *
  from sale;

 
commit;

rollback;

