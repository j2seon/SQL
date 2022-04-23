
--Join ����. 
--7. SELF JOIN�� ����Ͽ� ����� �̸� �� �����ȣ�� ������ �̸� �� ������ ��ȣ�� �Բ� ��� �Ͻÿ�. 
 --	������ ��Ī���� �ѱ۷� �����ÿ�. 
    select e.ename ����̸�, e.eno �����ȣ, m.ename �������̸�, e.manager �����ڹ�ȣ 
    from employee e, employee m
    where e.manager=m.eno
    order by e.ename;
    
--8. OUTER JOIN, SELF JOIN�� ����Ͽ� �����ڰ� ���� ����� �����Ͽ� �����ȣ�� �������� �������� �����Ͽ� ��� �Ͻÿ�. 
    select e.eno
    from employee e join employee m 
    on e.manager=m.eno(+)
    order by e.eno desc;
    
--9. SELF JOIN�� ����Ͽ� ������('SCOTT') ����� �̸�, �μ���ȣ, ������ ���('SCOTT')�� ������ �μ����� �ٹ��ϴ� ����� ����Ͻÿ�. 
  -- ��, �� ���� ��Ī�� �̸�, �μ���ȣ, ����� �Ͻÿ�. 
  select e.ename , dno, m.ename
  from employee e, employee m
  where dno=(select dno from employee where ename='SCOTT');
  
  
  
--10. SELF JOIN�� ����Ͽ� WARD ������� �ʰ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�. 
select ename, hiredate
from employee 
where hiredate<(select hiredate from employee where ename='WARD');


select hiredate
from employee
where ename='WARD';

desc employee;


--11. SELF JOIN�� ����Ͽ� ������ ���� ���� �Ի��� ��� ����� �̸� �� �Ի����� ������ �̸� �� �Ի��ϰ� �Բ� ����Ͻÿ�. 
  --  ��, �� ���� ��Ī�� �ѱ۷� �־ ��� �Ͻÿ�. 
  select e.eno,e.ename,e.hiredate,e.manager,d.hiredate
  from employee e, employee d
  where e.manager=d.eno
    and e.hiredate<d.hiredate;
  

--<<�Ʒ� ������ ��� Subquery�� ����Ͽ� ������ Ǫ����.>>

--1. �����ȣ�� 7788�� ����� ��� ������ ���� ����� ǥ��(����̸� �� ������) �Ͻÿ�.
select ename, dno
from employee
where job=(select job from employee where eno=7788);

--2. �����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ�� (����̸� �� ������) �Ͻÿ�. 
select ename, dno
from employee
where salary > (select salary from employee where eno=7788);

select*
from employee;

--3. �ּ� �޿��� �޴� ���޺���, ��� ���� �� �޿��� ǥ�� �Ͻÿ�(�׷� �Լ� ���)
select dno,min(salary)
from employee
group by dno;

select dno, salary
from employee
where salary in(select min(salary) from employee group by dno);

--4. ���޺��� ��� ���ϰ�, ���� ���� ���� ��տ��� ���� ���� ����� ���ް� �޿��� ǥ���Ͻÿ�.

--ù��° Ǯ�� 
select job, salary, ename
from employee -- �������� ��� ��հ��� ���� ���� ���� �۰ų� ���ƾ���.<�۾ƹ����� ���� �����ϱ� �۰ų� ���� ����!
where salary <= all(select min(avg(salary))from employee group by job)--���� �� ����� ���� ���� ������ ������ 
group by job, salary, ename  -- �׷�ȭ�� salary�� �����ؾ� ������ �� �� �ִµ� ������ �ش������� ��պ��� �����ֵ��� ����>> ���� ���� ���� �����ؾ���.
having salary <= all(select min(salary)from employee group by job); --���޵��߿� ���������� �۰ų� ���� ���� �� ���� �����ָ� �����Ҽ� �ִ�.

--having�� ��Ű��Ƽ� where�� and �����ؼ� �ߴµ� ��������!
select job , salary, ename
from employee
where salary <= all (select min(avg(salary)) from employee group by job)
    and salary <= all (select min(salary) from employee group by job)
