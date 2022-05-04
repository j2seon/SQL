--12일 차 - PL/SQL: 오라클에서 프로그래밍 요소를 적용한 SQL
    -- MSQL: T-SQL
    -- SQL : 구조화된 질의언어, 단점 : 유연한 프로그래밍 기능을 적용할 수 없다.
    
set serveroutput ON --PL/SQL의 출력을 활성화


/* PL/SQL의 기본작성 구문 
    begin(시작)
    -- PL/SQL 구문
    end;
    /
*/

--PL/SQL에서 기본 출력
set serveroutput ON ; -- 해당옵션을 줘야 출력이 된다!
begin 
    dbms_output.put_line('Welcome to Oracle'); --자바의 system.out.println와 같은 의미이다.
end ;
/

/*PL/SQL에서 변수 선언하기
     변수명:=변수 값  :=이 변수의 값을 할당할 때 사용한다.
     
     자료형 선언 
    1.Oracle 의 자료형을 사용.
    2.참조자료형 : 테이블의 컬럼의 선언된 자료형을 참조해서 사용.
        %type : 테이블의 틀정 컬럼의 자료형을 참조해서 사용. (테이블의 컬럼 1개 참조)
        %rowtype: 테이블 전체 컬럼의 자료형을 모두 참조해서 사용.
    
  */  
    
    desc employee;
set serveroutput on
declare --변수 선언(변수선언부)
    v_eno NUMBER(4);        --오라클의 자료형
    v_ename employee.ename%type; --참조 자료형 : 테이블의 컬럼의 자료형을 참조해서 적용 employee.ename%type >>> employee테이블의 ename의 type을 가져오겠다.
begin
    v_eno:=7788;       
    v_ename :='SCOTT';
    dbms_output.put_line('사원번호      사원이름');
    dbms_output.put_line('-------------------');
    dbms_output.put_line(V_eno ||'   '|| v_ename);
     end;
    /
/*사원번호와 사원이름 출력하기*/
set serveroutput on
declare
    v_eno employee.eno%type;
    v_ename employee.ename%type;
    begin
    dbms_output.put_line('사원번호      사원이름');
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
    
    /*PL/SQL 제어문 사용하기*/
    
    /*If ~ End if 문 사용하기*/
    set serveroutput on 
    declare 
    v_employee employee%rowtype; --rowtype : Employee 테이블의 모든 컬럼의 자료형을 참조해서 사용.
                                --V_employee 변수는 employee 테이블의 모든 컬럼을 참조.
    annsal number(7,2);          -- 총연봉을 저장하는 변수
    BEGIN
        select * into v_employee
        from employee
        where ename= 'SCOTT';
        
        if(v_employee.commission is null) then
        v_employee.commission:=0;
    end if;
    annsal := v_employee.salary*12+v_employee.commission;
    dbms_output.put_line('사원번호   사원이름   연봉' );
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
    
 /*PL/SQL을 사용해서 department 테이블을 변수에 담아서 출력해보세요
 조건은 dno =20인  */
    
    
  --1. %type : 변수 data type 을 테이블의 컬럼 하나하나를 참조해서 할당
set serveroutput on 
declare
    v_dno department.dno%type;
    v_dname department.dname%type;
    v_loc department.loc%type;
begin
    select dno, dname, loc into v_dno,v_dname,v_loc
    from department
    where dno=20;
    
    dbms_output.put_line('부서번호      부서명         위치');
    dbms_output.put_line('------------------------------'); 
    dbms_output.put_line(v_dno||' '||v_dname||' '||v_loc); 
    end;
    /
    
    --2%rowtype : 테이블의 모든컬럼을 참조해서 사용
set serveroutput on
declare
    v_department department%rowtype;
begin
    select dno, dname, loc into v_department
    from department
    where dno=20;
    
    dbms_output.put_line('부서번호      부서명         위치');
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
    
    dbms_output.put_line('사원번호   사원명   부서위치');
    dbms_output.put_line('------------------------------');
    dbms_output.put_line(v_eno || '   ' || v_ename || '   '|| v_dname);
    
    end;
    /
    
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
 
/* 커서 (cursor): PL/SQL에서 select 한 결과가 단일 레코드가 아니라 레코드셋인 경우에 커서가 필요하다.
 DECLARE
    CURSOR 커서명              1.커서 선언
    IS
    커서를 부착할 SELECT 구문
 BEGIN              
    OPEN 커서명                2. 커서 오픈
    LOOP
        FETCH 구문             3. 커서를 이동하고 출력 
    END LOOP;
    CLOSE 커서명;              4. 커서를 종료.
 END;
 /
*/ 

--커서를 사용해서 DEPARTMENT 테이블의 모든 내용을 출력하기

SET SERVEROUTPUT ON
DECLARE
    V_DEPT DEPARTMENT%ROWTYPE; -- 변수 선언
    CURSOR C1                   -- 1. 커서 선언
    IS
    SELECT * FROM department;
BEGIN
    DBMS_OUTPUT.PUT_LINE('부서번호   부서명   부서위치');
    DBMS_OUTPUT.PUT_LINE('---------------------------');
    OPEN C1;                    --2. 커서 오픈
    LOOP
        FETCH C1 INTO V_DEPT.DNO,V_DEPT.DNAME,V_DEPT.LOC;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V_DEPT.DNO||'  '||V_DEPT.DNAME||'  '||V_DEPT.LOC);
    END LOOP;
    CLOSE C1 ;                  --4. 커서 종료
END;
/

/*커서의 속성을 나타내는 속성값 
    커서명%NOTFOUND : 커서영역 내의 모든 자료가 FETCH 되었다면 TRUE
    커서명%FOUND : 커서영역 내의 FETCH 되지 않은 자료가 존재하면 TRUE 
    커서명%ISOPEN: 커서가 오픈되었다면 
    커서명%ROWCOUNT : 커서가 얻어온 레코드 갯수 
*/
    
/*
    사원명ENAME, 부서명DNAME,부서위치LOC , 월급 을 출력하는  PL/SQL을 사용해서 출력
*/

--ROWTYPE 를 사용해서 처리
SET SERVEROUTPUT ON
DECLARE
    V_EMP EMPLOYEE%ROWTYPE;
    V_DEP DEPARTMENT%ROWTYPE;

    CURSOR C2 IS
    SELECT ENAME, DNAME ,LOC, SALARY
    FROM EMPLOYEE E , department D 
    WHERE E.DNO=D.DNO;
BEGIN
    DBMS_OUTPUT.PUT_LINE('사원명   부서명   부서위치   월급');
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

/*cursor for loop문으로 커서를 사용해서 여러 레코드셋 출력 하기
    - open, close를 생략해서 사용
    - 한 테이블의 전체내용을 출력할 때 사용.
*/
set serveroutput on
declare 
    V_DEPT DEPARTMENT%ROWTYPE;
    CURSOR C1 IS
    SELECT * FROM DEPARTMENT;
begin 
    DBMS_OUTPUT.PUT_LINE('부서번호      부서명     지역명');
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    