/*
    �������� (SUBQUERY)
    : �ϳ��� ������ ���� ���Ե� �� �ٸ� ������
    ���� ������ �ϴ� �������� ���� ���� ������ �ϴ� ������
*/

-- "���ö" ����� ���� �μ��� ���� ��� ������ ��ȸ

-- 1) ���ö ����� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';

-- 2) �μ��ڵ尡 'D9'�� ��� ��ȸ
SELECT * 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- ���� 2���� �������� �ϳ��� ���ĺ��ٸ�...
SELECT * 
FROM EMPLOYEE
WHERE DEPT_CODE = ( SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö' );
                    
                    
                    
-- ��ü ����� ��� �޿����� �� ���� �޿��� �޴� ����� ������ ��ȸ

-- 1) ��ü ����� ��� �޿� ��ȸ (�ݿø� ó��)
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

--2) ��ձ޿�(3047664)���� �� ���� �޿��� �޴� ��� ���� ��ȸ
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >=3047663;

-- ���������� ������ ���ٸ�...
SELECT EMP_NAME, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= ( SELECT ROUND(AVG(SALARY))
                FROM EMPLOYEE);
-------------------------------------------------------------------------------
/*
    * ���������� ���� *
      ���������� ������ ��� ���� ���� ��� �����Ŀ� ���� �з�
      
      - ������ �������� : ���������� ���� ����� ������ 1���� �� (1�� 1��)
      - ������ �������� : ���������� ���� ����� �������� ��(N�� 1��)+
      - ���߿� �������� : ���������� ���� ����� �� ���̰� �������� �÷��� �� (1�� N��)
      - ������ ���߿� �������� : �ź������� ���� ����� ������ ���� �÷��� �� (N�� N��)
      
      >> ������ ���� �������� �տ� �ٴ� �����ڰ� �޶���!
*/
-- ������ �������� : �������� ����� ������ 1���϶�
/*
    �Ϲ����� �񱳿����� ��� ���� : = != < > <= >= ....
*/
-- �� ������ ��� �޿����� �� ���� �޿��� �޴� ������� �����, �����ڵ�, �޿���ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEE);

-- ���� �޿��� �޴� ����� �����, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE);

-- ���ö ����� �޿����� ���� �޴� ����� �����, �μ��ڵ�, �޿� ��ȸ
-- SALARY > ���ö ����� �޿�
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');
                
-- ���� ������� �μ� �ڵ带 �μ������� �����Ͽ� ��ȸ
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö')
    AND DEPT_CODE = DEPT_ID;
    
-- �μ��� �޿����� ���� ū �μ��� �μ��ڵ�, �޿����� ��ȸ
--1) �μ��� �޿��� �� ���� �� �� �ϳ��� ��ȸ --> 17700000
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) �μ��� �޿� ���� 17700000�� �μ��� �μ��ڵ�, �޿��� ��ȸ
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = 17700000;

-- �� �������� ���غ���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = ( SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE );
                        
-- ������ ����� ���� �μ��� ������� ���, �����, ����ó, �Ի���, �μ����� ��ȸ
-- ��, ������ ����� �����ϰ� ��ȸ!

-- * ����Ŭ ���� *
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
    AND DEPT_CODE = ( SELECT DEPT_CODE
                      FROM EMPLOYEE
                      WHERE EMP_NAME = '������')
    AND EMP_NAME <> '������';

-- * ANSI ���� *
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_CODE = ( SELECT DEPT_CODE
                      FROM EMPLOYEE
                      WHERE EMP_NAME = '������')
    AND EMP_NAME <> '������';
--------------------------------------------------------------------------------
/*
    ������ �������� : �������� ���� ����� �������� ��� (N�� 1��)
    
    IN (��������) : �������� ����� �߿��� �ϳ��� ��ġ�ϴ� ���� �ִٸ� ��ȸ
    > ANY(��������) : �������� ����� �߿��� �ϳ��� ū ��찡 ������ ��ȸ
    < ANY(��������) : �������� ����� �߿��� �ϳ��� ���� ��찡 �ִٸ� ��ȸ
        * �񱳴�� > ��1 OR �񱳴�� > ��2 OR ....
    
    > ALL(��������) : ��� ��������� Ŭ ��� ��ȸ
    < ALL(��������) : ��� ��������� ���� ��� ��ȸ
         * �񱳴�� > ��1 AND �񱳴�� > ��2 AND ....
*/
-- ����� ��� �Ǵ� ������ ����� ���� ������ �ڿ����� ���� ��ȸ(���, �����, �����ڵ�, �޿�)
-- * ����� ��� �Ǵ� ������ ����� �����ڵ� ��ȸ
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('�����', '������');

