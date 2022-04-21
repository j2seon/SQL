--1. ��� ����� �޿� �ְ��, ������, �Ѿ�, �� ��� �޿��� ��� �Ͻÿ�. 
--�÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 
select max(salary)�ְ��,min(salary)������, sum(salary)�Ѿ�,round(avg(salary),2)���
from employee;

--2. �� ������ �������� �޿� �ְ��, ������, �Ѿ� �� ��վ��� ����Ͻÿ�.
--�÷��� ��Ī�� ����(�ְ��, ������, �Ѿ�, ���)�ϰ� �����ϰ� ��տ� ���ؼ��� ������ �ݿø� �Ͻÿ�. 

select job,count(job)�ο���,max(salary)�ְ��,min(salary)������, sum(salary)�Ѿ�,round(avg(salary))���
from employee
GROUP by job;

--3. count(*)�Լ��� ����Ͽ� ��� ������ ������ ������� ����Ͻÿ�. 
select job,count(job)
from employee
GROUP by job;

--4. ������ ���� ���� �Ͻÿ�. �÷��� ��Ī�� "�����ڼ�" �� ���� �Ͻÿ�. 
select count(manager)�����ڼ�
from employee;

--5. �޿� �ְ��, ���� �޿����� ������ ��� �Ͻÿ�, �÷��� ��Ī�� "DIFFERENCE"�� �����Ͻÿ�. 
select max(salary)�ְ��,min(salary)������, max(salary)-min(salary) DIFFERENCE
from employee;

--6. ���޺� ����� ���� �޿��� ����Ͻÿ�. �����ڰ� �� �� ���� ��� �� ���� �޿��� 2000�̸��� �׷��� ���� ��Ű�� ����� �޿��� ���� ������������ �����Ͽ� ��� �Ͻÿ�. 
select job, min(salary)
from employee 
where salary>2000 and manager is not null
group by job
order by min(salary) desc; 

select job, min(salary)
from employee
where manager is not null
GROUP by job
having MIN(salary)>2000;


--7. �� �μ������� �μ���ȣ, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�.
--�÷��� ��Ī�� [�μ���ȣ, �����, ��ձ޿�] �� �ο��ϰ� ��ձ޿��� �Ҽ��� 2°�ڸ����� �ݿø� �Ͻÿ�. 
select dno �μ���ȣ,count(dno) �����,round(avg(salary),2)��ձ޿�
from employee
group by dno;

--8. �� �μ��� ���� �μ���ȣ�̸�, ������, �����, �μ����� ��� ����� ��� �޿��� ����Ͻÿ�. 
--�÷��� ��Ī�� [�μ���ȣ�̸�, ������, �����,��ձ޿�] �� �����ϰ� ��ձ޿��� ������ �ݿø� �Ͻÿ�.  
select *
from employee;
select decode(dno, 10,'ACCOUNTING',20,'RESEARCH',30, 'SALES','DEFAULTS') as DNAME,decode(dno, 10,'NEW YORK',20,'DALLS',30,'CHICAO','DEFAULTS') "Location",
count(dno)as "Number of People",round(avg(salary)) "Salary"
from employee                              
GROUP by dno;


