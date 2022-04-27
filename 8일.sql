-- 8일차 - 뷰, 시퀀스, 인덱스
/*
    뷰 (view) : 가상의 테이블
        -- 테이블은 데이터 값을 가지고 있다.
        - 뷰는 데이터 값을 가지지 않는다. 실행 코드만 들어가 있다. 
        -- 뷰를 사용하는 목적 : 
            (1) 보안: 실제 테이블의 특정 컬럼만 가져와서 실제 테이블의 중요 컬럼을 숨길 수 있다.
            (2) 복잡한 쿼리를 뷰를 생성해서 편리하게 사용할 수 있다. (복잡한 JOIN 쿼리)
        -- 뷰는 일반적으로 select 구문이 온다.
        -- 뷰는 insert, update, delete 구문이 올 수 없다.
        -- 뷰에 값을 insert 하면 실제테이블에 저장된다. 실제 테이블의 제약조건을 잘 만족하면 된다.
        -- 뷰에 값을 insert 할 경우 실제 테이블의 제약조건에 따라서 insert 될 수도 있고 그렇지않을수도 있다.
        -- 그룹함수를 적용한 view에는 insert 핤 ㅜ없다.
*/
    Create table dept_copy60
    as
    select * from department;
    
    create table emp_copy60
    as
    select * from employee;
    
-- 뷰 생성
    create view v_emp_job
    as 
    select eno, ename, dno, job
    from emp_copy60
    where job like 'SALESMAN';
    
-- 뷰 생성 확인
    select * from user_views;
    
--복잡한 조인 쿼리를 뷰에 생성하기

create view v_join1
as
select e.dno,ename,job, dname,loc
from employee e , department d
where e.dno=d.dno
and job = 'SALESMAN';

select * from v_join1;

--뷰를 사용해서 실제 테이블의 중요한 정보 숨기기 (보안)
select * from emp_copy60;

create view simple_emp
as
select ename,job,dno
from emp_copy60;

select * from simple_emp; --view를 사용해서 실제 테이블의 중요컬럼을 숨길 수 있다.

select * from user_views;

--뷰를 생성할 때 반드시 별칭이름을 사용해야하는 하는 경우 ,group by 할때

create view v_groupping 
as
select dno, count(*) groupCount, Avg(salary) avg ,sum(salary) sum
from emp_copy60
group by dno; 

select *from v_groupping;

--뷰를 생성할 때 as 하위에 select 문이 와야한다. insert, update,delete문은 올 수 없다.
create view v_error  --오류!
as 
insert into dno 
values(60,'hr','busan')

--view에 값을 insert 할 수 있을까? 컬럼에 제액조건을 만족하면 view에도 값을 넣을 수 있다.
    --실제테이블에 값이 insert 된다.
    
create view v_dept
as
select dno,dname
from dept_copy60;

select * from v_dept;

insert into v_dept --view에 값을 insert, 제약 조건이 일치할때 잘 insert가 된다.
values (70,'HR');

select * from dept_copy60;

create or replace view v_dept  --v_dept가 존재하지 않을 경우 create , 존재할 경우 : replace (수정)
as
select dname, loc
from dept_copy60;

select * from v_dept;

insert into v_dept
values('HR2','busan')


select * from dept_copy60;


update dept_copy60
set dno = 80
where dno is null;
commit;

alter table dept_copy60
add constraint PK_dep_copy60 primary key(dno)
select *from user_comstraints
where table_name ='DEPT_COPY60';

select * from v_dept;

insert into v_dept; --view에 값을 insert, 제약 조건이 일치할때 잘 insert가 된다.

select * from user_views;

select * from v_groupping; --그룹핑된 view에는 insert 할 수 없다.

create or repalce 


drop view v_groupping
drop view v_groupping;

--insert, update, delete가 가능한 뷰
create view v_dept10
as 
select dno,dname,loc
from dept_copy60

insert into v_dept10
values(90,'HR4','basan4')

select * from v_dept10;

update v_dept10
set dname = 'HR5',loc = 'basan6'
where dno =90;

delete v_dept10 
where dno =90 commit;

--읽기만 가능한 뷰를 생성: (insert m update ,delete 못하도록 설정)
create view v_readonly
as 
select dno,dname, loc 
from dept_copy60 with read only;

select * from v_readonly;

insert into v_readonly   --오류
values(88,'HR7','busan');

update v_readonly --오류
set dname= 'HR77',loc = 'busan77'
where dno = 88;

delete v_readonly --오류
where dno= 88;



