--13일차 - 저장 프로시져 (STROED PROCEDURE), 함수 (FUNCTION), 트리거(TRIGGER)

/*
    저장프로시져의 장점
        1. PL/SQL 을 사용가능하다 . 자동화
        2. 성능이 빠르다.
            일반적인 SQL구문 : 구문분석 -> 개체이름확인 ->사용권한확인 ->최적화->컴파일 ->실행
            저장프로시저 처음실행 : 구문분석 -> 개체이름확인 ->사용권한확인 ->최적화->컴파일 ->실행
            저장프로시저 두번째부터실행 : 컴파일(메모리에 로드)이 바로 실행된다. >>빠르다
        3. 입력 매개변수,출력 매개변수를 사용할 수 있다.
        4. 일련의 작업을 묶어서 저장 (모듈화된 프로그래밍이 가능하다.)
*/

--1. 저장프로시져 생성.
    --SOCTT 사원의 월급을 출력하는 저장 프로시져
CREATE PROCEDURE SP_SALARY
IS 
    V_SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT SALARY INTO V_SALARY
    FROM EMPLOYEE 
    WHERE ENAME='SCOTT';

    DBMS_OUTPUT.PUT_LINE('SCOOT의 급여는 : '|| V_SALARY||'입니다');
END;
/
   
/*저장 프로시져 정보를 확인하는 데이터 사전*/
SELECT * FROM USER_SOURCE
WHERE NAME='SP_SALARY';

--2. 저장프로시져 실행
EXECUTE SP_SALARY;      -- 전체이름
EXEC SP_SALARY;         -- 약식이름

--3. 저장프로시져 수정
CREATE OR REPLACE PROCEDURE SP_SALARY -- SP_SALARY가 존재하지 않으면 생성, 존재하면 수정.
IS 
    V_SALARY EMPLOYEE.SALARY%TYPE;
    V_COMMISSION EMPLOYEE.COMMISSION%TYPE;
BEGIN
    SELECT SALARY, COMMISSION INTO V_SALARY, V_COMMISSION
    FROM EMPLOYEE 
    WHERE ENAME='SCOTT';

    DBMS_OUTPUT.PUT_LINE('SCOOT의 급여는 : '|| V_SALARY||'보너스는 : '||V_COMMISSION||'입니다');
END;
/
EXEC SP_SALARY;

--4. 저장프로시져 삭제 
DROP PROCEDURE SP_SALARY;
    
------------<인풋 매개변수를 처리하는 저장 프로시져>>---------------------    
CREATE OR REPLACE PROCEDURE SP_SALARY_ENAME(  --입력매개변수(IN), 출력 매개변수(OUT)를 정의한다.
    V_ENAME IN EMPLOYEE.ENAME%TYPE --변수명 IN 자료형 <=주의 :<<;를 사용하면 안된다.>>  
)
IS      --변수선언(저장프로시져에서 사용할 변수 선언)
        V_SALARY EMPLOYEE.SALARY%TYPE;
BEGIN 
    SELECT SALARY INTO V_SALARY
    FROM EMPLOYEE
    WHERE ENAME = V_ENAME; -- 인풋매개변수 : V_ENAME
    DBMS_OUTPUT.PUT_LINE(V_ENAME || '의 급여는 '||V_SALARY || '입니다.');  
END;
/
EXEC SP_SALARY_ENAME('SCOTT');
EXEC SP_SALARY_ENAME('SMITH');

SELECT * FROM EMPLOYEE;


/*부서번호를 INPUT 받아서 이름 직책 부서번호 컬럼을 출력하는 저장 프로시져 생성*/

CREATE OR REPLACE PROCEDURE SP_DNO(
    V_DNO IN EMPLOYEE.DNO%TYPE
)
IS
    CURSOR C1 IS
    SELECT ENAME,JOB,DNO FROM EMPLOYEE
    WHERE DNO=V_DNO;
BEGIN
     DBMS_OUTPUT.PUT_LINE('사원이름'||'    '||'직책'||'    '||'부서번호');
    FOR C1_RE IN C1 LOOP
     DBMS_OUTPUT.PUT_LINE(C1_RE.ENAME||'    '||C1_RE.JOB||'    '||C1_RE.DNO);
    END LOOP;
END;
/

EXEC SP_DNO(10);


/*테이블 이름을 인풋 받아서 EMPLOYEE 테이블을 복사해서 생성하는 저장프로시져를 생성하세요*/

/*저장프로시져를 사용해서 테이블 생성*/
CREATE OR REPLACE PROCEDURE SP_CREATETABLE(
    V_NAME IN VARCHAR2 --자리수를 할당하지 않고! 
)
IS
    CURSOR1 INTEGER;
    V_SQL VARCHAR2(100) ; --SQL 쿼리를 저장하는 변수
BEGIN
    V_SQL := 'CREATE TABLE '||V_NAME|| ' AS SELECT * FROM EMPLOYEE'; --테이블 생성쿼리를 변수에 할당
    CURSOR1 := DBMS_SQL.OPEN_CURSOR;  --커서사용
    DBMS_SQL.PARSE(CURSOR1, V_SQL, DBMS_SQL.V7); --커서를 사용해서 SQL쿼리를 실행.
    DBMS_SQL.CLOSE_CURSOR(CURSOR1); --커서중지
