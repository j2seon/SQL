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
    