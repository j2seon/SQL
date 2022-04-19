--1.���������ڸ� ����Ͽ� ������� ���ؼ� 300 �� �޿��λ��� ����� �� ����� �̸� �޿� �λ�� �޿��� ����ϼ���
select ename,salary, salary+300 �λ�ȱ޿�
from employee;

--2.����� �̸� �޿� ���� �� ������ ���� �ͺ��� ���� ������ ����Ͻÿ� ���� �� ������ 100 �󿩱��� ���Ͻÿ�.
select ename,salary, salary*12+100 �����Ѽ���
from employee
order by salary desc , salary*12+100 desc;

--3.�޿��� 2000�� �Ѵ� ����� �̸��� �޿��� �޿��� ���� �ͺ��� ����������
select ename,salary
from employee
where salary>2000
order by salary desc ;

--4.�����ȣ�� 7788�� ����� �̸��� �μ���ȣ�� ���
select ename, dno
from employee
where eno=7788;

--5.�޿��� 2000���� 3000���̿� ���Ե��� �ʴ� ����� �̸� �޿�
select ename, salary
from employee
where salary not BETWEEN 2000 AND 3000 ;


--6. 1981/2/20~ 81/5/1 �Ի��ο��� ���� �Ի���
select ename , job , hiredate
from employee
where hiredate between '81/02/20' and '81/05/01';

--7. �μ� ��ȣ�� 20~30 �� ���� ��� �̸� �μ���ȣ �̸� ��������
select ename , dno
from employee
where dno between 20 and 30
order by ename desc;

--8. ����� �޿��� 2000 3000���� ��ȣ�� 20 30 �� �̸� �޿� �μ���ȣ ��������
select ename, salary, dno
from employee
where salary BETWEEN 2000 AND 3000 and(dno=20 or dno=30)
order by ename;

-- 9. 81�Ի��� ����� �̸��� �Ի���
select ename , hiredate
from employee
where hiredate like '81%';

--10. ������ �� ���� ��� �̸� ������
select ename , job
from employee
where manager is null;

--11. Ŀ�̼��� �޴� ��� �̸��� �޿� Ŀ�Ӽ� �޿� Ŀ�̼� ���� ��������
select ename, salary, commission
from employee
where commission is not null
order by salary desc, commission desc;

--12. 
select ename
from employee
where ename like '__R%';

--13. 
select ename
from employee
where ename like '%A%'and ename LIKE '%E%';

--14. 
select ename, job, salary
from employee
where job in('CLERK','SALESMAN') and (salary= 1600 or salary=950 or salary=1300) ;

--15. 
select ename , salary , commission
from employee
where commission>=500 ;

select *
from employee;


-- �پ��� �Լ� ����ϱ�
/*
1. ���ڸ� ó���ϴ� �Լ�
    1. ���ڸ� ó���ϴ� �Լ� 
    - UPPER :�빮�ڷ� ��ȯ
    - LOwer : �ҹ��ڷ� ��ȯ
    - INITCAP : ù�ڴ� �빮�ڷ� �������� �ҹ��ڷ� ��ȯ
    dual ���̺� : �ϳ��� ����� ����ϵ����ϴ� ���̺�
    
*/
select '�ȳ��ϼ���' as �ȳ�
from dual;

select * from employee;

select ename , lower (ename), initcap(ename), upper(ename)
from employee;

select * 
from employee
where lower(ename) = 'allen'; --�˻��� �ȵ�

select * from employee
where initcap(ename)='Allen';

-- ���� ���̸� ����ϴ� �Լ� 
 --length : ������ ���̸� ��ȯ, �����̳� �ѱ� ���� ���� ���ڼ��� ���� 1byte
 --lengthb : ������ ���̸� ��ȯ, �ѱ� 3 byte �� ��ȯ,
 
 select length ('Oracle mania'), length('����Ŭ�ŴϾ�')
 from dual; 

 select lengthb ('Oracle mania'), lengthb('����Ŭ�ŴϾ�') 
 from dual; 

select ename, length(ename),job ,length(job) from employee;

