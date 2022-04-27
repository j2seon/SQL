/*
    �������� : ���̺��� ���Ἲ�� Ȯ���ϱ� ���ؼ� �÷��� �ο��ϴ� ��Ģ
        1. Primary Key
        2. Unique
        3. Not Null
        4. Check
        5. Foreign Key
        6. Default
*/

-- 1. Primary Key : �ߺ��� ���� ���� �� ����.
    -- (1) ���̺� ������ �÷��� �ο��ϴ� ���
        -- ���� ���� �̸� : �������� ���� ��� -> ����Ŭ���� ������ �̸����� ����,
            -- ���������� ������ �� �������� �̸��� ����ؼ� ����. 
            -- PK_customer01_id : Primary Key���� �����̰� customer01 ���̺��� id(�÷���)�����÷�
            -- NN_customer01_pwd : NOT Null ���������̰� customer01 ���̺� �ο��� pwd(�÷���)�����÷�
    create table customer01(
        id varchar2(20) not null constraint PK_customer01_id Primary Key , -- PK_customer01_id �������� �̸�
        pwd varchar2(20) CONSTRAINT NN_customer01_pwd not null ,
        name varchar2(20) constraint NN_customer01_name not null ,
        phone varchar2(30) null,
        address varchar2(100) null);
    
    select * from user_constraints
    where table_name = 'CUSTOMER01'; -- �빮�ڷ� ó��
    
    create table customer02(
        id varchar2(20) not null Primary Key , -- PK_customer01_id �������� �̸�
        pwd varchar2(20) not null ,
        name varchar2(20) not null ,
        phone varchar2(30) null,
        address varchar2(100) null);
        
    select * from user_constraints
    where table_name = 'CUSTOMER02'; -- �빮�ڷ� ó��
    
    -- ���̺��� �÷� ���� �� ���� ���� �Ҵ�
        create table customer03(
            id varchar2(20) not null , -- PK_customer01_id �������� �̸�
            pwd varchar2(20)  CONSTRAINT NN_customer03_pwd not null ,
            name varchar2(20)  CONSTRAINT NN_customer03_name not null,
            phone varchar2(30) null,
            address varchar2(100) null,
            constraint PK_customer03_id Primary Key(id));

-- Foreign Key (����Ű) : �ٸ� ���̺� (�θ�)�� Primary KEy, Unique �÷��� �����ؼ� ���� �Ҵ�.
-- Check : �÷��� ���� �Ҵ��� �� check �� �´� ���� �Ҵ�

    --  �θ� ���̺�
    create table ParentTbl(
    name varchar2(20),
    age number(3) constraint CK_ParentTbl_age check (AGE > 0 and AGE < 200), --check �������� �̸�
    gender varchar2(3) constraint CK_ParentTbl_gender check (gender In ('M','W')),
    infono number constraint PK_ParentTbl_infono Primary Key
    )
    
    desc ParentTbl;
    select * from user_constraints
    where table_name = 'PARENTTBL';
    
    -- �ڽ� ���̺�
    Create table ChildTbl(
        id varchar2(40) constraint PK_ChildTbl_id Primary Key not null,
        pw varchar2(40) ,
        infono number,
        constraint FK_ChildTbl_infono Foreign Key (infono) REFERENCES ParentTbl(infono) --infono�� foreign Ű�� �־���
        );
    
    -- �θ����̺� �� insert ��Ű��
    insert into ParentTbl
    values ('ȫ�浿' , 30, 'M', 1);
    
     insert into ParentTbl
    values ('������' , 300, 'K', 1); -- ���� : 300 �� K �� check���� ���� ����, 1�� �ߺ��Ͽ� �־����Ƿ� Primary Key ����
    
    insert into ParentTbl
    values ('������' , 25, 'W', 2);
    
    select * from parenttbl;
    
    -- �ڽ� ���̺� �� insert
    insert into ChildTbl
    values ('aaa' , '1234', 3);  -- ���� : ChildTbl�� infono�� ParentTbl�� infono�� �����ؼ� ����� ��, ParentTbl�� infono�� 3�� �����Ƿ� ����
    
    insert into ChildTbl
    values ('aaa' , '1234', 1);
    
    insert into ChildTbl
    values ('bbb' , '1234', 2);
    
    select * from ChildTbl;
    commit;

---------------------------------------------------------------------
    -- �θ� ���̺�
    create table ParentTbl2(
        dno number(2) not null Primary KEy,
        dname varchar2(50),
        loc varchar2(50)
        );
        
    insert into parenttbl2 
    values (10, 'SALES' , 'SEOUL');
    commit;
    
    -- �ڽ� ���̺�
    create table ChildTbl2(
        no number not null,
        ename varchar2(50),
        dno number(2) not null,
        foreign key (dno) references ParentTbl2(dno)
        );
        
    insert into ChildTbl2
    values (1, 'PARK', 10);
    
    select * from ChildTbl2;
    commit;
 
 -- default ���� ���� : ���� �Ҵ����� ������  default���� �Ҵ�
 Create Table emp_sample01(
    eno number(4) Primary Key not null,
    ename varchar(50),
    salary number(7,2) default 1000);

    -- default �÷��� ���� �Ҵ��� ���
    insert into emp_sample01
    values ( 1111, 'ȫ�浿', 1500);
    
    -- default �÷��� ���� �Ҵ����� �ʴ� ��� -> default�� �Ҵ�� ���� ����
    insert into emp_sample01 (eno, ename)
    values ( 2222, '������');
    
    insert into emp_sample01 (eno, ename)
    values ( 3333, '������');
    
    select * from emp_sample01;
    commit;
    
    Create Table emp_sample02(
    eno number(4) Primary Key not null,
    ename varchar(50) default 'ȫȫȫ',
    salary number(7,2) default 1000);
    
    -- default �÷��� ���� �Ҵ����� �ʴ� ��� -> default�� �Ҵ�� ���� ����
    insert into emp_sample02(eno)
    values(10);
    
    insert into emp_sample02(eno)
    values(20);
    
     select * from emp_sample02;
     commit;
     
-- Primary Key , Foreign Key, Unique, Check, Default, Not null
    
    Create table member10(
        no number not null constraint PK_memember10_no Primary Key,
        name varchar2(50) constraint NN_member10_name Not null,
        birthday date default sysdate,
        age number(3) check (age > 0 and age < 150),
        gender char(1) check (gender in ('M' , 'W')),
        dno number(2) Unique
    );
    
    insert into member10
    values (1, '������', default, 25, 'W', 10);
    
    insert into member10
    values (2, '������', default, 25, 'W', 20);
    
    select * from member10;
    
    Create table order10(
        no number not null Primary Key,
        p_no varchar2(100) not null,
        price number check (price > 10),
        phone varchar2(100) default '010-0000-0000',
        dno number(2) not null,
        foreign key (dno) references member10(dno)
        );
    
    insert into order10  
    values (1, '������', 5000,default, 10);
    commit;
    
    drop table member;