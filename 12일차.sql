--12�� �� - PL/SQL: ����Ŭ���� ���α׷��� ��Ҹ� ������ SQL
    -- MSQL: T-SQL
    -- SQL : ����ȭ�� ���Ǿ��, ���� : ������ ���α׷��� ����� ������ �� ����.
    
set serveroutput ON --PL/SQL�� ����� Ȱ��ȭ


/* PL/SQL�� �⺻�ۼ� ���� 
    begin(����)
    -- PL/SQL ����
    end;
    /
*/

--PL/SQL���� �⺻ ���
set serveroutput ON ; -- �ش�ɼ��� ��� ����� �ȴ�!
begin 
    dbms_output.put_line('Welcome to Oracle'); --�ڹ��� system.out.println�� ���� �ǹ��̴�.
end ;
/

/*PL/SQL���� ���� �����ϱ�
     ������:=���� ��  :=�� ������ ���� �Ҵ��� �� ����Ѵ�.
     
     �ڷ��� ���� 
    1.Oracle �� �ڷ����� ���.
    2.�����ڷ��� : ���̺��� �÷��� ����� �ڷ����� �����ؼ� ���.
        %type : ���̺��� Ʋ�� �÷��� �ڷ����� �����ؼ� ���. (���̺��� �÷� 1�� ����)
        %rowtype: ���̺� ��ü �÷��� �ڷ����� ��� �����ؼ� ���.
    
  */  
    
    desc employee;
set serveroutput on
declare --���� ����(���������)
    v_eno NUMBER(4);        --����Ŭ�� �ڷ���
    v_ename employee.ename%type; --���� �ڷ��� : ���̺��� �÷��� �ڷ����� �����ؼ� ���� employee.ename%type >>> employee���̺��� ename�� type�� �������ڴ�.
begin
    v_eno:=7788;       
    v_ename :='SCOTT';
    dbms_output.put_line('�����ȣ      ����̸�');
    dbms_output.put_line('-------------------');
    dbms_output.put_line(V_eno ||'   '|| v_ename);
     end;
    /
/*�����ȣ�� ����̸� ����ϱ�*/
set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    begin
    dbms_output.put_line('�����ȣ      ����̸�');
    dbms_output.put_line('-------------------');
    select eno,ename into v_eno,v_ename
    from employee
    where ename = 'SCOTT';
    dbms_output.put_line(v_eno ||'   '|| v_ename);
    end;
    /
    
    select eno,ename
    from employee
    where ename= 'SCOTT';
    
    /*PL/SQL ��� ����ϱ�*/
    
    /*If ~ End if �� ����ϱ�*/
    set serveroutput on 
    declare 
    v_employee employee%rowtype; --rowtype : Employee ���̺��� ��� �÷��� �ڷ����� �����ؼ� ���.
                                --V_employee ������ employee ���̺��� ��� �÷��� ����.
    annsal number(7,2);          -- �ѿ����� �����ϴ� ����
    BEGIN
        select * into v_employee
        from employee
        where ename= 'SCOTT';
        
        if(v_employee.commission is null) then
        v_employee.commission:=0;
    end if;
    annsal := v_employee.salary*12+v_employee.commission;
    dbms_output.put_line('�����ȣ   ����̸�   ����' );
    dbms_output.put_line('--------------------------');
    dbms_output.put_line(v_employee.eno||'   '|| v_employee.ename|| '    ' ||annsal);
    end ;
    /
    
    /*
        v_employee.eno :=7788
        v_employee.ename := 'SCOTT'
        v_employee.job:=ANALYST
        v_employee.manager :=7566
        v_employee.hiredate :=87/07/03
        v_employee.dno :=
        v_employee.salary :=
    
    */
    select * from employee 
    where ename = 'SCOTT';
    
 /*PL/SQL�� ����ؼ� department ���̺��� ������ ��Ƽ� ����غ�����
 ������ dno =20��  */
    
    
  --1. %type : ���� data type �� ���̺��� �÷� �ϳ��ϳ��� �����ؼ� �Ҵ�
