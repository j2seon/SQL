--7���� - ��������

--���̺� ���� : ���̺��� ��ü�� ������.
    --���̺��� �����ϸ� , �÷��� ���ڵ常 ���簡 ��.
    --���̺��� �Ҵ�� ���������� ������� �ʴ´�.(Alter Table�� ����ؼ� �Ҵ��ؾ��Ѵ�.)
    --���� ���� : �÷��� �Ҵ�Ǿ��ִ�.���Ἲ�� üũ 
            --NOT NULL, Primary Key, Unique, Foreign key, check, default
            
--���̺��� ��ü ���ڵ带 ����             
create table dept_copy
as 
select * from department;

desc department;
desc dept_copy;

select *
from dept_copy;

create table emp_copy
as 
select * from employee;

select * from emp_copy;

--���̺� ���� : Ư�� �÷��� �����ϱ� 
create table emp_second 
as 
select eno, ename, salary , dno from employee;

select * from emp_second;

--���̺� ���� : ������ ����ؼ� ���̺� ����. 

create table emp_third 
as 
select eno, ename, salary 
from employee 
where salary > 2000;

select * from emp_third;

--���̺� ���� : �÷����� �ٲپ ����
create table emp_forth 
as 
select eno �����ȣ, ename �����, salary ����
from employee;

select �����ȣ, �����, ���� from emp_forth; --���̺��, �÷���<<==������� ����. 

--���̺� ���� : ������ �̿��ؼ� ���̺� ���� : �ݵ�� ��Ī�̸��� ����ؾ��Ѵ�.
create table emp_fifth 
as
select eno, ename, salary * 12 from employee;

select * from emp_fifth;   -- �ȸ�������� : ������ ���ԵǾ� �ֱ⶧��

create table emp_fifth 
as
select eno, ename, salary * 12 as salary from employee;

--���̺� ������ ���� , ���ڵ�� �������� �ʴ´�.
create table emp_sixth
as
select * from employee 
where 0=1       -- false 

select * from emp_sixth;
desc emp_sixth;

--���̺� ����: Alter Table 
create table dept20 
as
select * from department;

desc dept20;
select * from dept20;

--������ ���̺��� �÷� �߰� ��. 
Alter Table dept20
add (birth date );

alter table dept20 
add (email varchar2(100));

alter table dept20 
add(address varchar2(200));

--�����÷��� �ڷ����� ���� :
desc dept20;
alter table dept20
modify dname varchar2(100);

alter table dept20
modify dno number(4);

alter table dept20 
modify address Nvarchar2(200);

--Ư���÷� ���� : ���ϰ� ���� �߻��Ǿ �߰��� �ַ� �۾��Ѵ�.
alter table dept20
drop column birth;

alter table dept20
drop column email;

--�÷��� �����ÿ� ���ϰ� ���� �߻��� ��.
    --set unused : Ư���÷��� ��� ����(������), �߰��� ����.
    --���߿� drop�� �ϱ� ���ؼ� ����.
alter table dept20 
set unused (address) ;

desc dept20;

alter table dept20
drop unused column;

/*�÷� �̸�����*/
alter table dept20
rename column LOC to LOCATIONS;

alter table dept20
rename column DNO to D_Number;

/*���̺� �̸� ����*/
rename dept20 to dept30;
desc dept30;

/*���̺� ����*/
drop table dept30;

/*
    DDL : Create (����), Alter (����), drop(����)
    DML: Insert (���ڵ� �߰�),Update (���ڵ� ����),Delete (���ڵ� ����)
        << ���̺��� �� (���ڵ�, �ο�)>>
*/
/*
    DQL : Select 
*/
/*
    ���̺��� �����̳� ���̺� ���� �� 
    1. delete  : ���̺��� ���ڵ带 ����, where�� ������� ���� �� ��� ���ڵ� ����.<����>
    2. truncate  : ���̺��� ���ڵ带 ���� , �ӵ��� ������ ������.<��������>
    3. drop      :���̺� ��ü�� ����
*/

create table emp30
as
select * from employee;

--emp10 : delete�� ����ؼ� ����
    delete emp10;
    commit;
    select *from emp10;
    desc emp10;
--emp20 :
    truncate table emp20;
    select * from emp20;

--emp30:drop�� ����ؼ� ����
    drop table emp30;
    select * from emp30; --�������� ����.
    drop table emp_copy;


/*
    ������ ���� : �ý����� ���� ������ ����� �ִ� ���̺� 
        user_    : �ڽ��� ������ ���� ��ü ������ ���
        all_     :�ڽ��� ������ ������ ��ü�� ������ �ο� ���� ��ü ������ ���
        dba_     : ������ ���̽� �����ڸ� ���� ������ ��ü ������ ���.
*/

show user; 
select * from user_tables;      --����ڰ� ������ ���̺� ����
select table_name from user_tables; -- 
select * from user_views;       --����ڰ� ������ ���� ����
select * from user_indexes;     --����ڰ� ������ �ε��� ����.
select * from user_constraints;  --�������� Ȯ�� 
select * from user_constraints
where table_name = 'EMPLOYEE';

