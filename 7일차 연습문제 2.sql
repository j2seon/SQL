--7���� ����

--���̺� ������ (Foreign key) : �θ����̺� (FK���� ���̺�) �ڽ����̺� ����.
    --�ڽ����̺��� ������ �� FK�� ���� �ʰ� ������ , �θ����̺� ������, alter table�� ����ؼ� ���߿� fx�� �־��ش�.


create table tb_zipcode(
    zipcode varchar2(7) not null constraint PK_tb_zipcode_zipcode PRIMARY Key,
    sido varchar2(30),
    gugum varchar2(30),
    dong varchar2(30),
    bungi varchar2(30)
);

insert into tb_zipcode
values('111','����','��õ��','���굿','1����');

insert into tb_zipcode
values('222','����','��õ��','���굿','2����');

insert into tb_zipcode
values('333','����','��õ��','���굿','3����');

select * from tb_zipcode;
commit;

--------------------------------------------------------

create table member(
    id varchar2(20) not null constraint PK_member_id PRIMARY Key,
    pwd varchar2(20),
    name varchar2(50),
    zipcode varchar2(7),
    CONSTRAINT FK_member_id_tb_zipcode Foreign key (zipcode) references tb_zipcode(zipcode),
    address varchar2(20),
    tel varchar2(13),
    indate date default sysdate
);

select * from member;
desc member;
insert into member
values('ddd','ssss','ȫ�浿','111','����','010-0000-0000',default);
insert into member
values('aaa','kkk','ȫ���','222','õ��','010-1111-1111',default);
insert into member
values('bbb','jjj','ȫ�漱','333','û��','010-2222-2222',default);
commit;


---------------------------------------------------------------

create table products(
    product_code VARCHAR2(20) not null CONSTRAINT PK_products_product_code PRIMARY Key,
    product_name VARCHAR2(100),
    product_kind char(1),
    product_price1 varchar2(10),
    product_price2 varchar2(10),
    product_content varchar2(1000),
    product_image varchar2(50),
    sizeSt varchar2(5),
    sizeEt varchar2(5),
    product_quantity varchar2(5),
    useyn char(1),
    indate date
);

insert into products
values('1','1','1','1','1','1','1','1','1','1','1',sysdate);

insert into products
values('3','1','1','1','1','1','1','1','1','1','1',sysdate);
select * from products;
commit;



create table orders(
    o_seq NUMBER(10) not null CONSTRAINT PK_orders_o_seq PRIMARY KEY , 
    product_code VARCHAR2(20),
    CONSTRAINT FK_orders_product_code FOREIGN Key (product_code) REFERENCES products (product_code),
    id VARCHAR2(16),
    CONSTRAINT FK_orders_id_member FOREIGN KEY(id) REFERENCES member (id),
    product_size VARCHAR2(5),
    quantity VARCHAR2(5),
    result char(1),
    indate date
    );

insert into orders
values('1','1','ddd','1','1','1',sysdate);

insert into orders
values('2','2','aaa','2','2','2',sysdate);

insert into orders
values('3','3','bbb','3','3','3',sysdate);
select * from orders;
commit;

/*
    Foreign key�� �����Ǵ� ���̺� ������
    1. �ڽ����̺��� ���� ���� �� �θ� ���̺� ����
    2. Foreign key���� ������ �� ������ �Ŀ� ���̺� ����!
    3. cascade constraints �ɼ����� ���̺� ���� ����.
*/
--���̺� ���� �� ���� ����: �ٸ����̺��� Foreign key�� �ڽ��� ���̺��� �����ϰ� ������ ������ �ȵȴ�.
    --�ٸ����̺��� �����ϰ� �ִ��� ������ �����ϴ� �ɼ� : cascade
drop table orders;   
drop table member;      --order ���̺��� �����ϰ� �ֱ� ������ �����ȉ�.(order ���̺��� id �÷��� member ���̺��� id �÷��� �����ϰ� �ִ� .)
drop table tb_zipcode;    -- �����߻� :zipcode�� primarkey�� member���� �����ϰ� �ֱ� ������ ������ �ȵȴ�.
drop table products;


-- ���� ���� ���� �Ŀ� ���̺� ���� (Foreign Key �������ָ��.)
alter table member
drop constraint FK_MEMBER_ZIPCODE_TB_ZOPCODE;

alter table orders 
drop constraint FK_ORDERS_ID_MEMBER;

alter table orders 
drop constraint FK_ORDERS_PRODUCT_MEMBER;

--���� ���� Ȯ��
select * from user_constraints 
where table_name= 'orders';


--cascade constraints �ɼ��� ����ؼ� ���� , <==Foreign Key ���������� ���� ���� �� ����
drop table member cascade constraints;
drop table tb_zipcode cascade constraints;
drop table products cascade constraints;
drop table orders cascade constraints;

--------------------------------------------------------------
--xmfoswortus qkftod : DML: INSERT , UPDATE, DELTED< commit


alter table tb_zipcode --1. �÷� �߰�
add (ZIP_SEQ varchar2(30) );
desc tb_zipcode;

alter table tb_zipcode --2. �̸�����
rename column bungi to BUNJI;
    
alter table tb_zipcode --3. �̸�����
rename column GUGUM to GUGUN;   
    
alter table tb_zipcode --4. ũ��ø���
MODIFY DONG VARCHAR2(100);


--�������� ��� ��Ȱ��ȭ�ϱ� 
    --<== bulk Insert (�뷮���� Insert) : ������������ ���ؼ� Insert �Ǵ� �ӵ��� ������ �����ϴ�.
alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode;

alter table tb_zipcode 
disable constraint PK_tb_zipcode_zipcode cascade; -- Member ���̺��� fk�� ����� �������ǵ� �Բ� disable ��.

select * from user_constraints
where table_name IN('MEMBER','TB_ZIPCODE');

select constraint_name, table_name, status from user_constraints
where table_name IN('MEMBER','TB_ZIPCODE');

select * from tb_zipcode;

truncate table tb_zipcode; --������ ���ڵ常 �������(������ ��緹�ڵ� ����)
delete tb_zipcode;--������ ���ڵ常 ������� (������ ������ - �뷮�� ���)
commit;


--��������Ȱ��ȭ �ϱ�

select constraint_name, table_name, status from user_constraints
where table_name IN('MEMBER','TB_ZIPCODE');

alter table tb_zipcode
enable NOVALIDATE constraint PK_tb_zipcode_zipcode;

alter table tb_zipcode 
enable NOVALIDATE constraint PK_tb_zipcode_zipcode cascade;


--zip_seq �÷��� ������ ����� �ȵ����� , ����� ���ĵǵ��� �غ�����.
-- ���ڰ� �ƴ϶� ����Ÿ���̶� ����� �ȵƴ�. to number�� ���ڷ� ����ȯ �� ����)
select * from tb_zipcode
order by zip_seq;

select * from tb_zipcode
order by to_number (zip_seq,99999999);

desc tb_zipcode;

select * from tb_zipcode
where zip_seq = '4';

desc tb_zipcode;
