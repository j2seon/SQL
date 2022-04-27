-- ���� ���� ���� (Alter Table : ������ ���̺� ���� ������ ����)

create table emp_copy50
as
select * from employee;

create table dept_copy50
as
select * from department;

select * from user_constraints
where table_name in ('EMP_COPY50' , 'DEPT_COPY50');

select * from user_constraints
where table_name in ('EMPLOYEE' , 'DEPARTMENT');


-- ���̺��� �����ϸ� ���ڵ常 ���簡 �ȴ�. ���̺��� ���� ������ ����Ǿ� ���� �ʴ´�. Alter table�� ����ؼ� ���������� ��������� ��
select * from emp_copy50;
select * from dept_copy50;

alter table emp_copy50
add constraint PK_emp_copy50_eno PRIMARY key (eno);

alter table dept_copy50
add constraint PK_dept_copy50_ PRIMARY key (dno);

--Foreign Key 
alter table emp_copy50 
add constraint FK_emp_copy50_dno_dept_copy50 FOREIGN key (dno) references dept_copy50(dno);


--NOT NULL �������� �߰�. (������ �ٸ��� , add ��ſ� modify�� ���)
desc employee;
desc emp_copy50; --notnull�� ���� �ʾ����� ,primary Key ���������� �Ҵ�.

desc department;
desc dept_copy50;   --primary Key �������� not null 

    -- ������ null�� ���ִ� ������ NOT NULL �÷����� ������ �� ����.-->null�� ���� ��������� �����ϴ�.

select ename from emp_copy50
where ename is null;

alter table emp_copy50
MODIFY ename CONSTRAINT NN_emp_copy50_ename not null ;

--commion �÷��� not null �Ҵ��ϱ�
select *from emp_copy50;

alter table emp_copy50 
MODIFY commission CONSTRAINT NN_emp_copy50_commission not null;

update emp_copy50
set commission=0
where commission is null;

--Unique �������� �߰� : �÷��� �ߺ��� ���� ������ �Ҵ����� ���Ѵ�.

select ename , count (*)
from emp_copy50
group by ename
having count(*)>2;

alter table emp_copy50
add CONSTRAINT UK_emp_copy50_ename unique (ename);


--check �������� �߰�

select * from emp_copy50;

alter table emp_copy50 
add CONSTRAINT CK_emp_copy50_salary check (salary >0 and salary<10000);

--default �������� �߰� <==���������� �ƴ�: ���������̸��� �Ҵ��� �� ����.
    --���� ���� ���� ��� default�� ������ ���� ����.
alter table emp_copy50 
modify salary default 1000; 

alter table emp_copy50 
modify hiredate default sysdate;

desc emp_copy50;

insert into emp_copy50 (eno,ename,commission)
values(9999,'Juli',100);

insert into emp_copy50
values(8888,'julia',null,null,default,default,1500,null);

/*�������� ���� :alter table ���̺�� drop*/

--Primary key ���� 
alter table emp_copy50   -- ���� ���� ���ŵ�.
drop primary key cascade;


alter table dept_copy50   --�����߻� : foreign key�� �����ϱ� ������ �����ȵ�.
drop primary key;

select * from user_constraints
where table_name in('EMP_COPY50','DEPR_COPY50');


--not null �÷������ϱ� : 
alter table emp_copy50
drop CONSTRAINT NN_EMP_COPY50_ENAME;

--uNIque chck �������� ����
alter table emp_copy50;
alter table dept_copy50)  --foreign key�� ���� �����ϰ� primary key ����
drop primary key;

alter table emp_copy50;
drop CONSTRAINT NN_EMP_COPY50_saatl;

alter table emp_copy50;
drop CONSTRAINT NN_EMP_COPY50_COMMISSION;

--default �� null��� �÷��� default null�� ���� :  default ���� ������ �����ϴ� ��.
alter table emp_copy50
modify hiredate default null ;

/*�������� disable /enable
    -- ���������� ��� �߽�
    --�뷮 ���� ���� ���̺� �߰��� �� ���ϰ� ���� �ɸ���. disable ==>enable
    -index�� ������ ���ϰ� ���� �ɸ���. 
    */
    
alter table dept_copy50 
add constraint PK_DEPT_COPY50_DNO PRIMARY KEy(DNO);

ALTER TABLE emp_copy50
add constraint pk_emp_copy50_emo PRIMARY KEy(eno)l;

select * from user_constraints 
where table_name in ('EMP_copy50','DEPT_COPY50');

select * from emp_copy50;
select * from dept_copy50;

alter table emp_copy50;
disable constraint FK
_emp_copy50_dno ;

insert into (eno,ename, dno)
values(8989,'aaaa',50)

insert into dept_copy50
vlaues(50,'hr' ����);

alter table emp_copy50;
enable constraint FK_emp_copy50_dno;


