-- ���� �ּ�
/*
    ������ �ּ�
*/
SELECT * FROM DBA_USERS;    -- ���� ��� �����鿡 ���Ͽ� ��ȸ�ϴ� ��ɹ�
-- ��ɹ� ���� : �ʷϻ� �����ư Ŭ�� �Ǵ� Ctrl + Enter

-- �Ϲ� ����� ���� ���� ���� (������ �������θ� ����!)
-- [ǥ����] CREATE USER ������ IDENTIFIED BY ��й�ȣ;
CREATE USER "C##KH" IDENTIFIED BY KH;

-- ������ ����� ������ �ּ��� ���� (������ ����, ����) �ο�
-- [ǥ����] GRANT ����1, ����2, ... TO ������;
GRANT CONNECT, RESOURCE TO "C##KH";

-- ���̺� �����̽� ���� ����
ALTER USER "C##KH" DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;


CREATE USER "C##GENEJAR" IDENTIFIED BY GENEJAR;
GRANT CONNECT, RESOURCE TO "C##GENEJAR";
ALTER USER "C##GENEAJR" DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

CREATE USER "C##HOMEWORK" IDENTIFIED BY HOMEWORK;
GRANT CONNECT, RESOURCE TO "C##HOMEWORK";
ALTER USER "C##HOMEWORK" DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

-- �並 ������ �� �ִ� ������ �ο�
-- GRANT CREATE VIEW TO C##KH;