-- �����ڵ尡 J3 �Ǵ� J7�� ������� ������ ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3', 'J7');

-- ���������� �����غ���
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN (SELECT JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME IN ('�����', '������'));

-- �븮 ������ ����� �� ���� ������ ����� �ּұ޿����� ���� �޴� ��� ���� ��ȸ
--      (���, �̸�, ���޸�, �޿�)
SELECT SALARY
FROM EMPLOYEE;


-- * > ANY �����ڸ� ����Ͽ� ��
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE E.JOB_CODE = J.JOB_CODE 
        AND SALARY > ANY(SELECT SALARY
                            FROM EMPLOYEE
                            JOIN JOB USING (JOB_CODE)
                            WHERE JOB_NAME = '����')
        AND JOB_NAME = '�븮';
        
--------------------------------------------------------------------------------
/*
    ������ �������� : �������� ���� ����� ���� �ϳ��̰�, �÷�(��) ���� �������� ���
*/
                                        
-- ������ ����� ���� �μ��ڵ�, ���� �����ڵ� ��ȸ
-- 1) ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ��� ������ ��ȸ
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������';

SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������';

SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������';

-- ������ ���������� ����� ��� 
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������')
    AND JOB_CODE = ( SELECT JOB_CODE
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '������');
                        
-- ������ ���������� ����� ���
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������');

-- �ڳ��� ����� ���� �����ڵ�, ���� ����� ������ �ִ� ��� ���� ��ȸ(�����, �����ڵ�, �����ȣ)
-- 1) �ڳ��� ����� �����ڵ�, �����ȣ�� ��ȸ
SELECT JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME = '�ڳ���';

-- 2) ���� �����ڵ� ���� ����� ������ �ִ� ��� ������ ��ȸ
SELECT EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = ( SELECT JOB_CODE, MANAGER_ID
                                    FROM EMPLOYEE
                                    WHERE EMP_NAME = '�ڳ���');
--------------------------------------------------------------------------------
/*
    ������ ���߿� �������� : ���������� ����� ������, �������� ���� ���
*/
-- �� ���޺� �ּұ޿��� �޴� ��� ������ ��ȸ
--1) �� ���޺� �ּұ޿�
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;
/*
J1	8000000
J2	3700000
J4	1550000
J3	3400000
J7	1380000
J5	2200000
J6	2000000
*/
-- 2) �� ���޺� �ּұ޿��� �޴� ��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOCODE = 'J1' AND SALARY = 8000000
    OR JOCODE = 'J2' AND SALARY = 3700000;
    --.......;
    
-- �������� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN ( SELECT JOB_CODE, MIN(SALARY)
                                FROM EMPLOYEE
                                 GROUP BY JOB_CODE);
                                 

-- �� �μ����� �ְ�޿��� �޴� ��� ���� ��ȸ
SELECT DEPT_CODE, MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                                FROM EMPLOYEE
                                GROUP BY DEPT_CODE);

--------------------------------------------------------------------------------
/*
    �ζ��� �� : ���������� FROM���� ����ϴ� ��
                => ���������� ���� ����� ��ġ ���̺�ó�� ����ϴ� ��
*/
-- ������� ���, �̸�, ���ʽ� ���� ����, �μ��ڵ带 ��ȸ
-- ���ʽ� ���� ������ NULL�� �ƴϾ�� �ϰ�, ���ʽ� ���� ������ 3000���� �̻��� ����鸸 ��ȸ
--          => NVL : NULL�� ��� �ٸ� ������ ����
SELECT EMP_ID, EMP_NAME, SALARY*12*(1+ NVL(BONUS, 0)), DEPT_CODE
FROM EMPLOYEE
WHERE SALARY*12*(1+ NVL(BONUS, 0)) >= 30000000
ORDER BY 3 DESC;

