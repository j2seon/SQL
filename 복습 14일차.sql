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



CREATE OR REPLACE PROCEDURE SP_E2



