------------------변수 선언 및 변수 값 출력---------------------------
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
 --변수 상수로 선언 > 값이 변하지 않음 CONSTANT
 --디폴트 지정
 --NOTNULL 지정
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

---------------------IF 문--------------------------- 
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
     dbms_output.put_line('홀수!');
     ELSE
     dbms_output.put_line('짝수');
    END IF;
END;
/

----------------------------반복문(LOOP)-------------------------------
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
BEGIN  --거꾸로는 FOR i IN REVERSE 1..3 LOOP
   FOR i IN 1..10 LOOP
   CONTINUE WHEN MOD(i,2)=1;   
    dbms_output.put_line('I! : '|| i);
    END LOOP;
END;
/