END;
/
GRANT CREATE TABLE TO PUBLIC;--SYS 계정에서 실행 : 권한 할당하는 쿼리라서

EXEC SP_CREATETABLE('EMP_COPY33');

SELECT * FROM EMP_COPY33;
    
------------------<출력매개변수 사용>-------------------------------    
/* 저장프로시져 : 출력 매개변수 지원(여러개), 함수: 출력매개변수를 하나만 가진다.
    OUT 키워드 사용.
    저장 프로시져를 호출시 먼저 출력 매개변수 변수선언 후 호출이 가능.
    호출시 출력매개변수 이름앞에 ':변수명(출력매개변수명)'
    출력매개변수를 출력하기위해서 PRINT 명령문이나 PL/SQL을 사용해서 출력할 수 있다.
*/

CREATE OR REPLACE PROCEDURE SP_SALARY_ENAME2 ( --입력/출력 매개변수 선언부 
    V_ENAME IN EMPLOYEE.ENAME%TYPE, --입력매개변수
    V_SALARY OUT EMPLOYEE.SALARY%TYPE --출력매개변수
    )
IS
BEGIN
    SELECT SALARY INTO V_SALARY 
    FROM EMPLOYEE 
    WHERE ENAME=V_ENAME;
END;
/
--주석처리 주의 --호출부에서 아웃풋 매개변수를 선언-- :VAR_SALARY <== : 주의 
SELECT * FROM USER_SOURCE WHERE NAME='SP_SALARY_ENAME2'; --데이터 사전에서 확인 
VARIABLE VAR_SALARY VARCHAR2(50);
EXEC SP_SALARY_ENAME2('SCOTT', :VAR_SALARY); 
PRINT VAR_SALARY;
    
    
--OUT 파라미터를 여러개 가지는 저장프로시져 생성 및 출력(PL/SQL) 
-- 사원번호를 인풋받아서 사원이름, 급여 직업, 직책을 OUT 파라미터에 넘겨주는 프로시져를 PL/SQL을 사용해서 출력.

/*
CREATE OR REPLACE PROCEDURE SEL_EMPNO( -- IN, OUT : 자료형은 참조자료형 (%TYPE),
    V_ENO IN NUMBER,                    --기본자료형 바이트수 생략.
    V_ENAME OUT VARCHAR2,
    V_SAL OUT NUMBER,
    V_JOB OUT VARCHAR2 
)
IS
BEGIN
    SELECT ENAME,SALARY,JOB INTO V_ENAME,V_SAL,V_JOB
    FROM EMPLOYEE
    WHERE ENO = V_ENO;
END;
*/
create or replace procedure SEL_EMPNO (  -- In, Out: 자료형은 참조자료형 (%type) , 기본 자료형일 경우 바이트수 생략
    v_eno in number,
    v_ename out varchar2,
    v_sal out number,
    v_job out varchar2
)
is  
begin
    select ename, salary , job into v_ename, v_sal, v_job  -- 호출하는 곳으로 다시 던져줌
    from employee
    where eno = v_eno;
end;
/
    
--PL/SQL을 사용해서 저장 프로시져 호출
DECLARE
    VAR_ENAME VARCHAR2(50);
    VAR_SAL NUMBER;
    VAR_JOB VARCHAR2(50);
BEGIN
    --익명 블록에서는 저장프로시져 호출 시 EXEC를 붙이지 않는다.
    SEL_EMPNO(7788,VAR_ENAME,VAR_SAL,VAR_JOB); --저장프로시저 호출
    DBMS_OUTPUT.PUT_LINE('조회결과 : '||VAR_ENAME || '  '||VAR_SAL||'  '||VAR_JOB);
END;
/


/*함수 (FUNCTION): 값을 넣어서 하나의 값을 반환받아온다.  <==SQL구문내에서 사용가능
    --비교, 저장프로시저는 OUT 매개변수를 여러개 반환받아올 수 있다.<==SQL구문내에서는 사용 불가.
*/
CREATE OR REPLACE FUNCTION FN_SALARY_ENAME( --인풋매개변수 
    V_ENAME IN EMPLOYEE.ENAME%TYPE
)
RETURN NUMBER       --호출하는 곳으로 값을 던져줌.
IS
    V_SALARY NUMBER(7,2);
BEGIN
    SELECT SALARY INTO V_SALARY
    FROM EMPLOYEE 
    WHERE ENAME = V_ENAME; --인풋매개변수
    RETURN V_SALARY;
END;
/

/*함수의 데이터사전*/
SELECT * FROM USER_SOURCE
WHERE NAME = 'FN_SALARY_ENAME';

--1.함수사용 
VARIABLE VAR_SALARY NUMBER;
EXEC :VAR_SALARY:=FN_SALARY_ENAME('SCOTT');
PRINT VAR_SALARY;

--2. 함수사용 (SQL 구문내에서 함수사용) << 프로시져는 불가능
SELECT ENAME, FN_SALARY_ENAME('SCOTT') AS 월급
FROM EMPLOYEE 
WHERE ENAME = 'SCOTT';

--3.함수삭제 
DROP FUNCTION FN_SALARY_ENAME;
