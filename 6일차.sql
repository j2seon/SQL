-- 6일차 CRUD(Crate, Read, Update, Delete)

-- Object (객체) : DataBase의 존재(XE, <= Express Edtion(무료버전), 
--                                      Standard Edtion (유료), EnterPrise Edtion (유료) )
        -- 1. 테이블 , 2. 뷰, 3. 저장프로시저, 4. 트리거, 5. 인덱스, 6. 함수, 7. 시퀀스  <- DDL(Crete, Alter, Drop)
-- 테이블 생성(Create)
/*
    Create Table 테이블명(
    
        컬럼명 자료형 Null허용여부 [제약조건],
        컬럼명 자료형 Null허용여부 [제약조건],
        컬럼명 자료형 Null허용여부 [제약조건]
    );
*/
Create Table dept(
    dno number (2) not null, -- 정수 2자리만 올 수 있다. 반드시 값 있어야 함
    dname varchar2(14) not null,
    loc varchar2(13) null);
    
select * from dept;

-- DML : 테이블의 값을 넣고(insert) 수정(update), 삭제(delete)하는 구문
    -- 트랜잭션을 발생 시킴 : log에 기록을 먼저하고 Database에 적용한다.
    
    begin transaction ;  --트랜젹션 시작( insert, update, delete 구문이 시작되면 자동으로 시작)
    rollback;           -- 트랜잭션을 롤백(RAM에 적용된 트랜 잭션을 삭제_
    commit ;            -- 트랜 잭션을 적용( 실제 DB에 여원히 적용)
/*
    Insert into 테이블명 (컬렴명1, 컬럼명2, 컬럼명3)
    values (값1, 값2, 값3)
*/

    -- insert , update, delete 구문은 자동으로 트랜잭션이 시작(begin transacion) - RAM에만 적용되어 있는 상태
    insert into dept (dno, dname, loc)  -- Insert하는 순간 begin transartion 실행
    values (10, 'MANAGER' , 'SEOUL');
    
    select * from dept;
    insert into dept
    values(20,'ACCOUNTING', 'PUSAN');
    commit;
    
    desc dept;
    /*null 허용 컬럼에 값을 넣지 않기 */
    insert into dept(dno,dname)
    values(30,'RESEARCH'); 
    
    /*데이터 유형에 맞지 않는 값 넣으면 오류발생 */
    insert into dept(dno,dname,loc)
    values(20,'SALES','DEAGU');     --오류발생, number(2)
    
    insert into dept(loc,dname,dno)
    values('DEAJEON','SALES',20); -- 가능
    
    insert into dept(loc,dname,dno)
    values('DEAJEON','SALsssssssssssss',20);  --오류발생 dname varchar2(14)
    
--자료형(문자자료형)
    -- char(10) : 고정크기 10바이트, 3바이트만 넣을 경우 빈공간 7바이트 생성, 성능이 빠름(장), 하드공간낭비(단)
        --자리수를 알수 있는 고정 크기 컬럼(주민번호 전화번호)
    -- varchar2(10) : 가변크기 10바이트, 3바이트만 넣을 경우 3바이트만 공간할당, 성능이 느림 하드공간낭비가 없음  
            --자리수가 가변크기인경우 (주소,메일주소)
    --Nchar(10) : 유니코드 10자 (한글, 중국어, 일본어...) 
    --Nvarchar2 (10) : 유니코드 10자 (한글, 중국어, 일본어...) 
    
--자료형(숫자형 자료형)
    --NUMBER(2) : 정수 2자리만 입력가능
    --NUMBER(7,3): 전체7자리, 소수점 3자리까지 저장이 됨.
    --NUMBER(8,5):정수 8자리, 소수 5자리
    
    create table test1_tb1(
    a number(3,2) not null,
    b number(7,5) not null,
    c char(6) null,
    d varchar2(10) null,
    e Nchar(6) null,
    f Nvarchar2(10) null
    );
    
    insert into test1_tb1(a,b,c,d,e,f)
    values(3.22,77.555,'aaaaaa','bbbbbbbbbb','한글여섯자리','한글열자까지');

insert into test1_tb1(a,b,c,d,e,f)
    values(3.22,77.555,'한글','bbbbbbbbbb','한글여섯자리','한글열자까지');
    
    --오라클 한글 1자는 3byte를 차지한다.

select * from test1_tb1
    
    drop table test1_tb1; --삭제
    
    
    
    desc test1_tb1;
    select * from test1_tb1;
    insert into test1_tb1 (a,b,c,d,e,f)
    values(3.2,5.55,'aaaa','bbbbb','한글여','한글열자');
    
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
    values(1,'aaaa','password','홍길동','010-1111-1111','서울 중구 남산동',sysdate,'aaa@aaa.com');
    
     insert into member1
    values(3,'bbbb','password','이순신','010-2222-2222','서울 중구 남산동',sysdate,'bbb@bbb.com');
    
    insert into member1(no,id,passwd,name,phone,address,mdate,email)
    values(3,'cccc','password','강감찬',null,null,sysdate,null);
    
    --null 허용 컬럼에 값을 넣지 않을 경우 null값이 들어간다.
    
    insert into member1(no,id,passwd,name,mdate)
    values(4,'dddd','password','세종대왕',sysdate);
    
    
    select *from member1;
    commit;    
    desc member1;
    
--데이터 수정(update : 데이터 수정 후 commit; 
        --반드시 where 조건을 사용해야한다. 그렇지 않으면 모든 레코드가 수정됨.
        
/*
    update 테이블명
    set 컬럼명 = 수정할 값
    where 컬럼명 = 값
*/
    update member1
    set no=2
    where name='이순신';
    commit;
    
    update member1
    set name='신사임당'
    where no=2;
    commit;
    
    update member1
    set name='김유신'
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
    
    
--하나의 레코드에서 여러컬럼 동시에 수정하기
update member1
set name = '김유신', email='bbb@kkk.com',phone='010-7777-7777'
where no=1

commit;

update member1
set mdate = to_date('2022-01-01','yyyy-mm-dd')
where no=3;    

--레코드 (로우) 삭제(delete : 반드시 where조건을 사용해야함.)
/*
    delete 테이블명
    where 컬럼명 = 값 
*/
    select *from member1;
    delete member1
    where no =3;
    commit;

delete member1      --모든 레코드가 삭제됨.
rollback;

/*
    update, delete는 반드시 where 조건을 사용해야한다. 트랜잭션을 종료 (rollback, commit)
    update나 delete시 where 절에 사용되는 컬럼은 고유한 컬럼이어야한다. (Primary key, Unique 컬럼을 사용해야한다.)
    그렇지 않으면 여러 컬럼이 업데이트되거나 삭제 될 수 있다.
*/
    update member1
    set name ='김똘똘'
    where no = 4;

/*
    제약조건 : 컬럼의 무결성을 확보하기 위해서 사용, 무결성 : 결함 없는 데이터(즉, 원하는 데이터만 저장.)
             -- Primary key
             -- 하나의 테이블에 한번만 사용, 중복된 데이터를 넣지 못하도록 설정.
             -- null 값을 할당 할 수 없다. 
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
    values(1,'aaaa','password','홍길동','010-1111-1111','서울 중구 남산동',sysdate,'aaa@aaa.com');
    
     insert into member2
    values(2,'bbbb','password','이순신','010-2222-2222','서울 중구 남산동',sysdate,'bbb@bbb.com');
    
    insert into member2(no,id,passwd,name,phone,address,mdate,email)
    values(3,'cccc','password','강감찬',null,null,sysdate,null);
    
    insert into member2(no,id,passwd,name,phone,address,mdate,email)
    values(4,'dddd','password','세종대왕',null,null,sysdate,null);

    select * from member2;
    commit;

    update member2
    set name='김유신'
    where no=5;       --  <==테이블에서 중복되지 않는 고유한 컬럼을 조건으로 사용해야한다.
    
    /*
        제약 조건
            --UNIQUE : 중복되지 않는 고유한 값을 저장. 하나의 테이블에서 여러 컬럼에 지정할 수 있다.
                    --null을 허용함, null은 한번만 넣을 수 있다. 
    */
    
    
    create table member3(
    no number(10) Primary key, -- not null 생략하면 자동으로 부여된다.
    id varchar2(50) not null UNIQUE, --중복된 값을 넣을 수 없다.
    passwd varchar2(50) not null,
    name Nvarchar2(6) not null,
    phone varchar2(50) null,
    address varchar2(100) null,
    mdate date not null,
    email varchar2(50) null
    );
    
        select * from member3;

     insert into member3(no,id,passwd,name,phone,address,mdate,email)
    values(1,'aaaa','password','홍길동','010-1111-1111','서울 중구 남산동',sysdate,'aaa@aaa.com');
    
     insert into member3
    values(2,'bbbb','password','이순신','010-2222-2222','서울 중구 남산동',sysdate,'bbb@bbb.com');
    
    insert into member3(no,id,passwd,name,phone,address,mdate,email)
    values(3,'cccc','password','강감찬',null,null,sysdate,null);
    
    insert into member3(no,id,passwd,name,phone,address,mdate,email)
    values(5,'dddd','password','세종대왕',null,null,sysdate,null);
    
