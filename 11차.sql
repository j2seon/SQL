/*
    권한 관리
    -- 사용 권한 : DBMS는 여러명이 사용.
        - 각 사용자별로 계정을 생성 : DBMS엣 접속할 수 있는 사용자를 생성해야한다.
            (인증 (Authentication): Credential(Identity+password) 확인)
            (허가 (Authorization): 인증된 사용자에게 Oracle의 시스템 권한, 객체(테이블,뷰,트리거,함수 ) 권한 부여)
                -System Privilleges : 오라클 전반적인 권한 ,테이블 스페이스 내에소 전반적인 권한.
                -Object privilleages : 테이블 , 뷰, 트리거 , 함수 ,저장프로시져, 시퀀스, 인덱스 접근권한.
*/

--Oracle에서 계정 생성. (일반 계정에서는 계정을 생성 할 수 있는 권한이 없다 )
--create user 계정명 identified by 패스워드; 
create user usertest01 identified by 1234; --오류
show user;


--Object Privileges : 테이블, 뷰, 트리거, 함수,
/*   -- 저장프로시져, 시퀀스 , 인덱스 에 부여되는 권한 할당. 
  ---------------------------------------------------- 
     권한         Table   view    sequence   procedeur
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

-- 특정 테이블에 selete 권한 부여하기

create user user_test10 identified by 1234; --계정생성>>sys 계정으로





















