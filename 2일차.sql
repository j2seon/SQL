
--desc 테이블명 : 테이블의 구조를 확인
desc department;
--department의 모든컬럼을 가져와라~
select * from department;

/*
SQL : 구조화된 질의 언어

select 구문의 전체 필드 내용 

select      컬럼명
Distinct    컬럼 내의 값의 중복을 제거해라.
From        테이블명, 뷰명
where       조건
Group By    특정값을 그룹핑
Having      그룹핑한 값을 정렬
Order by    값을 정렬해서 출력
*/
--해당 테이블에 뭐가있는지! ;세미콜론이 마침표임! 
desc employee;
select * --여러라인으로 써도 상관없다
from employee;

--특정 컬럼만 출력하기
select eno,ename from employee;

--특정컬럼을 여러번 출력
select eno,ename,eno,ename,ename from employee;

select eno,ename, salary from employee;

--컬럼에 연산을 적용할 수 있다.
select eno,ename,salary*12 from employee;

--컬럼명 알리어스(Alias) ,
    --컬럼에 연산을 하거나 함수를 사용하면 컬럼명이 없어진다. as가 생략도 가능하다.
select eno,ename,salary,salary*12 as 연봉 from employee;
select eno as 사원번호 , ename as 사원명, salary as 월급 , salary *12 as 연봉 from employee;
select eno 사원번호 , ename 사원명, salary 월급 , salary *12 연봉 from employee;

---공백이나 특수문자가 들어갈때는 ""로 묶어줘야한다.
select eno "사원 번호" , ename "사원?명", salary 월급 , salary *12 연봉 from employee;

--nvl 함수 : 연산시에 null을 처리하는 함수
select * from employee;

--nvl함수를 사용하지 않고 전체 연봉을 계산 null이 포함된 컬럼에 연산을 적용하면 null이 나옴.
        --null을 0으로 처리해서 연산해야함. :NVL함수 
select eno 사원번호, ename 사원명, salary 월급, commission 보너스,
salary * 12,
salary*12+commission 연봉                -- 전체 연봉
from employee;

--nvl함수를 사용해서 계산한 결과
select eno 사원번호, ename 사원명, salary 월급, commission 보너스,
salary * 12,
salary*12+ NVL(commission,0) 연봉                -- 전체 연봉
from employee;

select eno, ename, salary, commission ,salary*12+NVL(commission,0)
from employee;


-- distinct : 특정 컬럼의 내용을 중복제거 후 출력 
select * from employee;
select dno from employee; 
select distinct dno from employee;

-- 오류가 난다. 다른컬럼때문에 중복제거가 안됌.
select ename,distinct dno from employee;

--조건을 사용해서 검색 (Where)
select * from employee;
select eno 사원번호, ename 사원명, job 직책 , manager 직속상관, hiredate 입사날짜,
salary 월급 , commission 보너스 ,dno 부서번호 from employee;

--사원번호가 7788인 사원의 이름을 검색.
select * from employee
where eno = 7788;

--사원번호가 7788인 사원의 부서코드을 검색.
select eno , ename from emloyee
where eno = 7788;

==사원번호가 7788인 사원의 부서번호 , 월급과 입사날짜를 검색.
select dno 부서번호 , salary 월급, hiredate 입사날짜
from employee
where eno = 7788;

desc employee;

select *
from employee
where ename ='SMITH';

--레코드를 가져올때
    --number 일때는 ''를 붙이지 않는다. but 문자테이터(char, varchar2), 날짜를 가져올때는 ''사용하고 대소문자를 구분한다.

--입사날짜 81/12 3
select ename, hiredate from employee
where hiredate='81/12/03';

--부서코드가 20인 모든사원을 출력해라
select dno , ename from employee
where dno =20;


select *from employee;

--월급이 3000이상인 사원의 이름과 부서, 입사날짜를 출력.
select ename, dno, hiredate, salary, salary*12 연봉
from employee
where salary >= 3000 ;

--null검색 : is 키워드 사용 <=== 주의 : =를 사용하면 안된다. is를 사용 
select *
from employee
where commission is null;

--commission이 300 이상인 사원 이름과 직책과 월급
select ename, job, salary , commission
from employee
where commission >=300;

--commission이 없는 사람들의 이름
select ename
from employee
where commission is null;

--월급 500 이상 2500미만인 사원들의 이름 사원번호 입사날짜 월급
select ename, eno, hiredate, salary
from employee
where salary >=500 and salary <2500;

--직책이 salesman 이거나 부서가 20 이름 직책 월급 부서코드
select eno, ename, salary, job, dno
from employee
where job='SALESMAN' or dno=20;

--커미션이 없는 사용자중에 부서코드가 20인 사용자의 이름 부서코드와 입사날짜를 출력
select ename,dno,hiredate
from employee
where commission is null and dno=20;

--커미션이 null이 아닌사람들 이름 입사날짜 월급
select ename, hiredate,salary
from employee
where commission is not null;

--날짜 검색 : 
--1982/1/1 ~ 1983년 사이에 입사한 사원

select *
from employee
where hiredate >='1982/01/01' and hiredate < '1983/12/31';

--81년도에 입사
select *
from employee
where hiredate >='1981/01/01' and hiredate <= '1981/12/31';

--between A and B  :  A이상 B이하
select *
from employee
where hiredate between '1981/01/01' and '1981/12/31';

--% 이용해서 출력
select *
from employee
where hiredate like'81%';

--81년 2월에 입사한 사원만 출력
select *
from employee
where hiredate like'81/02%';

--정렬 : order by , asc(오름차순 정렬):기본(생략가능), dsc(내림차순 정렬)

select *
from employee
order by eno ; --asc 이 생략됨.

select *
from employee
order by eno desc;

--이름 컬럼을 정렬(생략되면 asc 이 기본값.ㄴ)
select *
from employee
order by ename desc;

--날짜 정렬
select *
from employee
order by hiredate desc;

--질문답변형 게시판에서 주로 사용 . 두개 이상의 컬럼을 정렬할때
select *from employee
order by dno desc;

--두개의 컬럼이 정렬 : 제일 처음 컬럼이 정렬을 하고 ,동일한 값에 대해서 두번째 컬럼을 정렬
select dno, ename
from employee
order by dno, ename ;

--게시판용일듯
select dno, ename
from employee
order by dno desc , ename asc;

-- IN 연산자 
--커미션이 300 500 1400인 

select *
from employee
where commission in (300,500,1400);

-- like : 컬럼내의 특정한 문자열을 검색 <== 글 검색 기능을 사용할 때
    -- % :뒤에 어떤 글자가 와도 상관 없다.
    -- _ :한글자가 어떤값이 와도 상관 없다. 
    
-- F로 시작하는 이름을 가진 사원을 모두 검색하기,
select *
from employee
where ename like 'F%';

--이름이 ES로 끝나는 사원을 검색하기.
select *
from employee
where ename like '%ES';

--J로 시작되고 J뒤에 두단어가 어떤게 와도 상관이 없는
select *
from employee
where ename like 'J__%ES';

--R로 끝나는 사원 출력
select *
from employee
where ename like '%R';

select *
from employee
where job like '%MAN%';


--where 절과 order by 절이 같이 사용될 때.
select *
from employee
where commission is null 
order by ename desc;  