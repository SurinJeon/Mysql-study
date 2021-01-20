select user(), database();

show databases;
use mysql;


/*
 * root가 해야할 일
 * 1. 데이터베이스 생성
 * 2. 사용자 생성과 동시에 권한 추가
 */

create database if not exists coffee;

grant all
   on coffee.*
   to 'user_coffee'@'localhost' identified by 'rootroot';
