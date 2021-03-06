DROP TABLE EMPLOYEE;
DROP TABLE DEPARTMENT;
DROP TABLE SALGRADE;

CREATE TABLE DEPARTMENT
        (DNO INTEGER CONSTRAINT PK_DEPT PRIMARY KEY,
         DNAME VARCHAR(14),
	 LOC   VARCHAR(13) ) ;
CREATE TABLE EMPLOYEE 
        (ENO INTEGER CONSTRAINT PK_EMP PRIMARY KEY,
	 ENAME VARCHAR(10),
 	 JOB   VARCHAR(9),
	 MANAGER  INTEGER,
	 HIREDATE DATE,
	 SALARY INTEGER,
	 COMMISSION SMALLMONEY,
	 DNO INTEGER CONSTRAINT FK_DNO REFERENCES DEPARTMENT);
CREATE TABLE SALGRADE
        (GRADE BIGINT,
	 LOSAL BIGINT,
	 HISAL BIGINT );

INSERT INTO DEPARTMENT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPARTMENT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPARTMENT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPARTMENT VALUES (40,'OPERATIONS','BOSTON');

/*
DELETE EMPLOYEE 
WHERE ENO=7369

SELECT CONVERT(VARCHAR(10), 19801217, 120)


*/



INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','CLERK', 7902, CONVERT(CHAR(10), CONVERT(DATETIME, '19801217'), 101),800,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7499,'ALLEN','SALESMAN', 7698,CONVERT(CHAR(10), CONVERT(DATETIME, '19810220'), 101),1600,300,30);
INSERT INTO EMPLOYEE VALUES
(7521,'WARD','SALESMAN', 7698,CONVERT(CHAR(10), CONVERT(DATETIME, '19810222'), 101),1250,500,30);
INSERT INTO EMPLOYEE VALUES
(7566,'JONES','MANAGER', 7839,CONVERT(CHAR(10), CONVERT(DATETIME, '19810402'), 101),2975,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7654,'MARTIN','SALESMAN', 7698,CONVERT(CHAR(10), CONVERT(DATETIME, '19810928'), 101),1250,1400,30);
INSERT INTO EMPLOYEE VALUES
(7698,'BLAKE','MANAGER', 7839,CONVERT(CHAR(10), CONVERT(DATETIME, '19810501'), 101),2850,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7782,'CLARK','MANAGER', 7839,CONVERT(CHAR(10), CONVERT(DATETIME, '19810609'), 101),2450,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7788,'SCOTT','ANALYST', 7566,CONVERT(CHAR(10), CONVERT(DATETIME, '19870713'), 101),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7839,'KING','PRESIDENT', NULL,CONVERT(CHAR(10), CONVERT(DATETIME, '19811117'), 101),5000,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7844,'TURNER','SALESMAN',7698,CONVERT(CHAR(10), CONVERT(DATETIME, '19810908'), 101),1500,0,30);
INSERT INTO EMPLOYEE VALUES
(7876,'ADAMS','CLERK',    7788,CONVERT(CHAR(10), CONVERT(DATETIME, '19870713'), 101),1100,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7900,'JAMES','CLERK',    7698,CONVERT(CHAR(10), CONVERT(DATETIME, '19811203'), 101),950,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7902,'FORD','ANALYST',   7566,CONVERT(CHAR(10), CONVERT(DATETIME, '19811203'), 101),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7934,'MILLER','CLERK',   7782,CONVERT(CHAR(10), CONVERT(DATETIME, '19820123'), 101),1300,NULL,10);

INSERT INTO SALGRADE VALUES (1, 700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);


select * from employee;
select * from department;
select * from SALGRADE;

--COMMIT;
/*MS-SQL,MYSQL?? ???? ???????????? : DML (INSERT, UPDATE,DELETE)

MSSQL,MYSQL?? ?????????? ??????, UPDATE, DELETE ?????? ?????? ?? ?????? ?????????? ????, COMMIT; ROLLBACK;

*/

SELECT * FROM EMPLOYEE;
SELECT ENO AS ???????? , ENAME ??????, JOB , JOB,SALARY,SALARY FROM EMPLOYEE;

SELECT DNO , COUNT(*), MIN(SALARY),MAX(SALARY),SUM(SALARY), AVG(SALARY)
FROM EMPLOYEE 
GROUP BY DNO;

--ANSI ???? : INNER JOIN, ORACLE, MYSQL, MSSQL....
SELECT ENO, ENAME, SALARY, E.DNO, DNAME, LOC
FROM EMPLOYEE E JOIN DEPARTMENT D
ON  E.DNO=D.DNO;

--?????? ????
SELECT * INTO EMP_COPY
FROM EMPLOYEE;

SELECT * FROM EMP_COPY;

UPDATE EMP_COPY
SET ENAME='PARK'
WHERE ENO=7934;

BEGIN TRANSACTION; --?????????? ???????? ?????????? ???????? ?????? ?????? ?? ????! WHERE ?????? ?????????? ?????? ???? ???????? ??????????.
DELETE EMP_COPY

ROLLBACK;
COMMIT;




