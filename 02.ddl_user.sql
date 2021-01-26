select user(), database();

-- p79 create/drop user (������ ������ �� �ְ� ���� �ٸ� ������ �ο��ϴ� ���� �ƴ�)
create user 'ceo'@'localhost' identified by '1234567';
drop user 'ceo'@'localhost';

show grants;
show grants for 'ceo'@'localhost';

-- ���� �ο�
grant select, insert, delete 
   on mysql_study.*
   to 'ceo'@'localhost';
   
-- p85 �������� ���Ѻο� ����ο� �� ���� �غ���
grant select, insert, delete
   on coffe.*
   to 'study'@'localhost' identified by '1234567';
  
show grants for 'study'@'localhost';

-- p86
select user(), database();

desc mysql.db; -- ���� � ������ ������ �ֳ� ����ִ� database / only by root

select *
  from mysql.db
 where user = 'study'; -- 'study'@'localhost' ������ � ������ �ִ��� Ȯ�� ����
 
-- p89
grant all
   on mysql_study.*
   to 'user_mysql_study'@'localhost' identified by 'rootroot';


  
  
  
  
  
  
  
  
  
  
  