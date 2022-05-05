create database xe;
use xe;

DROP TABLE DEPARTMENT;
DROP TABLE SALGRADE;
DROP TABLE EMPLOYEE;
ROLLBACK;
CREATE TABLE DEPARTMENT
        (DNO INT,
         DNAME VARCHAR(14),
		 LOC VARCHAR(13) ,
         CONSTRAINT PK_DEPT primary key (dno)) ;
CREATE TABLE EMPLOYEE 
        (ENO INT ,
	 ENAME VARCHAR(10),
 	 JOB   VARCHAR(9),
	 MANAGER  INT,
	 HIREDATE DATE,
	 SALARY double,
	 COMMISSION double,
	 DNO INT,
     CONSTRAINT FK_DNO FOREIGN KEY (dno) REFERENCES DEPARTMENT (dno),
     constraint PK_EMP Primary key(eno));
CREATE TABLE SALGRADE
        (GRADE INT,
	 LOSAL INT,
	 HISAL INT );

INSERT INTO DEPARTMENT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPARTMENT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPARTMENT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPARTMENT VALUES (40,'OPERATIONS','BOSTON');

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','CLERK',7902,str_to_date('17-12-1980','%d,%m,%Y'),800,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7499,'ALLEN','SALESMAN',7698,str_to_date('20-2-1981', '%d,%m,%Y'),1600,300,30);
INSERT INTO EMPLOYEE VALUES
(7521,'WARD','SALESMAN',7698,str_to_date('22-2-1981', '%d,%m,%Y'),1250,500,30);
INSERT INTO EMPLOYEE VALUES
(7566,'JONES','MANAGER',7839,str_to_date('2-4-1981',  '%d,%m,%Y'),2975,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7654,'MARTIN','SALESMAN',7698,str_to_date('28-9-1981','%d,%m,%Y'),1250,1400,30);
INSERT INTO EMPLOYEE VALUES
(7698,'BLAKE','MANAGER',7839,str_to_date('1-5-1981', '%d,%m,%Y'),2850,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7782,'CLARK','MANAGER',7839,str_to_date('9-6-1981', '%d,%m,%Y'),2450,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7788,'SCOTT','ANALYST',7566,str_to_date('13-07-1987','%d,%m,%Y'),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7839,'KING','PRESIDENT', NULL,str_to_date('17-11-1981','%d,%m,%Y'),5000,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7844,'TURNER','SALESMAN',7698,str_to_date('8-9-1981','%d,%m,%Y'),1500,0,30);
INSERT INTO EMPLOYEE VALUES
(7876,'ADAMS','CLERK',7788,str_to_date('13-07-1987', '%d,%m,%Y'),1100,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7900,'JAMES','CLERK',7698,str_to_date('3-12-1981','%d,%m,%Y'),950,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7902,'FORD','ANALYST',7566,str_to_date('3-12-1981', '%d,%m,%Y'),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7934,'MILLER','CLERK',7782,str_to_date('23-1-1982','%d,%m,%Y'),1300,NULL,10);

INSERT INTO SALGRADE VALUES (1, 700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

COMMIT;

SELECT * FROM EMPLOYEE;


DELETE FROM 