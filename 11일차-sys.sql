--sys계정 < 최고 관리자 계정으로 접속해야한다.
--Autication (인증) : credential(ID+pass)만듬
create user user_test10 identified by 1234; --계정생성

--Authorization (허가) :system 권한 할당.
grant create session, create table, create view to user_test10;

--기본적으로 계정을 생성하면 system 테이블 스페이스를 사용한다.<===관리자만 사용가능한 테이블 스페이스 
--테이블 스페이스 바꾸기. (users table space로)
alter user user_test10
default tablespace "USERS"
temporary tablespace "TEMP";

-- 테이블 스페이스 용량 할당
ALTER USER "USER_TEST10" QUOTA UNLIMITED ON "USERS";

--특정계정에서 객체를 생성하면 그 계정이 그 객체를 소유하게된다.

select * from dba_tables
where owner in ('HR','USER_TEST10');

-- 다른 사용자의 테이블 접근 할려면 권한을 가져야 한다. (grant 객체권한 on 가저오고싶은 객체명 to 사용하고자 하는 계정명)
grant select on hr. employee to user_test10; 

--select/insert/update/delete 권한 부여!
grant select on hr.emp_copy55 to user_test10;
grant insert,update,delete on hr.emp_copy55 to user_test10;

--권한을 해제할 경우!! revoke 사용!
revoke insert,update,delete on hr.emp_copy55 from user_test10;


/*
with grant option : 특정 계정에게 권한을 부여하면서 해당 권한을 다른 사용자에게 부여할 수 있는 권한.
*/
grant select on hr.employee to user_test10 with grant option ; 
    --user_test10 계정은 hr.employee 테이블에 대해서 다른 사용자에게 select 권한을 부여할 수 있다.

grant select on hr.dept_copy55 to user_test10 with grant option ; 

/*
    public : 모든 사용자에게 권한을 부여하는 것.
*/
grant select,insert,update,delete on hr.dept_copy56 to public ;

/*
    룰(Role) : 자주사용하는 여러개의 권한 을 묶어 놓은 것
        1. dba: 시스템의 모든 권한이 적용된 role, --sys 계정(최고 관리자 권한)
        2. connect : 
        3. resource : 
*/

--사용자 정의 role 생성 : 자주사용하는 권한들을 묶어서 role를 생성.
    --  1. 롤생성 :   
    create role ROLETEST1;
    
    --2. 롤에 자주사용하는 권한을 적용.
    grant create session,create table,create view,create sequence, create trigger to roletest1;
    
    --3. 생성된 롤을 계정에게 적용.
    grant roletest1 to user_test10;
    
/*
    현재 사용자에게 부여된 롤 확인
*/
select * from user_role_privs;

/*
    롤에 부여된 권한 정보 확인
*/
select * from role_sys_privs
where role like 'DBA';

select * from role_sys_privs
where role like 'ROLETEST1';

/* 객체 권한을 role에 부여하기 */
create role roletest2;
grant select on hr.employee to roletest2; --roletest2가 계정이 아니라 role이다!! 계정에게 객체권한을 적용한 것이 아니라 롤에 적용한것.

grant roletest2 to user_test10;  --롤을 계정에게 적용! 해당롤은 hr.employee의select관한 권한을 가지고 있음!!!

--실습 : hr.dept_copy57을 생성 
-- 롤생성 : roletest3
-- roletest3 :select insert delete /user_test10에 적용

create role roletest3;
grant select,insert,dselectelete on hr.dept_copy57 to roletest3;
grant roletest3 to user_test10;

select * from role_sys_privs
where role like 'roletest3'; 






