--1.substr �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ����Ͻÿ�.
select * from employee;
select ename, substr(hiredate,1,5)
from employee;

--2. substr �Լ��� ����Ͽ� 4���� �Ի��� ����� ����Ͻÿ�.
select * 
FROM employee
where substr(hiredate,5,1)=4;

--3. mod �Լ��� ����Ͽ� ���ӻ���� Ȧ�� �λ���� ����Ͻÿ�.
select * 
from employee
where mod(manager,2) = 1; 

--3-1. mod �Լ��� ����Ͽ� ������ 3�� ����� ����鸸 ����ϼ���.
select * 
from employee
where mod(salary,3) = 0; 

--4. �Ի��ѳ⵵�� 2�ڸ� ���� mon���� ������ ���� �����Ͽ� ���
select ename ,to_char(hiredate,'yy-mm-dd dy') as �Ի�⵵
from employee;

--5. ���� ������ �������� ����Ͻÿ� ���� ��¥���� ���� 1�� 1���� �� ����� ����ϰ� Todate�Լ��� ����Ͽ� ������������ ��ġ
select trunc(sysdate-to_date('22/01/01')) 
from dual;

--5-1. �ڽ��� �¾ ��¥���� ������� �� ���� �������� ��� �ϼ���. 
select trunc(sysdate-to_date('96/04/01')) as �ϼ�
from dual;

--5-2. �ڽ��� �¾ ��¥���� ������� �� ������ �������� ��� �ϼ���. 
select trunc(months_between(sysdate,to_date('96/04/01'))) as ����
from dual;

--6. ������� ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� null ����� 0���� ��� �Ͻÿ�. 
select ename ,NVL(manager,0) ���id
from employee;


--7.  DECODE �Լ��� ���޿� ���� �޿��� �λ��ϵ��� �Ͻÿ�. ������ 'ANAIYST' ����� 200 , 'SALESMAN' ����� 180,
--    'MANAGER'�� ����� 150, 'CLERK'�� ����� 100�� �λ��Ͻÿ�. 
select ename , job,salary ,decode(job , 'ANALYST', salary+200,
                          'SALESMAN' ,salary+180,
                          'MANAGER', salary+150,
                          'CLERK', salary+100,
                           salary) as �λ�ȱ޿����
from employee;

--8. �����ȣ , �����ȣ�� 2�ڸ��� ����ϰ� �������� ��ǥ as ������ȣ , �̸�, �̸��� ù�ڸ� ��� �� 4�ڸ��� ��� ���ڸ��� *�� ����
select eno, rpad(substr(eno,1,2),4,'*')������ȣ , ename, rpad(substr(ename,1,1),4,'*')�����̸�
from employee; 

--9.�ֹι�ȣ �� 6�ڸ� 801210-1******�� ��� ,��ȭ��ȣ : 010-11****** ������ ���  
select rpad(substr('960401-2222222',1,8),14,'*')
from dual;

select rpad(substr('960401-2222222',1,8),14,'*')
from dual;
--10.�����ȣ,���ӻ�� , ���ӻ���� �����ȣ�� ���� ��� : 0000����(������ ó��) �� ���ڸ��� 75�� ��� : 5555
                                            --76 :6666 , 77:7777 78 :8888�� ���
select eno , manager ,decode(substr(manager,1,2), 75,5555,
                                                 76,6666,
                                                 77,7777,
                                                 78,8888,
                                                    5555)
from employee;
        




