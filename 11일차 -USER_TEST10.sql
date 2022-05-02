create table test10tbl(
    a number not null,
    b varchar(50) null
);

--user_test10에서 HR이 소유주인 employee 테이블을 접근할때 객체에 접근 권한이 필요하다.  (소유주가 다르다.)
/*grant select on hr. employee to user_test10; - sys계정에서 부여해줌*/
select *from hr.employee ; --권한을 부여받고 나면 접근이 가능하다.

--user_test10에서 만든 테이블 보기
show user;
select * from test10tbl;

-- 다른사용자의 객체를 접근할때는 소유주명.객체명!!!! 
select * from employee;          --오류발생
select * from HR.employee;       -- 다른사용자의 객체를 접근할때 권한이 있어야한다.

--다른 사용자 테이블에서 insert 권한.
desc hr.employee;
select * from hr.emp_copy55; --오류남 : 권한이 부여되지 않았음!!! / 부여하고 나면 가능 grant select on hr.emp_copy55 to user_test10(sys 에서)

--insert
insert into hr.emp_copy55(eno)
values( 3333 );

--with grant opion을 부여받았다. (select , hr.employee) 자기테이블이 아닌데 권한을 부여해줬음..
    --sys계정에서 grant select on hr.employee to user_test10 with grant option ; 를 통해 권한을 부여받아서!!!
grant select on hr.employee to user_test11;

select * from hr.dept_copy55; --오류남 : 권한이 부여되지 않았음!!! 할당되면 가능
grant select on hr.dept_copy55 to user_test11;
select * from hr.dept_copy56; -- 받은 권한 확인 

select * from hr.dept_copy57; --받은 권한 확인하기



