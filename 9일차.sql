-- 9���� ������ ,�ε���

/*
������ : �ڵ���ȣ �߻���!!!!!!!
    -- ��ȣ�� �߻��� �Ǹ� �ڷ� �ǵ��ư��� ����. >> ������ �ٽ� �����ؾ��Ѵ�.
    -- primary Key�� ��ȣ�� �ڵ����� �߻���Ű�� ���ؼ� ����Ѵ�.
    --  primary Key�� Ű �÷����� �ߺ����� �ʴ� ������ ���� �Ű澲�� �ʾƵ��ȴ�!!
*/

--�ʱ� �� : 10 �������� 10  : 10�� �����ϴ� ������!
create SEQUENCE sample_sequence    
INCREMENT by 10             --������   
start with 10;              --�ʱⰪ

--�������� ������ ����ϴ� ������ ����
select * from user_sequences ;

select sample_sequence.nextval from dual ; -- �������� �������� ����Ѵ�.
select sample_sequence.currval from dual; --�������� ���� ��!

--�ʱⰪ 2 ������ 2

create SEQUENCE sample_sequence2
INCREMENT by 2
start with 2 
nocache; --ĳ���� ������� �ʰڴ�  > cache�� ������ ���ϸ� �ٿ� �� �� �ִ�. 

select * from user_sequences;

select sample_sequence2.nextval from dual;
select sample_sequence2.currval from dual;

--�������� primary Key �����ϱ�
create table dept_copy80
as
select * from department
where 0=1;

select * from dept_copy80;
    --dno�� �ѹ����� �ϰڴ�!

    --������ ���� : �ʱⰪ 10 ������ 10
create sequence dept_seq
INCREMENT by 10 
start with 10
NOCACHE;

    /*
    sequence�� CACHE�� ����ϴ� ��� / ������� �ʴ� ���
        -- CACHE : ������ ������ ����ϱ� ���ؼ� ���!!(�⺻�� : 20 ��)
        -- ������ �ٿ�� ��� : ĳ���� �ѹ����� ��� ���󰣴�... ���󰡰� ���ο� ���� �Ҵ� �޴´�.
        -- ������ ����, �ʱⰪ ������ �� ����� �����ϱ�!
    */

insert into dept_copy80 (dno,dname,loc)
values (dept_seq.nextval,'HR','SEOUL');

select * from dept_copy80;
--������ ����
create SEQUENCE emp_seq_no
INCREMENT by 1
start with 1
NOCACHE;


--���̺� ����
create table emp_copy80
as
select * from employee
where 0=1;

--�������� ���̺��� Ư�� �÷��� ����!!
--���� ���̺� �������� �����Ų��. eno�� !
select * from emp_copy80;

insert into emp_copy80
values (emp_seq_no.nextval, 'SMIth', 'SALESMAN',2222,SYSDATE,3000,300,20);

--���� ������ ����
select * from user_sequences;

alter sequence emp_seq_no
maxvalue 1000 ;  --�ִ밪 

alter sequence emp_seq_no
cycle; --�ִ밪�� ����ǰ� �ٽ� ó������ ��ȯ!

alter sequence emp_seq_no
nocycle; --��ȯ���� �ʰڴ�.

select * from user_sequences;

drop sequence SAMPLE_SEQUENCE;



/*
    Index : ���̺��� �÷��� ����, Ư�� �÷��� �˻��� ������ ����� �� �ֵ��� �Ѵ�.
        - Index Page : �÷��� �߿� Ű���带 �ɷ��� ��ġ������ ��Ƴ��� ��������� �Ѵ�.(���̺��� ������ �˻��Ҷ� ������ �˻��ϱ� ���ؼ�)
            -DB ������ 10%������ �����ϰ��ִ�
        - �ε����� 'å�� ����'�� ����!(���� = Index) å�� ������ �߿�Ű���带 �����ؼ� ��ġ�� �˷��ش�.
        - ���̺� ��ĵ : ���ڵ��� ó������ ~ ���������� �˻�(�˻��ӵ��� ������.), �ε����� ������� �ʰ� �˻��ϴ� ��!
            -index�� �����Ǿ����� ���� �÷��� ���̺� ��ĵ�� �Ѵ�.
        - Primary Key, Unique Key �� ����� �÷��� Index Page�� �ڵ����� �����Ǿ� �˻��� ������ �Ѵ�.
        - where ������ ���� �˻��� �ϴ� �÷��� Index�� ����.
        - ���̺��� �˻��� �����ϴ� �÷��� Index�� ����, ���̺� ��ĵ�� ���� �ʰ�! index page�� �˻��ؼ� ��ġ�� ������ ã�´�.
        - Index�� �����Ҷ� ���ϰ� ���� �ɸ���. �ַ� �߰��۾��� �Ѵ�.
*/

--index ������ ����Ǿ� �ִ� ������ ����.
    --user_columns , user_ind_columns �ΰ� !
    
select * from user_tab_columns ;
select * from user_ind_columns;

select * from user_tab_columns
where table_name in('EMPLOYEE','DEPARTMENT');


select index_name, table_name,column_name
from user_ind_columns
where table_name in('EMPLOYEE','DEPARTMENT');

select * from employee;     --eno �÷��� Primary key<== �ڵ����� index�� ������.

/*
    Index �ڵ�����, (Primary Key, Unique)�÷����� Index Page�� �ڵ����� �����ȴ�.
*/

--���̺� ���� 
create table tbl1(
    a number(4) constraint PK_tbl1_a Primary Key, -- Primary Key�� �ִ� >> �ε����� �����Ǿ���.
    b number(4),
    c number(4)
    );
    
