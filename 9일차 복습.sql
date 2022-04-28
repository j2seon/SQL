---복습

--현재사용자가 만들어둔 테이블을 볼 수 있다.
select * from user_tables;  --데이터 사전: 시스템의 각종 정보를 출력해주는 것,레코드값을 볼때는 대문자로 쓰자

select * from user_tables
where table_name = 'DEPT';

drop table dept; --커밋을 쓰지 않아도 된다. insert update delete만 사용

create table dept (
    dno number(2) not null,
    dname varchar2(14) not null,
    loc varchar2(13) null
);

drop table emp; --커밋을 쓰지 않아도 된다. insert update delete만 사용

create table emp(
    eno number(4) not null,
    ename varchar2(10) null, 
    dno number(2)
);
--DB설정에 따라서 , null허용 여부가 다르게 셋팅되어 있을 수 있다.

--테이블의 크기 수정!
desc emp;

alter table emp
modify ename varchar2(25);

--길이 보기!
select length (ename) from employee
where length (ename)>5;

--원하는 부분만 가져와서 테이블 만들기 !! 테이블 복사 시에 제약조건은 복사되지 않는다 .
create table employee2
as
select eno,ename, salary,dno from employee;
select * from employee2;

--제약조건
    --primary key : 한 테이블에 하나만 존재한다. (not null)
    --Unique :primary key와 비슷하지만 여러번 가능하다. 
    --check
    --default
    --foreign

--테이블 이름 변경
rename employee2 to emp;
desc emp;

--테이블 내의 컬럼제거하기
select * from dept;

alter table dept 
drop column dname;


-- unused 하기 
    -- drop해서 삭제할 수 있찌만 실제 운영하는 시스템에서는 레코드가 엄청많다 . 
    -- 바로삭제시에 부하가 걸릴 수 있기 때문에 unused를 하고 추후에 삭제한다.
    
alter table dept
set unused(loc);

select * from dept;

-- unused 된 컬럼 삭제
alter table dept
drop unused column;


--구조만 복사해서 테이블 만들기
select * from emp;

create table emp_insert
as
select * from emp
where 0=1; --조건을 false로 설정하면 레코드를 가지고오지 않는다!!

select * from emp_insert;

-- 컬럼 추가 : 컬럼 추가시 null허용으로 추가해야한다.
alter table emp_insert
add hiredate date;

desc emp_insert;

--로우 추가 
select * from emp_insert;

insert into emp_insert(eno,ENAME,SALARY,DNO,HIREDATE)
values(1000,'이모씨',3000.35,10,sysdate);
commit;

insert into emp_insert(eno,ENAME,SALARY,DNO,HIREDATE)
values(1001,'김모씨',3000.35,10,to_date(sysdate-1,'yy/mm/dd'));
commit;


--구조+내용 복사
create table emp_copy
as
select *from employee;


--사원번호 7788인 부서번호 10으로 바꾸기 // 7499 바꿔주기
select *from emp_copy;

update emp_copy
set dno=10
where eno = 7788; --주의 : update 나 delete 시 반드시 where 조건을 사용한다
commit;

select *from emp_copy
where eno=7788 or eno=7499;

update emp_copy
set job=(select job from emp_copy where eno=7788),
salary=(select salary from emp_copy where eno=7788 )
where eno=7499;
commit;
 
--7369와 동일한 사원의 부서번호를  7369 부서번호로 바꾸기
select *from emp_copy
where eno=7369;

select * from emp_copy
where job='CLERK';

update emp_copy
set dno = (select dno from emp_copy where eno=7369)
where job= (select job from emp_copy where eno=7369);
commit;


--테이블 만들기 
create table dept_copy
as
select * from department;

-- 부서명 RESEARCH 삭제
delete dept_copy
where dname ='RESEARCH';

select * from dept_copy;
commit;

-- 부서번호가 10,40인 제거
delete dept_copy
where dno in (10,40);
commit;



--테이블의 무결성 !!!!
drop table dept_sample;

-- 테이블 복사할때 제약조건은 복사되지 않는다.
--1. employee 테이블의 구조를 복사하여 emp_sample 란 이름의 테이블을 만드시오. 
--사원 테이블의 사원번호 컬럼에 테이블 레벨로 primary key 제약조건을 지정하되 제약조건 이름은 my_emp_pk로 지정하시오. 
create table emp_sample
as
select * from employee
where 0=1;

select *from emp_sample;

alter table emp_sample
add constraint PK_emp_sample_eno Primary Key (eno);

select * from user_constraints
where table_name='EMP_SAMPLE'; --대문자로 처리해야함.