set serveroutput on 
declare
    v_dno department.dno%type;
    v_dname department.dname%type;
    v_loc department.loc%type;
begin
    select dno, dname, loc into v_dno,v_dname,v_loc
    from department
    where dno=20;
    
    dbms_output.put_line('�μ���ȣ      �μ���         ��ġ');
    dbms_output.put_line('------------------------------'); 
    dbms_output.put_line(v_dno||' '||v_dname||' '||v_loc); 
    end;
    /
    
    --2%rowtype : ���̺��� ����÷��� �����ؼ� ���
set serveroutput on
declare
    v_department department%rowtype;
begin
    select dno, dname, loc into v_department
    from department
    where dno=20;
    
    dbms_output.put_line('�μ���ȣ      �μ���         ��ġ');
    dbms_output.put_line('------------------------------'); 
    dbms_output.put_line(v_department.dno||'    '||v_department.dname||'     '||v_department.loc); 
    
    end;
    /
    
--lf ~ elslf ~ end if
set SERVEROUTPUT on
declare
    v_eno employee.eno%type;
    v_ename employee.ename% type;
    v_dno employee.dno%type;
    v_dname department.dname%type := null;
BEGIN
    select eno , ename , dno into v_eno , v_ename , v_dno
    from employee
    where ename = 'SCOTT';
  
    if(v_dno=10) then
        v_dname := 'ACCOUNT';
    elsif(v_dno=20) then
        v_dname :='RESEARCH';
    elsif(v_dno=30) then
        v_dname :='SALES';
    elsif(v_dno=40) then
        v_dname := 'OPERATIONS';
    end if; 
    
    dbms_output.put_line('�����ȣ   �����   �μ���ġ');
    dbms_output.put_line('------------------------------');
    dbms_output.put_line(v_eno || '   ' || v_ename || '   '|| v_dname);
    
    end;
    /
    
/*employee���̺��� eno,ename, salary, dno�� commission 1400�� �Ϳ� ���ؼ� ���*/
 
 -- 1. %type
set SERVEROUTPUT on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    v_salary employee.salary%type;
    v_dno employee.dno%type;
BEGIN
    select eno,ename,salary,dno into v_eno,v_ename,v_salary,v_dno
    from employee
    where commission =1400;
    
    dbms_output.put_line('�����ȣ   �����   ����   �μ���ȣ');
    dbms_output.put_line('--------------------------------');
    dbms_output.put_line(v_eno||'   '||v_ename||'   '||v_salary||'   '||v_dno);
end;
/
 --2.%rowtype
 
 set serveroutput on
 declare
      v_employee employee%rowtype;
 begin
    select * into v_employee
    from employee
    where commission =1400;
     dbms_output.put_line('�����ȣ   �����   ����   �μ���ȣ');
     dbms_output.put_line('--------------------------------');
     dbms_output.put_line(v_employee.eno||'   '||v_employee.ename||'   '||v_employee.salary||'   '||v_employee.dno);
 end;
 /
 
/* Ŀ�� (cursor): PL/SQL���� select �� ����� ���� ���ڵ尡 �ƴ϶� ���ڵ���� ��쿡 Ŀ���� �ʿ��ϴ�.
 DECLARE
    CURSOR Ŀ����              1.Ŀ�� ����
    IS
    Ŀ���� ������ SELECT ����
 BEGIN              
    OPEN Ŀ����                2. Ŀ�� ����
    LOOP
        FETCH ����             3. Ŀ���� �̵��ϰ� ��� 
    END LOOP;
    CLOSE Ŀ����;              4. Ŀ���� ����.
 END;
 /
*/ 

--Ŀ���� ����ؼ� DEPARTMENT ���̺��� ��� ������ ����ϱ�

SET SERVEROUTPUT ON
DECLARE
    V_DEPT DEPARTMENT%ROWTYPE; -- ���� ����
    CURSOR C1                   -- 1. Ŀ�� ����
    IS
    SELECT * FROM department;
