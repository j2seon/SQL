-- 3일차 

-- 숫자함수 
/*
    ROUND : 특정 자릿수에서 반올림.
    TRUNC : 특정자리수에서 잘라낸다.(버린다.)
    MOD : 입력받은 수를 나눈 나머지 값만 출력
*/

--round (대상) : 소수점 아래자리에서 반올림! ex )98.7654-> 99
--round (대상, 소숫점 자리수) : 
        -- 양수 : 양수일때 소수점 오른쪽으로 이동한다. 오른쪽으로 자릿수만큼이동해서 그자릿수 뒤에서 반올림한다. < 
        -- 음수 : 음수일때 소수점 기준으로 왼쪽으로 이동. 왼쪽으로 자릿수만큼 이동하고 그 자릿수에서 반올림한다.
                                            -- ex)98.7654,2->98.77    -- 98인 8에서 반올림처리   
select 98.7654 as 숫자, Round(98.7654) round함수적용,round(98.7654,2),round(98.7654,-1),round(98.7654,-2)
        ,round(98.7654,-3) ,round(98.7654,3) 
from dual; 

select 1232.1212 , round(1232.1212),round(1232.1212,2),round(1232.1212,-1)
from dual;

select 12345.6789, round(12345.6789), round(12345.6789,-3), round(123678.123456,-3)
from dual;

--TRUNC : 버림
select 98.7654, Trunc(98.7654), Trunc(98.7654,2), Trunc(98.7654,-1)
from dual;

--MOD (대상, 나누는 수 ): 대상을 나누어서 나머지만 출력한다. 

select mod (31,2), mod(31,5),mod(31,8)
from dual;

select * from employee;

select salary, mod(salary, 300)
from employee;

--employee 테이블에서 사원번호가 짝수인 사원들만 출력
select *
FROM employee
where mod(eno,2)=0;

/* 날짜 함수 
    sysdate : 시스템에 저장된 현재날짜를 출력한다. < 제일 많이 사용
    months_between : 두 날짜 사이의 개월을 반환
    add_months : 특정날짜에 개월 수를 더한다.
    next_day : 특정날짜에서 최초로 도래하는 인자로 받은 요일의 날짜를 변환.
    last_day : 달의 마지막 날짜를 반환
    round : 인자로 받은 날짜를 특정 기준으로 반올림. 
    trunk : 인자로 받은 날짜를 특정기준으로 버림.
*/
--자신의 시스템의 현재 날짜 출력
select sysdate
from dual; 
--날짜에 연산을 적용할 수 있다. 
select sysdate -1 as 어제날짜, sysdate 오늘날짜 , sysdate+1 내일날짜
from dual;

select * from employee
order by hiredate asc;

select hiredate, hiredate-1 , hiredate+10 
from employee;

--근무일수 : 입사일에서부터 현재까지의 근무일수를 출력해라
select ename 사원명, round(sysdate-hiredate) 근무일수,round((sysdate-hiredate)/365) 근무년도
from employee
order by round((sysdate-hiredate)/365) desc, round(sysdate-hiredate) desc;

select ename 사원명, round((sysdate-hiredate),2) 근무일수
from employee;

select ename 사원명, trunc(sysdate-hiredate) 근무일수
from employee;

--특정날짜에서 월(month)을 기준으로 버림한 날짜 -> 월을 기준으로 했기 때문에 일이 01이 나온다.
select hiredate, trunc (hiredate,'MONTH')
from employee;

--round 월을 기준으로 반올림됨. 15일을 기준으로 
select hiredate, round (hiredate,'MONTH')
from employee;

select round (sysdate,'month') from dual;

--months_between(date1,date2) : date1과 date2 사이의 월의 개월 수를 출력 
-- 각 사원들의 근무한 개월 수 구하기 
select ename ,sysdate , hiredate, trunc(months_between(sysdate , hiredate))근무개월수
from employee;

--add_months (date1 , 개월수) : date1 날짜에 개월 수를 더한 날짜를 출력해줌.
select add_months(sysdate,5)
from dual;


-- 입사한 후 6개월이 지난시점은?
select ename ,hiredate, add_months(hiredate,6)
from employee;

--입사한 후 100일 이 자난 시점?
select ename ,hiredate, hiredate+100 as "100일이 되는 날짜"
from employee;

-- next_day(date,'요일') : date 에 도래하는 요일에 대한 날짜를 출력하는 함수
select sysdate, next_day(sysdate,'토요일')"이번주 토요일의 날짜"
from dual;

--last_day (date) :date에 들어간 달의 마지막 날짜를 출력
select hiredate, last_day(hiredate) 
from employee;

--(중요!!!)형 변환 함수
/*
    TO_CHAR : 날짜형 또는 숫자형을 문자형으로 변환하는 함수 
    TO_DATE : 문자형을 날짜 또는 숫자형으로 변환하는 함수 
    TO_NUMBER : 문자형을 숫자형으로 변환하는 함수.
*/

--날짜함수 사용해보기! 
--TO_CHAR(date,'yyyymmdd') day 는 요일을 출력 줄여서 dy로 사용가능

select ename , hiredate, to_char(hiredate,'yyyymmdd') , to_char(hiredate,'yymm'),
to_char(hiredate, 'yyyymmdd day'),to_char(hiredate ,'yyyymmdd dy')
from employee;

--오늘 날짜를 출력하고 시간 초까지 출력 
select sysdate 오늘날짜 , to_char(sysdate,'yyyy-mm-dd hh:mi:ss day')  
from dual;

