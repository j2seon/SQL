/*
    Ʈ����(TRIGGER) : ������ ��Ƽ�(Ʈ����), ��Ƽ踦 ���� �Ѿ��� �߻��.
    -���̺� �����Ǿ��ִ�.
    -���̺� �̹�Ʈ�� �߻��ɶ� ¥������ �۵��Ǵ� ���α׷� �ڵ�
    -���̺� �߻��Ǵ� �̺�Ʈ�� (INSERT, UPDATE,DELETE)
    -Ʈ���ſ��� ���ǵ� BEGIN ~ END ������ ������ �����.
    - BEFORE Ʈ���� : ���̺��� Ʈ���Ÿ� ���� ���� ��  INSERT, UPDATE,DELETE�� ����.
    - AFTER Ʈ���� : INSERT, UPDATE, DELETE�� ������ Ʈ���Ÿ� ����
    --��) �ֹ����̺� ���� �־��� �� ������̺� �ڵ����� ����.
    --��) �߿����̺��� �α׸� ���涧�� ����.
    -- :NEW : ���� �ӽ����̺�, Ʈ���Ű� ������ ���̺� ���Ӱ� ������ ���ڵ��� �ӽ����̺�
    -- :OLD : ������ �ӽ����̺�, Ʈ���Ű� ������ ���̺� �����Ǵ� ���ڵ��� �ӽ����̺�
    --Ʈ���Ŵ� �ϳ��� ���̺� �� 3������ ������.(INSERT,UPDATE,DELETE)
*/ 

--�ǽ����̺� 2�� ���� : ���̺��� ������ ����


CREATE TABLE  DEPT_COPY
AS
SELECT * FROM DEPARTMENT
WHERE 0=1;

DROP TABLE TRI_SAMPLE1;

--Ʈ���� ����(DEPT_ORIGINAL ���̺� ����, INSERT �̺�Ʈ�� �߻��ɶ� �ڵ����� �۵�)
CREATE OR REPLACE TRIGGER TRI_SAMPLE1
    --Ʈ���Ű� ������ ���̺�, �̺�Ʈ(INSERT, UPDATE, DELETE),BEFORE,AFTER
     AFTER INSERT      --INSERT �̺�Ʈ�� �۵��ǰ� �� �Ŀ� Ʈ���Ű� �۵�(BEFIN ~END ������ �ڵ�)
    ON DEPT_ORIGINAL
    FOR EACH ROW --��� ROW�� ���ؼ� 
    
BEGIN       --Ʈ���Ű� ������ �ڵ� 
    IF INSERTING THEN 
        DBMS_OUTPUT.PUT_LINE('INSERT TRIGGER �߻�!!!!');
        INSERT INTO DEPT_COPY
        VALUES( :NEW.DNO, :NEW.DNAME, :NEW.LOC) ; --NEW �����ӽ����̺�
    END IF;
END;
/

SELECT * FROM USER_SOURCE
WHERE NAME ='TRI_SAMPLE1';

SELECT * FROM DEPT_ORIGINAL;
SELECT * FROM DEPT_COPY;

INSERT INTO DEPT_ORIGINAL
VALUES (13,'PROGRAM','BUSAN');
COMMIT;

-- Ʈ���� Ȯ�� ������ ���� : USER_SOURCE 

/*DELETE Ʈ���� : DEPT_ORGINAL���� ���� ==>DEPT_COPY���� �ش系�������� */

CREATE OR REPLACE TRIGGER TRI_DEL
    --Ʈ���Ű� �۵���ų���̺� , �̺�Ʈ
    AFTER DELETE --�������̺��� DELETE�� ���� ������ Ʈ���� �۵� 
    ON DEPT_ORIGINAL  --DEPT_ORIGINAL ���̺� Ʈ���� ����
    FOR EACH ROW
BEGIN 
    DBMS_OUTPUT.PUT_LINE('DELETE TRIGGER �߻���!!');
    DELETE DEPT_COPY
    WHERE DEPT_COPY.DNO = :OLD.DNO;     --DEPT_ORIGINAL���� �����Ǵ� �����ӽ����̺� : OLD
END;
/

DELETE DEPT_ORIGINAL
WHERE DNO=13;

SELECT * FROM DEPT_ORIGINAL;
SELECT * FROM DEPT_COPY;


/* UPDATE Ʈ���� : DEPT_ORIGINAL ���̺��� Ư������ �����ϸ� DEPT_COPY ���̺��� ������ ������Ʈ ��.*/

CREATE OR REPLACE TRIGGER TRI_UPDATE
    AFTER UPDATE
    ON DEPT_ORIGINAL
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('UPDATE TRIGGER �߻�');
    UPDATE DEPT_COPY
    SET DEPT_COPY.DNAME = :NEW.DNAME 
    WHERE DEPT_COPY.DNO = 13;
END;
/
SELECT * FROM DEPT_ORIGINAL;    -- <<�ֹ����̺� ����>>
SELECT * FROM DEPT_COPY;        -- <<������̺� ����>>

UPDATE DEPT_ORIGINAL
SET DNAME ='PROG'
WHERE DNO=13;







