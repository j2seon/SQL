-- 8���� - ��, ������, �ε���
/*
    �� (view) : ������ ���̺�
        -- ���̺��� ������ ���� ������ �ִ�.
        - ��� ������ ���� ������ �ʴ´�. ���� �ڵ常 �� �ִ�. 
        -- �並 ����ϴ� ���� : 
            (1) ����: ���� ���̺��� Ư�� �÷��� �����ͼ� ���� ���̺��� �߿� �÷��� ���� �� �ִ�.
            (2) ������ ������ �並 �����ؼ� ���ϰ� ����� �� �ִ�. (������ JOIN ����)
        -- ��� �Ϲ������� select ������ �´�.
        -- ��� insert, update, delete ������ �� �� ����.
        -- �信 ���� insert �ϸ� �������̺� ����ȴ�. ���� ���̺��� ���������� �� �����ϸ� �ȴ�.
        -- �信 ���� insert �� ��� ���� ���̺��� �������ǿ� ���� insert �� ���� �ְ� �׷����������� �ִ�.
        -- �׷��Լ��� ������ view���� insert �A �̾���.
*/
    Create table dept_copy60
    as
    select * from department;
    
    create table emp_copy60
    as
    select * from employee;
    
-- �� ����
    create view v_emp_job
    as 
    select eno, ename, dno, job
    from emp_copy60
    where job like 'SALESMAN';
    
-- �� ���� Ȯ��
    select * from user_views;
    
--������ ���� ������ �信 �����ϱ�

create view v_join1
as
select e.dno,ename,job, dname,loc
from employee e , department d
where e.dno=d.dno
and job = 'SALESMAN';

select * from v_join1;

--�並 ����ؼ� ���� ���̺��� �߿��� ���� ����� (����)
select * from emp_copy60;

create view simple_emp
as
select ename,job,dno
from emp_copy60;

select * from simple_emp; --view�� ����ؼ� ���� ���̺��� �߿��÷��� ���� �� �ִ�.

select * from user_views;

--�並 ������ �� �ݵ�� ��Ī�̸��� ����ؾ��ϴ� �ϴ� ��� ,group by �Ҷ�

create view v_groupping 
as
select dno, count(*) groupCount, Avg(salary) avg ,sum(salary) sum
from emp_copy60
group by dno; 

select *from v_groupping;

--�並 ������ �� as ������ select ���� �;��Ѵ�. insert, update,delete���� �� �� ����.
create view v_error  --����!
as 
insert into dno 
values(60,'hr','busan')

--view�� ���� insert �� �� ������? �÷��� ���������� �����ϸ� view���� ���� ���� �� �ִ�.
    --�������̺� ���� insert �ȴ�.
    
create view v_dept
as
select dno,dname
from dept_copy60;

select * from v_dept;

insert into v_dept --view�� ���� insert, ���� ������ ��ġ�Ҷ� �� insert�� �ȴ�.
values (70,'HR');

select * from dept_copy60;

create or replace view v_dept  --v_dept�� �������� ���� ��� create , ������ ��� : replace (����)
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

insert into v_dept; --view�� ���� insert, ���� ������ ��ġ�Ҷ� �� insert�� �ȴ�.

select * from user_views;

select * from v_groupping; --�׷��ε� view���� insert �� �� ����.

create or repalce 


drop view v_groupping
drop view v_groupping;

--insert, update, delete�� ������ ��
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

--�б⸸ ������ �並 ����: (insert m update ,delete ���ϵ��� ����)
create view v_readonly
as 
select dno,dname, loc 
from dept_copy60 with read only;

select * from v_readonly;

insert into v_readonly   --����
values(88,'HR7','busan');

update v_readonly --����
set dname= 'HR77',loc = 'busan77'
where dno = 88;

delete v_readonly --����
where dno= 88;



