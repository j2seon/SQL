-- 3���� 

-- �����Լ� 
/*
    ROUND : Ư�� �ڸ������� �ݿø�.
    TRUNC : Ư���ڸ������� �߶󳽴�.(������.)
    MOD : �Է¹��� ���� ���� ������ ���� ���
*/

--round (���) : �Ҽ��� �Ʒ��ڸ����� �ݿø�! ex )98.7654-> 99
--round (���, �Ҽ��� �ڸ���) : 
        -- ��� : ����϶� �Ҽ��� ���������� �̵��Ѵ�. ���������� �ڸ�����ŭ�̵��ؼ� ���ڸ��� �ڿ��� �ݿø��Ѵ�. < 
        -- ���� : �����϶� �Ҽ��� �������� �������� �̵�. �������� �ڸ�����ŭ �̵��ϰ� �� �ڸ������� �ݿø��Ѵ�.
                                            -- ex)98.7654,2->98.77    -- 98�� 8���� �ݿø�ó��   
select 98.7654 as ����, Round(98.7654) round�Լ�����,round(98.7654,2),round(98.7654,-1),round(98.7654,-2)
        ,round(98.7654,-3) ,round(98.7654,3) 
from dual; 

select 1232.1212 , round(1232.1212),round(1232.1212,2),round(1232.1212,-1)
from dual;

select 12345.6789, round(12345.6789), round(12345.6789,-3), round(123678.123456,-3)
from dual;

--TRUNC : ����
select 98.7654, Trunc(98.7654), Trunc(98.7654,2), Trunc(98.7654,-1)
from dual;

--MOD (���, ������ �� ): ����� ����� �������� ����Ѵ�. 

select mod (31,2), mod(31,5),mod(31,8)
from dual;

select * from employee;

select salary, mod(salary, 300)
from employee;

--employee ���̺��� �����ȣ�� ¦���� ����鸸 ���
select *
FROM employee
where mod(eno,2)=0;

/* ��¥ �Լ� 
    sysdate : �ý��ۿ� ����� ���糯¥�� ����Ѵ�. < ���� ���� ���
    months_between : �� ��¥ ������ ������ ��ȯ
    add_months : Ư����¥�� ���� ���� ���Ѵ�.
    next_day : Ư����¥���� ���ʷ� �����ϴ� ���ڷ� ���� ������ ��¥�� ��ȯ.
    last_day : ���� ������ ��¥�� ��ȯ
    round : ���ڷ� ���� ��¥�� Ư�� �������� �ݿø�. 
    trunk : ���ڷ� ���� ��¥�� Ư���������� ����.
*/
--�ڽ��� �ý����� ���� ��¥ ���
select sysdate
from dual; 
--��¥�� ������ ������ �� �ִ�. 
select sysdate -1 as ������¥, sysdate ���ó�¥ , sysdate+1 ���ϳ�¥
from dual;

select * from employee
order by hiredate asc;

select hiredate, hiredate-1 , hiredate+10 
from employee;

--�ٹ��ϼ� : �Ի��Ͽ������� ��������� �ٹ��ϼ��� ����ض�
select ename �����, round(sysdate-hiredate) �ٹ��ϼ�,round((sysdate-hiredate)/365) �ٹ��⵵
from employee
order by round((sysdate-hiredate)/365) desc, round(sysdate-hiredate) desc;

select ename �����, round((sysdate-hiredate),2) �ٹ��ϼ�
from employee;

select ename �����, trunc(sysdate-hiredate) �ٹ��ϼ�
from employee;

--Ư����¥���� ��(month)�� �������� ������ ��¥ -> ���� �������� �߱� ������ ���� 01�� ���´�.
select hiredate, trunc (hiredate,'MONTH')
from employee;

--round ���� �������� �ݿø���. 15���� �������� 
select hiredate, round (hiredate,'MONTH')
from employee;

select round (sysdate,'month') from dual;

