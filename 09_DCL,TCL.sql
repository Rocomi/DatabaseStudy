/*
    * DCL (DATA CONTROL LANGUAGE) : ������ ���� ���
    
    => ������ �ý��� ����/ ��ü���� ������ �ο��ϰų� ȸ���ϴ� ����
    
        - �ý��� ���� : DB�� �����ϴ� ����, ��ü�� ������ �� �ִ� ����
        - ��ü���� ���� : Ư�� ��ü���� ������ �� �ִ� ����
*/
/*
    * ���� ���� * 
    CREATE USER ������ IDENTIFIED BY ��й�ȣ;
    
    * ���� �ο�*
    GRANT ����(CONNECT, RESOURCE) TO ������;
    
    * �ý��� ���� ���� *
    - CREATE SESSION : ���� ����
    - CREATE TABLE : ���̺� ���� ����
    - CREATE VIEW : �� ���� ����
    - CREATE SEQUENCE : ������ ���� ����
    ...
    
    * ��ü ���� ���� ���� * 
    
    ����      | ���� ��ü
    SELECT    | TABELE, VIEW, SEQUENCE      -- ��ȸ(R)
    INSERT     | TABLE, VIEW                -- �߰�(C)
    UPDATE     | TABLE, VIEW                -- ����(U)
    DELETE      | TABLE, VIEW               -- ����(D)
    
    GRANT �������� ON Ư����ü TO ������;
    ex) GRANT SELECT ON KH.EMPLOYEE TO TEST
    --> TEST ������ KH������ EMPLOYEE ���̺��� ��ȸ�� �� �ִ� ������ �ο�
    
    * ���� ȸ�� *
    REVOKE ȸ���ұ��� FROM ������;
    ex) REVOKE SELECT ON KH.EMPLOYEE FROM TEST;
    --> TEST ������ �ο��ߴ� KH ������ EMPLOYEE ���̺��� ��ȸ�� �� �ִ� ������ ȸ��
*/
/*
    ROLE (��, ��Ģ) : Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ��� ��
    
    - CONNECT   : ���� ���� (CREATE SESSION)
    - RESOURCE  : �ڿ� ���� (Ư�� ��ü ���� ����) (CREATE TABLE, CREATE VIEW, ...)
*/
-- �� ������ ��ȸ
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT', 'RESOURCE');

SELECT * FROM ROLE_SYS_PRIVS
WHERE PRIVILEGE LIKE '%VIEW%';

--------------------------------------------------------------------------------
/*
    TCL (Transaction Control Language)
    
    * Ʈ������ : �����ͺ��̽��� ���� ���� ����
                �������� �������(DML ��� ��)���� �ϳ��� ����ó�� Ʈ�����ǿ� ��Ƶ�
                
    * Ʈ������ ����
        - COMMIT : Ʈ����ǿ� ����� �ִ� ������׵��� ���� DB�� �����ϰڴٸ� �ǹ�!
        - ROLLBACK : Ʈ����ǿ� ����ִ� ������׵��� ����(���) �ϰ�,
                        ������ COMMIT ��ġ(����)�� ���ư��� ���� �ǹ�!
        - SAVEPOINT : ���� ������ ������׵��� �ӽ÷� �����صδ� ���� �ǹ�!
                        ROLLBACK �� ��ü ��������� ��� �������� �ʰ� �ش� ��ġ������ ��Ұ� ����
*/
-- EMP01 ���̺� ����
DROP TABLE EMP01;   --> DDL. Ʈ������ ó�� X

-- EMP01 ���̺��� ���� (EMPLOYEE ���̺��� ���, �����, �μ����� ��ȸ)
CREATE TABLE EMP01
AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
        FROM EMPLOYEE
            JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    ); 
    
SELECT * FROM EMP01;

-- ����� 217, 214 �� ��� ���� -> DML. Ʈ����� ó�� O.
DELETE FROM EMP01 WHERE EMP_ID IN (217, 214);

ROLLBACK;       -- ������� ��� (Ʈ������� ����)
--------------------------------------------------------------------------------
DELETE FROM EMP01 WHERE EMP_ID = 217;
DELETE FROM EMP01 WHERE EMP_ID = 214;

COMMIT;     -- ������� ����
ROLLBACK;   --������ COMMIT �������� ���ư�
--------------------------------------------------------------------------------
-- 208, 209 210 �� ����� ����
DELETE FROM EMP01
WHERE EMP_ID IN (208, 209, 210);

SAVEPOINT SP;

--500�� ��� �߰�
INSERT INTO EMP01 VALUES (500, 'ī����', '�ؿܿ���2��');

-- 215�� ��� ����
DELETE FROM EMP01 WHERE EMP_ID = 215;

-- SP �������� �ѹ�
ROLLBACK TO SP;
COMMIT;     -- SP�������� ���ư� �� COMMIT�� �߱� ���� EDLETE 208, 209, 210�� DB�� �����

--------------------------------------------------------------------------------
SELECT * FROM EMP01;


-- 221�� ��� ����
DELETE FROM EMP01 WHERE EMP_ID = 221;

-- DDL�� ���..
CREATE TABLE TEST (
    TID NUMBER
);

ROLLBACK;

--> DDL��(CREATE, ALTER, DROP)�� ����ϰ� �Ǹ� ���� Ʈ����ǿ� ����� ������׵��� ������ �ݿ���(COMMIT)
-- DDL�� ����� DML�� ���� �������� �ִٸ� Ȯ���ϰ� ó���� �Ŀ� DDL�� ����ؾ���!















