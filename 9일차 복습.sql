---����

--�������ڰ� ������ ���̺��� �� �� �ִ�.
select * from user_tables;  --������ ����: �ý����� ���� ������ ������ִ� ��,���ڵ尪�� ������ �빮�ڷ� ����

select * from user_tables
where table_name = 'DEPT';

drop table dept; --Ŀ���� ���� �ʾƵ� �ȴ�. insert update delete�� ���

create table dept (
    dno number(2) not null,
    dname varchar2(14) not null,
    loc varchar2(13) null
);

drop table emp; --Ŀ���� ���� �ʾƵ� �ȴ�. insert update delete�� ���

create table emp(
    eno number(4) not null,
    ename varchar2(10) null, 
    dno number(2)
);
--DB������ ���� , null��� ���ΰ� �ٸ��� ���õǾ� ���� �� �ִ�.

--���̺��� ũ�� ����!
desc emp;

alter table emp
modify ename varchar2(25);

--���� ����!
select length (ename) from employee
where length (ename)>5;

--���ϴ� �κи� �����ͼ� ���̺� ����� !! ���̺� ���� �ÿ� ���������� ������� �ʴ´� .
create table employee2
as
select eno,ename, salary,dno from employee;
select * from employee2;

--��������
    --primary key : �� ���̺� �ϳ��� �����Ѵ�. (not null)
    --Unique :primary key�� ��������� ������ �����ϴ�. 
    --check
    --default
    --foreign

--���̺� �̸� ����
rename employee2 to emp;
desc emp;

--���̺� ���� �÷������ϱ�
select * from dept;

alter table dept 
drop column dname;


-- unused �ϱ� 
    -- drop�ؼ� ������ �� ��� ���� ��ϴ� �ý��ۿ����� ���ڵ尡 ��û���� . 
    -- �ٷλ����ÿ� ���ϰ� �ɸ� �� �ֱ� ������ unused�� �ϰ� ���Ŀ� �����Ѵ�.
    
alter table dept
set unused(loc);

select * from dept;

-- unused �� �÷� ����
alter table dept
drop unused column;


--������ �����ؼ� ���̺� �����
select * from emp;

create table emp_insert
as
select * from emp
where 0=1; --������ false�� �����ϸ� ���ڵ带 ��������� �ʴ´�!!

select * from emp_insert;

-- �÷� �߰� : �÷� �߰��� null������� �߰��ؾ��Ѵ�.
alter table emp_insert
add hiredate date;

desc emp_insert;

--�ο� �߰� 
select * from emp_insert;

insert into emp_insert(eno,ENAME,SALARY,DNO,HIREDATE)
values(1000,'�̸�',3000.35,10,sysdate);
commit;

insert into emp_insert(eno,ENAME,SALARY,DNO,HIREDATE)
values(1001,'���',3000.35,10,to_date(sysdate-1,'yy/mm/dd'));
commit;


--����+���� ����
create table emp_copy
as
select *from employee;


--�����ȣ 7788�� �μ���ȣ 10���� �ٲٱ� // 7499 �ٲ��ֱ�
select *from emp_copy;

update emp_copy
set dno=10
where eno = 7788; --���� : update �� delete �� �ݵ�� where ������ ����Ѵ�
commit;

select *from emp_copy
where eno=7788 or eno=7499;

update emp_copy
set job=(select job from emp_copy where eno=7788),
salary=(select salary from emp_copy where eno=7788 )
where eno=7499;
commit;
 
--7369�� ������ ����� �μ���ȣ��  7369 �μ���ȣ�� �ٲٱ�
select *from emp_copy
where eno=7369;

select * from emp_copy
where job='CLERK';

update emp_copy
set dno = (select dno from emp_copy where eno=7369)
where job= (select job from emp_copy where eno=7369);
commit;


--���̺� ����� 
create table dept_copy
as
select * from department;

-- �μ��� RESEARCH ����
delete dept_copy
where dname ='RESEARCH';

select * from dept_copy;
commit;

-- �μ���ȣ�� 10,40�� ����
delete dept_copy
where dno in (10,40);
commit;



--���̺��� ���Ἲ !!!!
drop table dept_sample;

-- ���̺� �����Ҷ� ���������� ������� �ʴ´�.
--1. employee ���̺��� ������ �����Ͽ� emp_sample �� �̸��� ���̺��� ����ÿ�. 
--��� ���̺��� �����ȣ �÷��� ���̺� ������ primary key ���������� �����ϵ� �������� �̸��� my_emp_pk�� �����Ͻÿ�. 
create table emp_sample
as
select * from employee
where 0=1;

select *from emp_sample;

alter table emp_sample
add constraint PK_emp_sample_eno Primary Key (eno);