select hiredate, to_char(hiredate,'yyyy_mm_dd hh:mi:ss day') 
from employee;


--to_char 에서 숫자와 관련된 형식
/*
 0 : 자리수를 나타내며 자리수가 맞지 않을 경우 0으로 채움.
 9 : 자리수를 나타내며 자리수가 맞지 않을 경우 채우지 않음.
 L : 각 지역별 통화 기호를 출력
 .: 소숫점으로 표현 
 ,: 천단위의 구분자
*/

desc employee;
--salary가 number 타입인데 변환시킨것
select ename , salary , to_char(salary, 'L999,999'), to_char(salary, 'L0000,000')
from employee;

--to_date('char','format') :날짜형식으로 변환.

--오류발생 sysdate는 날짜형이고 20000101이 char형이라서 연산이 안된다. (같은 형식으로 변환시켜야한다.)
select sysdate, sysdate-'20000101' 
from dual;

--20000101를 'YYYYMMDD'인 날짜형식으로 변환해줌 . 2000년 1월1일에서 오늘까지의 일수  
select sysdate, trunc(sysdate - to_date(20000101,'YYYYMMDD'))
from dual ;

select sysdate, trunc(sysdate-to_date(20200101,'yyyymmdd'))
from dual;

select sysdate, to_date('02/10/10','yy/mm/dd'), trunc(sysdate-to_date('021010','yymmdd'))
from dual;

select ename , hiredate 
from employee
where hiredate ='81/02/22';

--오류발생 > number 타입이라서! date 타입으로 바꿔야한다.
select ename , hiredate 
from employee
where hiredate =to_date(19810222,'yyyymmdd');

select ename, hiredate
from employee
where hiredate = '1981-02-22';

select ename, hiredate
from employee
where hiredate = to_date('1981-02-22', 'YYYY-mm-dd');

--2000년 12월 25일 부터 오늘까지     months_between : 두 날짜 사이의 개월을 반환

select months_between(sysdate,to_date(20220101,'yyyymmdd'))
from dual;

select trunc(months_between(sysdate,to_date(20001225,'yyyy-mm-dd'))) as months
from dual;


--to_date('format','char') :날짜형식으로 변환.
select sysdate, trunc(sysdate-to_date('021010','yymmdd'))
from dual;

--to_number : number 숫자 데이터타입으로 변환, 

 
select 100000 - 50000
from dual;

select to_number('100,000','999,999')-to_number('50,000','999,999')
from dual;

--오류발생 : 문자열 - 문자열 
select '100,000' - '50,000'
from dual ;

--NVL 함수 : null을 다른 값으로 치환해주는 함수 
    -- NVL(expr1,expr2) : expr1 에서 expr2로 치환

select commission, NVL(commission,0) 
from employee;

select manager
from employee;

select manager, NVL(manager, 1111)
from employee;

--NVL2 함수
 --nvl2(expr1,expr2,expr3) : expr1이 null이 아니면 exor2 를 출력, expr1이 null이면 expr2를 출력.
 
 select salary, commission
 from employee;
 
 --NVL 함수로 연봉 계산하기
 select salary,salary*12, salary*12+NVL(commission,0) as 연봉
 from employee;
 
 --NVL2 함수를 사용해서 연봉 계산하기 
 select salary, commission, NVL2(commission, salary*12+commission,salary*12) 연봉
 from employee;
 
 -- nullif:두표현식을 비교해서 동일한 경우 Null 을 반환하고 동일하지않은 경우 첫번째 표현식을 반환
    -- nullif(expr1,expr2) : 
 select nullif('A','A'), nullif('A','B')
 from dual;
 
 --coalesce 함수 
 coalesce(expr1,expr2,expr3.....expr-n) :
        -- expr1이 null이 아니면 expr1을 반환하고, 
        -- expr1이 null이고 exppr2가 null이 아니면 expr2를 반환하고 
        --expr1 이 null 이고 expr2가 null이고 expr3가 null이 아니면 expr3를 반환.

select coalesce('abc','bcd','def','efg')
from dual;

select coalesce(null,'bcd','def','efg')
from dual;

select coalesce(null,null,'def','efg')
from dual;

select ename, salary, commission, coalesce(commission,salary,0)
from employee;

--decode 함수 : switch case 문과 동일한 구문 
/*
DECODE (표현식, 조건1, 결과1, 
               조건2, 결과2,
               조건3, 결과3,
               기본결과n
*/

select ename,dno, decode(dno, 10,'ACCOUNTING',
                              20,'RESEARCH',
                              30, 'SALES',
                              40,'OPERATIONS',
                              'DEFAULTS') as DNAME
from employee;                              

--dno컬럼이 10번 부서일 경우 월급에서 +300 을 처리하고, 20일 경우 월급에 +500 , 부서번호가 30일 경우 월급에 +700을 해서 이름, 월급, 부서별 월급+
select * from employee;

select ename, salary, dno ,decode(dno ,10, salary+300,
                                       20, salary+500,
                                       30, salary+700) as 총합
                                
from employee
order by dno asc;

--case : if ~ else if, else if-- 쉽표가 없어야함!!!
    /*
        case 표현식  when 조건1 then 결과1
                         조건2 then 결과2
                         조건3 then 결과3
                         ELSE 결과n
        END
    */
  select ename , dno ,case when dno=10 then 'ACCOUNTING'
                           when dno=20 then 'RESEARCH'
                           when dno=30 then 'SALES'
                          ELSE 'DEFAULT'
                    end as 부서명
  from employee
  order by dno;