select * from all_tables;  --������̺��� ��� , ������ �ο����� ���̺� ���
select * from all_views;

select * from dba_tables; -- ���� ���������� ������ �����ϴ�!!!


/*
    �������� 
    1.Primary Key

*/
--1.Primary Key : �ߺ��� ���� ���� �� ����.
    --a. ���̺� ������ �÷��� �ο�
    --���� ���� �̸� : �������� ���� ��� oracle���� ������ �̸����� ����.
        --���������� �����Ҷ� ���������̸��� ����ؼ� �����ϰԵȴ�.
        --PK_customer01_id : Primary Key , customer01,id
        --NN_customer01_pwd : Not Null, custrmer01(���̺��),pwd(�÷���)
        
    create table customer02(                                --���������̸�
        id varchar2(20) not null constraint PK_customer02_id Primary Key ,
        pwd varchar2(20) constraint NN_customer02_pwd not null,
        name varchar2(20) constraint NN_customer02_name not null,
        phone varchar2(30) null,
        address varchar2(100) null
        )
        
        select * from user_constraints
        where table_name=CUSTOMER01;

--���̺� �÷� ���� �� ���� ���� �Ҵ�. 
    create table customer03(                                
        id varchar2(20) not null,
        pwd varchar2(20) constraint NN_customer03_pwd not null,
        name varchar2(20) constraint NN_customer03_name not null,
        phone varchar2(30) null,
        address varchar2(100) null,
        constraint PK_customer03_id Primary Key(id) 
        )


/*
    Foreign Key (����Ű ): �ٸ� ���̺��� Primary Key Unique �÷��� �����ؼ� ���� �Ҵ�.
    
*/

--�θ����̺� 
Create table ParentTbl(
    name varchar(20),
    age number(3) constraint CK_ParentTbl_age check (AGE >0 and AGE<200),
    gender varchar(3) constraint CK_ParentTbl_gender check (gender In('M','W')),
    infono number constraint PK_ParentTbl_infono Primary Key
    )
    
    desc parentTbl
    select * from user_constraints
    where table_name ='PARENTTBL';
    
    select * from parentTbl;
    insert into ParentTbl
    values('ȫ�浿',30,'M',1);
    
    insert into ParentTbl
    values('��ʶ�',300,'K',1); --�����߻� : 300 (check ����), K(check ����), 1(Primary Key ����)
    
    insert into ParentTbl
    values('��ʶ�',50,'M',2);
    
--�ڽ����̺�

create table ChildTbl(
    id varchar2(40) constraint PK_ChildTbl_id Primary Key,
    pw varchar2(40),
    infono number,
    constraint Fk_ChildTbl_infono foreign key (infono) references ParentTbl(infono)
);
insert into ChildTbl
values('aaa','1234',1);

select * from ChildTbl;

insert into ChildTbl
values('bbb','1234',2);
commit;

--�θ����̺�
create table ParentTbl2(
    dno number(2) not null primary Key ,
    dname varchar2(50),
    loc varchar2(50)
);
insert into ParentTbl2
values(10,'SALES','SEOUL');


create table ChildTbl2(
    no number not null,
    ename varchar(50),
    dno number(2) not null,
    foreign key(dno) references ParentTbl2(dno)
);

insert into ChildTbl2
values(1,'park',10);

select * from ChildTbl2;

--default ���� ���� : ���� �Ҵ����� ������ default ���� �Ҵ�.
create Table emp_sample01(
    eno number(4) not null Primary key,
    ename varchar(50),
    salary number(7,2) default 1000
);

select * from emp_sample01;

--default �÷��� ���� �Ҵ��� ���. 
insert into emp_sample01
values(1111,'ȫ�浿'1500);

--default �÷��� ���� �Ҵ����� �ʴ� ���. default���� �Ҵ�� ���� ����ȴ�. 

insert into emp_sample01(eno, ename)
values(2222,'ȫ���');

insert into emp_sample01
values(3333,'������',default);


create Table emp_sample02(
    eno number(4) not null Primary key,
    ename varchar(50) default 'ȫȫȫ',
    salary number(7,2) default 1000
);
insert into emp_sample02(eno)
values(10);

insert into emp_sample02
values(3333,default,default);

select * from emp_sample02;

/*
    Primary Key, Foreign Key ,Unique , check, Dfault ,not null

*/

create table member10(
    no number not null constraint PK_member10_no Primary Key,
    name varchar(50) constraint NN_member10_name Not null,
    birthday date default sysdate,
    age number(3) check(age>0 and age <150),
    gender char(1) check (gender in ('M','W')),
    dno number(2) Unique
    );
insert into member10
values(1,'ȫ�浿', default, 30,'M',10);
    
insert into member10
values(2,'������', default, 30,'M',10); --����! 

insert into member10
values(2,'������', default, 30,'M',20);

    select * from member10;
    
create table orders10(
    no number not null Primary Key,
    p_no varchar(100) not null,
    p_name varchar(100) not null,
    price number check( price > 10)
    phone varchar(100) default '010-0000-0000',
    dno number(2) not null,
    foreign key (dno) references member10(dno)
);



