--1. employee ���̺��� ������ �����Ͽ� emp_sample �� �̸��� ���̺��� ����ÿ�. 
--��� ���̺��� �����ȣ �÷��� ���̺� ������ primary key ���������� �����ϵ� �������� �̸��� my_emp_pk�� �����Ͻÿ�. 

CREATE TABLE emp_sample
AS 
SELECT * FROM employee;
ALTER TABLE emp_sample
ADD CONSTRAINT my_emp_pk PRIMARY KEY (ENO);

DESC emp_sample;

--2. department ���̺��� ������ �����Ͽ� dept_sample �� �̸��� ���̺��� ����ÿ�. 
--�μ� ���̺��� �μ���ȣ �÷��� ������ primary key ���� ������ �����ϵ� ���� �����̸��� my_dept_pk�� �����Ͻÿ�. 
CREATE TABLE dept_sample
AS
SELECT * FROM department;

DESC dept_sample;

ALTER TABLE dept_sample
ADD CONSTRAINT my_dept_pk PRIMARY KEY (DNO);

--3. ��� ���̺��� �μ���ȣ �÷��� �������� �ʴ� �μ��� ����� �������� �ʵ��� �ܷ�Ű ���������� �����ϵ�
--���� �����̸��� my_emp_dept_fk �� �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]

ALTER TABLE emp_sample
ADD CONSTRAINT my_emp_dept_fk FOREIGN KEY (DNO) REFERENCES dept_sample (DNO);

DESC emp_sample;

--4. ������̺��� Ŀ�Լ� �÷��� 0���� ū ������ �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. [
--���� : �� ������ ���̺��� ����Ͻÿ�]

ALTER TABLE emp_sample
ADD CONSTRAINT CK_emp_sample_COMMISSION CHECK (COMMISSION>=0);
select * from user_constraints;

--5. ������̺��� ���� �÷��� �⺻ ������ 1000 �� �Է��� �� �ֵ��� ���� ������ �����Ͻÿ�. 
--[���� : �� ������ ���̺��� ����Ͻÿ�]
ALTER TABLE emp_sample
MODIFY SALARY DEFAULT 1000;

--6. ������̺��� �̸� �÷��� �ߺ����� �ʵ���  ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
ALTER TABLE emp_sample
ADD CONSTRAINT UK_emp_sample_ENAME UNIQUE (ENAME);

--7. ������̺��� Ŀ�Լ� �÷��� null �� �Է��� �� ������ ���� ������ �����Ͻÿ�. [���� : �� ������ ���̺��� ����Ͻÿ�]
UPDATE emp_sample
SET COMMISSION =0
WHERE COMMISSION IS NULL;
COMMIT;


alter table emp_sample 
MODIFY COMMISSION CONSTRAINT NN_emp_sample_COMMISSION not null;


--8. ���� ������ ��� ���� ������ ���� �Ͻÿ�. 
select * from user_constraints 
where table_name in ('EMP_SAMPLE','DEPT_SAMPLE');

ALTER TABLE emp_sample
DROP CONSTRAINT CK_EMP_SAMPLE_COMMISSION;

ALTER TABLE emp_sample
DROP CONSTRAINT MY_EMP_DEPT_FK;

ALTER TABLE emp_sample
DROP CONSTRAINT NN_EMP_SAMPLE_COMMISSION;

ALTER TABLE emp_sample
DROP CONSTRAINT UK_EMP_SAMPLE_ENAME;

--PRIMARY Ű ����
alter table emp_sample   
drop primary key cascade;

alter table dept_sample  
drop primary key cascade;


--�� ���� 

--1. 20�� �μ��� �Ҽӵ� ����� �����ȣ�� �̸��� �μ���ȣ�� ����ϴ� select ���� �ϳ��� view �� ���� �Ͻÿ�.
	--���� �̸� : v_em_dno  
    CREATE VIEW v_em_dno
    AS
    SELECT ENO,DNO
    FROM EMPLOYEE
    WHERE DNO=20;
    
    SELECT * FROM v_em_dno;

--2. �̹� ������ ��( v_em_dno ) �� ���ؼ� �޿� ���� ��� �� �� �ֵ��� �����Ͻÿ�. 
 CREATE OR REPLACE VIEW v_em_dno
 AS
  SELECT ENO,DNO,SALARY
    FROM EMPLOYEE
    WHERE DNO=20;

--3. ������  �並 ���� �Ͻÿ�. 
    DROP VIEW v_em_dno;
    
--4. �� �μ��� �޿���  �ּҰ�, �ִ밪, ���, ������ ���ϴ� �並 ���� �Ͻÿ�. 
--	���̸� : v_sal_emp
    CREATE VIEW v_sal_emp
    AS 
    SELECT MIN(SALARY) �ּҰ�, MAX(SALARY) �ִ밪 , AVG(SALARY) ���, SUM(SALARY) �޿�
    FROM employee
    GROUP BY DNO;
    SELECT * FROM v_sal_emp;

5--. �̹� ������ ��( v_em_dno ) �� ���ؼ� �޿��� �б� ��������
    CREATE VIEW v_em_dno
    AS 
    SELECT SALARY 
    FROM employee WITH READ ONLY;
    
    SELECT * FROM v_em_dno;
