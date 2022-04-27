--7일차 문제

--테이블 생성시 (Foreign key) : 부모테이블 (FK참조 테이블) 자식테이블 생성.
    --자식테이블을 생성할 때 FK를 넣지 않고 생성후 , 부모테이블 생성후, alter table를 사용해서 나중에 fx를 넣어준다.


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

/*
    Foreign key로 참조되는 테이블 삭제시
    1. 자식테이블을 먼저 삭제 후 부모 테이블 삭제
    2. Foreign key제약 조건을 다 제거한 후에 테이블 삭제!
    3. cascade constraints 옵셥으로 테이블 강제 삭제.
*/
--테이블 삭제 시 주의 사항: 다른테이블에서 Foreign key로 자신의 테이블을 참조하고 있으면 삭제가 안된다.
    --다른테이블이 참조하고 있더라도 강제로 삭제하는 옵션 : cascade
drop table orders;   
drop table member;      --order 테이블에서 참고하고 있기 때문에 삭제안됌.(order 테이블의 id 컬럼이 member 테이블의 id 컬럼을 참조하고 있다 .)
drop table tb_zipcode;    -- 오류발생 :zipcode의 primarkey를 member에서 참조하고 있기 때문에 삭제가 안된다.
drop table products;


-- 제약 조건 제거 후에 테이블 삭제 (Foreign Key 삭제해주면됌.)
alter table member
drop constraint FK_MEMBER_ZIPCODE_TB_ZOPCODE;

alter table orders 
drop constraint FK_ORDERS_ID_MEMBER;

alter table orders 
drop constraint FK_ORDERS_PRODUCT_MEMBER;

--제약 조건 확인
select * from user_constraints 
where table_name= 'orders';


--cascade constraints 옵션을 사용해서 삭제 , <==Foreign Key 제약조건을 먼저 제거 후 삭제
drop table member cascade constraints;
drop table tb_zipcode cascade constraints;
drop table products cascade constraints;
drop table orders cascade constraints;

--------------------------------------------------------------
--xmfoswortus qkftod : DML: INSERT , UPDATE, DELTED< commit


alter table tb_zipcode --1. 컬럼 추가
add (ZIP_SEQ varchar2(30) );
desc tb_zipcode;

alter table tb_zipcode --2. 이름변경
rename column bungi to BUNJI;
    
alter table tb_zipcode --3. 이름변경
rename column GUGUM to GUGUN;   
    
alter table tb_zipcode --4. 크기늘리기
MODIFY DONG VARCHAR2(100);


--제약조건 잠시 비활성화하기 
    --<== bulk Insert (대량으로 Insert) : 제약조건으로 인해서 Insert 되는 속도가 굉장히 느립니다.
alter table tb_zipcode
disable constraint PK_tb_zipcode_zipcode;

alter table tb_zipcode 
disable constraint PK_tb_zipcode_zipcode cascade; -- Member 테이블의 fk가 적용된 제약조건도 함께 disable 됨.

select * from user_constraints
where table_name IN('MEMBER','TB_ZIPCODE');

select constraint_name, table_name, status from user_constraints
where table_name IN('MEMBER','TB_ZIPCODE');

select * from tb_zipcode;

truncate table tb_zipcode; --기존의 레코드만 모두제거(빠르게 모든레코드 삭제)
delete tb_zipcode;--기존의 레코드만 모두제거 (삭제가 느리다 - 대량일 경우)
commit;


--제약조건활성화 하기

select constraint_name, table_name, status from user_constraints
where table_name IN('MEMBER','TB_ZIPCODE');

alter table tb_zipcode
enable NOVALIDATE constraint PK_tb_zipcode_zipcode;

alter table tb_zipcode 
enable NOVALIDATE constraint PK_tb_zipcode_zipcode cascade;


--zip_seq 컬럼의 정렬이 제대로 안된이유 , 제대로 정렬되도록 해보세요.
-- 숫자가 아니라 문자타입이라서 제대로 안됐다. to number로 숫자로 형번환 후 정렬)
select * from tb_zipcode
order by zip_seq;

select * from tb_zipcode
order by to_number (zip_seq,99999999);

desc tb_zipcode;

select * from tb_zipcode
where zip_seq = '4';

desc tb_zipcode;