select * from user_constraints
where table_name='EMP_SAMPLE'; --�빮�ڷ� ó���ؾ���.


--2. department ���̺��� ������ �����Ͽ� dept_sample �� �̸��� ���̺��� ����ÿ�. 
--�μ� ���̺��� �μ���ȣ �÷��� ������ primary key ���� ������ �����ϵ� ���� �����̸��� my_dept_pk�� �����Ͻÿ�. 
create table dept_sample
as
select * from department
where 0=1;

alter table dept_sample
add constraint PK_dept_sample_dno Primary Key (dno);

select * from user_constraints
where table_name='DEPT_SAMPLE';


--3. ��� ���̺��� �μ���ȣ �÷��� �������� �ʴ� �μ��� ����� �������� �ʵ��� �ܷ�Ű ���������� �����ϵ�
--���� �����̸��� my_emp_dept_fk �� �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
select * from emp_sample ; 
select * from dept_sample ; 

alter table emp_sample
add constraint FK_emp_sample_dno_dept_sample Foreign key (dno) references dept_sample (dno);

select * from user_constraints
where table_name in('EMP_SAMPLE','DEPT_SAMPLE');

--4. ������̺��� Ŀ�Լ� �÷��� 0���� ū ������ �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [
--���� : �� ������ ���̺��� ����Ͻÿ�]
alter table emp_sample
add constraint CK_emp_sample_commission check(commission>=0); --0���� �������� ���� �ȵȴ�.


--5. ������̺��� ���� �÷��� �⺻ ������ 1000 �� �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. 
--[���� : �� ������ ���̺��� ����Ͻÿ�]
--default �� not null�� modify�� �̿��Ѵ�!!!!
alter table emp_sample 
modify salary default 1000;

--6. ������̺��� �̸� �÷��� �ߺ����� �ʵ���  ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
--primary�� �̹� �־ ���� ����.
select * from user_constraints
where table_name in('EMP_SAMPLE','DEPT_SAMPLE');

alter table emp_sample 
add constraint UK_emp_sample_ename Unique (ename);

--7. ������̺��� Ŀ�Լ� �÷��� null �� �Է��� �� ������ ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
--���������̸��� �ȳ־ �̸��� �ڵ��� �ο��Ǿ���!
alter table emp_sample
modify commission NOT NULL;

--8. ���� ������ ��� ���� ������ ���� �Ͻÿ�. 
select * from user_constraints
where table_name in('EMP_SAMPLE','DEPT_SAMPLE');

--���������� ���Ž� : foreign key�� �����ϸ� ���Ű� �ȵȴ�.
    --1.foreign key�� ���� ������ primary key ����
    --2.primary key�� ������ �� cascade �ɼ��� ��� : �ѹ��� �۾��ϸ� �ȴ�!!

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

--�� ���� 
--��� ������ ���̺� select ���� �´�!!
    --������ ���ؼ� �������̺��� �÷��� ���� �� �ִ�.
    --���Ǽ��� ���ؼ� : ������ ������ view �� �����ϸ�!
--1. 20�� �μ��� �Ҽӵ� ����� �����ȣ�� �̸��� �μ���ȣ�� ����ϴ� select ���� �ϳ��� view �� ���� �Ͻÿ�.
--	���� �̸� : v_em_dno  
    

create table emp_view --������ ���̺�� ���� ����! 
as
select * from employee;
create table dept_view
as
select * from department;

--�� ����
create view v_em_dno
as 
select eno,ename,dno
from emp_view
where dno=20;

--�� ����
select * from v_em_dno; --���̺� ��µǵ� ��µȴ�.

--2. �̹� ������ ��( v_em_dno ) �� ���ؼ� �޿� ���� ��� �� �� �ֵ��� �����Ͻÿ�. 
create or replace view v_em_dno
as
select eno, ename, dno, salary
from emp_view
where dno=20;
 
--3. ������  �並 ���� �Ͻÿ�. 
drop view v_em_dno;

--4. �� �μ��� �޿���  �ּҰ�, �ִ밪, ���, ������ ���ϴ� �並 ���� �Ͻÿ�. 
--	���̸� : v_sal_emp
create or replace view v_sal_emp
as 
select min(salary) �ּҰ� , max(salary) �ִ밪, avg(salary) ���, sum(salary) ����
from emp_view
group by dno;

select * from v_sal_emp;

-- 5. �̹� ������ ��( v_em_dno ) �� ���ؼ� �б� ��������!

create or replace view v_sal_emp
as 
select min(salary) �ּҰ� , max(salary) �ִ밪, avg(salary) ���, sum(salary) ����
from emp_view
group by dno with read only;

select * from v_sal_emp;








