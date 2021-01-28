select user(), database();

create database ncs_coffee;

show databases;

grant all
   on ncs_coffee.*
   to 'user_ncs_coffee'@'localhost' identified by 'rootroot';
   
select user(), database();