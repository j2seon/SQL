--13���� - ���� ���ν��� (STROED PROCEDURE), �Լ� (FUNCTION), Ʈ����(TRIGGER)

/*
    �������ν����� ����
        1. PL/SQL �� ��밡���ϴ� . �ڵ�ȭ
        2. ������ ������.
            �Ϲ����� SQL���� : �����м� -> ��ü�̸�Ȯ�� ->������Ȯ�� ->����ȭ->������ ->����
            �������ν��� ó������ : �����м� -> ��ü�̸�Ȯ�� ->������Ȯ�� ->����ȭ->������ ->����
            �������ν��� �ι�°���ͽ��� : ������(�޸𸮿� �ε�)�� �ٷ� ����ȴ�. >>������
        3. �Է� �Ű�����,��� �Ű������� ����� �� �ִ�.
        4. �Ϸ��� �۾��� ��� ���� (���ȭ�� ���α׷����� �����ϴ�.)
*/

--1. �������ν��� ����.
    --SOCTT ����� ������ ����ϴ� ���� ���ν���
CREATE PROCEDURE SP_SALARY
IS 
    V_SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT SALARY INTO V_SALARY
    FROM EMPLOYEE 
    WHERE ENAME='SCOTT';

    DBMS_OUTPUT.PUT_LINE('SCOOT�� �޿��� : '|| V_SALARY||'�Դϴ�');
END;
/
   
/*���� ���ν��� ������ Ȯ���ϴ� ������ ����*/
SELECT * FROM USER_SOURCE
WHERE NAME='SP_SALARY';

--2. �������ν��� ����
EXECUTE SP_SALARY;      -- ��ü�̸�
EXEC SP_SALARY;         -- ����̸�

--3. �������ν��� ����
CREATE OR REPLACE PROCEDURE SP_SALARY -- SP_SALARY�� �������� ������ ����, �����ϸ� ����.
IS 
    V_SALARY EMPLOYEE.SALARY%TYPE;
    V_COMMISSION EMPLOYEE.COMMISSION%TYPE;
BEGIN
    SELECT SALARY, COMMISSION INTO V_SALARY, V_COMMISSION
    FROM EMPLOYEE 
    WHERE ENAME='SCOTT';

    DBMS_OUTPUT.PUT_LINE('SCOOT�� �޿��� : '|| V_SALARY||'���ʽ��� : '||V_COMMISSION||'�Դϴ�');
END;
/
EXEC SP_SALARY;

--4. �������ν��� ���� 
DROP PROCEDURE SP_SALARY;
    
------------<��ǲ �Ű������� ó���ϴ� ���� ���ν���>>---------------------    
CREATE OR REPLACE PROCEDURE SP_SALARY_ENAME(  --�Է¸Ű�����(IN), ��� �Ű�����(OUT)�� �����Ѵ�.
    V_ENAME IN EMPLOYEE.ENAME%TYPE --������ IN �ڷ��� <=���� :<<;�� ����ϸ� �ȵȴ�.>>  
)
IS      --��������(�������ν������� ����� ���� ����)
        V_SALARY EMPLOYEE.SALARY%TYPE;
BEGIN 
    SELECT SALARY INTO V_SALARY
    FROM EMPLOYEE
    WHERE ENAME = V_ENAME; -- ��ǲ�Ű����� : V_ENAME
    DBMS_OUTPUT.PUT_LINE(V_ENAME || '�� �޿��� '||V_SALARY || '�Դϴ�.');  
END;
/
EXEC SP_SALARY_ENAME('SCOTT');
EXEC SP_SALARY_ENAME('SMITH');

SELECT * FROM EMPLOYEE;


/*�μ���ȣ�� INPUT �޾Ƽ� �̸� ��å �μ���ȣ �÷��� ����ϴ� ���� ���ν��� ����*/

CREATE OR REPLACE PROCEDURE SP_DNO(
    V_DNO IN EMPLOYEE.DNO%TYPE
)
IS
    CURSOR C1 IS
    SELECT ENAME,JOB,DNO FROM EMPLOYEE
    WHERE DNO=V_DNO;
BEGIN
     DBMS_OUTPUT.PUT_LINE('����̸�'||'    '||'��å'||'    '||'�μ���ȣ');
    FOR C1_RE IN C1 LOOP
     DBMS_OUTPUT.PUT_LINE(C1_RE.ENAME||'    '||C1_RE.JOB||'    '||C1_RE.DNO);
    END LOOP;
END;
/

EXEC SP_DNO(10);


/*���̺� �̸��� ��ǲ �޾Ƽ� EMPLOYEE ���̺��� �����ؼ� �����ϴ� �������ν����� �����ϼ���*/

/*�������ν����� ����ؼ� ���̺� ����*/
CREATE OR REPLACE PROCEDURE SP_CREATETABLE(
    V_NAME IN VARCHAR2 --�ڸ����� �Ҵ����� �ʰ�! 
)
IS
    CURSOR1 INTEGER;
    V_SQL VARCHAR2(100) ; --SQL ������ �����ϴ� ����
BEGIN
    V_SQL := 'CREATE TABLE '||V_NAME|| ' AS SELECT * FROM EMPLOYEE'; --���̺� ���������� ������ �Ҵ�
    CURSOR1 := DBMS_SQL.OPEN_CURSOR;  --Ŀ�����
    DBMS_SQL.PARSE(CURSOR1, V_SQL, DBMS_SQL.V7); --Ŀ���� ����ؼ� SQL������ ����.
    DBMS_SQL.CLOSE_CURSOR(CURSOR1); --Ŀ������
