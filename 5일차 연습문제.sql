
--Join 문제. 
--7. SELF JOIN을 사용하여 사원의 이름 및 사원번호를 관리자 이름 및 관리자 번호와 함께 출력 하시오. 
 --	각열에 별칭값을 한글로 넣으시오. 
    select e.ename 사원이름, e.eno 사원번호, m.ename 관리자이름, e.manager 관리자번호 
    from employee e, employee m
    where e.manager=m.eno
    order by e.ename;
    
    ------풀이
    --Self Join : 반드시 별칭을 사용해야한다~  별칭 이름.컬럼명
        -- 조직도 출력, 직속상관정보 출력 시 많이 사용 
    select e.ename 사원이름, e.eno 사원번호, e.manager 관리자번호, m.ename 관리자이름
    from employee e join employee m
    on e.manager=m.eno
    order by e.ename;
    
    
--8. OUTER JOIN, SELF JOIN을 사용하여 관리자가 없는 사원을 포함하여 사원번호를 기준으로 내림차순 정렬하여 출력 하시오. 
    select e.eno
    from employee e join employee m 
    on e.manager=m.eno(+)
    order by e.eno desc;
    
    -----풀이 
    
    select e.eno, e.manager
    from employee e left outer join employee m
    on e.manager = m.eno
    order by e.eno desc;
    
--9. SELF JOIN을 사용하여 지정한('SCOTT') 사원의 이름, 부서번호, 지정한 사원('SCOTT')과 동일한 부서에서 근무하는 사원을 출력하시오. 
  -- 단, 각 열의 별칭은 이름, 부서번호, 동료로 하시오. 
  select e.ename , e.dno, m.ename
  from employee e join employee m
  on e.dno=m.dno
  where e.ename='SCOTT';
  
  -----풀이
  select e.ename, e.dno, m.ename
  from employee e , employee m 
  where e.dno =m.dno
  and e.ename='SCOTT' and m.ename!='SCOTT';

  
--10. SELF JOIN을 사용하여 WARD 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하시오. 
select ename, hiredate
from employee 
where hiredate<(select hiredate from employee where ename='WARD');

select e.ename ,e.hiredate, m.ename , m.hiredate
from employee e , employee m
where e.hiredate < m.hiredate
and e.ename='WARD'
order by m.hiredate;

/*select  m.ename , m.hiredate
from employee e , employee m
where e.hiredate = m.hiredate
and m.hiredate > (select hiredate from employee where ename='WARD');
*/

--11. SELF JOIN을 사용하여 관리자 보다 먼저 입사한 모든 사원의 이름 및 입사일을 관리자 이름 및 입사일과 함께 출력하시오. 
  --  단, 각 열의 별칭을 한글로 넣어서 출력 하시오. 
  select e.eno,e.ename,e.hiredate,e.manager,d.ename, d.hiredate
  from employee e, employee d
  where e.manager=d.eno
  and e.hiredate<d.hiredate;
  
  --공통 키 컬럼을 뭐로할지 뽑아서 확인 후에 하면 편하다!! 
 select eno, ename, manager ,hiredate, eno, ename, manager ,hiredate from employee;

 select e.eno, e.ename, e.hiredate, m.ename, m.hiredate
 from employee e , employee m
 where e.manager = m.eno
 and e.hiredate<m.hiredate;

--<<아래 문제는 모두 Subquery를 사용하여 문제를 푸세요.>>

--1. 사원번호가 7788인 사원과 담당 업무가 같은 사원을 표시(사원이름 과 담당업무) 하시오.
select job from employee where eno='7788';
select ename, job from employee where job ='ANALYST';

select ename, job from employee where job = (select job from employee where eno='7788'); 

select ename, dno
from employee
where job=(select job from employee where eno=7788);

--2. 사원번호가 7499인 사원보다 급여가 많은 사원을 표시 (사원이름 과 담당업무) 하시오. 
select ename, dno
from employee
where salary > (select salary from employee where eno=7788);

select*
from employee;

--3. 최소 급여를 받는 직급별로, 담당 업무 및 급여를 표시 하시오(그룹 함수 사용)
select job,min(salary)
from employee
group by job;

select ename, job, salary
from employee
where salary in(select min(salary) from employee group by job);


--4. 직급별로 평균 구하고, 가장 작은 직급 평균에서 가장 작은 사원의 직급과 급여를 표시하시오.

--첫번째 풀이 
select job, salary, ename
from employee -- 직급으로 묶어서 평균값의 가장 작은 값이 작거나 같아야함.<작아버리면 값이 없으니까 작거나 같게 적용!
where salary <= all(select min(avg(salary))from employee group by job)--적용 시 평균이 제일 작은 직급이 나오고 
group by job, salary, ename  -- 그룹화로 salary를 적용해야 월급을 볼 수 있는데 지금은 해당직급의 평균보다 작은애들이 나옴>> 가장 작은 에를 정의해야함.
having salary <= all(select min(salary)from employee group by job); --직급들중에 작은값보다 작거나 같게 적용 시 제일 작은애만 추출할수 있다.

--having이 긴거같아서 where에 and 적용해서 했는데 가능했음!
select job , salary, ename
from employee
where salary <= all (select min(avg(salary)) from employee group by job)
    and salary <= all (select min(salary) from employee group by job)
group by job, salary, ename;

