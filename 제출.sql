/*employee테이블의 eno,ename, salary, dno를 commission 1400인 것에 대해서 출력*/
 
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
    
    dbms_output.put_line('사원번호   사원명   연봉   부서번호');
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
     dbms_output.put_line('사원번호   사원명   연봉   부서번호');
     dbms_output.put_line('--------------------------------');
     dbms_output.put_line(v_employee.eno||'   '||v_employee.ename||'   '||v_employee.salary||'   '||v_employee.dno);
 end;
 /
    