--1.EQUI ������ ����Ͽ� SCOTT����� �μ���ȣ�� �μ��̸��� ����Ͻÿ�
select e.ename,e.dno,d.dname
from employee e , department d
where e.dno=d.dno
and ename='SCOTT';

select *
from department, employee; --ī��þ� ��

select *
from employee,department  --ī��þ� ��
where employee.dno =department.dno;

select e.dno �μ���ȣ, d.dname
from employee e,department d
where e.dno = d.dno
and ename='SCOTT';

select *
from department;
select *
from employee;

--�������� : ���̺��� �÷��� �Ҵ�Ǿ �������� ���Ἲ�� Ȯ��
 -- Primary Key : ���̺� �ѹ��� ����� �� �ִ�. �ϳ��� �÷�, �ΰ��̻��� �׷����ؼ�!
                -- �ߺ��� ���� ���� �� ����. NULL���� ���� �� ����.
 --UNIQUE : ���̺� �����÷��� �Ҵ��� �� �ִ�.
 -- foreign Key : �ٸ����̺��� Ư�� �÷��� ���� �����ؼ� ���� �� �ִ�.
                --�ڽ��� �÷��� ������ ���� �Ҵ����� ���Ѵ�.
 --NOT NULL: NULL���� �÷��� �Ҵ��� �� ����.
 --CHECK:�÷��� ���� �Ҵ��Ҷ� üũ�ؼ� (���ǿ� ����)���� �Ҵ�.
 --DEFAULT: ���� ���� �ʾ��� �� �⺻���� �Ҵ�.



--2.INNER JOIN�� on�����ڸ� ����Ͽ� ����̸��� �Բ� �� ����� �Ҽӵ� �μ��̸��� �������� ����Ͻÿ�.
select ename, dname, loc
from employee e join department d
on e.dno=d.dno;



--3. INNER JOIN�� using �����ڸ� ����Ͽ� 10�� �μ��� ���ϴ� ��� �������� ������ ���(�ѹ����� ǥ��)�� �μ��� �������� �����Ͽ� ����Ͻÿ�.

--join���� using�� ����ϴ� ��� :
    -- Natural join : ����Ű�÷��� ������ �� �ִ�. �ݵ�� �����̺��� ����Ű �÷��� ������Ÿ���� ���ƾ��Ѵ�.
    --�����̺��� ����Ű�÷��� ������Ÿ���� �ٸ� ��� Using�� ���!!!!
    --�����̺��� ���� Ű�ø��� �������ΰ�� USING�� ����Ѵ�.
desc employee;
desc department;

select dno ,job, loc 
from employee e join department d 
using (dno) 
where dno = 10;


--4. NATUAL JOIN�� ����Ͽ� Ŀ�Լ��� ���� ��� ����� �̸� �μ��̸� �������� ����Ͻÿ�
select ename,commission, dname, loc
from employee e natural join department d
where commission is not null;

--5. EQUI ���ΰ� WILDCARD�� ����Ͽ� �̸��� A�� ���Ե� ������� �̸��� �μ����� ����Ͻÿ�.
select ename , dname
from employee e , department d
where e.dno=d.dno
and ename like '%A%';

--6.NATUAL JOIN�� ����Ͽ� NEW YORK�� �ٹ��ϴ� ������� �̸� ���� �μ���ȣ �� �μ����� ����Ͻÿ�.
select ename, job, dno, dname,loc
from employee e natural join department d
where loc='NEW YORK';