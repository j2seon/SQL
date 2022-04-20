--1.substr 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력하시오.
select * from employee;
select ename, substr(hiredate,1,5)
from employee;

--2. substr 함수를 사용하여 4월에 입사한 사원을 출력하시오.
select * 
FROM employee
where substr(hiredate,5,1)=4;

--3. mod 함수를 사용하여 직속상관이 홀수 인사원만 출력하시오.
select * 
from employee
where mod(manager,2) = 1; 

--3-1. mod 함수를 사용하여 월급이 3의 배수인 사원들만 출력하세요.
select * 
from employee
where mod(salary,3) = 0; 

--4. 입사한년도는 2자리 월을 mon으로 요일은 약어로 지정하여 출력
select ename ,to_char(hiredate,'yy-mm-dd dy') as 입사년도
from employee;

--5. 올해 몇일이 지났는지 출력하시오 현재 날짜에서 올해 1월 1일을 뺀 결과를 출력하고 Todate함수를 사용하여 데이터형식을 일치
select trunc(sysdate-to_date('22/01/01')) 
from dual;

--5-1. 자신이 태어난 날짜에서 현재까지 몇 일이 지났는지 출력 하세요. 
select trunc(sysdate-to_date('96/04/01')) as 일수
from dual;

--5-2. 자신이 태어난 날짜에서 현재까지 몇 개월이 지났는지 출력 하세요. 
select trunc(months_between(sysdate,to_date('96/04/01'))) as 개월
from dual;

--6. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 null 갑대신 0으로 출력 하시오. 
select ename ,NVL(manager,0) 상관id
from employee;


--7.  DECODE 함수로 직급에 따라 급여를 인상하도록 하시오. 직급이 'ANAIYST' 사원은 200 , 'SALESMAN' 사원은 180,
--    'MANAGER'인 사원은 150, 'CLERK'인 사원은 100을 인상하시오. 
select ename , job,salary ,decode(job , 'ANALYST', salary+200,
                          'SALESMAN' ,salary+180,
                          'MANAGER', salary+150,
                          'CLERK', salary+100,
                           salary) as 인상된급여결과
from employee;

--8. 사원번호 , 사원번호를 2자리만 출력하고 나머지는 별표 as 가린번호 , 이름, 이름의 첫자만 출력 총 4자리로 출력 세자리는 *로 가림
select eno, rpad(substr(eno,1,2),4,'*')가린번호 , ename, rpad(substr(ename,1,1),4,'*')가린이름
from employee; 

--9.주민번호 앞 6자리 801210-1******로 출력 ,전화번호 : 010-11****** 가려서 출력  
select rpad(substr('960401-2222222',1,8),14,'*')
from dual;

select rpad(substr('960401-2222222',1,8),14,'*')
from dual;
--10.사원번호,직속상관 , 직속상관의 사원번호가 없을 경우 : 0000으로(마지막 처리) 앞 두자리가 75일 경우 : 5555
                                            --76 :6666 , 77:7777 78 :8888로 출력
select eno , manager ,decode(substr(manager,1,2), 75,5555,
                                                 76,6666,
                                                 77,7777,
                                                 78,8888,
                                                    5555)
from employee;
        




