-- 9일차 시퀀스 ,인덱스

/*
시퀀스 : 자동번호 발생기!!!!!!!
    -- 번호가 발생이 되면 뒤로 되돌아가지 못함. >> 삭제후 다시 생성해야한다.
    -- primary Key에 번호를 자동으로 발생시키기 위해서 사용한다.
    --  primary Key에 키 컬럼에는 중복되지 않는 고유한 값을 신경쓰지 않아도된다!!
*/

--초기 값 : 10 증가값이 10  : 10씩 증가하는 시퀀스!
create SEQUENCE sample_sequence    
INCREMENT by 10             --증가값   
start with 10;              --초기값

--시퀀스의 정보를 출력하는 데이터 사전
select * from user_sequences ;

select sample_sequence.nextval from dual ; -- 시퀀스의 다음값을 출력한다.
select sample_sequence.currval from dual; --시컨스의 현재 값!

--초기값 2 증가값 2

create SEQUENCE sample_sequence2
INCREMENT by 2
start with 2 
nocache; --캐쉬를 사용하지 않겠다  > cache는 서버의 부하를 줄여 줄 수 있다. 

select * from user_sequences;

select sample_sequence2.nextval from dual;
select sample_sequence2.currval from dual;

--시퀀스를 primary Key 적용하기
create table dept_copy80
as
select * from department
where 0=1;

select * from dept_copy80;
    --dno에 넘버링을 하겠다!

    --시퀀스 생성 : 초기값 10 증가값 10
create sequence dept_seq
INCREMENT by 10 
start with 10
NOCACHE;

    /*
    sequence에 CACHE를 사용하는 경우 / 사용하지 않는 경우
        -- CACHE : 서버의 성능을 향상하기 위해서 사용!!(기본값 : 20 개)
        -- 서버가 다운된 경우 : 캐쉬된 넘버링이 모두 날라간다... 날라가고 새로운 값을 할당 받는다.
        -- 시퀀스 생성, 초기값 증가값 등 방법을 숙지하기!
    */

insert into dept_copy80 (dno,dname,loc)
values (dept_seq.nextval,'HR','SEOUL');

select * from dept_copy80;
--시퀀스 생성
create SEQUENCE emp_seq_no
INCREMENT by 1
start with 1
NOCACHE;


--테이블 생성
create table emp_copy80
as
select * from employee
where 0=1;

--시퀀스를 테이블의 특정 컬럼여 적용!!
--만든 테이블에 시퀀스를 연결시킨다. eno에 !
select * from emp_copy80;

insert into emp_copy80
values (emp_seq_no.nextval, 'SMIth', 'SALESMAN',2222,SYSDATE,3000,300,20);

--기존 시퀀스 수정
select * from user_sequences;

alter sequence emp_seq_no
maxvalue 1000 ;  --최대값 

alter sequence emp_seq_no
cycle; --최대값이 적용되고 다시 처음부터 순환!

alter sequence emp_seq_no
nocycle; --순환하지 않겠다.

select * from user_sequences;

drop sequence SAMPLE_SEQUENCE;



/*
    Index : 테이블의 컬럼에 생성, 특정 컬럼의 검색을 빠르게 사용할 수 있도록 한다.
        - Index Page : 컬럼의 중요 키워드를 걸러서 위치정보를 담아놓는 페이지라고 한다.(테이블의 정보를 검색할때 빠르게 검색하기 위해서)
            -DB 공간의 10%정도를 차지하고있다
        - 인덱스는 '책의 색인'과 같다!(색인 = Index) 책의 내용의 중요키워드를 수집해서 위치를 알려준다.
        - 테이블 스캔 : 레코드의 처음부터 ~ 마지막까지 검색(검색속도가 느리다.), 인덱스를 사용하지 않고 검색하는 것!
            -index가 생성되어있지 않은 컬럼은 테이블 스캔을 한다.
        - Primary Key, Unique Key 가 적용된 컬럼은 Index Page가 자동으로 생성되어 검색을 빠르게 한다.
        - where 절에서 자주 검색을 하는 컬럼의 Index를 생성.
        - 테이블의 검색을 자주하는 컬럼에 Index를 생성, 테이블 스캔을 하지 않고! index page를 검색해서 위치를 빠르게 찾는다.
        - Index를 생성할때 부하가 많이 걸린다. 주로 야간작업에 한다.
*/

--index 정보가 저장되어 있는 데이터 사전.
    --user_columns , user_ind_columns 두개 !
    
select * from user_tab_columns ;
select * from user_ind_columns;

select * from user_tab_columns
where table_name in('EMPLOYEE','DEPARTMENT');


select index_name, table_name,column_name
from user_ind_columns
where table_name in('EMPLOYEE','DEPARTMENT');

