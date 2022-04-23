--Self Join : �ڱ��ڽ��� ���̺��� �����Ѵ�.(�ַ� ����� ��� ������ ����Ҷ� ���)
    --��Ī�� �ݵ�� ����ؾ��Ѵ�. 
    --select �� : ���̺��̸� ��Ī.�÷���,
select eno , ename, manager
from employee  
where manager ='7788';

--self join �� ����ؼ� ����� ���ӻ���̸�
select e.eno as"�����ȣ", e.ename as "����̸�" ,e.manager as "���ӻ����ȣ" ,m.eno,m.ename as "���ӻ���̸�" 
from employee e, employee m --�������� : ��Ī�� ������Ѵ�!
where e.manager =m.eno
order by e.ename asc;

select e.ename ||'�� ���ӻ����' ||e.manager ||m.ename ||'�Դϴ�.'
from employee e, employee m
where e.manager = m.eno
order by e.ename asc;

select eno, ename, manager, eno, ename
from employee;


--ANSI ȣȯ :INNER JOIN���� ó��,

select e.eno, e.ename , e.manager, m.ename
from employee e join employee m on (e.manager =m.eno)
order by e.ename asc;

--ANSI ȣȯ :INNER JOIN
select e.ename ||'�� ���ӻ����' ||e.manager || '�Դϴ�.'
from employee e join employee m
on e.manager = m.eno
order by e.ename asc;

--OUTER JOIN :
    --Ư���÷��� �� ���̺��� ���������� ���� ������ ����ؾ��Ҷ�.
    --���������� �ʴ� �÷��� null�� ���
    -- + ��ȣ�� ����ؼ� ����Ѵ�. : Oracle 
    -- ANSI ȣȯ : OUTER JOIN ������ ����ؼ� ��� <==��� DBMS���� ȣȯ.

--Oracle 
select e.ename, m.ename
from employee e join employee m on (e.manager = m.eno (+)) -- �����ʿ� �ִ°� ��Ī�ȵǴ��� �� �����! ������ ��¾ȉ�.
order by e.ename asc;

--Ansi ȣȯ�� ����ؼ� ��� 
    -- left Outer JOIN : �������� �κ��� ������ ������ ������ ��� ��� 
    -- right Outer JOIN : �������� �κ��� ������ �������� ������ ��� ��� 
    -- Full Outer Join : �������� �κ��� ������ ���� ��� ������ ��� ��� 
select e.ename , m.ename
from employee e right outer join employee m
on e.manager=m.eno
order by e.ename;

--��������
--subQuery : select �� ���� select���� �ִ� ����/
    --where ������ : sub query
    --having ������ : sub query

--scott �� ���޺��� ���� ����ڸ� ����϶�(��������)
select salary from employee where salary >=3000;

select ename, salary
from employee
where salary >= (select salary from employee where ename='SCOTT');

select * from employee;

--SCOTT�� ������ �μ��� �ٹ��ϴ� ����� ����ϱ� 
 select  e.dno ,e.ename, d.dname
 from employee e, department d;
 
select dno from employee where ename ='SCOTT';
select ename , dno from employee where dno=20;

select ename , dno 
from employee 
where dno=(select dno from employee where ename ='SCOTT');

select ename
from employee 
where dno=(select dno from employee where ename='SCOTT');

--�ּ� �޿��� �޴� ����� �̸� ������ �޿� ����ϱ�
select min (salary) from employee;
select ename, job, salary
from employee
where salary =(select min(salary)from employee);

select ename, job, dno, salary
from employee
where salary = (select min(salary) from employee);

--having ���� sub query ����ϱ�

--30���μ�(dno)���� �ּ� ������ �޴� ����� ���� ���� ����� �̸��� �μ���ȣ�� ������ ���

select salary, dno from employee where dno=30;
select min(salary) from employee where dno=30;

--where ����� 
select ename, dno , salary
from employee
where salary > (select min(salary) from employee where dno=30);
 
 --having ���� sub query ����ϱ�
 --30�� �μ��� �ּҿ��޺��� ū �� �μ��� �ּҿ���
select dno, min(salary),count (dno)
from employee
group by dno
having min(salary)>(select min(salary) from employee where dno=30);

-- ������ �������� : sub query�� ��� ���� �� �ϳ��� ���.
        --������ �񱳿����� : >,=,>=,<,<=,<> 
--������ �������� : sub query�� ��� ���� ������ ���
        --������ �������� ������ : IN,ANY,SOME,ALL,EXISTS
            --IN : ���������� �� ������ '='�����ڷ� ���� ���) �� ���������� ��� �� �߿� �ϳ��� ��ġ�ϸ� ��
            --ANY,SOME :���������� �������� ���������� �˻������ �ϳ� �̻� ��ġ�ϸ� ��
            --ALL : ���������� �������� ���������� �˻������ ��� ���� ��ġ�ϸ� ��
            --EXIST : ���������� �������� ���������� ����� �߿��� �����ϴ� ���� �ϳ��� �����ϸ� ��
            
--IN ������ ����ϱ� .
select ename, eno,dno,salary
from employee
order by dno asc;

--�μ����� �ּ� ������ �޴� ����ڵ� ����ϱ�(���������� �ݵ�� ���)
select dno, min(salary),count(*)
from employee
group by dno;

select ename, dno, salary 
from employee
where salary in(950,800,1300);

select ename, dno, salary 
from employee
where salary in(select min(salary) from employee group by dno);


--Any ������
    --���������� ��ȯ�ϴ� ������ ���� ����.
    --'<any'�� �ִ밪���� ������ ��Ÿ��.
    --'>any'�� �ּҰ����� ŭ�� ��Ÿ��.
    --'=any'�� IN�� ���� ��.
    
    
    --������ salesman�� �ƴϸ鼭 �޿��� ������ salesman ���� ���� ����� ���
    --1600(�ִ밪)���� ���� ��� ����� �ƴϰ� 
    select eno, ename,job, salary
    from employee
    where salary < any (select salary from employee
                            where job ='SALESMAN')
                       AND JOB<> 'SALESMAN';
                       
    select ename ,job ,salary from employee
    order by job asc;
    
--All ������
    --subquery�� ��ȯ�ϴ� ��� ���� ��.
    --'>all' : �ִ밪���� ŭ�� ��Ÿ��.
    --'<all' : �ּҰ����� ������ ��Ÿ��. 

--��) ������ salesman�� �ƴϸ鼭 ������ salesman�� ������� �޿��� ���� ����� ��� ���.
    -- 1250(�ּҰ�) ���� ���� ���(������ SALESMAN�� �ƴ�)
    select eno,ename, job, salary
    from employee
    where salary < all( select salary from employee where job = 'SALESMAN') AND job <>'SALESMAN';
    
--��) ��� ������ �м����� ������� �޿��� �����鼭 ������ �м����� �ƴ� ������� ǥ��
select eno,ename, job, salary
from employee
where salary<all(select salary from employee where job='ANALYST')and job <> 'ANALYST';

--�޿��� ��ձ޿����� ���� ������� �����ȣ�� �̸��� ǥ���ϵ� ��� �޿��� ���� �������� �Ͻÿ�
select eno , ename, salary
from employee
where salary> (select round(avg(salary)) from employee)
order by salary ;