-- ���������Լ� 
/*
 - concat : ���ڿ� ���ڸ� ����
 - substr : ���ڸ� Ư�� ��ġ���� �߶���� �Լ� (����, �ѱ� ��� 1byte�� ó��)
 - substrb :���ڸ� Ư�� ��ġ���� �߶���� �Լ� ( ������ 1byte, �ѱ��� 3byte�� ó��)
 - instr : ������ Ư�� ��ġ�� �ε��� ���� ��ȯ
 - instrb : ������ Ư�� ��ġ�� �ε��� ���� ��ȯ( ������ 1byte, �ѱ��� 3byte�� ó��)
 - lpad, rpad: �Է¹��� ���ڿ����� Ư���� ���ڸ� ����.
 - trim : �߶󳻰� ���� ���ڸ� ��ȯ.
*/

select '�ȳ�' ,'�ϼ���', concat('�ȳ�','�ϼ���')
from dual;
select 'Oracle', 'mania', concat('Oracle', 'mania') 
from dual;

--substr (���, ������ġ, ���ⰹ��) : Ư�� ��ġ���� ���ڸ� �߶�´�.  

select '����ٳ���������', substr('����ٳ���������',3,3) 
from dual;
select 'Oracle mania', substr('Oracle mania',4,3) , substr('����Ŭ �ŴϾ�',2,4)
from dual;

select '�ڵ���1��',substr('010-3221-9382',-4,4) from dual;
select '������',substr('���ֳ����ĳ���',-3,1) from dual; 
select 'Oracle mania', substr('Oracle mania',-4,3) , substr('����Ŭ �ŴϾ�',-6,4)
from dual;

--�̸� ����
select ename as �̸� , substr(ename,1,2) ��, substr(ename,-3,3)  
from employee;
select ename, substr(ename,2,3), substr(ename,-5,2) from employee;

select substrb ('Oracle mania',3,3),substrb('����Ŭ �ŴϾ�', 4,6) from dual;

--�̸��� N���� ������ ����� ����ϱ� (substr �Լ��� ���)
SELECT ename 
from employee
where substr(ename,-1,1)='N';
-- like�� �̸��� N���� ������ ����� ���
select ename 
from employee
where ename like '%N';

--87�⵵ �Ի��� ����� ����ϱ� (substr �Լ��� ���)
select * 
from employee
where substr(hiredate,1,2)=87;

select * from emloyee
where substr (hiredate,1,2)='87';

--instr (���, ã�� ���� , ������ġ, �� ��° �߰�) : ��󿡼� ã�� ������ �ε��� ���� ���.

select 'abcdefg', instr('abcdefg','d') from dual;
select 'abcdabcd' , instr('abcdabcd','c',2,2) from dual;
select 'Oracle mania', instr ('Oracle mania','a') from dual;
select 'Oracle mania', instr ('Oracle mania','a',5,2) from dual;

select 'Oracle mania', instr ('Oracle mania','a',-5,1) from dual;

select distinct instr(job,'A',1,1) 
from employee
where job ='MANAGER';



--lpad, rpad : Ư�� ���̸�ŭ ���ڿ��� �����ؼ� ���� ,�������� ������ Ư�� ���ڷ� ó�� 
    -- lpad(���,�÷��� ���ڿ� ũ�� ,Ư����������)
    -- 
select lpad ('1234',10,'#')from dual;
select rpad ('1234',10,'#')from dual;

select salary from employee;

select lpad(salary, 10, '*')from employee;


--trim :�������� Ư�����ڵ� ���� 
  --LTRIM :������ ������ ���� 
  --RTRIM :�������� ������ ���� 
  --TRIM : ����, ������ ������ ���� 
  
select ltrim ('   Oracle mania   ') a ,rtrim('   Oracle mania   ') b,trim('   Oracle mania   ') as c 
from dual;


select * from employee;
--||���� �� ��� 
select concat(ename,'  ' || job) from employee;

select '�̸��� : ' || ename || ' �̰�, ��å�� : ' ||job || ' �Դϴ�.' as �÷�����
from employee; 

select '�̸��� : ' || ename || '�̰� , ���ӻ�� ����� : ' || manager||' �Դϴ�.' as ���ӻ�����
from employee;