select * from employee;     --eno 컬럼에 Primary key<== 자동으로 index가 생성됨.

/*
    Index 자동생성, (Primary Key, Unique)컬럼에는 Index Page가 자동으로 생성된다.
*/

--테이블 생성 
create table tbl1(
    a number(4) constraint PK_tbl1_a Primary Key, -- Primary Key가 있다 >> 인덱스가 생성되었다.
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
where ename= 'KING'; --ename 컬럼에 index가 없으므로 KING을 검색하기 위해서 테이블 스캔한다.

--ename 컬럼에 index 생성하기(야간에!생성해야한다 부하걸려서 )
--컬럼에 index가 생성되어있지 않으면 테이블 스캔(처음부터 끝까지 하나하나 찾음)을 한다. 따라서 시간이 오래걸린다.
--컬럼에 index가 생성되어있으면 index page(ex 책의 목차!)를 검색한다. 

--on 해당테이블의(컬럼)
create index id_emp_ename
on emp_copy90(ename);

drop index id_emp_ename;

select * from emp_copy90
where job='SALESMAN';

select * from emp_copy90
where ename='WARD';



/*
    Index는 주기적으로 rebuild 해줘야한다. (1주일, 한달 주기)
        - Index page 는 조각난다 (insert, update,delete가 빈번하게 일어나면 값이 달라진다) >> 새로 rebuild를 해야한다. 
*/


--Index는 Rebuild를 해야하는 정보 얻기 : index의 tree 깊이가 4이상인 경우가 조회가 되면 Rebuild 할 필요가 있다.
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

alter index id_emp_ename Rebuild; --index를 새롭게 생성한다.

select * from emp_copy90;

/*
    index를 사용해야 하는 경우 
        1. table 행(로우,레코드)의 개수가 많은 경우 
        2. where 절에서 자주사용되는 컬럼인 경우
        3. Join 시 사용되는 키컬럼.
        4. 검색결과가 원본테이블 데이터의 2~4% 되는 경우 
        5. 해당컬럼이 null이 포함되는 경우 (색인은 null은 제외)
        
    index를 사용하면 안좋은 경우
        1.table 행(로우,레코드)의 개수가 적은 경우 
        2. 검색결과가 원본테이블의 많은 비중을 차지하는 경우 
        3. insert update delete 가 빈번하게 일어나는 컬럼  
*/

/*
    index의 종류 
        1. 고유인덱스 (Unique Index) : 컬럼에 중복되지 않는 고유한 값을 갖는 인덱스 Primary Key와 Unique !!!
        2. 단일 인덱스 (Single Index) : 한 컬럼에 부여되는 Index 
        3. 결합 인덱스 (Composite Index) : 여러컬럼을 묶어서 생성한 Index
        4. 함수 인덱스 (Function Base Index) : 함수를 적용한 컬럼에 생성한 Index 
*/

select * from emp_copy90;

-- 단일 인덱스 생성
create index inx_emp_copy90_salary 
on emp_copy90 (salary);

--결합 인덱스 생성 : 두컬럼이상을 결합해서 인덱스 생성.
create TABLE dept_copy91
as 
select * from department;

create index idx_dept_copy91_dname_loc
on dept_copy91 (dname, loc);

select index_name, table_name,column_name
from user_ind_columns
where table_name in('DEPT_COPY91');

--함수기반 인덱스 : 함수를 적용한 컬럼에 부여되는 index

create table emp_copy91 
as
select * from employee;

create index idx_emp_copy91_allsal
on emp_copy91 (salary*12);          --컬럼에 함수, 계산식을 적용한 것.

select index_name, table_name,column_name
from user_ind_columns
where table_name in('EMP_COPY91');

-- 인덱스 삭제
drop index idx_emp_copy91_allsal;

/*
    권한 관리
    -- 사용 권한 : DBMS는 여러명이 사용.
        - 각 사용자별로 계정을 생성 : DBMS엣 접속할 수 있는 사용자를 생성해야한다.
            (인증 (Authentication): Credential(Identity+password) 확인)
            (허가 (Authorization): 인증된 사용자에게 Oracle의 시스템 권한, 객체(테이블,뷰,트리거,함수 ) 권한 부여)
                -System Privilleges : 오라클 전반적인 권한 
                -Object privilleages : 테이블 , 뷰, 트리거 , 함수 ,저장프로시져, 시퀀스, 인덱스 접근권한.
*/

--Oracle에서 계정 생성. (일반 계정에서는 계정을 생성 할 수 있는 권한이 없다 )
--create user 계정명 identified by 패스워드; 
create user usertest01 identified by 1234; --오류
show user;


