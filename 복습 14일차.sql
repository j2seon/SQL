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



CREATE OR REPLACE PROCEDURE SP_E2



