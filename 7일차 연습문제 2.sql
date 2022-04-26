--7일차 문제
create table tb_zipcode(
    zipcode varchar2(7) not null constraint PK_tb_zipcode_zipcode PRIMARY Key,
    sido varchar2(30),
    gugum varchar2(30),
    dong varchar2(30),
    bungi varchar2(30)
);

insert into tb_zipcode
values('111','서울','금천구','가산동','1번지');

insert into tb_zipcode
values('222','서울','금천구','가산동','2번지');

insert into tb_zipcode
values('333','서울','금천구','가산동','3번지');

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
values('ddd','ssss','홍길동','111','대전','010-0000-0000',default);
insert into member
values('aaa','kkk','홍길순','222','천안','010-1111-1111',default);
insert into member
values('bbb','jjj','홍길선','333','청주','010-2222-2222',default);
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

--------------------------------------------------------------
alter table tb_zipcode --1. 컬럼 추가
add (ZIP_SEQ varchar2(30) );
desc tb_zipcode;

alter table tb_zipcode --2. 이름변경
rename column bungi to BUNJI;
    
alter table tb_zipcode --3. 이름변경
rename column GUGUM to GUGUN;   
    
alter table tb_zipcode --4. 크기늘리기
MODIFY DONG VARCHAR2(100);


--primary 키 관련오류인데 변경방법을 모르겠습니다 ...