-- =>TOP-N �м� : ���� N���� ��ȸ
SELECT ROWNUM, ���, �̸�, ����, �μ��ڵ�
FROM (SELECT EMP_ID ���, EMP_NAME �̸�, SALARY*12*(1+ NVL(BONUS, 0)) ����, DEPT_CODE �μ��ڵ�
        FROM EMPLOYEE
        WHERE SALARY*12*(1+ NVL(BONUS, 0)) >= 30000000
        ORDER BY 3 DESC)
WHERE ROWNUM <= 5;

-- ���� �ֱٿ� �Ի��� ��� 5���� ��ȸ
-- �Ի��� ���� �������� ���� (���, �̸�, �Ի���)
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;

SELECT ROWNUM, EMP_ID, EMP_NAME, HIRE_DATE
FROM (SELECT EMP_ID, EMP_NAME, HIRE_DATE
        FROM EMPLOYEE
        ORDER BY HIRE_DATE DESC)
WHERE ROWNUM <= 5;
--------------------------------------------------------------------------------
/*
    ������ �ű�� �Լ� (WINDOW FUNCTION)
    
    - RANK() OVER(���ı���) : ������ ���� ������ ����� ������ �� ��ŭ �ǳʶٰ� ���� ���
    - DENSE_RANK() OVER(���ı���)  : ������ ������ �ִ��� �� ���� ����� +1�ؼ� ���� ���
    
    *SELECT �������� ��� ����!
*/
-- �޿��� ���� ������� ������ �Ű� ��ȸ
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE;
--> ���� 19���� 2���� �ְ�, �� ���� ������ 21���� ǥ�õ�

SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE;
--> ���� 19���� 2�� ���Ŀ� �� ���� ������ 20���� ǥ�õ�.(+1)


-->���� 5�� ��ȸ
-- WHERE ���� <=; --> ���� �߻� ! WHERE�������� ��Ī ��� �Ұ�!

SELECT * 
FROM (SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
        FROM EMPLOYEE)
WHERE ���� <= 5;

-- ���� 3��~ 5�� ��ȸ
SELECT * 
FROM (SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
        FROM EMPLOYEE)
WHERE ���� >= 3 AND ���� <= 5;

--------------------------------------------------------------------------------
-- 1) ROWNUM�� Ȱ���Ͽ� �޿��� ���� ���� 5���� ��ȸ�Ϸ� ������, ����� ��ȸ�� ���� �ʾҴ�.
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

-- ������ (����) : ���� ���� 5���� �߷���
-- 5���� ��µǾ���.

-- �ذ���      :
SELECT *
FROM (SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) "����" FROM EMPLOYEE)
WHERE ROWNUM <= 5;

SELECT DEPT_CODE, SUM(SALARY) �հ�, FLOOR(AVG(SALARY)) ���, COUNT(*) �ο���

FROM EMPLOYEE

GROUP BY DEPT_CODE

HAVING FLOOR(AVG(SALARY)) > 2800000

ORDER BY DEPT_CODE ASC;

-- 2) �μ��� ��� �޿��� 270������ �ʰ��ϴ� �μ��� �ش��ϴ� �μ��ڵ�, �μ��� �� �޿���, �μ��� ��ձ޿�, �μ��� ��� ���� ��ȸ
SELECT DEPT_CODE, SUM(SALARY) "����", FLOOR(AVG(SALARY)) AS "���", COUNT(*) "�ο���"
FROM EMPLOYEE
WHERE SALARY > 2700000
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

-- ������ (����) : ��ձ޿��� �ƴ� ���� �޿��� 270������ �Ѵ� �ο��� ������� ��µȴ�
-- �ذ���      :
SELECT *
FROM (SELECT DEPT_CODE, SUM(SALARY) "����", FLOOR(AVG(SALARY)) "���", COUNT(*) "�ο���" FROM EMPLOYEE GROUP BY DEPT_CODE)
WHERE ��� > 2700000;

--����� Ǯ��
SELECT DEPT_CODE, SUM(SALARY) "����", FLOOR(AVG(SALARY)) AS "���", COUNT(*) "�ο���"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING FLOOR(AVG(SALARY)) > 2700000
ORDER BY DEPT_CODE ASC;



--------------------------------------------------------------------------------

