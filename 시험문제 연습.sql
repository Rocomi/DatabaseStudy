-- * QUIZ1 * --------
/*
	CREATE USER C##TEST IDENTIFIED BY 1234; ����
	User C##TEST��(��) �����Ǿ����ϴ�.
    
	���� ������ �ϰ� ���� �� ���� (user C##TEST lacks CREATE SESSION privillege; logon denied ����)
*/

-- ���� ? ����� ������ ������ �Ŀ� ������ �ο����� ����
-- �ذ��� ? - ������ �������� ������ �Ŀ� �ش� ����ڿ� �ּ����� ����(CONNECT, RESOURCE)�� �ο������ ��
--           - ������ �������� ������ �� CREATE SESSION ������ �ο������ ��
-- GRANT CONNECT, RESOURCE TO "C##TEST";

-- * QUIZ2 * --------
CREATE TABLE TB_JOB (
	JOBCODE NUMBER PRIMARY KEY,
	JOBNAME VARCHAR2(10) NOT NULL
);

CREATE TABLE TB_EMP (
	EMPNO NUMBER PRIMARY KEY,
	EMPNAME VARCHAR2(10) NOT NULL,
	JOBNO NUMBER REFERENCES TB_JOB(JOBCODE)
);
/*
	���� �� ���̺��� �����Ͽ� EMPNO, EMPNAME, JOBNO, JOBNAME �÷��� ��ȸ�ϰ��� �Ѵ�.
	�̶� ������ SQL���� �Ʒ��� ���ٰ� ���� ��,
*/
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
	JOIN TB_JOB USING(JOBNO);
-- ������ ���� ������ �߻��ߴ�.
-- ORA-00904: "TB_JOB"."JOBNO": invalid identifier

-- ���� ? �����ϰ��� �ϴ� �� ���̺��� ����� ������ �ϴ� �÷����� �ٸ��Ƿ� JOIN~USING ������ ����� �� ����
-- �ذ��� ? JOIN~USING������ JOIN~ON�������� ����
--           JOIN TB_JOB ON (JOBCODE = JOBNO)


/*
	* �˻��ϰ��� �ϴ� ���� :
	
		�����ڵ尡 J7�̰ų� J6�̸鼭 SALARY ���� 200���� �̻��̰�
		BONUS�� �ְ� �����̸� �̸����ּҴ� _�տ� 3���ڸ� �ִ� �����
		�����, �ֹε�Ϲ�ȣ, �����ڵ�, �μ��ڵ�, �޿�, ���ʽ��� ��ȸ�ϰ��� �Ѵ�.
		
		(���������� ��ȸ�� �ȴٸ� 2���� ����� Ȯ���� �� ����)
*/

-- �Ʒ� ���������� ���� �� ���ϴ� ����� ������ �ʴ´�. 
-- � ������ �ִ� �� ������ �ľ��Ͽ� �ۼ��� ��, �ذ����ּ���.
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6'  -- JOB_CODE IN ('J7', 'J6')
      AND SALARY > 2000000
      AND EMAIL LIKE '____%' ESCAPE '#'
      AND BONUS IS NULL
--      AND SUBSTR(EMP_NO, 8, 1) IN (2, 4);
-- ���� : 
/*
    1) �����ڵ忡 ���� ������ �켱������ ���� ����� ������� ����
       => ��ȣ�� �����ְų� IN �����ڷ� ��ü�ؾ� ��
    2) �ۼ��� ������ SALARY ���� 200���� �ʰ�(>)�� �ۼ��Ǿ� ����
       => 200���� �̻��� ������ ��ȣ�� �߰�������� (>=)
    3) �̸����� 4��°�ڸ��� �����(_)�� ���ϵ�ī��� ����
       => �����ν� ������ �ְ��� �Ѵٸ� ESCAPE�� ����Ͽ� ������ ���ϵ�ī��� ��������� ��
    4) ���ʽ��� �ִ� ����� ��ȸ�ؾ��ϴµ� ���� ����� ��ȸ�ϰ� ����
       => BONUS IS NULL --> BONUS IS NOT NULL�� ��������� ��
    5) ���� ��� ������ ������
       => ���� ��� ������ �߰������ ��
*/