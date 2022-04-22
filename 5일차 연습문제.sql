
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
 select e.ename ,e.hiredate, m.ename,m.hiredate
 from employee e , employee m
 where e.hiredat=;

--11. SELF JOIN�� ����Ͽ� ������ ���� ���� �Ի��� ��� ����� �̸� �� �Ի����� ������ �̸� �� �Ի��ϰ� �Բ� ����Ͻÿ�. 
  --  ��, �� ���� ��Ī�� �ѱ۷� �־ ��� �Ͻÿ�. 

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

--4. ���޺��� ��� �޿��� ���ϰ�, ���� ���� ���� ��տ��� ���� ���� ����� ���ް� �޿��� ǥ���Ͻÿ�.
select dno,avg(salary)--30
from employee
group by dno;

select  min(avg(salary))
from employee
group by dno;

select dno, min(salary)
from employee
where 
group by dno;
hav


select salary--30
from employee
where dno=30;


select*
from employee;



--5. �� �μ��� �ʼ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.

--6. ��� ������ �м���(ANALYST) �� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ǥ�� (�����ȣ, �̸�, ������, �޿�) �Ͻÿ�.

--7. ���������� ���� ����� �̸��� ǥ�� �Ͻÿ�. 

--8. ���������� �ִ� ����� �̸��� ǥ�� �Ͻÿ�. 

--9. BLAKE �� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�(��, BLAKE �� ����). 

--10. �޿��� ��պ��� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���ؼ� ���� �������� ���� �Ͻÿ�. 

--11. �̸��� K �� ���Ե� ����� ���� �μ����� ���ϴ� ����� �����ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. 

--12. �μ� ��ġ�� DALLAS �� ����� �̸��� �μ� ��ȣ �� ��� ������ ǥ���Ͻÿ�. 

--13. KING���� �����ϴ� ����� �̸��� �޿��� ǥ���Ͻÿ�. 

--14. RESEARCH �μ��� ����� ���� �μ���ȣ, ����̸� �� ��� ������ ǥ�� �Ͻÿ�. 

--15. ��� �޿����� ���� �޿��� �ް� �̸��� M�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�. 

--16. ��� �޿��� ���� ���� ������ ã���ÿ�. 

--17. �������� MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�. 

