create table test10tbl(
    a number not null,
    b varchar(50) null
);

--user_test10���� HR�� �������� employee ���̺��� �����Ҷ� ��ü�� ���� ������ �ʿ��ϴ�.  (�����ְ� �ٸ���.)
/*grant select on hr. employee to user_test10; - sys�������� �ο�����*/
select *from hr.employee ; --������ �ο��ް� ���� ������ �����ϴ�.

--user_test10���� ���� ���̺� ����
show user;
select * from test10tbl;

-- �ٸ�������� ��ü�� �����Ҷ��� �����ָ�.��ü��!!!! 
select * from employee;          --�����߻�
select * from HR.employee;       -- �ٸ�������� ��ü�� �����Ҷ� ������ �־���Ѵ�.

--�ٸ� ����� ���̺��� insert ����.
desc hr.employee;
select * from hr.emp_copy55; --������ : ������ �ο����� �ʾ���!!! / �ο��ϰ� ���� ���� grant select on hr.emp_copy55 to user_test10(sys ����)

--insert
insert into hr.emp_copy55(eno)
values( 3333 );

--with grant opion�� �ο��޾Ҵ�. (select , hr.employee) �ڱ����̺��� �ƴѵ� ������ �ο�������..
    --sys�������� grant select on hr.employee to user_test10 with grant option ; �� ���� ������ �ο��޾Ƽ�!!!
grant select on hr.employee to user_test11;

select * from hr.dept_copy55; --������ : ������ �ο����� �ʾ���!!! �Ҵ�Ǹ� ����
grant select on hr.dept_copy55 to user_test11;
select * from hr.dept_copy56; -- ���� ���� Ȯ�� 

select * from hr.dept_copy57; --���� ���� Ȯ���ϱ�



