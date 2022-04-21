--4����
/*
    �׷��Լ� : ������ ���� ���ؼ� �׷����ؼ� ó���ϴ� �Լ� 
            group by ���� Ư���÷��� ������ ���, �ش� �÷��� ������ ������ �׷����ؼ� ������ ����.
            
    �����Լ� : 
        -sum : �׷��� �հ�
        -AVG : �׷��� ���
        -MAX : �׷��� �ִ밪         
        -MIN : �׷��� �ִ밪 
        -COUNT : �׷��� �Ѱ���(���ڵ�� record, �ο�� row )
*/


select  sum(salary),round(avg(salary),2),max(salary),min(salary)
from employee;

--���� : �����Լ��� ó���� �� , ��� �÷��� ���ϰ����� ������ �÷��� ����
--sum�� ���� ���Ϸγ����µ� �ٸ� ���� ���� ���� �ƴѰ�� �����߻�
select sum (salary), ename from employee;
select sum (salary) from employee;

select *
from employee;

--�����Լ��� null ���� ó���ؼ� �����Ѵ�.
select sum (commission),avg(commission),max(commission),min(commission)
from employee;

--count() : ���ڵ� ��, �ο� �� 
    --null�� ó������ �ʴ´�.
    --���̺��� ��ü ���ڵ� ���� �����ð��  : count(*) �Ǵ� not null �÷��� count())
select eno from employee; --���ڵ� 14�� 

--��ü�����ȣ�� ����?
select count (eno)from employee;



--Ŀ�Ӽ��� �ִ� ������� ����? 
select commission from employee; --Ŀ�Ӽ���Ȳ
select count(commission) from employee;-- null�� ������ �ʴ´�.

--��ü ���ڵ� ī��Ʈ 
--��ü �ο��� ���� �˰� ������ * �Ǵ� null���� ���� ��������
select count(*) from employee;
select count (eno)from employee;
 
 
-- �ߺ����� �ʴ� ������ ����
select job from employee; --��ü ������ ��Ȳ
select count(distinct job) from employee; --������ ����
select distinct job from employee; --��������

--�μ��� ����(dno)
select count (distinct dno) from employee;
select distinct dno from employee; --�μ��� ����

--Groub by: Ư�� �÷��� ���� �׷����Ѵ�. �ַ� �����Լ��� select ������ ���� �����.
/*
    select �÷���, �����Լ�ó���� �÷�
    from ���̺� 
    where ����
    group by �÷���
    having ���� (group by�� ����� ����)
    order by ����

*/

--�μ��� ��ձ޿�.
select dno as �μ���ȣ, avg(salary) as ��ձ޿�
from employee
group by dno ; -- dno �÷��� �ߺ��� ���� �׷�����.

select dno 
from employee
order by dno;

--��ü ��� �޿�.
select avg (salary) as ��ձ޿�
from employee;

--dno�� ���� ���� count �� �� dno, �׷��ε� ������ salary�� �հ�
select dno, count(dno) , sum(salary)
from employee
group by dno;

--goup by�� ����ϸ鼭 select ���� ������ �÷��� �� �����ؾ��Ѵ�. ename�� ���ǿ� �����ʴ´� ���� ����
select dno, count(dno) , sum(salary),ename
from employee
group by dno;

--�ش� �μ������� ������ ������ ��.
select dno, count(dno) , sum(salary), avg(salary), max(commission), min(commission)
from employee
group by dno;

--������ ��å�� �׷����ؼ� ������ ��� ,�հ� �ִ밪 �ּҰ��� ���
select job ,sum(salary),round(avg(salary),2),max(salary),min(salary)
from employee
group by job;

--���� �÷��� �׷����ϱ�
select dno, job, count(*),sum(salary)
from employee
group by dno,job; --���÷� ��� ��ġ�ϴ� ���� �׷���

select dno, job ,sum(salary),round(avg(salary),2),max(salary),min(salary)
from employee
group by dno,job;

select ename,dno,job 
from employee
where dno = 20 and job = 'CLERK';

-- having : goup by���� ���� ����� �������� ó���� ��.
    --��Ī�̸��� �������� ����ϸ� �ȵȴ�.
-- �μ��� ������ �հ谡 9000�̻��� �͸� ���.  
select dno �μ�, count(*)�μ��ο�,sum (salary)as �μ����հ�, round(avg(salary),2) as �μ������
from employee
GROUP by dno
having sum (salary)>9000;

select dno,sum (salary)as �μ����հ�, round(avg(salary),2) as �μ������
from employee
group by dno
having sum (salary)>9900;

--�μ��� ������ ����� 2000�̻� ���
select dno �μ�, count(*)�μ��ο�,sum (salary)as �μ����հ�, round(avg(salary),2) as �μ������
from employee
GROUP by dno
having round(avg(salary),2)>2000;

select dno , round(avg(salary),2) as �μ������
from employee 
group by dno
having round(avg(salary),2)>2200;


--where�� having�� ���� ���Ǵ� ���
 --where : ���� ���̺� ������ �༭ �˻�
 --having : group by ����� ���ؼ� ������ ó��. 
 
 --������ 1500���ϴ� �����ϰ� ���μ����� ������ ����� ���ϵ� ������ ����� 2000�̻��ΰǸ� ���
 select dno,count(*),round(avg(salary))
 from employee
 where salary >1500
 group by dno
 having round(avg(salary))>2500;
 
  select *
 from employee;
 
 --job�� CLERK�� �����ϰ� �μ����� ������ �հ�� ����� ���Ѵ��� �����2000�̻��� ��� ���
 select job,count(job), sum(salary), round(avg(salary))
 from employee
 where job != upper('CLERK')
 group by job
 having round(avg(salary))>2000;
 
 --ROLLUP
 --CUBE
    --GROUP BY ������ ����ϴ� Ư���� �Լ�
    --�����÷��� ������ �� �ִ�.
    -- GROUP BY���� �ڼ��� ������ ���
 
 --ROLLUP,CUBE�� ������� ���� ���
select dno, count(*),sum (salary),round(avg(salary))
from employee
group by dno
order by dno;

--ROLLUP: �μ��� �հ�� ����� ����ϰ� ������ ���ο� ��ü �հ�,���
select dno, count(*),sum (salary),round(avg(salary))
from employee
group by rollup(dno)
order by dno;

--���޺� + ��ü ��
select job ,count(job),sum (salary),round(avg(salary))
from employee
group by rollup(job);
  
--�μ��� �հ�� ����� ����ϰ� ������ ���ο� ��ü �հ�,���
select dno, count(*),sum (salary),round(avg(salary))
from employee
group by CUBE(dno)
order by dno;
  
--Rollup : ���÷��̻� ��dno���� ���� 
select dno, job, count(*),max(salary),sum(salary),round(avg(salary))
from employee
group by rollup(dno,job); --�ΰ��� �÷��� ����� ���÷��� ���ļ� �����Ҷ� �׷���.

select job, dno, count(*),max(salary),sum(salary),round(avg(salary))
from employee
group by rollup(job,dno);

--rollup ���� order by�� ������ ��� ��ü ó���� ������� ������ �ʴ´�.
select dno, job, count(*),max(salary),sum(salary),round(avg(salary))
from employee
group by dno,job
order by dno asc;
 
--cube :dno�� �������� �� job ���� -> dno���׷��� ������ + job���� ����� ����
select dno, job, count(*),max(salary),sum(salary),round(avg(salary))
from employee
group by cube(dno,job)
order by dno , job ; 

--JOIN: �������̺��� ���ļ� �� ���̺��� �÷��� �����´�.
 --deparment�� employee�� ������ �ϳ��� ���̺��̾����� �𵨸�(�ߺ�����,�������)�� ���ؼ� �����̺��� �и���Ŵ 
 --�����̺��� ����Ű�÷�(dno) ,employee���̺��� dno �÷��� department���̺��� dno�÷��� �����ϰ� �ִ�.
 --�ΰ� �̻��� ���̺��� �÷��� JOIN������ ����ؼ� ���.