select index_name, table_name,column_name
from user_ind_columns
where table_name in('TBL1');

select * from tbl1;


create table tbl2(
    a number (4) constraint PK_tbl2_a Primary key , 
    b number (2) constraint UK_tbl2_b Unique,
    c number (4) constraint UK_tbl2_c Unique,
    d number (4),
    e number (4)
);

create table emp_copy90
as 
select * from employee;


select index_name, table_name,column_name
from user_ind_columns
where table_name in('TBL1','TBL2','emp_copy90');

select * from emp_copy90;

select * from emp_copy90
where ename= 'KING'; --ename �÷��� index�� �����Ƿ� KING�� �˻��ϱ� ���ؼ� ���̺� ��ĵ�Ѵ�.

--ename �÷��� index �����ϱ�(�߰���!�����ؾ��Ѵ� ���ϰɷ��� )
--�÷��� index�� �����Ǿ����� ������ ���̺� ��ĵ(ó������ ������ �ϳ��ϳ� ã��)�� �Ѵ�. ���� �ð��� �����ɸ���.
--�÷��� index�� �����Ǿ������� index page(ex å�� ����!)�� �˻��Ѵ�. 

--on �ش����̺���(�÷�)
create index id_emp_ename
on emp_copy90(ename);

drop index id_emp_ename;

select * from emp_copy90
where job='SALESMAN';

select * from emp_copy90
where ename='WARD';



/*
    Index�� �ֱ������� rebuild ������Ѵ�. (1����, �Ѵ� �ֱ�)
        - Index page �� �������� (insert, update,delete�� ����ϰ� �Ͼ�� ���� �޶�����) >> ���� rebuild�� �ؾ��Ѵ�. 
*/


--Index�� Rebuild�� �ؾ��ϴ� ���� ��� : index�� tree ���̰� 4�̻��� ��찡 ��ȸ�� �Ǹ� Rebuild �� �ʿ䰡 �ִ�.
SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC;

SELECT I.TABLESPACE_NAME,I.TABLE_NAME,I.INDEX_NAME, I.BLEVEL,
       DECODE(SIGN(NVL(I.BLEVEL,99)-3),1,DECODE(NVL(I.BLEVEL,99),99,'?','Rebuild'),'Check') CNF
FROM   USER_INDEXES I
WHERE   I.BLEVEL > 4
ORDER BY I.BLEVEL DESC;

--Index Rebuild:

alter index id_emp_ename Rebuild; --index�� ���Ӱ� �����Ѵ�.

select * from emp_copy90;

/*
    index�� ����ؾ� �ϴ� ��� 
        1. table ��(�ο�,���ڵ�)�� ������ ���� ��� 
        2. where ������ ���ֻ��Ǵ� �÷��� ���
        3. Join �� ���Ǵ� Ű�÷�.
        4. �˻������ �������̺� �������� 2~4% �Ǵ� ��� 
        5. �ش��÷��� null�� ���ԵǴ� ��� (������ null�� ����)
        
    index�� ����ϸ� ������ ���
        1.table ��(�ο�,���ڵ�)�� ������ ���� ��� 
        2. �˻������ �������̺��� ���� ������ �����ϴ� ��� 
        3. insert update delete �� ����ϰ� �Ͼ�� �÷�  
*/

/*
    index�� ���� 
        1. �����ε��� (Unique Index) : �÷��� �ߺ����� �ʴ� ������ ���� ���� �ε��� Primary Key�� Unique !!!
        2. ���� �ε��� (Single Index) : �� �÷��� �ο��Ǵ� Index 
        3. ���� �ε��� (Composite Index) : �����÷��� ��� ������ Index
        4. �Լ� �ε��� (Function Base Index) : �Լ��� ������ �÷��� ������ Index 
*/

select * from emp_copy90;

-- ���� �ε��� ����
create index inx_emp_copy90_salary 
on emp_copy90 (salary);

--���� �ε��� ���� : ���÷��̻��� �����ؼ� �ε��� ����.
create TABLE dept_copy91
as 
select * from department;

create index idx_dept_copy91_dname_loc
on dept_copy91 (dname, loc);

select index_name, table_name,column_name
from user_ind_columns
where table_name in('DEPT_COPY91');

--�Լ���� �ε��� : �Լ��� ������ �÷��� �ο��Ǵ� index

create table emp_copy91 
as
select * from employee;

create index idx_emp_copy91_allsal
on emp_copy91 (salary*12);          --�÷��� �Լ�, ������ ������ ��.

select index_name, table_name,column_name
from user_ind_columns
where table_name in('EMP_COPY91');

-- �ε��� ����
drop index idx_emp_copy91_allsal;

/*
    ���� ����
    -- ��� ���� : DBMS�� �������� ���.
        - �� ����ں��� ������ ���� : DBMS�� ������ �� �ִ� ����ڸ� �����ؾ��Ѵ�.
            (���� (Authentication): Credential(Identity+password) Ȯ��)
            (�㰡 (Authorization): ������ ����ڿ��� Oracle�� �ý��� ����, ��ü(���̺�,��,Ʈ����,�Լ� ) ���� �ο�)
                -System Privilleges : ����Ŭ �������� ���� 
                -Object privilleages : ���̺� , ��, Ʈ���� , �Լ� ,�������ν���, ������, �ε��� ���ٱ���.
*/

--Oracle���� ���� ����. (�Ϲ� ���������� ������ ���� �� �� �ִ� ������ ���� )
--create user ������ identified by �н�����; 
create user usertest01 identified by 1234; --����
show user;


