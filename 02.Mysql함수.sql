select user(), database();

use coffee;

select concat (name, '(', code, ')' ) as '제품명(코드)'
  from product;
  
 select *
   from product;
   
