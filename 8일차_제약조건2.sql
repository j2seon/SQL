-- 제약 조건 수정 (Alter Table : 기존의 테이블에 제약 조건을 수정)

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


-- 테이블을 복사하면 레코드만 복사가 된다. 테이블의 제약 조건은 복사되어 오지 않는다. Alter table을 사용해서 제약조건을 적용해줘야 함
select * from emp_copy50;
select * from dept_copy50;

alter table emp_copy50
add constraint PK_emp_copy50_eno PRIMARY key (eno);

alter table dept_copy50
add constraint PK_dept_copy50_ PRIMARY key (dno);

--Foreign Key 
alter table emp_copy50 
add constraint FK_emp_copy50_dno_dept_copy50 FOREIGN key (dno) references dept_copy50(dno);


--NOT NULL 제약조건 추가. (구문이 다르다 , add 대신에 modify를 사용)
desc employee;
desc emp_copy50; --notnull을 넣지 않았지만 ,primary Key 제약조건을 할당.

desc department;
desc dept_copy50;   --primary Key 적용으로 not null 

    -- 기존의 null이 들어가있는 곳에는 NOT NULL 컬럼으로 지정할 수 없다.-->null을 따로 지정해줘야 가능하다.

select ename from emp_copy50
where ename is null;

alter table emp_copy50
MODIFY ename CONSTRAINT NN_emp_copy50_ename not null ;

--commion 컬럼에 not null 할당하기
select *from emp_copy50;

alter table emp_copy50 
MODIFY commission CONSTRAINT NN_emp_copy50_commission not null;

update emp_copy50
set commission=0
where commission is null;

--Unique 제약조건 추가 : 컬럼에 중복된 값이 있으면 할당하지 못한다.

select ename , count (*)
from emp_copy50
group by ename
having count(*)>2;

alter table emp_copy50
add CONSTRAINT UK_emp_copy50_ename unique (ename);


--check 제약조건 추가

select * from emp_copy50;

alter table emp_copy50 
add CONSTRAINT CK_emp_copy50_salary check (salary >0 and salary<10000);

--default 제약조건 추가 <==제약조건이 아님: 제약조건이름을 할당할 수 없다.
    --값을 넣지 않을 경우 default로 설정된 값이 들어간다.
alter table emp_copy50 
modify salary default 1000; 

alter table emp_copy50 
modify hiredate default sysdate;

desc emp_copy50;

insert into emp_copy50 (eno,ename,commission)
values(9999,'Juli',100);

insert into emp_copy50
values(8888,'julia',null,null,default,default,1500,null);

/*제약조건 제거 :alter table 테이블명 drop*/

--Primary key 제거 
alter table emp_copy50   -- 오류 없이 제거됨.
drop primary key cascade;


alter table dept_copy50   --오류발생 : foreign key가 참조하기 때문에 삭제안됨.
drop primary key;

select * from user_constraints
where table_name in('EMP_COPY50','DEPR_COPY50');


--not null 컬럼제거하기 : 
alter table emp_copy50
drop CONSTRAINT NN_EMP_COPY50_ENAME;

--uNIque chck 제약조건 제거
alter table emp_copy50;
alter table dept_copy50)  --foreign key를 먼저 제거하고 primary key 제거
drop primary key;

alter table emp_copy50;
drop CONSTRAINT NN_EMP_COPY50_saatl;

alter table emp_copy50;
drop CONSTRAINT NN_EMP_COPY50_COMMISSION;

--default 는 null허용 컬럼은 default null로 세팅 :  default 제약 조건을 제거하는 것.
alter table emp_copy50
modify hiredate default null ;

/*제약조건 disable /enable
    -- 제약조건을 잠시 중시
    --대량 으로 값을 테이블에 추가할 때 부하가 많이 걸린다. disable ==>enable
    -index를 생성시 부하가 많이 걸린다. 
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
vlaues(50,'hr' 서울);

alter table emp_copy50;
enable constraint FK_emp_copy50_dno;


