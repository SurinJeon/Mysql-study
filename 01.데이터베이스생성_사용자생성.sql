select user(), database();

show databases;
use mysql;


/*
 * root�� �ؾ��� ��
 * 1. �����ͺ��̽� ����
 * 2. ����� ������ ���ÿ� ���� �߰�
 */

create database if not exists coffee;

grant all
   on coffee.*
   to 'user_coffee'@'localhost' identified by 'rootroot';
