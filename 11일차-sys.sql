--sys���� < �ְ� ������ �������� �����ؾ��Ѵ�.
--Autication (����) : credential(ID+pass)����
create user user_test10 identified by 1234; --��������

--Authorization (�㰡) :system ���� �Ҵ�.
grant create session, create table, create view to user_test10;

--�⺻������ ������ �����ϸ� system ���̺� �����̽��� ����Ѵ�.<===�����ڸ� ��밡���� ���̺� �����̽� 
--���̺� �����̽� �ٲٱ�. (users table space��)
alter user user_test10
default tablespace "USERS"
temporary tablespace "TEMP";

-- ���̺� �����̽� �뷮 �Ҵ�
ALTER USER "USER_TEST10" QUOTA UNLIMITED ON "USERS";

--Ư���������� ��ü�� �����ϸ� �� ������ �� ��ü�� �����ϰԵȴ�.

select * from dba_tables
where owner in ('HR','USER_TEST10');

-- �ٸ� ������� ���̺� ���� �ҷ��� ������ ������ �Ѵ�. (grant ��ü���� on ����������� ��ü�� to ����ϰ��� �ϴ� ������)
grant select on hr. employee to user_test10; 

--select/insert/update/delete ���� �ο�!
grant select on hr.emp_copy55 to user_test10;
grant insert,update,delete on hr.emp_copy55 to user_test10;

--������ ������ ���!! revoke ���!
revoke insert,update,delete on hr.emp_copy55 from user_test10;


/*
with grant option : Ư�� �������� ������ �ο��ϸ鼭 �ش� ������ �ٸ� ����ڿ��� �ο��� �� �ִ� ����.
*/
grant select on hr.employee to user_test10 with grant option ; 
    --user_test10 ������ hr.employee ���̺� ���ؼ� �ٸ� ����ڿ��� select ������ �ο��� �� �ִ�.

grant select on hr.dept_copy55 to user_test10 with grant option ; 

/*
    public : ��� ����ڿ��� ������ �ο��ϴ� ��.
*/
grant select,insert,update,delete on hr.dept_copy56 to public ;

/*
    ��(Role) : ���ֻ���ϴ� �������� ���� �� ���� ���� ��
        1. dba: �ý����� ��� ������ ����� role, --sys ����(�ְ� ������ ����)
        2. connect : 
        3. resource : 
*/

--����� ���� role ���� : ���ֻ���ϴ� ���ѵ��� ��� role�� ����.
    --  1. �ѻ��� :   
    create role ROLETEST1;
    
    --2. �ѿ� ���ֻ���ϴ� ������ ����.
    grant create session,create table,create view,create sequence, create trigger to roletest1;
    
    --3. ������ ���� �������� ����.
    grant roletest1 to user_test10;
    
/*
    ���� ����ڿ��� �ο��� �� Ȯ��
*/
select * from user_role_privs;

/*
    �ѿ� �ο��� ���� ���� Ȯ��
*/
select * from role_sys_privs
where role like 'DBA';

select * from role_sys_privs
where role like 'ROLETEST1';

/* ��ü ������ role�� �ο��ϱ� */
create role roletest2;
grant select on hr.employee to roletest2; --roletest2�� ������ �ƴ϶� role�̴�!! �������� ��ü������ ������ ���� �ƴ϶� �ѿ� �����Ѱ�.

grant roletest2 to user_test10;  --���� �������� ����! �ش���� hr.employee��select���� ������ ������ ����!!!

--�ǽ� : hr.dept_copy57�� ���� 
-- �ѻ��� : roletest3
-- roletest3 :select insert delete /user_test10�� ����

create role roletest3;
grant select,insert,dselectelete on hr.dept_copy57 to roletest3;
grant roletest3 to user_test10;

select * from role_sys_privs
where role like 'roletest3'; 