select * from department; --�μ������� �����ϴ� ���̺� 
select * from employee; -- ��������� �����ϴ� ���̺� 

--EQUI JOIN : ����Ŭ���� ���� ���� ����ϴ� JOIN, Oracle������ ��밡��
    --from �� : ������ ���̺��� ,�� ó��
    --whrere �� : �� ���̺��� ������ Ű �÷��� " = "�� ó��
        --and ��: ������ ó��
    
    --where�� : ����Ű �÷��� ó���� ���
select *
from employee,department
where department.dno = employee.dno
and job= 'MANAGER';



-- ANSI ȣȯ : [INNER] JOIN <==��� SQL���� ��밡���� join ��� (INNER�� ��������)
--ON �� : ����Ű�÷��� ó���� ���
    --where�� : ������ ó��
select * 
from employee e join department d
on e.dno = d.dno
where job ='MANAGER';

--JOIN�� ���̺� �˸�� (���̺��̸��� ��ħ���� �ΰ� ���� ��� )
select *
from employee e, department d
where e.dno=d.dno
and salary >1500;


--select ������ ������ Ű�÷��� ��½� ������̺��� �÷����� ��� : dno
select eno , job , d.dno, dname 
from employee e , department d
where e.dno=d.dno;

--�����̺��� JOIN�ؼ� ����(salary)�� �ִ밪�� �μ������� ����غ�����
select dname,count(*),max(salary)
from  department d , employee e
where d.dno=e.dno
group by dname;

select dname ,max(salary)
from employee e join department d
on e.dno=d.dno
group by dname;


--NATUAL JOIN : Oracle 9i ����
    -- EQUI JOIN �� Where ���� ���� : �����̺��� ������ Ű�÷��� ���� "="
    --������ Ű�÷��� Oracle ���������� �ڵ����� �����ؼ� ó��
    --���� Ű�÷��� ��Ī�̸� ��� �� ������ �߻�.
    --�ݵ�� ���� Ű�÷��� ������Ÿ���� ���ƾ��Ѵ�.
    --from ���� natural join Ű���带 ���.
    
select e.eno, e.ename , d.dname , dno
from employee e natural join department d;

--���� : select ���� ����Ű �÷��� ��� �� ���̺���� ����ϸ� ���� �߻�.
-- EQUI JOIN vs NATUAL JOIN �� ����Ű�÷� ó��
    --EQUI JOIN : select���� ����Ű �÷��� ����Ҷ� ���̺���� �ݵ�� ���
    --NATUAL JOIN:select���� ����Ű �÷��� ����Ҷ� ���̺���� �ݵ�� ������� �ʾƾ���.
    
--EQUI                            
select ename,salary,dname,d.dno   --d.dno�̷������� ��ð� �����ǵǾ��־���Ѵ�!!(EQUI JOIN)
from employee e, department d
where e.dno=d.dno
and salary >2000;

--NATURAL                        
select ename, salary, dname, dno  --dno : ����ϸ� �����߻�!!!(natural join)
from employee natural join department d
where salary >2000;

--ANSI : INNER JOIN
select ename, salary, dname, e.dno
from employee e join department d 
on e.dno = d.dno
where salary >2000;


--NON EQUI JOIN : EQUI JOIN���� where���� "=" ������� �ʴ� JOIN
--select * from salgrade; : ������ ����� ǥ���ϴ� ���̺� 

select ename, salary, grade
from employee,salgrade
where salary BETWEEN losal and hisal;

--���̺� 3�� ���� 
--ename,salary : employee / dname : department / grade : salgrade
select ename,dname,salary,grade
from employee e, department d, salgrade s
where e.dno = d.dno
and salary between losal and hisal;
