/*
    ���� ����
    -- ��� ���� : DBMS�� �������� ���.
        - �� ����ں��� ������ ���� : DBMS�� ������ �� �ִ� ����ڸ� �����ؾ��Ѵ�.
            (���� (Authentication): Credential(Identity+password) Ȯ��)
            (�㰡 (Authorization): ������ ����ڿ��� Oracle�� �ý��� ����, ��ü(���̺�,��,Ʈ����,�Լ� ) ���� �ο�)
                -System Privilleges : ����Ŭ �������� ���� ,���̺� �����̽� ������ �������� ����.
                -Object privilleages : ���̺� , ��, Ʈ���� , �Լ� ,�������ν���, ������, �ε��� ���ٱ���.
*/

--Oracle���� ���� ����. (�Ϲ� ���������� ������ ���� �� �� �ִ� ������ ���� )
--create user ������ identified by �н�����; 
create user usertest01 identified by 1234; --����
show user;


--Object Privileges : ���̺�, ��, Ʈ����, �Լ�,
/*   -- �������ν���, ������ , �ε��� �� �ο��Ǵ� ���� �Ҵ�. 
  ---------------------------------------------------- 
     ����         Table   view    sequence   procedeur
  -----------------------------------------------------
    alter          0                0       
    delete         0      0        
    execute                                      0
    index          0       
    insert         0      0
    references     0
    selete         0      0         0
    update         0      0 
*/

-- Ư�� ���̺� selete ���� �ο��ϱ�

create user user_test10 identified by 1234; --��������>>sys ��������





















