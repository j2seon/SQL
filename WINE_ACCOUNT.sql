--

CREATE TABLE grade_pt_rade(
    mem_grade varchar2(20) PRIMARY KEY,
    grade_pt_rate number (3,2)
);
SELECT * FROM grade_pt_rade;

CREATE TABLE today(
    today_code varchar2(6) PRIMARY KEY,
    today_sens_value number(3),
    today_intell_value number(3),
    today_phy_value number(3)
);
SELECT * FROM today;

CREATE TABLE nation(
    nation_code varchar2(26) PRIMARY KEY,
    nation_name varchar2 (50) CONSTRAINT NN_nation_nation_name NOT NULL
);
SELECT * FROM nation;


CREATE TABLE theme(
    theme_code varchar2(6) PRIMARY KEY,
    theme_name varchar2(50) CONSTRAINT NN_theme_theme_name NOT NULL
); 
SELECT * FROM theme;


CREATE TABLE manager(
    manager_id varchar2(30) PRIMARY KEY,
    manager_pwd varchar2(20) CONSTRAINT NN_manager_manager_pwd NOT NULL,
    manager_tel varchar2(20)
);
SELECT * FROM manager;


CREATE TABLE wine_type(
    wine_type_code varchar2(6) PRIMARY KEY,
    wine_type_name varchar2(50)
);
SELECT * FROM wine_type;


CREATE TABLE wine(
    wine_code varchar2(26) PRIMARY KEY,
    wine_name varchar2(100) CONSTRAINT wine_wine_name NOT NULL,
    wine_url blob,
    nation_code varchar2(6),
    CONSTRAINT FK_wine_nation_code FOREIGN KEY (nation_code) REFERENCES nation(nation_code),
    wine_type_code varchar2(6),
    CONSTRAINT FK_wine_wine_type_code FOREIGN KEY (wine_type_code) REFERENCES wine_type(wine_type_code),
    wine_sugar_code number(2),
    wine_price number(15) CONSTRAINT NN_wine_wine_price NOT NULL,
    wine_vintage DATE,
    theme_code varchar2(6),
    CONSTRAINT FK_wine_theme_code FOREIGN KEY(theme_code) REFERENCES theme(theme_code),
    today_code varchar2(6),
    CONSTRAINT FK_today_today_code FOREIGN KEY(today_code) REFERENCES today(today_code)
);
SELECT * FROM wine;

CREATE TABLE member(
    mem_id varchar2(6) PRIMARY KEY,
    mem_grade varchar2 (20),
    CONSTRAINT FK_member_grade_grade_pt_rade FOREIGN KEY (mem_grade) REFERENCES grade_pt_rade(mem_grade),
    mem_pw varchar2(20) CONSTRAINT NN_member_mem_pw NOT NULL,
    mem_birth date DEFAULT SYSDATE NOT NULL,
    mem_tel varchar2(20),
    mem_pt varchar2(10) DEFAULT 0 NOT NULL
);

SELECT * FROM member;

CREATE TABLE stock_mamagement (
    stock_code varchar2(6) PRIMARY KEY,
    wine_code varchar2(6),
    CONSTRAINT stock_mamagement_wine_code FOREIGN KEY (wine_code) REFERENCES wine(wine_code),
    manager_id varchar2(30),
    CONSTRAINT stock_mamagement_manager_id FOREIGN KEY (manager_id) REFERENCES manager (manager_id),
    ware_date date DEFAULT SYSDATE NOT NULL,
    stock_amount number(5) DEFAULT 0 NOT NULL
);
SELECT * FROM stock_mamagement;

CREATE TABLE sale(
    sale_date date DEFAULT SYSDATE PRIMARY KEY,
    wine_code varchar2(6) NOT NULL ,
    CONSTRAINT NN_sale_wine_code FOREIGN KEY (wine_code) REFERENCES wine(wine_code) ,
    mem_id varchar2(30)NOT NULL ,
    CONSTRAINT NN_sale_mem_id FOREIGN KEY (mem_id) REFERENCES member(mem_id),
    sale_amount varchar2(5)DEFAULT 0 NOT NULL,
    sale_price varchar2(6)DEFAULT 0 NOT NULL,
    sale_tot_price varchar2(15)DEFAULT 0 NOT NULL
);
SELECT * FROM sale;


INSERT INTO stock_mamagement
VALUES('AK','a','1234',SYSDATE,0);

INSERT INTO stock_mamagement
VALUES('AL','aa','1235',SYSDATE,0);

INSERT INTO stock_mamagement
VALUES('AJ','aaa','1236',SYSDATE,0);
COMMIT;


--grade_pt_rade °ª
INSERT INTO grade_pt_rade
VALUES('AA',5.00);

INSERT INTO grade_pt_rade
VALUES('BB',4.00);

INSERT INTO grade_pt_rade
VALUES('CC',3.00);

SELECT * FROM grade_pt_rade;

--today °ª
INSERT INTO today
VALUES(000001,001,001,001);
INSERT INTO today
VALUES(000002,002,002,002);
INSERT INTO today
VALUES(000003,003,003,003);
COMMIT;
SELECT * FROM today;

create table today_copy
as
select * from today
where 0=1;
select * from today_copy;
create SEQUENCE tt
INCREMENT by 1
start with 1
NOCACHE;


INSERT INTO today_copy
VALUES('AA',TT.NEXTVAL,TT.NEXTVAL,TT.NEXTVAL);



INSERT INTO nation
VALUES('1234','KOREA');
INSERT INTO nation
VALUES('1233','CHINA');
INSERT INTO nation
VALUES('1244','JAPAN');
COMMIT;
SELECT * FROM nation;



INSERT INTO theme
VALUES(111111,'SWEET');
INSERT INTO theme
VALUES(111112,'HAPPY');
INSERT INTO theme
VALUES(111113,'SUMMER');
COMMIT;
SELECT * FROM theme;

INSERT INTO manager
VALUES('1234','1111','010-0000-0000');
INSERT INTO manager
VALUES('1235','2222','010-1111-1111');
INSERT INTO manager
VALUES('1236','3333','010-2222-2222');

INSERT INTO wine_type
VALUES('AAAAAA','AA');
INSERT INTO wine_type
VALUES('AAAAAB','BB');
INSERT INTO wine_type
VALUES('AAAAAC','CC');

INSERT INTO wine
VALUES('a','AA','a','1234','AAAAAA',1,100000,'96/06/01',111111,000001);

INSERT INTO wine
VALUES('aa','Ab','a','1233','AAAAAB',2,200000,'80/06/01',111112,000002);

INSERT INTO wine
VALUES('aaa','Ac','6f','1244','AAAAAC',3,30000,DEFAULT,111113,000003);

select * from wine;
commit;

INSERT INTO member
VALUES('HAHA','AA','1111',SYSDATE,'011-0000-0000','10');

INSERT INTO member
VALUES('PEP','BB','222',SYSDATE,'011-0000-0000','20');

INSERT INTO member
VALUES('ZERO','CC','333',SYSDATE,'011-0000-0000','130');

INSERT INTO sale
VALUES(SYSDATE,'a','HAHA',100,100,100);

INSERT INTO sale
VALUES(SYSDATE,'aa','ZERO',200,200,200);

INSERT INTO sale
VALUES(SYSDATE,'aaa','PEP',300,300,300);
