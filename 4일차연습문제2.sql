--1.EQUI 조인을 사용하여 SCOTT사원의 부서번호와 부서이름을 출력하시오
select e.ename,e.dno,d.dname
from employee e , department d
where e.dno=d.dno
and ename='SCOTT';

select *
from department;
select *
from employee;

--2.INNER JOIN과 on연산자를 사용하여 사원이름과 함께 그 사원이 소속된 부서이름과 지역명을 출력하시오.
select ename, dname, loc
from employee e join department d
on e.dno=d.dno;

--3. INNER JOIN과 using 연산자를 사용하여 10번 부서에 속하는 모든 담당업무의 고유한 목록(한번씩만 표시)을 부서의 지역명을 포함하여출력하시오.
--4. NATUAL JOIN을 사용하여 커밋션을 받은 모든 사원의 이름 부서이름 지역명을 출력하시오
select ename,commission, dname, loc
from employee e natural join department d
where commission is not null;

--5. EQUI 조인과 WILDCARD를 사용하여 이름에 A가 포함된 모든사원의 이름과 부서명을 출력하시오.
select e.ename , d.dname
from employee e , department d
where e.dno=d.dno
and ename like '%A%';

--6.NATUAL JOIN을 사용하여 NEW YORK에 근무하는 모든사원의 이름 업무 부서번호 및 부서명을 출력하시오.
select ename, job, dno, dname,loc
from employee e natural join department d
where loc='NEW YORK';