END;
/
GRANT CREATE TABLE TO PUBLIC;--SYS �������� ���� : ���� �Ҵ��ϴ� ������

EXEC SP_CREATETABLE('EMP_COPY33');

SELECT * FROM EMP_COPY33;
    
------------------<��¸Ű����� ���>-------------------------------    
/* �������ν��� : ��� �Ű����� ����(������), �Լ�: ��¸Ű������� �ϳ��� ������.
    OUT Ű���� ���.
    ���� ���ν����� ȣ��� ���� ��� �Ű����� �������� �� ȣ���� ����.
    ȣ��� ��¸Ű����� �̸��տ� ':������(��¸Ű�������)'
    ��¸Ű������� ����ϱ����ؼ� PRINT ��ɹ��̳� PL/SQL�� ����ؼ� ����� �� �ִ�.
*/

CREATE OR REPLACE PROCEDURE SP_SALARY_ENAME2 ( --�Է�/��� �Ű����� ����� 
    V_ENAME IN EMPLOYEE.ENAME%TYPE, --�Է¸Ű�����
    V_SALARY OUT EMPLOYEE.SALARY%TYPE --��¸Ű�����
    )
IS
BEGIN
    SELECT SALARY INTO V_SALARY 
    FROM EMPLOYEE 
    WHERE ENAME=V_ENAME;
END;
/
--�ּ�ó�� ���� --ȣ��ο��� �ƿ�ǲ �Ű������� ����-- :VAR_SALARY <== : ���� 
SELECT * FROM USER_SOURCE WHERE NAME='SP_SALARY_ENAME2'; --������ �������� Ȯ�� 
VARIABLE VAR_SALARY VARCHAR2(50);
EXEC SP_SALARY_ENAME2('SCOTT', :VAR_SALARY); 
PRINT VAR_SALARY;
    
    
--OUT �Ķ���͸� ������ ������ �������ν��� ���� �� ���(PL/SQL) 
-- �����ȣ�� ��ǲ�޾Ƽ� ����̸�, �޿� ����, ��å�� OUT �Ķ���Ϳ� �Ѱ��ִ� ���ν����� PL/SQL�� ����ؼ� ���.

/*
CREATE OR REPLACE PROCEDURE SEL_EMPNO( -- IN, OUT : �ڷ����� �����ڷ��� (%TYPE),
    V_ENO IN NUMBER,                    --�⺻�ڷ��� ����Ʈ�� ����.
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
create or replace procedure SEL_EMPNO (  -- In, Out: �ڷ����� �����ڷ��� (%type) , �⺻ �ڷ����� ��� ����Ʈ�� ����
    v_eno in number,
    v_ename out varchar2,
    v_sal out number,
    v_job out varchar2
)
is  
begin
    select ename, salary , job into v_ename, v_sal, v_job  -- ȣ���ϴ� ������ �ٽ� ������
    from employee
    where eno = v_eno;
end;
/
    
--PL/SQL�� ����ؼ� ���� ���ν��� ȣ��
DECLARE
    VAR_ENAME VARCHAR2(50);
    VAR_SAL NUMBER;
    VAR_JOB VARCHAR2(50);
BEGIN
    --�͸� ��Ͽ����� �������ν��� ȣ�� �� EXEC�� ������ �ʴ´�.
    SEL_EMPNO(7788,VAR_ENAME,VAR_SAL,VAR_JOB); --�������ν��� ȣ��
    DBMS_OUTPUT.PUT_LINE('��ȸ��� : '||VAR_ENAME || '  '||VAR_SAL||'  '||VAR_JOB);
END;
/


/*�Լ� (FUNCTION): ���� �־ �ϳ��� ���� ��ȯ�޾ƿ´�.  <==SQL���������� ��밡��
    --��, �������ν����� OUT �Ű������� ������ ��ȯ�޾ƿ� �� �ִ�.<==SQL������������ ��� �Ұ�.
*/
CREATE OR REPLACE FUNCTION FN_SALARY_ENAME( --��ǲ�Ű����� 
    V_ENAME IN EMPLOYEE.ENAME%TYPE
)
RETURN NUMBER       --ȣ���ϴ� ������ ���� ������.
IS
    V_SALARY NUMBER(7,2);
BEGIN
    SELECT SALARY INTO V_SALARY
    FROM EMPLOYEE 
    WHERE ENAME = V_ENAME; --��ǲ�Ű�����
    RETURN V_SALARY;
END;
/

/*�Լ��� �����ͻ���*/
SELECT * FROM USER_SOURCE
WHERE NAME = 'FN_SALARY_ENAME';

--1.�Լ���� 
VARIABLE VAR_SALARY NUMBER;
EXEC :VAR_SALARY:=FN_SALARY_ENAME('SCOTT');
PRINT VAR_SALARY;

--2. �Լ���� (SQL ���������� �Լ����) << ���ν����� �Ұ���
SELECT ENAME, FN_SALARY_ENAME('SCOTT') AS ����
FROM EMPLOYEE 
WHERE ENAME = 'SCOTT';

--3.�Լ����� 
DROP FUNCTION FN_SALARY_ENAME;
