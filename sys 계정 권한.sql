show user;

-- �ְ� ������ ���� sys :������ ���� �� �� �ִ� ������ ������ �ִ�.
create user usertest01 identified by 1234; 

--���̵� : usertest01 ���:1234

--������ ��ȣ�� �����ߴٰ� �ٷ� �������� ���ϰ� ������ �޾ƾ��Ѵ�.

--System Privileges : 
    -- Create Session : ����Ŭ�� ������ �� �ִ� ����.
    -- Create table : ����Ŭ���� ���̺��� ������ �� �ִ� ����.
    -- Create sequence : ������ ������ �� �ִ� ����
    -- Create view : �並 ������ �� �ִ� ����.

--DDL : ��ü ����(Create, Alter,drop)
--DCL : ���ڵ� ����(Insert, update, delete)
--DQL : ���ڵ� �˻�(select)
--DTL : Ʈ����� (Begin transaction, rollback, commit)
--DCL : ���Ѱ��� (Grant, Revoke, Deny) 

--������ �������� ����Ŭ�� ���� �� �� �ִ� Create session ���� �ο�
--grant �ο��� ���� to ������
grant create session to usertest01; --����Ŭ�� ������ �� �ִ� ���Ѹ� ������ > ���̺� ������ �� �ִ� ������ ����.

--���̺��� ������ �� �ִ� ���� 
grant create table to usertest01; 

/*
    ���̺� �����̽� (Table space) : ��ü (���̺�,��, ������, �ε���, Ʈ����, �������ν���, �Լ�...)
    �� �����ϴ� ����, ������ �������� �� ����ں� ���̺� �����̽��� Ȯ��. 
    SYSTEM : DBA (������ ���������� ���� ����)    
*/

select * from dba_users;        -- dba_ :sys (�ְ� ������ �������� Ȯ��)
select username, default_tablespace as Datafile , temporary_tablespace as LogFile
from dba_users
where username in('HR','USERTES T01');

--�������� ���̺� �����̽� ����(SYSTEM==>USERS) ����
alter user usertest01
default tablespace users  --Datafile ���� : ��ü�� ����Ǵ� ���� (���̺� ,��, Ʈ����, �ε���)
temporary tablespace temp;  --temporary tablespace temp : LOG�� �����ϴ� ���� DML{insert upadate delete�� ����Ǹ� LOG�� ����� �ȴ�.}
                            --LOG�� ȣĪ�Ҷ� Trasaction Log. �ý��ۿ� ���� �߻� �� ��� ������ �ƴ϶� ������ �������� �����ϱ� ���ؼ� �ʿ�
                            
                            
--���̺� �����̽� : ��ü�� �α׸� �����ϴ� �������� ����
    -- DataFile : ��ü�� �����ϰ� �ִ�.(���̺�, ��,�ε���....)
    -- Log :transaction Log�� ���� 
    -- DataFile�� Log ������ ���������� �ٸ� �ϵ������ �����ؾ� ������ ���� �� �ִ�.
        --RAID �� ������ �����ϸ� ������ ���� �� �ִ�.
                            
                            
                            

--�������� Users ���̺� �����̽��� ����� �� �ִ� ���� �Ҵ�.users ���̺� �����̽��� 2mb�� ����� �� �ִ� ���� �Ҵ�.
alter user usertest01
quota 2m on users; 



----------------------------------------------------------
���� : usertest02 ������ �����Ŀ� users ���̺� �����̽����� ���̺� �����ϰ� insert �ϱ�..
--��������� 
create user usertest02 identified by 1234;
--���� �ֱ� 
grant create session to usertest02;
grant create table to usertest02;

-- ���� �����̽�����
    --�����̽�Ȯ��
select * from dba_users;        -- dba_ :sys (�ְ� ������ �������� Ȯ��)
select username, default_tablespace as Datafile , temporary_tablespace as LogFile
from dba_users
where username in('USERTEST02');
    -- ����
alter user usertest02
default tablespace users
temporary tablespace temp;

--�����Ҵ�
alter user usertest02
quota 101m on users;

select * from all_tables --���̺��� �����ָ� ������ش�.
where owner in('HR','USERTEST01','USETTEST02');