--2. department 테이블의 구조를 복사하여 dept_sample 란 이름의 테이블을 만드시오. 
--부서 테이블의 부서번호 컬럼에 레벨로 primary key 제약 조건을 지정하되 제약 조건이름은 my_dept_pk로 지정하시오. 
create table dept_sample
as
select * from department
where 0=1;

alter table dept_sample
add constraint PK_dept_sample_dno Primary Key (dno);

select * from user_constraints
where table_name='DEPT_SAMPLE';


--3. 사원 테이블의 부서번호 컬럼에 존재하지 않는 부서의 사원이 배정되지 않도록 외래키 제약조건을 지정하되
--제약 조건이름은 my_emp_dept_fk 로 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
select * from emp_sample ; 
select * from dept_sample ; 

alter table emp_sample
add constraint FK_emp_sample_dno_dept_sample Foreign key (dno) references dept_sample (dno);

select * from user_constraints
where table_name in('EMP_SAMPLE','DEPT_SAMPLE');

--4. 사원테이블의 커밋션 컬럼에 0보다 큰 값만을 입력할 수 있도록 제약 조건을 지정하시오. [
--주의 : 위 복사한 테이블을 사용하시오]
alter table emp_sample
add constraint CK_emp_sample_commission check(commission>=0); --0보다 작은값을 쓰면 안된다.


--5. 사원테이블의 웝급 컬럼에 기본 값으로 1000 을 입력할 수 있도록 제약 조건을 지정하시오. 
--[주의 : 위 복사한 테이블을 사용하시오]
--default 랑 not null은 modify를 이용한다!!!!
alter table emp_sample 
modify salary default 1000;

--6. 사원테이블의 이름 컬럼에 중복되지 않도록  제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
--primary는 이미 있어서 쓸수 없다.
select * from user_constraints
where table_name in('EMP_SAMPLE','DEPT_SAMPLE');

alter table emp_sample 
add constraint UK_emp_sample_ename Unique (ename);

--7. 사원테이블의 커밋션 컬럼에 null 을 입력할 수 없도록 제약 조건을 지정하시오. [주의 : 위 복사한 테이블을 사용하시오]
--제약조건이름을 안넣어서 이름이 자동을 부여되었음!
alter table emp_sample
modify commission NOT NULL;

--8. 위의 생성된 모든 제약 조건을 제거 하시오. 
select * from user_constraints
where table_name in('EMP_SAMPLE','DEPT_SAMPLE');

--제약조건을 제거시 : foreign key가 참조하면 제거가 안된다.
    --1.foreign key를 먼저 제거후 primary key 제거
    --2.primary key를 제거할 때 cascade 옵션을 사용 : 한번만 작업하면 된다!!

alter table dept_sample
drop constraint primary key cascade;

alter table emp_sample
drop constraint PK_EMP_SAMPLE_ENO cascade;

alter table emp_sample
drop constraint CK_EMP_SAMPLE_COMMISSION;

alter table emp_sample
drop constraint UK_EMP_SAMPLE_ENAME;

alter table emp_sample
drop constraint SYS_C007259;

--뷰 문제 
--뷰는 가상의 테이블 select 문만 온다!!
    --보안을 위해서 실제테이블의 컬럼을 숨길 수 있다.
    --편의성을 위해서 : 복잡한 구문을 view 를 생성하면!
--1. 20번 부서에 소속된 사원의 사원번호과 이름과 부서번호를 출력하는 select 문을 하나의 view 로 정의 하시오.
--	뷰의 이름 : v_em_dno  
    

create table emp_view --참조할 테이블로 만들어서 쓰기! 
as
select * from employee;
create table dept_view
as
select * from department;

--뷰 생성
create view v_em_dno
as 
select eno,ename,dno
from emp_view
where dno=20;

--뷰 실행
select * from v_em_dno; --테이블 출력되듯 출력된다.

--2. 이미 생성된 뷰( v_em_dno ) 에 대해서 급여 역시 출력 할 수 있도록 수정하시오. 
create or replace view v_em_dno
as
select eno, ename, dno, salary
from emp_view
where dno=20;
 
--3. 생성된  뷰를 제거 하시오. 
drop view v_em_dno;

--4. 각 부서의 급여의  최소값, 최대값, 평균, 총합을 구하는 뷰를 생성 하시오. 
--	뷰이름 : v_sal_emp
create or replace view v_sal_emp
as 
select min(salary) 최소값 , max(salary) 최대값, avg(salary) 평균, sum(salary) 총합
from emp_view
group by dno;

select * from v_sal_emp;

-- 5. 이미 생성된 뷰( v_em_dno ) 에 대해서 읽기 전용으로!

create or replace view v_sal_emp
as 
select min(salary) 최소값 , max(salary) 최대값, avg(salary) 평균, sum(salary) 총합
from emp_view
group by dno with read only;

select * from v_sal_emp;








