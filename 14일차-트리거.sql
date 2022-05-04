/*
    트리거(TRIGGER) : 권총의 방아쇠(트리거), 방아쇠를 당기면 총알이 발사됨.
    -테이블에 부착되어있다.
    -테이블에 이번트가 발생될때 짜동으로 작동되는 프로그램 코드
    -테이블에 발생되는 이벤트는 (INSERT, UPDATE,DELETE)
    -트리거에서 정의된 BEGIN ~ END 사이의 문장이 실행됨.
    - BEFORE 트리거 : 테이블에서 트리거를 먼저 실행 후  INSERT, UPDATE,DELETE가 적용.
    - AFTER 트리거 : INSERT, UPDATE, DELETE가 실행후 트리거를 실행
    --예) 주문테이블에 값을 넣었을 때 배송테이블에 자동으로 저장.
    --예) 중요테이블의 로그를 남길때도 사용됨.
    -- :NEW : 가상 임시테이블, 트리거가 부착된 테이블에 새롭게 들어오는 레코드의 임시테이블
    -- :OLD : 가상의 임시테이블, 트리거가 부착된 테이블에 삭제되는 레코드의 임시테이블
    --트리거는 하나의 테이블에 총 3개까지 부착됨.(INSERT,UPDATE,DELETE)
*/ 

--실습테이블 2개 생성 : 테이블의 구조만 복사


CREATE TABLE  DEPT_COPY
AS
SELECT * FROM DEPARTMENT
WHERE 0=1;

DROP TABLE TRI_SAMPLE1;

--트리거 생성(DEPT_ORIGINAL 테이블에 부착, INSERT 이벤트가 발생될때 자동으로 작동)
CREATE OR REPLACE TRIGGER TRI_SAMPLE1
    --트리거가 부착될 테이블, 이벤트(INSERT, UPDATE, DELETE),BEFORE,AFTER
     AFTER INSERT      --INSERT 이벤트가 작동되고 난 후에 트리거가 작동(BEFIN ~END 사이의 코드)
    ON DEPT_ORIGINAL
    FOR EACH ROW --모든 ROW에 대해서 
    
BEGIN       --트리거가 실행할 코드 
    IF INSERTING THEN 
        DBMS_OUTPUT.PUT_LINE('INSERT TRIGGER 발생!!!!');
        INSERT INTO DEPT_COPY
        VALUES( :NEW.DNO, :NEW.DNAME, :NEW.LOC) ; --NEW 가상임시테이블
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

-- 트리거 확인 데이터 사전 : USER_SOURCE 

/*DELETE 트리거 : DEPT_ORGINAL에서 제거 ==>DEPT_COPY에서 해당내용을제거 */

CREATE OR REPLACE TRIGGER TRI_DEL
    --트리거가 작동시킬테이블 , 이벤트
    AFTER DELETE --원본테이블의 DELETE를 먼저 실행후 트리거 작동 
    ON DEPT_ORIGINAL  --DEPT_ORIGINAL 테이블에 트리거 부착
    FOR EACH ROW
BEGIN 
    DBMS_OUTPUT.PUT_LINE('DELETE TRIGGER 발생됨!!');
    DELETE DEPT_COPY
    WHERE DEPT_COPY.DNO = :OLD.DNO;     --DEPT_ORIGINAL에서 삭제되는 가상임시테이블 : OLD
END;
/

DELETE DEPT_ORIGINAL
WHERE DNO=13;

SELECT * FROM DEPT_ORIGINAL;
SELECT * FROM DEPT_COPY;


/* UPDATE 트리거 : DEPT_ORIGINAL 테이블의 특정값을 수정하면 DEPT_COPY 테이블의 내용을 업데이트 함.*/

CREATE OR REPLACE TRIGGER TRI_UPDATE
    AFTER UPDATE
    ON DEPT_ORIGINAL
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('UPDATE TRIGGER 발생');
    UPDATE DEPT_COPY
    SET DEPT_COPY.DNAME = :NEW.DNAME 
    WHERE DEPT_COPY.DNO = 13;
END;
/
SELECT * FROM DEPT_ORIGINAL;    -- <<주문테이블 가정>>
SELECT * FROM DEPT_COPY;        -- <<배송테이블 가정>>

UPDATE DEPT_ORIGINAL
SET DNAME ='PROG'
WHERE DNO=13;







