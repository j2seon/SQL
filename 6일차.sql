-- 6���� CRUD(Crate, Read, Update, Delete)

-- Object (��ü) : DataBase�� ����(XE, <= Express Edtion(�������), 
--                                      Standard Edtion (����), EnterPrise Edtion (����) )
        -- 1. ���̺� , 2. ��, 3. �������ν���, 4. Ʈ����, 5. �ε���, 6. �Լ�, 7. ������  <- DDL(Crete, Alter, Drop)
-- ���̺� ����(Create)
/*
    Create Table ���̺��(
    
        �÷��� �ڷ��� Null��뿩�� [��������],
        �÷��� �ڷ��� Null��뿩�� [��������],
        �÷��� �ڷ��� Null��뿩�� [��������]
    );
*/
Create Table dept(
    dno number (2) not null, -- ���� 2�ڸ��� �� �� �ִ�. �ݵ�� �� �־�� ��
    dname varchar2(14) not null,
    loc varchar2(13) null);
    
select * from dept;

-- DML : ���̺��� ���� �ְ�(insert) ����(update), ����(delete)�ϴ� ����
    -- Ʈ������� �߻� ��Ŵ : log�� ����� �����ϰ� Database�� �����Ѵ�.
    
    begin transaction ;  --Ʈ������ ����( insert, update, delete ������ ���۵Ǹ� �ڵ����� ����)
    rollback;           -- Ʈ������� �ѹ�(RAM�� ����� Ʈ�� ����� ����_
    commit ;            -- Ʈ�� ����� ����( ���� DB�� ������ ����)
/*
    Insert into ���̺�� (�÷Ÿ�1, �÷���2, �÷���3)
    values (��1, ��2, ��3)
*/

    -- insert , update, delete ������ �ڵ����� Ʈ������� ����(begin transacion) - RAM���� ����Ǿ� �ִ� ����
    insert into dept (dno, dname, loc)  -- Insert�ϴ� ���� begin transartion ����
    values (10, 'MANAGER' , 'SEOUL');
    
    select * from dept;
    insert into dept
    values(20,'ACCOUNTING', 'PUSAN');
    commit;
    
    desc dept;
    /*null ��� �÷��� ���� ���� �ʱ� */
    insert into dept(dno,dname)
    values(30,'RESEARCH'); 
    
    /*������ ������ ���� �ʴ� �� ������ �����߻� */
    insert into dept(dno,dname,loc)
    values(20,'SALES','DEAGU');     --�����߻�, number(2)
    
    insert into dept(loc,dname,dno)
    values('DEAJEON','SALES',20); -- ����
    
    insert into dept(loc,dname,dno)
    values('DEAJEON','SALsssssssssssss',20);  --�����߻� dname varchar2(14)
    
--�ڷ���(�����ڷ���)
    -- char(10) : ����ũ�� 10����Ʈ, 3����Ʈ�� ���� ��� ����� 7����Ʈ ����, ������ ����(��), �ϵ��������(��)
        --�ڸ����� �˼� �ִ� ���� ũ�� �÷�(�ֹι�ȣ ��ȭ��ȣ)
    -- varchar2(10) : ����ũ�� 10����Ʈ, 3����Ʈ�� ���� ��� 3����Ʈ�� �����Ҵ�, ������ ���� �ϵ�������� ����  
            --�ڸ����� ����ũ���ΰ�� (�ּ�,�����ּ�)
    --Nchar(10) : �����ڵ� 10�� (�ѱ�, �߱���, �Ϻ���...) 
    --Nvarchar2 (10) : �����ڵ� 10�� (�ѱ�, �߱���, �Ϻ���...) 
    
--�ڷ���(������ �ڷ���)
    --NUMBER(2) : ���� 2�ڸ��� �Է°���
    --NUMBER(7,3): ��ü7�ڸ�, �Ҽ��� 3�ڸ����� ������ ��.
    --NUMBER(8,5):���� 8�ڸ�, �Ҽ� 5�ڸ�
    
    create table test1_tb1(
    a number(3,2) not null,
    b number(7,5) not null,
    c char(6) null,
    d varchar2(10) null,
    e Nchar(6) null,
    f Nvarchar2(10) null
    );
    
    insert into test1_tb1(a,b,c,d,e,f)
    values(3.22,77.555,'aaaaaa','bbbbbbbbbb','�ѱۿ����ڸ�','�ѱۿ��ڱ���');

insert into test1_tb1(a,b,c,d,e,f)
    values(3.22,77.555,'�ѱ�','bbbbbbbbbb','�ѱۿ����ڸ�','�ѱۿ��ڱ���');
    
    --����Ŭ �ѱ� 1�ڴ� 3byte�� �����Ѵ�.

select * from test1_tb1
    
    drop table test1_tb1; --����
    
    
    
    desc test1_tb1;
    select * from test1_tb1;
    insert into test1_tb1 (a,b,c,d,e,f)
    values(3.2,5.55,'aaaa','bbbbb','�ѱۿ�','�ѱۿ���');
    
        create table test2_tb1(
        a  NUMBER(3,2) not null)
        
        insert into test2_tb1( a )
        values(3.22);
        
create table member1(
    no number(10) not null,
    id varchar2(50) not null,
    passwd varchar2(50) not null,
    name Nvarchar2(6) not null,
    phone varchar2(50) null,
    address varchar2(100) null,
    mdate date not null,
    email varchar2(50) null
    );
    
    select *from member1;
    desc member1;
    drop table member1;
    
    insert into member1(no,id,passwd,name,phone,address,mdate,email)
    values(1,'aaaa','password','ȫ�浿','010-1111-1111','���� �߱� ���굿',sysdate,'aaa@aaa.com');
    
     insert into member1
    values(3,'bbbb','password','�̼���','010-2222-2222','���� �߱� ���굿',sysdate,'bbb@bbb.com');
    
    insert into member1(no,id,passwd,name,phone,address,mdate,email)
    values(3,'cccc','password','������',null,null,sysdate,null);
    
    --null ��� �÷��� ���� ���� ���� ��� null���� ����.
    
    insert into member1(no,id,passwd,name,mdate)
    values(4,'dddd','password','�������',sysdate);
    
    
    select *from member1;
    commit;    
    desc member1;
    
--������ ����(update : ������ ���� �� commit; 
        --�ݵ�� where ������ ����ؾ��Ѵ�. �׷��� ������ ��� ���ڵ尡 ������.
        
/*
    update ���̺��
    set �÷��� = ������ ��
    where �÷��� = ��
*/
    update member1
    set no=2
    where name='�̼���';
    commit;
    
    update member1
    set name='�Ż��Ӵ�'
    where no=2;
    commit;
    
    update member1
    set name='������'
    where no=1;
    commit;
    
    update member1
    set email='abcd@abcd.com'
    where no=1;
    commit;
    select *from member1;
    
    update member1
    set mdate='22/01/01'
    where no=4;
    
    
--�ϳ��� ���ڵ忡�� �����÷� ���ÿ� �����ϱ�
update member1
set name = '������', email='bbb@kkk.com',phone='010-7777-7777'
where no=1

commit;

update member1
set mdate = to_date('2022-01-01','yyyy-mm-dd')
where no=3;    

--���ڵ� (�ο�) ����(delete : �ݵ�� where������ ����ؾ���.)
/*
    delete ���̺��
    where �÷��� = �� 
*/
    select *from member1;
    delete member1
    where no =3;
    commit;

delete member1      --��� ���ڵ尡 ������.
rollback;

/*
    update, delete�� �ݵ�� where ������ ����ؾ��Ѵ�. Ʈ������� ���� (rollback, commit)
    update�� delete�� where ���� ���Ǵ� �÷��� ������ �÷��̾���Ѵ�. (Primary key, Unique �÷��� ����ؾ��Ѵ�.)
    �׷��� ������ ���� �÷��� ������Ʈ�ǰų� ���� �� �� �ִ�.
*/
    update member1
    set name ='��ʶ�'
    where no = 4;

/*
    �������� : �÷��� ���Ἲ�� Ȯ���ϱ� ���ؼ� ���, ���Ἲ : ���� ���� ������(��, ���ϴ� �����͸� ����.)
             -- Primary key
             -- �ϳ��� ���̺� �ѹ��� ���, �ߺ��� �����͸� ���� ���ϵ��� ����.
             -- null ���� �Ҵ� �� �� ����. 
*/

create table member2(
    no number(10) not null Primary key,
    id varchar2(50) not null,
    passwd varchar2(50) not null,
    name Nvarchar2(6) not null,
    phone varchar2(50) null,
    address varchar2(100) null,
    mdate date not null,
    email varchar2(50) null
    );
     insert into member2(no,id,passwd,name,phone,address,mdate,email)
    values(1,'aaaa','password','ȫ�浿','010-1111-1111','���� �߱� ���굿',sysdate,'aaa@aaa.com');
    
     insert into member2
    values(2,'bbbb','password','�̼���','010-2222-2222','���� �߱� ���굿',sysdate,'bbb@bbb.com');
    
    insert into member2(no,id,passwd,name,phone,address,mdate,email)
    values(3,'cccc','password','������',null,null,sysdate,null);
    
    insert into member2(no,id,passwd,name,phone,address,mdate,email)
    values(4,'dddd','password','�������',null,null,sysdate,null);

    select * from member2;
    commit;

    update member2
    set name='������'
    where no=5;       --  <==���̺��� �ߺ����� �ʴ� ������ �÷��� �������� ����ؾ��Ѵ�.
    
    /*
        ���� ����
            --UNIQUE : �ߺ����� �ʴ� ������ ���� ����. �ϳ��� ���̺��� ���� �÷��� ������ �� �ִ�.
                    --null�� �����, null�� �ѹ��� ���� �� �ִ�. 
    */
    
    
    create table member3(
    no number(10) Primary key, -- not null �����ϸ� �ڵ����� �ο��ȴ�.
    id varchar2(50) not null UNIQUE, --�ߺ��� ���� ���� �� ����.
    passwd varchar2(50) not null,
    name Nvarchar2(6) not null,
    phone varchar2(50) null,
    address varchar2(100) null,
    mdate date not null,
    email varchar2(50) null
    );
    
        select * from member3;

     insert into member3(no,id,passwd,name,phone,address,mdate,email)
    values(1,'aaaa','password','ȫ�浿','010-1111-1111','���� �߱� ���굿',sysdate,'aaa@aaa.com');
    
     insert into member3
    values(2,'bbbb','password','�̼���','010-2222-2222','���� �߱� ���굿',sysdate,'bbb@bbb.com');
    
    insert into member3(no,id,passwd,name,phone,address,mdate,email)
    values(3,'cccc','password','������',null,null,sysdate,null);
    
    insert into member3(no,id,passwd,name,phone,address,mdate,email)
    values(5,'dddd','password','�������',null,null,sysdate,null);
    
