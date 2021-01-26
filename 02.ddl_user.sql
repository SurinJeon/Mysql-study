select user(), database();

-- p79 create/drop user (계정을 접속할 수 있게 만듦 다만 권한을 부여하는 일은 아님)
create user 'ceo'@'localhost' identified by '1234567';
drop user 'ceo'@'localhost';

show grants;
show grants for 'ceo'@'localhost';

-- 권한 부여
grant select, insert, delete 
   on mysql_study.*
   to 'ceo'@'localhost';
   
-- p85 계정생성 권한부여 비번부여 한 번에 해보기
grant select, insert, delete
   on coffe.*
   to 'study'@'localhost' identified by '1234567';
  
show grants for 'study'@'localhost';

-- p86
select user(), database();

desc mysql.db; -- 누가 어떤 권한을 가지고 있나 담겨있는 database / only by root

select *
  from mysql.db
 where user = 'study'; -- 'study'@'localhost' 계정에 어떤 권한이 있는지 확인 가능
 
-- p89
grant all
   on mysql_study.*
   to 'user_mysql_study'@'localhost' identified by 'rootroot';


  
  
  
  
  
  
  
  
  
  
  