group by job, salary, ename;

--where���� ������ �� �־����� �׷��� group���� ���� �ʾƵ� ���� ����
select job,ename,salary
from employee 
where salary< = all(select min(avg(salary))from employee group by job)
and salary< =all(select min(salary)from employee group by job);


--5. �� �μ��� �ּ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.

select ename, salary, dno
from employee
where salary in(select min(salary) from employee group by dno);

 select dno, min(salary)
 from employee
 group by dno;
 
    
--6. ��� ������ �м���(ANALYST) �� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ǥ�� (�����ȣ, �̸�, ������, �޿�) �Ͻÿ�.
select salary
from employee
where job='ANALYST';

select eno, ename, job, salary
from employee
where salary < any(select salary from employee where job='ANALYST')
    and job <> 'ANALYST';

--7. ���������� ���� ����� �̸��� ǥ�� �Ͻÿ�. 
select m.ename
from employee e right outer join employee m
on e.manager=m.eno
where e.ename is null;

select e.ename,m.ename
from employee e join employee m 
on e.manager (+) = m.eno
where e.ename is null;


--8. ���������� �ִ� ����� �̸��� ǥ�� �Ͻÿ�. 
select distinct(m.ename)
from employee e join employee m
on e.manager=m.eno;


--9. BLAKE �� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�(��, BLAKE �� ����). 
select dno
from employee
where ename= 'BLAKE'; --30

select ename , hiredate
from employee
where dno=(select dno from employee where ename= 'BLAKE')
        and ename !='BLAKE';

--10. �޿��� ��պ��� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ���� �������� ���� �Ͻÿ�. 
select eno,ename,salary
from employee
where salary>(select avg(salary) from employee);

--11. �̸��� K �� ���Ե� ����� ���� �μ����� ���ϴ� ����� �����ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 
select ename, dno
from employee
where ename like '%K%';

select eno, ename
from employee
where dno in(select dno from employee where ename like '%K%');

--12. �μ� ��ġ�� DALLAS �� ����� �̸��� �μ� ��ȣ �� ��� ������ ǥ���Ͻÿ�. 
select ename, job, dno, dname,loc
from employee e natural join department d
where loc='DALLAS';

select e.ename ,e.job, dno , d.dname, d.loc
from employee e join department d using(dno)
where loc='DALLAS';

--13. KING���� �����ϴ� ����� �̸��� �޿��� ǥ���Ͻÿ�. 

select e.ename ���� , m.ename ���
from employee e join employee m 
on e.manager =m.eno
where m.ename= 'KING';


select ename, salary from employee
where manager=(select eno from employee 
                where ename='KING');


--14. RESEARCH �μ��� ����� ���� �μ���ȣ, ����̸� �� ��� ������ ǥ�� �Ͻÿ�. 
select dname,dno,ename,job
from employee e natural join department d
where dname= 'RESEARCH';

select d.dname,e.dno,e.ename,e.job
from employee e join department d on e.dno=d.dno
where dname= 'RESEARCH';

select d.dname, dno, e.ename, e.job
from employee e join department d using(dno)
where dname= 'RESEARCH';


select d.dname,e.dno,e.ename,e.job
from employee e , department d 
where e.dno=d.dno
and dname= 'RESEARCH';

--15. ��� �޿����� ���� �޿��� �ް� �̸��� M�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�. 
select ename,salary,dno
from employee
where ename like '%M%';

select avg(salary) from employee;

select avg(salary),dno 
from employee
group by dno;

--16. ��� �޿��� ���� ���� ������ ã���ÿ�. 

select job, avg(salary)
from employee
group by job
having avg(salary)=(select min(avg(salary)) from employee group by job) ;

--17. �������� MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�. 
select e.ename , d.dname
from employee e join department d on e.dno= d.dno
where job='MANAGER';

select e.ename, d.dname 
from employee e join department d on e.dno = d.dno
where d.dname in(select d.dname from employee e join department d on e.dno = d.dno where job='MANAGER');