--months_between(date1,date2) : date1�� date2 ������ ���� ���� ���� ��� 
-- �� ������� �ٹ��� ���� �� ���ϱ� 
select ename ,sysdate , hiredate, trunc(months_between(sysdate , hiredate))�ٹ�������
from employee;

--add_months (date1 , ������) : date1 ��¥�� ���� ���� ���� ��¥�� �������.
select add_months(sysdate,5)
from dual;


-- �Ի��� �� 6������ ����������?
select ename ,hiredate, add_months(hiredate,6)
from employee;

--�Ի��� �� 100�� �� �ڳ� ����?
select ename ,hiredate, hiredate+100 as "100���� �Ǵ� ��¥"
from employee;

-- next_day(date,'����') : date �� �����ϴ� ���Ͽ� ���� ��¥�� ����ϴ� �Լ�
select sysdate, next_day(sysdate,'�����')"�̹��� ������� ��¥"
from dual;

--last_day (date) :date�� �� ���� ������ ��¥�� ���
select hiredate, last_day(hiredate) 
from employee;

--(�߿�!!!)�� ��ȯ �Լ�
/*
    TO_CHAR : ��¥�� �Ǵ� �������� ���������� ��ȯ�ϴ� �Լ� 
    TO_DATE : �������� ��¥ �Ǵ� ���������� ��ȯ�ϴ� �Լ� 
    TO_NUMBER : �������� ���������� ��ȯ�ϴ� �Լ�.
*/

--��¥�Լ� ����غ���! 
--TO_CHAR(date,'yyyymmdd') day �� ������ ��� �ٿ��� dy�� ��밡��

select ename , hiredate, to_char(hiredate,'yyyymmdd') , to_char(hiredate,'yymm'),
to_char(hiredate, 'yyyymmdd day'),to_char(hiredate ,'yyyymmdd dy')
from employee;

--���� ��¥�� ����ϰ� �ð� �ʱ��� ��� 
select sysdate ���ó�¥ , to_char(sysdate,'yyyy-mm-dd hh:mi:ss day')  
from dual;

select hiredate, to_char(hiredate,'yyyy_mm_dd hh:mi:ss day') 
from employee;


--to_char ���� ���ڿ� ���õ� ����
/*
 0 : �ڸ����� ��Ÿ���� �ڸ����� ���� ���� ��� 0���� ä��.
 9 : �ڸ����� ��Ÿ���� �ڸ����� ���� ���� ��� ä���� ����.
 L : �� ������ ��ȭ ��ȣ�� ���
 .: �Ҽ������� ǥ�� 
 ,: õ������ ������
*/

desc employee;
--salary�� number Ÿ���ε� ��ȯ��Ų��
select ename , salary , to_char(salary, 'L999,999'), to_char(salary, 'L0000,000')
from employee;

--to_date('char','format') :��¥�������� ��ȯ.

--�����߻� sysdate�� ��¥���̰� 20000101�� char���̶� ������ �ȵȴ�. (���� �������� ��ȯ���Ѿ��Ѵ�.)
select sysdate, sysdate-'20000101' 
from dual;

--20000101�� 'YYYYMMDD'�� ��¥�������� ��ȯ���� . 2000�� 1��1�Ͽ��� ���ñ����� �ϼ�  
select sysdate, trunc(sysdate - to_date(20000101,'YYYYMMDD'))
from dual ;

select sysdate, trunc(sysdate-to_date(20200101,'yyyymmdd'))
from dual;

select sysdate, to_date('02/10/10','yy/mm/dd'), trunc(sysdate-to_date('021010','yymmdd'))
from dual;

select ename , hiredate 
from employee
where hiredate ='81/02/22';

--�����߻� > number Ÿ���̶�! date Ÿ������ �ٲ���Ѵ�.
select ename , hiredate 
from employee
where hiredate =to_date(19810222,'yyyymmdd');

select ename, hiredate
from employee
where hiredate = '1981-02-22';

select ename, hiredate
from employee
where hiredate = to_date('1981-02-22', 'YYYY-mm-dd');

