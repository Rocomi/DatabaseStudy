CREATE USER C##TESTUSER IDENTIFIED BY 1234;     --사용자 계정 추가

GRANT CONNECT,RESOURCE TO C##TESTUSER;          -- 사용자 계정에 권한 부여
                                                --(최소한의 권한 : CONNECT(접속), RESOURCE(자원관리))
DROP TABLE CUSTOMER;       
                                                
                                             