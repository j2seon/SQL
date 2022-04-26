--7일차 연습문제

--다음표에 명시된 대로 dept테이블을 생성하시오

create table DEPT(
    DNO number(2) not null,
    DNAME varchar2(14) null,
    LOC varchar2(13) null
)
--emp
create table EMP(
    ENO number(4) not null,
    ENAME varchar2(10) null,
    DNO number(2) null
)
--3.수정
alter table EMP
modify ENAME varchar2(25);

desc EMP;

--4.

create table EMPLOYEE2
as 
select eno EMP_ID, ename NAME, salary SAL, dno DEPT_ID from employee;
desc EMPLOYEE2; select * from EMPLOYEE2;

--5.
Drop table emp;

--6.
rename EMPLOYEE2 to EMP;

--7. 
alter table DEPT
drop column DNAME;
select * from DEPT;

--8.
alter table DEPT 
set unused (LOC) ;

--9.
alter table DEPT
drop unused column;

-----------------------------------------------------------

--1.
create table emp_insert
as
select * from EMP 
where 0=1      

alter table emp_insert
add (hiredate date );

select * from emp_insert;

--2.
desc emp_insert;
insert into emp_insert(EMP_ID,NAME,SAL,DEPT_ID,HIREDATE)
values(1,'주진선',3000,1,sysdate);
commit;
--3    
insert into emp_insert(EMP_ID,NAME,SAL,DEPT_ID,HIREDATE)
values(2,'주진기',3000,2,to_date('220425','yymmdd'));
commit;
--4.

create table emp_copy
as 
select * from employee;

--5
select * from emp_copy;
update emp_copy
set dno=10
where eno=7788;
commit;
    
--6.
update emp_copy
set job='SALESMAN', salary='1600'
where eno=7788;

--7.
update emp_copy
set dno=20
where job='CLERK';
commit;

--8.
create table dept_copy
as 
select * from department;

--9
select * from dept_copy;
delete dept_copy
where dname ='RESEARCH';
commit;

--10.
delete dept_copy
where dno =10 or dno= 40;
commit;




    