--2000�� 12�� 25�� ���� ���ñ���     months_between : �� ��¥ ������ ������ ��ȯ

select months_between(sysdate,to_date(20220101,'yyyymmdd'))
from dual;

select trunc(months_between(sysdate,to_date(20001225,'yyyy-mm-dd'))) as months
from dual;


--to_date('format','char') :��¥�������� ��ȯ.
select sysdate, trunc(sysdate-to_date('021010','yymmdd'))
from dual;

--to_number : number ���� ������Ÿ������ ��ȯ, 

 
select 100000 - 50000
from dual;

select to_number('100,000','999,999')-to_number('50,000','999,999')
from dual;

--�����߻� : ���ڿ� - ���ڿ� 
select '100,000' - '50,000'
from dual ;

--NVL �Լ� : null�� �ٸ� ������ ġȯ���ִ� �Լ� 
    -- NVL(expr1,expr2) : expr1 ���� expr2�� ġȯ

select commission, NVL(commission,0) 
from employee;

select manager
from employee;

select manager, NVL(manager, 1111)
from employee;

--NVL2 �Լ�
 --nvl2(expr1,expr2,expr3) : expr1�� null�� �ƴϸ� exor2 �� ���, expr1�� null�̸� expr2�� ���.
 
 select salary, commission
 from employee;
 
 --NVL �Լ��� ���� ����ϱ�
 select salary,salary*12, salary*12+NVL(commission,0) as ����
 from employee;
 
 --NVL2 �Լ��� ����ؼ� ���� ����ϱ� 
 select salary, commission, NVL2(commission, salary*12+commission,salary*12) ����
 from employee;
 
 -- nullif:��ǥ������ ���ؼ� ������ ��� Null �� ��ȯ�ϰ� ������������ ��� ù��° ǥ������ ��ȯ
    -- nullif(expr1,expr2) : 
 select nullif('A','A'), nullif('A','B')
 from dual;
 
 --coalesce �Լ� 
 coalesce(expr1,expr2,expr3.....expr-n) :
        -- expr1�� null�� �ƴϸ� expr1�� ��ȯ�ϰ�, 
        -- expr1�� null�̰� exppr2�� null�� �ƴϸ� expr2�� ��ȯ�ϰ� 
        --expr1 �� null �̰� expr2�� null�̰� expr3�� null�� �ƴϸ� expr3�� ��ȯ.

select coalesce('abc','bcd','def','efg')
from dual;

select coalesce(null,'bcd','def','efg')
from dual;

select coalesce(null,null,'def','efg')
from dual;

select ename, salary, commission, coalesce(commission,salary,0)
from employee;

--decode �Լ� : switch case ���� ������ ���� 
/*
DECODE (ǥ����, ����1, ���1, 
               ����2, ���2,
               ����3, ���3,
               �⺻���n
*/

select ename,dno, decode(dno, 10,'ACCOUNTING',
                              20,'RESEARCH',
                              30, 'SALES',
                              40,'OPERATIONS',
                              'DEFAULTS') as DNAME
from employee;                              

--dno�÷��� 10�� �μ��� ��� ���޿��� +300 �� ó���ϰ�, 20�� ��� ���޿� +500 , �μ���ȣ�� 30�� ��� ���޿� +700�� �ؼ� �̸�, ����, �μ��� ����+
select * from employee;

select ename, salary, dno ,decode(dno ,10, salary+300,
                                       20, salary+500,
                                       30, salary+700) as ����
                                
from employee
order by dno asc;

--case : if ~ else if, else if-- ��ǥ�� �������!!!
    /*
        case ǥ����  when ����1 then ���1
                         ����2 then ���2
                         ����3 then ���3
                         ELSE ���n
        END
    */
  select ename , dno ,case when dno=10 then 'ACCOUNTING'
                           when dno=20 then 'RESEARCH'
                           when dno=30 then 'SALES'
                          ELSE 'DEFAULT'
                    end as �μ���
  from employee
  order by dno;