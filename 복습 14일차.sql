--1.각 부서별로 최소 급여, 최대급여, 평균급여를 출력하는 저장 프로시져를 생성하시오.
        --여러개가 나오기때문에 커서가 필요하다.
SELECT * FROM EMPLOYEE;
SET SERVEROUTPUT ON        
CREATE OR REPLACE PROCEDURE SP_EX1
IS -- 변수선언 , 커서 선언
    V_DNO EMPLOYEE.DNO%TYPE;
    V_MIN EMPLOYEE.SALARY%TYPE;
    V_MAX EMPLOYEE.SALARY%TYPE;
    V_AVG EMPLOYEE.SALARY%TYPE;
    
    CURSOR C1 IS
    SELECT DNO, MIN(SALARY), MAX(SALARY),AVG(SALARY)
    FROM EMPLOYEE
    GROUP BY DNO;
    
BEGIN 
    DBMS_OUTPUT.PUT_LINE('부서번호   최소급여    최대급여    평균급여');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    OPEN C1; --커서 시작
    LOOP
        FETCH C1 INTO V_DNO,V_MIN,V_MAX,V_AVG;
        EXIT WHEN C1%NOTFOUND; --레코드가 존재하지 않을때 빠져나간다.
        DBMS_OUTPUT.PUT_LINE(V_DNO||'        '||V_MIN||'        '||V_MAX||'      '||V_AVG);
    END LOOP;
    CLOSE C1;
END;
/

EXEC SP_EX1;


-- 2.사원번호 사원이름 부서명 부서위치를 출력하는 저장프로시져를 생성하시오.

CREATE OR REPLACE PROCEDURE SP_E2
IS
     CURSOR C2 IS 
    SELECT E.ENO ,E.ENAME , D.DNAME,D.LOC
    FROM EMPLOYEE E JOIN DEPARTMENT D
    ON E.DNO=D.DNO;
BEGIN 
    FOR C1RECODE IN C2 LOOP
        DBMS_OUTPUT.PUT_LINE(C1RECODE.ENO||'  '||C1RECODE.ENAME||'  '||C1RECODE.DNAME||'  '||C1RECODE.LOC);
    END LOOP;
END;
/
EXEC SP_E2;

--3. 급여를 입력 받아  입력받은 급여보다 높은 사원의 사원이름, 급여, 직책을 출력 하세요.

CREATE OR REPLACE PROCEDURE SP_E3(
    V_SALARY EMPLOYEE.SALARY%TYPE
)
IS
    V_EMP EMPLOYEE%ROWTYPE;
    CURSOR C1 IS
    SELECT ENAME, SALARY, JOB
    FROM EMPLOYEE
    WHERE SALARY>V_SALARY;
BEGIN
    DBMS_OUTPUT.PUT_LINE('사원이름   급여    직책');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    FOR C1RE IN C1 LOOP
        DBMS_OUTPUT.PUT_LINE(C1RE.ENAME||' '|| C1RE.SALARY||'  '|| C1RE.JOB);
    END LOOP;
END;
/

EXEC SP_E3(1700);

--4.인풋매개변수 EMP_C10, DEPT_C10 두개를 입력받아 각각 EMPLOYEE,DEPARTMENT 
--테이블을 복사하는 저장프로시저를 생성하세요
--GRANT CREATE TABLE TO PUBLIC 
--GRANT CREATE TABLE TO USER_TEST10;
 set serveroutput on
    create or replace procedure sp4(
        v_emp in varchar2,              -- 주의 : ',' 넣으면 안됨, 자료형의 크기를 지정하면 안됨
        v_dept in varchar2
    )
    
    is 
        c1 integer; -- 커서 변수 선언 -> Integer 타입으로 선언
        v_sql1 varchar2(500);   -- 테이블 생성 쿼리를 담을 변수
        v_sql2 varchar2(500); -- 
    begin
        v_sql1 := 'Create table ' || v_emp || ' as select * from employee';
        v_sql2 := 'Create table ' || v_dept || ' as select * from department';
        
        -- 커서 오픈
        c1 := DBMS_SQL.OPEN_CURSOR;
        -- 커서 적용
        DBMS_SQL.Parse (c1, v_sql1, dbms_sql.v7);
        DBMS_SQL.Parse (c1, v_sql2, dbms_sql.v7);
        -- 커서 닫기
        DBMS_SQL.close_cursor(c1);
        
    end;
    /
EXEC sp4('EMP_C11','DEPT_C11');

DROP TABLE EMP_C11;

----5.DEPT_C10 테이블에서 DNO,DNAME,LOC 컬럼의 값을 
--인풋받아 인풋받은 값을 INSERT하는 저장프로시져를 생성하시오.
CREATE OR REPLACE PROCEDURE SP_E5(
    V_DNO DEPT_C11.DNO%TYPE,
    V_DNAME DEPT_C11.DNAME%TYPE,
    V_LOC DEPT_C11.LOC%TYPE
)
IS 
BEGIN
    INSERT INTO DEPT_C11
    VALUES(V_DNO,V_DNAME,V_LOC);
END;
/
EXEC SP_E5(50,'HR','SEOUL');
SELECT * FROM DEPT_C11;

--9. 위의 두 테이블명을 인풋 받아 두 테이블을 삭제하는 저장프로시져를 생성 하시오. 

 set serveroutput on
    create or replace procedure sp_E9(
        v_emp in varchar2,              -- 주의 : ',' 넣으면 안됨, 자료형의 크기를 지정하면 안됨
        v_dept in varchar2
    )
    
    is 
        c1 integer; -- 커서 변수 선언 -> Integer 타입으로 선언
        v_sql1 varchar2(500);   -- 테이블 생성 쿼리를 담을 변수
        v_sql2 varchar2(500); -- 
    begin
        v_sql1 := 'DROP table ' || v_emp || ' as select * from employee';
        v_sql2 := 'DROP table ' || v_dept || ' as select * from department';
        
        -- 커서 오픈
        c1 := DBMS_SQL.OPEN_CURSOR;
        -- 커서 적용
        DBMS_SQL.Parse (c1, v_sql1, dbms_sql.v7);
        DBMS_SQL.Parse (c1, v_sql2, dbms_sql.v7);
        -- 커서 닫기
        DBMS_SQL.close_cursor(c1);
        
    end;
    /
    EXEC SP_E9('EMP_C11','DEPT_C11');
