--1.덧셈연산자를 사용하여 모든사원에 대해서 300 의 급여인상을 계산한 후 사원의 이름 급여 인상된 급여를 출력하세요
select ename,salary, salary+300 인상된급여
from employee;

--2.사원의 이름 급여 연간 총 수입이 많은 것부터 작은 순으로 출력하시오 연간 총 수입은 100 상여금을 더하시오.
select ename,salary, salary*12+100 연간총수입
from employee
order by salary desc , salary*12+100 desc;

--3.급여가 2000을 넘는 사원의 이름과 급여를 급여가 많은 것부터 작은순으로
select ename,salary
from employee
where salary>2000
order by salary desc ;

--4.사원번호가 7788인 사원의 이름과 부서번호를 출력
select ename, dno
from employee
where eno=7788;

--5.급여가 2000에서 3000사이에 포함되지 않는 사원의 이름 급여
select ename, salary
from employee
where salary not BETWEEN 2000 AND 3000 ;


--6. 1981/2/20~ 81/5/1 입사인원의 업무 입사일
select ename , job , hiredate
from employee
where hiredate between '81/02/20' and '81/05/01';

--7. 부서 번호가 20~30 에 속한 사원 이름 부서번호 이름 내림차순
select ename , dno
from employee
where dno between 20 and 30
order by ename desc;

--8. 사원의 급여가 2000 3000사이 번호가 20 30 인 이름 급여 부서번호 오름차순
select ename, salary, dno
from employee
where salary BETWEEN 2000 AND 3000 and(dno=20 or dno=30)
order by ename;

-- 9. 81입사한 사원의 이름과 입사일
select ename , hiredate
from employee
where hiredate like '81%';

--10. 관리자 가 없는 사원 이름 담당업무
select ename , job
from employee
where manager is null;

--11. 커미션을 받는 사원 이름의 급여 커머션 급여 커미션 기준 내림차순
select ename, salary, commission
from employee
where commission is not null
order by salary desc, commission desc;

--12. 
select ename
from employee
where ename like '__R%';

--13. 
select ename
from employee
where ename like '%A%'and ename LIKE '%E%';

--14. 
select ename, job, salary
from employee
where job in('CLERK','SALESMAN') and (salary= 1600 or salary=950 or salary=1300) ;

--15. 
select ename , salary , commission
from employee
where commission>=500 ;

select *
from employee;


-- 다양한 함수 사용하기
/*
1. 문자를 처리하는 함수
    1. 문자를 처리하는 함수 
    - UPPER :대문자로 변환
    - LOwer : 소문자로 변환
    - INITCAP : 첫자는 대문자로 나머지는 소문자로 변환
    dual 테이블 : 하나의 결과를 출력하도록하는 테이블
    
*/
select '안녕하세요' as 안녕
from dual;

select * from employee;

select ename , lower (ename), initcap(ename), upper(ename)
from employee;

select * 
from employee
where lower(ename) = 'allen'; --검색이 안됨

select * from employee
where initcap(ename)='Allen';

-- 문자 길이를 출력하는 함수 
 --length : 문자의 길이를 반환, 영문이나 한글 관계 없이 글자수를 리턴 1byte
 --lengthb : 문자의 길이를 반환, 한글 3 byte 로 반환,
 
 select length ('Oracle mania'), length('오라클매니아')
 from dual; 

 select lengthb ('Oracle mania'), lengthb('오라클매니아') 
 from dual; 

select ename, length(ename),job ,length(job) from employee;

-- 문자조작함수 
/*
 - concat : 문자와 문자를 연결
 - substr : 문자를 특정 위치에서 잘라오는 함수 (영문, 한글 모두 1byte로 처리)
 - substrb :문자를 특정 위치에서 잘라오는 함수 ( 영문은 1byte, 한글은 3byte로 처리)
 - instr : 문자의 특정 위치의 인덱스 값을 반환
 - instrb : 문자의 특정 위치의 인덱스 값을 반환( 영문은 1byte, 한글은 3byte로 처리)
 - lpad, rpad: 입력받은 문자열에서 특수한 문자를 적용.
 - trim : 잘라내고 남은 문자를 반환.
*/

select '안녕' ,'하세요', concat('안녕','하세요')
from dual;
select 'Oracle', 'mania', concat('Oracle', 'mania') 
from dual;

--substr (대상, 시작위치, 추출갯수) : 특정 위치에서 문자를 잘라온다.  

select '사과바나나오렌지', substr('사과바나나오렌지',3,3) 
from dual;
select 'Oracle mania', substr('Oracle mania',4,3) , substr('오라클 매니아',2,4)
from dual;

select '핸드폰1번',substr('010-3221-9382',-4,4) from dual;
select '무지개',substr('빨주노초파남보',-3,1) from dual; 
select 'Oracle mania', substr('Oracle mania',-4,3) , substr('오라클 매니아',-6,4)
from dual;

--이름 뜯어보기
select ename as 이름 , substr(ename,1,2) 성, substr(ename,-3,3)  
from employee;
select ename, substr(ename,2,3), substr(ename,-5,2) from employee;

select substrb ('Oracle mania',3,3),substrb('오라클 매니아', 4,6) from dual;

--이름이 N으로 끝나는 사원들 출력하기 (substr 함수를 사용)
SELECT ename 
from employee
where substr(ename,-1,1)='N';
-- like로 이름이 N으로 끝나는 사원들 출력
select ename 
from employee
where ename like '%N';

--87년도 입사한 사원들 출력하기 (substr 함수를 사용)
select * 
from employee
where substr(hiredate,1,2)=87;

select * from emloyee
where substr (hiredate,1,2)='87';

--instr (대상, 찾을 글자 , 시작위치, 몇 번째 발견) : 대상에서 찾을 글자의 인덱스 값을 출력.

select 'abcdefg', instr('abcdefg','d') from dual;
select 'abcdabcd' , instr('abcdabcd','c',2,2) from dual;
select 'Oracle mania', instr ('Oracle mania','a') from dual;
select 'Oracle mania', instr ('Oracle mania','a',5,2) from dual;

select 'Oracle mania', instr ('Oracle mania','a',-5,1) from dual;

select distinct instr(job,'A',1,1) 
from employee
where job ='MANAGER';



--lpad, rpad : 특정 길이만큼 문자열을 지정해서 왼쪽 ,오른족에 공백을 특정 문자로 처리 
    -- lpad(대상,늘려줄 문자열 크기 ,특수문자적용)
    -- 
select lpad ('1234',10,'#')from dual;
select rpad ('1234',10,'#')from dual;

select salary from employee;

select lpad(salary, 10, '*')from employee;


--trim :공백제거 특정문자도 제거 
  --LTRIM :왼쪽의 공백을 제거 
  --RTRIM :오른쪽의 공백을 제거 
  --TRIM : 왼쪽, 오른쪽 공백을 제거 
  
select ltrim ('   Oracle mania   ') a ,rtrim('   Oracle mania   ') b,trim('   Oracle mania   ') as c 
from dual;


select * from employee;
--||연결 시 사용 
select concat(ename,'  ' || job) from employee;

select '이름은 : ' || ename || ' 이고, 직책은 : ' ||job || ' 입니다.' as 컬럼연결
from employee; 

select '이름은 : ' || ename || '이고 , 직속상관 사번은 : ' || manager||' 입니다.' as 직속상관출력
from employee;
