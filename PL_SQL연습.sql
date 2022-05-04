------------------���� ���� �� ���� �� ���---------------------------
SET SERVEROUTPUT ON
DECLARE
    V_EMPO NUMBER(4) :=7788;
    V_ENAME VARCHAR2(10);
BEGIN
    V_ENAME :='SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_EMPO : '||V_EMPO);
        DBMS_OUTPUT.PUT_LINE('V_ENAME : '||V_ENAME);
END;
 /
 --���� ����� ���� > ���� ������ ���� CONSTANT
 --����Ʈ ����
 --NOTNULL ����
SET SERVEROUTPUT ON
DECLARE
    V_EMPO CONSTANT NUMBER(4) :=7788;   
    V_DNO NUMBER(4) DEFAULT 10;
    V_ENO NUMBER(4) NOT NULL :=11;
    V_ED VARCHAR2(30) NOT NULL DEFAULT 'DD';
BEGIN 
    DBMS_OUTPUT.PUT_LINE('V_EMPO : '||V_EMPO);
    DBMS_OUTPUT.PUT_LINE('V_DNO : '||V_DNO);
    DBMS_OUTPUT.PUT_LINE('V_ENO : '||V_ENO);
    DBMS_OUTPUT.PUT_LINE('V_ED : '||V_ED);    
END;
/

---------------------IF ��--------------------------- 
DECLARE 
    V_EMPO EMPLOYEE%ROWTYPE;
    V_SUM NUMBER(5);
BEGIN 
    SELECT * INTO V_EMPO 
    FROM EMPLOYEE
    WHERE ENAME = 'SCOTT';
    
    IF(V_EMPO.COMMISSION IS NULL) THEN
    V_EMPO.COMMISSION :=0;
    END IF;
    V_SUM := V_EMPO.SALARY*12;
    dbms_output.put_line(V_EMPO.ENAME || ' '||V_SUM); 
END;
/
DECLARE 
    V_NUM NUMBER :=13;
BEGIN
    IF MOD(V_NUM,2) =1 THEN
     dbms_output.put_line('Ȧ��!');
     ELSE
     dbms_output.put_line('¦��');
    END IF;
END;
/

----------------------------�ݺ���(LOOP)-------------------------------
DECLARE 
    V_NUM NUMBER :=0;
BEGIN
    LOOP
    dbms_output.put_line('V_NUM! : '|| V_NUM);
    V_NUM :=V_NUM+1;
    EXIT WHEN V_NUM=4;
    END LOOP;
END;
/
----------------------------WHILE------------------------------------
DECLARE 
    V_NUM NUMBER :=0;
BEGIN
    WHILE V_NUM<5 LOOP
    dbms_output.put_line('V_NUM! : '|| V_NUM);
    V_NUM :=V_NUM+1;
    END LOOP;
END;
/
----------------------------FOR LOOP-------------------------
BEGIN  --�Ųٷδ� FOR i IN REVERSE 1..3 LOOP
   FOR i IN 1..10 LOOP
   CONTINUE WHEN MOD(i,2)=1;   
    dbms_output.put_line('I! : '|| i);
    END LOOP;
END;
/
----------------------------CURSOR--------------------------
DECLARE
    V_DEPT DEPARTMENT%ROWTYPE;
    CURSOR CUR1 IS
    SELECT * FROM DEPARTMENT;
BEGIN
    OPEN CUR1;
    LOOP
        FETCH CUR1 INTO V_DEPT;
        EXIT WHEN CUR1%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(V_DEPT.DNO||'  '||V_DEPT.DNAME||'  '||V_DEPT.LOC);
    END LOOP;
END;
/
    
--------------------------FOR LOOP------------------------
DECLARE
    V_EMPO EMPLOYEE%ROWTYPE;
    CURSOR C1 IS
    SELECT * FROM EMPLOYEE
    WHERE DNO=20;
BEGIN
    FOR V_EMPO IN C1 LOOP
    DBMS_OUTPUT.PUT_LINE(V_EMPO.ENO||'  '||V_EMPO.ENAME||'  '||V_EMPO.SALARY);
    END LOOP;
END;


--------------------------���ν���--------------------------
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE SP_SALARY1
IS
    V_EMPO EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT SALARY INTO V_EMPO
    FROM EMPLOYEE
    WHERE ENAME = 'SCOTT';
    
    DBMS_OUTPUT.PUT_LINE('SCOOT�� �޿��� : '||V_EMPO||'�Դϴ�');
END;
/

EXEC SP_SALARY1;

----------------------------��ǲ�Ű����� ���ν���-------------------
CREATE OR REPLACE PROCEDURE SP_IN(
    V_ENAME EMPLOYEE.ENAME%TYPE
)
IS
    V_EMPO EMPLOYEE%ROWTYPE;
BEGIN 
    SELECT * INTO V_EMPO
    FROM EMPLOYEE
    WHERE ENAME=V_ENAME;
    DBMS_OUTPUT.PUT_LINE(V_ENAME || '�� �޿��� '||V_EMPO.SALARY || '�Դϴ�.');  
END;
/
EXEC SP_IN('SCOTT');

--------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SP_DNO1(
    V_DNO IN EMPLOYEE.DNO%TYPE
)
IS
    V_EMPO EMPLOYEE%ROWTYPE;
    CURSOR C1 IS
    SELECT * FROM EMPLOYEE
    WHERE DNO=V_DNO;
BEGIN
    DBMS_OUTPUT.PUT_LINE('����̸�'||'    '||'��å'||'    '||'�μ���ȣ');
    FOR V_EMPO IN C1 LOOP
    DBMS_OUTPUT.PUT_LINE(V_EMPO.ENAME||'    '||V_EMPO.JOB||'    '||V_EMPO.DNO);
END LOOP;
END;
/
EXEC SP_DNO1(10);

--------------------------���̺� ���� -------------------------
CREATE OR REPLACE PROCEDURE SP_CREATETB(
    V_NAME IN VARCHAR2
)
IS 
    CURSORID INTEGER; 
    V_SQL VARCHAR2(100);
BEGIN 
    V_SQL := 'CREATE TABLE'||V_NAME||'AS SELECT * FROM EMPLOYEE';
    CURSORID := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(CURSORID , V_SQL, DBMS_SQL.V7);
    DBMS_SQL.CLOSE_CURSOR(CURSORID);
END;
/
GRANT CREATE TABLE TO PUBLIC;

EXEC SP_CREATETB('EMP_COPY77');






