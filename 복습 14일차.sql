--1.�� �μ����� �ּ� �޿�, �ִ�޿�, ��ձ޿��� ����ϴ� ���� ���ν����� �����Ͻÿ�.
        --�������� �����⶧���� Ŀ���� �ʿ��ϴ�.
SELECT * FROM EMPLOYEE;
SET SERVEROUTPUT ON        
CREATE OR REPLACE PROCEDURE SP_EX1
IS -- �������� , Ŀ�� ����
    V_DNO EMPLOYEE.DNO%TYPE;
    V_MIN EMPLOYEE.SALARY%TYPE;
    V_MAX EMPLOYEE.SALARY%TYPE;
    V_AVG EMPLOYEE.SALARY%TYPE;
    
    CURSOR C1 IS
    SELECT DNO, MIN(SALARY), MAX(SALARY),AVG(SALARY)
    FROM EMPLOYEE
    GROUP BY DNO;
    
BEGIN 
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ   �ּұ޿�    �ִ�޿�    ��ձ޿�');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    OPEN C1; --Ŀ�� ����
    LOOP
        FETCH C1 INTO V_DNO,V_MIN,V_MAX,V_AVG;
        EXIT WHEN C1%NOTFOUND; --���ڵ尡 �������� ������ ����������.
        DBMS_OUTPUT.PUT_LINE(V_DNO||'        '||V_MIN||'        '||V_MAX||'      '||V_AVG);
    END LOOP;
    CLOSE C1;
END;
/

EXEC SP_EX1;


-- 2.�����ȣ ����̸� �μ��� �μ���ġ�� ����ϴ� �������ν����� �����Ͻÿ�.

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

--3. �޿��� �Է� �޾�  �Է¹��� �޿����� ���� ����� ����̸�, �޿�, ��å�� ��� �ϼ���.

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
    DBMS_OUTPUT.PUT_LINE('����̸�   �޿�    ��å');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    FOR C1RE IN C1 LOOP
        DBMS_OUTPUT.PUT_LINE(C1RE.ENAME||' '|| C1RE.SALARY||'  '|| C1RE.JOB);
    END LOOP;
END;
/

EXEC SP_E3(1700);

--4.��ǲ�Ű����� EMP_C10, DEPT_C10 �ΰ��� �Է¹޾� ���� EMPLOYEE,DEPARTMENT 
--���̺��� �����ϴ� �������ν����� �����ϼ���
--GRANT CREATE TABLE TO PUBLIC 
--GRANT CREATE TABLE TO USER_TEST10;
 set serveroutput on
    create or replace procedure sp4(
        v_emp in varchar2,              -- ���� : ',' ������ �ȵ�, �ڷ����� ũ�⸦ �����ϸ� �ȵ�
        v_dept in varchar2
    )
    
    is 
        c1 integer; -- Ŀ�� ���� ���� -> Integer Ÿ������ ����
        v_sql1 varchar2(500);   -- ���̺� ���� ������ ���� ����
        v_sql2 varchar2(500); -- 
    begin
        v_sql1 := 'Create table ' || v_emp || ' as select * from employee';
        v_sql2 := 'Create table ' || v_dept || ' as select * from department';
        
        -- Ŀ�� ����
        c1 := DBMS_SQL.OPEN_CURSOR;
        -- Ŀ�� ����
        DBMS_SQL.Parse (c1, v_sql1, dbms_sql.v7);
        DBMS_SQL.Parse (c1, v_sql2, dbms_sql.v7);
        -- Ŀ�� �ݱ�
        DBMS_SQL.close_cursor(c1);
        
    end;
    /
EXEC sp4('EMP_C11','DEPT_C11');

DROP TABLE EMP_C11;

----5.DEPT_C10 ���̺��� DNO,DNAME,LOC �÷��� ���� 
--��ǲ�޾� ��ǲ���� ���� INSERT�ϴ� �������ν����� �����Ͻÿ�.
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

--9. ���� �� ���̺���� ��ǲ �޾� �� ���̺��� �����ϴ� �������ν����� ���� �Ͻÿ�. 

 set serveroutput on
    create or replace procedure sp_E9(
        v_emp in varchar2,              -- ���� : ',' ������ �ȵ�, �ڷ����� ũ�⸦ �����ϸ� �ȵ�
        v_dept in varchar2
    )
    
    is 
        c1 integer; -- Ŀ�� ���� ���� -> Integer Ÿ������ ����
        v_sql1 varchar2(500);   -- ���̺� ���� ������ ���� ����
        v_sql2 varchar2(500); -- 
    begin
        v_sql1 := 'DROP table ' || v_emp || ' as select * from employee';
        v_sql2 := 'DROP table ' || v_dept || ' as select * from department';
        
        -- Ŀ�� ����
        c1 := DBMS_SQL.OPEN_CURSOR;
        -- Ŀ�� ����
        DBMS_SQL.Parse (c1, v_sql1, dbms_sql.v7);
        DBMS_SQL.Parse (c1, v_sql2, dbms_sql.v7);
        -- Ŀ�� �ݱ�
        DBMS_SQL.close_cursor(c1);
        
    end;
    /
    EXEC SP_E9('EMP_C11','DEPT_C11');
