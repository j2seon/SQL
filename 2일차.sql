
--desc ���̺�� : ���̺��� ������ Ȯ��
desc department;
--department�� ����÷��� �����Ͷ�~
select * from department;

/*
SQL : ����ȭ�� ���� ���

select ������ ��ü �ʵ� ���� 

select      �÷���
Distinct    �÷� ���� ���� �ߺ��� �����ض�.
From        ���̺��, ���
where       ����
Group By    Ư������ �׷���
Having      �׷����� ���� ����
Order by    ���� �����ؼ� ���
*/
--�ش� ���̺� �����ִ���! ;�����ݷ��� ��ħǥ��! 
desc employee;
select * --������������ �ᵵ �������
from employee;

--Ư�� �÷��� ����ϱ�
select eno,ename from employee;

--Ư���÷��� ������ ���
select eno,ename,eno,ename,ename from employee;

select eno,ename, salary from employee;

--�÷��� ������ ������ �� �ִ�.
select eno,ename,salary*12 from employee;

--�÷��� �˸��(Alias) ,
    --�÷��� ������ �ϰų� �Լ��� ����ϸ� �÷����� ��������. as�� ������ �����ϴ�.
select eno,ename,salary,salary*12 as ���� from employee;
select eno as �����ȣ , ename as �����, salary as ���� , salary *12 as ���� from employee;
select eno �����ȣ , ename �����, salary ���� , salary *12 ���� from employee;

---�����̳� Ư�����ڰ� ������ ""�� ��������Ѵ�.
select eno "��� ��ȣ" , ename "���?��", salary ���� , salary *12 ���� from employee;

--nvl �Լ� : ����ÿ� null�� ó���ϴ� �Լ�
select * from employee;

--nvl�Լ��� ������� �ʰ� ��ü ������ ��� null�� ���Ե� �÷��� ������ �����ϸ� null�� ����.
        --null�� 0���� ó���ؼ� �����ؾ���. :NVL�Լ� 
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�,
salary * 12,
salary*12+commission ����                -- ��ü ����
from employee;

--nvl�Լ��� ����ؼ� ����� ���
select eno �����ȣ, ename �����, salary ����, commission ���ʽ�,
salary * 12,
salary*12+ NVL(commission,0) ����                -- ��ü ����
from employee;

select eno, ename, salary, commission ,salary*12+NVL(commission,0)
from employee;


-- distinct : Ư�� �÷��� ������ �ߺ����� �� ��� 
select * from employee;
select dno from employee; 
select distinct dno from employee;

-- ������ ����. �ٸ��÷������� �ߺ����Ű� �ȉ�.
select ename,distinct dno from employee;

--������ ����ؼ� �˻� (Where)
select * from employee;
select eno �����ȣ, ename �����, job ��å , manager ���ӻ��, hiredate �Ի糯¥,
salary ���� , commission ���ʽ� ,dno �μ���ȣ from employee;

--�����ȣ�� 7788�� ����� �̸��� �˻�.
select * from employee
where eno = 7788;

--�����ȣ�� 7788�� ����� �μ��ڵ��� �˻�.
select eno , ename from emloyee
where eno = 7788;

==�����ȣ�� 7788�� ����� �μ���ȣ , ���ް� �Ի糯¥�� �˻�.
select dno �μ���ȣ , salary ����, hiredate �Ի糯¥
from employee
where eno = 7788;

desc employee;

select *
from employee
where ename ='SMITH';

--���ڵ带 �����ö�
    --number �϶��� ''�� ������ �ʴ´�. but ����������(char, varchar2), ��¥�� �����ö��� ''����ϰ� ��ҹ��ڸ� �����Ѵ�.

--�Ի糯¥ 81/12 3
select ename, hiredate from employee
where hiredate='81/12/03';

--�μ��ڵ尡 20�� ������� ����ض�
select dno , ename from employee
where dno =20;


select *from employee;

--������ 3000�̻��� ����� �̸��� �μ�, �Ի糯¥�� ���.
select ename, dno, hiredate, salary, salary*12 ����
from employee
where salary >= 3000 ;

--null�˻� : is Ű���� ��� <=== ���� : =�� ����ϸ� �ȵȴ�. is�� ��� 
select *
from employee
where commission is null;

--commission�� 300 �̻��� ��� �̸��� ��å�� ����
select ename, job, salary , commission
from employee
where commission >=300;

--commission�� ���� ������� �̸�
select ename
from employee
where commission is null;

--���� 500 �̻� 2500�̸��� ������� �̸� �����ȣ �Ի糯¥ ����
select ename, eno, hiredate, salary
from employee
where salary >=500 and salary <2500;

--��å�� salesman �̰ų� �μ��� 20 �̸� ��å ���� �μ��ڵ�
select eno, ename, salary, job, dno
from employee
where job='SALESMAN' or dno=20;

--Ŀ�̼��� ���� ������߿� �μ��ڵ尡 20�� ������� �̸� �μ��ڵ�� �Ի糯¥�� ���
select ename,dno,hiredate
from employee
where commission is null and dno=20;

--Ŀ�̼��� null�� �ƴѻ���� �̸� �Ի糯¥ ����
select ename, hiredate,salary
from employee
where commission is not null;

--��¥ �˻� : 
--1982/1/1 ~ 1983�� ���̿� �Ի��� ���

select *
from employee
where hiredate >='1982/01/01' and hiredate < '1983/12/31';

--81�⵵�� �Ի�
select *
from employee
where hiredate >='1981/01/01' and hiredate <= '1981/12/31';

--between A and B  :  A�̻� B����
select *
from employee
where hiredate between '1981/01/01' and '1981/12/31';

--% �̿��ؼ� ���
select *
from employee
where hiredate like'81%';

--81�� 2���� �Ի��� ����� ���
select *
from employee
where hiredate like'81/02%';

--���� : order by , asc(�������� ����):�⺻(��������), dsc(�������� ����)

select *
from employee
order by eno ; --asc �� ������.

select *
from employee
order by eno desc;

--�̸� �÷��� ����(�����Ǹ� asc �� �⺻��.��)
select *
from employee
order by ename desc;

--��¥ ����
select *
from employee
order by hiredate desc;

--�����亯�� �Խ��ǿ��� �ַ� ��� . �ΰ� �̻��� �÷��� �����Ҷ�
select *from employee
order by dno desc;

--�ΰ��� �÷��� ���� : ���� ó�� �÷��� ������ �ϰ� ,������ ���� ���ؼ� �ι�° �÷��� ����
select dno, ename
from employee
order by dno, ename ;

--�Խ��ǿ��ϵ�
select dno, ename
from employee
order by dno desc , ename asc;

-- IN ������ 
--Ŀ�̼��� 300 500 1400�� 

select *
from employee
where commission in (300,500,1400);

-- like : �÷����� Ư���� ���ڿ��� �˻� <== �� �˻� ����� ����� ��
    -- % :�ڿ� � ���ڰ� �͵� ��� ����.
    -- _ :�ѱ��ڰ� ����� �͵� ��� ����. 
    
-- F�� �����ϴ� �̸��� ���� ����� ��� �˻��ϱ�,
select *
from employee
where ename like 'F%';

--�̸��� ES�� ������ ����� �˻��ϱ�.
select *
from employee
where ename like '%ES';

--J�� ���۵ǰ� J�ڿ� �δܾ ��� �͵� ����� ����
select *
from employee
where ename like 'J__%ES';

--R�� ������ ��� ���
select *
from employee
where ename like '%R';

select *
from employee
where job like '%MAN%';


--where ���� order by ���� ���� ���� ��.
select *
from employee
where commission is null 
order by ename desc;  