BEGIN
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ   �μ���   �μ���ġ');
    DBMS_OUTPUT.PUT_LINE('---------------------------');
    OPEN C1;                    --2. Ŀ�� ����
    LOOP
        FETCH C1 INTO V_DEPT.DNO,V_DEPT.DNAME,V_DEPT.LOC;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V_DEPT.DNO||'  '||V_DEPT.DNAME||'  '||V_DEPT.LOC);
    END LOOP;
    CLOSE C1 ;                  --4. Ŀ�� ����
END;
/

/*Ŀ���� �Ӽ��� ��Ÿ���� �Ӽ��� 
    Ŀ����%NOTFOUND : Ŀ������ ���� ��� �ڷᰡ FETCH �Ǿ��ٸ� TRUE
    Ŀ����%FOUND : Ŀ������ ���� FETCH ���� ���� �ڷᰡ �����ϸ� TRUE 
    Ŀ����%ISOPEN: Ŀ���� ���µǾ��ٸ� 
    Ŀ����%ROWCOUNT : Ŀ���� ���� ���ڵ� ���� 
*/
    
/*
    �����ENAME, �μ���DNAME,�μ���ġLOC , ���� �� ����ϴ�  PL/SQL�� ����ؼ� ���
*/

--ROWTYPE �� ����ؼ� ó��
SET SERVEROUTPUT ON
DECLARE
    V_EMP EMPLOYEE%ROWTYPE;
    V_DEP DEPARTMENT%ROWTYPE;

    CURSOR C2 IS
    SELECT ENAME, DNAME ,LOC, SALARY
    FROM EMPLOYEE E , department D 
    WHERE E.DNO=D.DNO;
BEGIN
    DBMS_OUTPUT.PUT_LINE('�����   �μ���   �μ���ġ   ����');
    DBMS_OUTPUT.PUT_LINE('---------------------------');
    OPEN C2;
    LOOP 
        FETCH C2 INTO V_EMP.ENAME, V_DEP.DNAME, V_DEP.LOC , V_EMP.SALARY;
        EXIT WHEN C2%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V_EMP.ENAME||'   '||V_DEP.DNAME||'   '||V_DEP.LOC||'   '||V_EMP.SALARY);
    END LOOP;
    CLOSE C2;
END;
/

/*cursor for loop������ Ŀ���� ����ؼ� ���� ���ڵ�� ��� �ϱ�
    - open, close�� �����ؼ� ���
    - �� ���̺��� ��ü������ ����� �� ���.
*/
set serveroutput on
declare 
    V_DEPT DEPARTMENT%ROWTYPE;
    CURSOR C1 IS
    SELECT * FROM DEPARTMENT;
begin 
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ      �μ���     ������');
    DBMS_OUTPUT.PUT_LINE('-------------------------------');
    FOR D_DEPT IN C1 LOOP
        DBMS_OUTPUT.PUT_LINE(D_DEPT.DNO || '    '||D_DEPT.DNAME||'      '|| D_DEPT.LOC );
    END LOOP;
end;
/

SET SERVEROUTPUT ON
DECLARE
    V_EMPT EMPLOYEE%ROWTYPE;
    CURSOR C2 IS 
    SELECT * FROM EMPLOYEE;
BEGIN
    FOR C2_RE IN C2 LOOP
    DBMS_OUTPUT.PUT_LINE(C2_RE.ENO||' '||C2_RE.ENAME||' '||C2_RE.SALARY||' '||C2_RE.DNO);   
    END LOOP;
END;
/
SELECT * FROM EMPLOYEE;
    
SET SERVEROUTPUT ON
DECLARE
    V_EMPT EMPLOYEE%ROWTYPE;
    CURSOR C3 IS 
    SELECT * FROM EMPLOYEE
    WHERE DNO IN ('10','20')
    AND SALARY>=2000;
BEGIN
    FOR V_EMPT IN C3 LOOP
    DBMS_OUTPUT.PUT_LINE(V_EMPT.ENO||' '||V_EMPT.ENAME||' '||V_EMPT.SALARY||' '||V_EMPT.DNO);   
    END LOOP;
END;
/

SELECT * FROM EMPLOYEE;   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    