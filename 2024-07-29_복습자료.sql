-- * ������ �������� ������ �� �Ʒ� �������� �������ּ���.
--   USERNAME / PWD : C##TESTUSER / 1234
--------------------------------------------------------------------------------------------------------
DROP TABLE DEPARTMENTS;
DROP TABLE EMPLOYEES;

-- DEPARTMENTS ���̺� ����
CREATE TABLE DEPARTMENTS (
    DEPT_ID NUMBER PRIMARY KEY,
    DEPT_NAME VARCHAR2(50) NOT NULL
);

-- EMPLOYEES ���̺� ����
CREATE TABLE EMPLOYEES (
    EMP_ID NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(50) NOT NULL,
    SALARY NUMBER,
    HIRE_DATE DATE,
    DEPT_ID NUMBER,
    FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENTS(DEPT_ID)
);

-- DEPARTMENTS ������ ����
INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME) VALUES (1, '�λ��');
INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME) VALUES (2, '�繫��');
INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME) VALUES (3, 'IT�μ�');

-- EMPLOYEES ������ ����
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (101, 'ȫ�浿', 5000, TO_DATE('2020-01-15', 'YYYY-MM-DD'), 1);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (102, '��ö��', 4500, TO_DATE('2019-03-22', 'YYYY-MM-DD'), 2);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (103, '�̿���', 5500, TO_DATE('2021-07-10', 'YYYY-MM-DD'), 3);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (104, '������', 6500, TO_DATE('2018-11-05', 'YYYY-MM-DD'), 2);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (105, '�ֹ�ȣ', 7000, TO_DATE('2022-02-18', 'YYYY-MM-DD'), 1);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (106, '�ű��', 4000, TO_DATE('2024-05-13', 'YYYY-MM-DD'), 3);
--------------------------------------------------------------------------------------------------------

-- ��� ������ �̸��� �޿��� ��ȸ 


-- '�繫��'�� ���� �������� �̸��� �μ����� ��ȸ 


-- ��� ������ ��� �޿��� ��� 


-- �μ��� ���� ���� ����ϰ�, ���� ���� 1�� �̻��� �μ��� ��ȸ 


-- ��� ������ �̸��� �ش� �μ����� ��ȸ 

-- �޿��� ���� ���� ������ �̸��� �޿��� ��ȸ

-- ���ο� ���̺� PROJECTS�� ���� ( ���� ����: ������Ʈ��ȣ (PROJECT_ID:NUMBER (PK), ������Ʈ�� (PROJECT_NAME:VARCHAR2(100) NULL ���X)))

-- ���ο� ���� '�����'�� EMPLOYEES ���̺� ���� ( ��� ����, �޿� 6200, IT�μ�, ���� �Ի�)

-- EMPLOYEES ���̺��� 'ȫ�浿'�� �޿��� 5500���� ����

-- EMPLOYEES ���̺��� �޿��� 5000 ������ �������� ����

-- EMPLOYEES ���̺� ���ο� �÷� EMAIL�� �߰� (VARCHAR2(100))

-- �μ��� ��� �޿��� ����ϰ�, ��� �޿��� 6000 �̻��� �μ��� ��ȸ

-- ��� ������ �̸��� �޿��� �����ϴ� �� EMP_VIEW�� ����

-- �� EMP_VIEW�� ����

-- EMPLOYEES ���̺��� ����