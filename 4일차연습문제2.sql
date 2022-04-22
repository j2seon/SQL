--1.EQUI 조인을 사용하여 SCOTT사원의 부서번호와 부서이름을 출력하시오
select e.ename,e.dno,d.dname
from employee e , department d
where e.dno=d.dno
and ename='SCOTT';

select *
from department, employee; --카디시안 곱

select *
from employee,department  --카디시안 곱
where employee.dno =department.dno;

select e.dno 부서번호, d.dname
from employee e,department d
where e.dno = d.dno
and ename='SCOTT';

select *
from department;
select *
from employee;

--제약조건 : 테이블의 컬럼에 할당되어서 데이터의 무결성을 확보
 -- Primary Key : 테이블에 한번만 사용할 수 있다. 하나의 컬럼, 두개이상을 그룹핑해서!
                -- 중복된 값을 넣을 수 없다. NULL값을 넣을 수 없다.
 --UNIQUE : 테이블에 여러컬럼에 할당할 수 있다.
 -- foreign Key : 다른테이블의 특정 컬럼의 값을 참조해서 넣을 수 있다.
                --자신의 컬럼에 임의의 값을 할당하지 못한다.
 --NOT NULL: NULL값을 컬럼에 할당할 수 없다.
 --CHECK:컬럼에 값을 할당할때 체크해서 (조건에 만족)값을 할당.
 --DEFAULT: 값을 넣지 않았을 때 기본값이 할당.



--2.INNER JOIN과 on연산자를 사용하여 사원이름과 함께 그 사원이 소속된 부서이름과 지역명을 출력하시오.
select ename, dname, loc
from employee e join department d
on e.dno=d.dno;



--3. INNER JOIN과 using 연산자를 사용하여 10번 부서에 속하는 모든 담당업무의 고유한 목록(한번씩만 표시)을 부서의 지역명을 포함하여 출력하시오.

--join에서 using을 사용하는 경우 :
    -- Natural join : 공통키컬럼을 생략할 수 있다. 반드시 두테이블의 공통키 컬럼의 데이터타입이 같아야한다.
    --두테이블의 공통키컬럼의 데이터타입이 다른 경우 Using을 사용!!!!
    --두테이블의 공통 키컬림이 여러개인경우 USING을 사용한다.
desc employee;
desc department;

select dno ,job, loc 
from employee e join department d 
using (dno) 
where dno = 10;


--4. NATUAL JOIN을 사용하여 커밋션을 받은 모든 사원의 이름 부서이름 지역명을 출력하시오
select ename,commission, dname, loc
from employee e natural join department d
where commission is not null;

--5. EQUI 조인과 WILDCARD를 사용하여 이름에 A가 포함된 모든사원의 이름과 부서명을 출력하시오.
select ename , dname
from employee e , department d
where e.dno=d.dno
and ename like '%A%';

--6.NATUAL JOIN을 사용하여 NEW YORK에 근무하는 모든사원의 이름 업무 부서번호 및 부서명을 출력하시오.
select ename, job, dno, dname,loc
from employee e natural join department d
where loc='NEW YORK';