--where에서 조건이 다 주어져서 그런지 group으로 묶지 않아도 값이 나옴
select job,ename,salary
from employee 
where salary< = all(select min(avg(salary))from employee group by job)
and salary< =all(select min(salary)from employee group by job);

    ----풀이
select job, round(avg(salary)) from employee group by job;

select ename 이름, job 직급, salary 급여 
from employee
where salary = (select min(salary) from employee group by job
                having avg(salary) = (select min(avg(salary)) from employee group by job));

select min(salary),job
from employee
group by job 
having avg (salary) <= all(select avg(salary)from employee group by job);


--5. 각 부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.

select ename, salary, job
from employee
where salary in(select min(salary) from employee group by job);

 select dno, min(salary)
 from employee
 group by dno;
 
--6. 담당 업무가 분석가(ANALYST) 인 사원보다 급여가 적으면서 업무가 분석가가 아닌 사원들을 표시 (사원번호, 이름, 담당업무, 급여) 하시오.
select salary
from employee
where job='ANALYST';

select eno, ename, job, salary
from employee
where salary < any(select salary from employee where job='ANALYST')
    and job <> 'ANALYST';

--7. 부하직원이 없는 사원의 이름을 표시 하시오. 
select m.ename
from employee e right outer join employee m
on e.manager=m.eno
where e.ename is null;

select e.ename,m.ename
from employee e join employee m 
on e.manager (+) = m.eno
where e.ename is null;


--8. 부하직원이 있는 사원의 이름을 표시 하시오. 
select distinct(m.ename)
from employee e join employee m
on e.manager=m.eno
order by m.ename;

------풀이
select eno, ename
from employee
where eno in(select manager from employee where manager is not null) 
order by ename;

--9. BLAKE 와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오(단, BLAKE 는 제외). 
select dno
from employee
where ename= 'BLAKE'; --30

select ename , hiredate
from employee
where dno=(select dno from employee where ename= 'BLAKE')
        and ename !='BLAKE';

--10. 급여가 평균보다 많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대해서 오름 차순으로 정렬 하시오. 
select eno,ename,salary
from employee
where salary>(select avg(salary) from employee);

-----풀이
    select eno, ename, salary 
    from employee 
    where salary >(select round(avg(salary))from employee);

--11. 이름에 K 가 포함된 사원과 같은 부서에서 일하는 사원의 사원번호와 이름을 표시하는 질의를 작성하시오. 
select ename, dno
from employee
where ename like '%K%';

select eno, dno, ename
from employee
where dno in(select dno from employee where ename like '%K%');

-----풀이
select dno, ename
from employee 
where dno in(select dno from employee where ename like '%K%'); 


--12. 부서 위치가 DALLAS 인 사원의 이름과 부서 번호 및 담당 업무를 표시하시오. 
select ename, job, dno, dname, loc
from employee e natural join department d
where loc='DALLAS';

select e.ename ,e.job, dno , d.dname, d.loc
from employee e join department d using(dno)
where loc='DALLAS';

select ename, e.dno, job, loc 
from employee e, department d 
where e.dno=d.dno
and loc='DALLAS';

-----
select ename , e.dno, job, loc
from employee e , department d
where e.dno=d.dno
and e.dno in(select dno from department where loc = 'DALLAS');


--13. KING에게 보고하는 사원의 이름과 급여를 표시하시오. 

select e.ename 부하 , m.ename 상관
from employee e join employee m 
on e.manager =m.eno
where m.ename= 'KING';

-----풀이
select ename , salary 
from employee 
where manager = (select eno from employee where ename='KING');

select ename, salary from employee
where manager=(select eno from employee 
                where ename='KING');


--14. RESEARCH 부서의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시 하시오. 
select dname,dno,ename,job
from employee e natural join department d
where dname= 'RESEARCH';

select d.dname,e.dno,e.ename,e.job
from employee e join department d on e.dno=d.dno
where dname= 'RESEARCH';

select d.dname, dno, e.ename, e.job
from employee e join department d using(dno)
where dname= 'RESEARCH';

select eno, ename , job, dname
from employee e ,department d
where e.dno = d.dno
and e.dno in(select dno from department where dname='RESEARCH');

select d.dname,e.dno,e.ename,e.job
from employee e , department d 
where e.dno=d.dno
and dname= 'RESEARCH';

--15. 평균 급여보다 많은 급여를 받고 이름에 M이 포함된 사원과 같은 부서에서 근무하는 사원의 사원번호, 이름, 급여를 표시하시오. 
select round(avg(salary)) from employee; --평균급여

select ename --m이들어가는 사람
from employee
where ename like '%M%';

select eno 사원번호 , ename 이름, salary 급여, dno 부서
from employee
where salary > (select round(avg(salary)) from employee)
        and dno in(select dno from employee where ename like '%M%');

--16. 평균 급여가 가장 적은 업무를 찾으시오. 
select job 업무, round(avg(salary))평균급여 
from employee
group by job
having avg(salary)=(select min(avg(salary)) from employee group by job);


select job, avg(salary)
from employee
group by job
having avg(salary)=(select min(avg(salary)) from employee group by job) ;



--17. 담당업무가 MANAGER인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오. 
select e.ename , d.dname
from employee e join department d on e.dno= d.dno
where job='MANAGER';

select e.ename, d.dname 
from employee e join department d on e.dno = d.dno
where d.dname in(select d.dname from employee e join department d on e.dno = d.dno where job='MANAGER');

select * from employee where job ='MANAGER';

select ename 
from employee 
where dno in(select dno from employee where job='MANAGER');
