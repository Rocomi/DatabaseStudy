/*
    * �Լ�
        : ���޵� �÷����� �о �Լ��� ������ ����� ��ȯ 
        
        - ������ �Լ� : N���� ���� �о N���� ������� ���� (�ึ�� �Լ��� ������ ����� ��ȯ)
        - �׷� �Լ�   : N���� ���� �о 1���� ������� ���� (�׷��� ���� �׷캰�� �Լ��� ������ ����� ��ȯ)

        + SELECT�� ������ �Լ��� �׷��Լ��� �Բ� ����� �� ����!
            => ���� ���� ������ �ٸ��� ������
            
        + �Լ����� ����� �� �ִ� ��ġ : SELECT��, WHERE��, ORDER��, GROUP BY��, HAVING��
*/
--================================================================================
/*
    * ����Ÿ���� ������ ó�� �Լ�
    => VARCHAR2, CHAR
    
    * LENGTH(�÷��� | '���ڿ�') : �ش� ���ڿ��� ���ڼ��� ��ȯ
      LENGTHB(�÷��� | '���ڿ�') : �ش� ���ڿ��� ����Ʈ���� ��ȯ
      
      => ������, ����, Ư������ ���ڴ� 1byte
         �ѱ��� ���ڴ� 3byte
*/
-- '����Ŭ' �ܾ��� ���ڼ��� ����Ʈ���� Ȯ���غ���.
SELECT LENGTH('����Ŭ') ���ڼ�, LENGTHB('����Ŭ') ����Ʈ��
FROM DUAL;

-- 'ORACLE' �ܾ��� ���ڼ��� ����Ʈ���� Ȯ���غ���.

SELECT LENGTH('ORACLE') ���ڼ�, LENGTHB('ORACLE') ����Ʈ��
FROM DUAL;

-- EMPLOYEE ���̺��� �����, �����(���ڼ�), �����(����Ʈ��), �̸���, �̸���(���ڼ�), �̸���(����Ʈ��)
SELECT EMP_NAME �����, LENGTH(EMP_NAME) ���ڼ� , LENGTHB(EMP_NAME) ����Ʈ��,EMAIL �̸���, LENGTH(EMAIL) ���ڼ�, LENGTHB(EMAIL) ����Ʈ��
FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    * INSTR : ���ڿ��κ��� Ư�� ������ ������ġ�� ��ȯ
    
    [ǥ����]
            INSTR(�÷� | '���ڿ�', 'ã�����ϴ� ����' [, ã�� ��ġ�� ���۰�, ����])
            => �Լ� ���� ����� ����Ÿ��(NUMBER)
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;      -- ���ʿ� �ִ� ù��° B�� ��ġ : 3

SELECT INSTR('AABAACAABBAA', 'B', 4) FROM DUAL;     -- ã�� ��ġ�� ���۰� : 1(�⺻��)

SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;    -- �������� ���۰����� �����ϸ� �ڿ������� ã�´�. 
                                                    -- �ٸ�, ��ġ�� ���� ���� �տ������� �о ����� ��ȯ.
                                                    -- ���ʿ� �ִ� ù��° B�� ��ġ : 10
                                                    
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;  -- ������ ������ ���� ���۰��� �����ؾ� ��!
                                                    -- ���ʿ� �ִ� �ι�° B�� ��ġ : 9
-- ��� ���� �� �̸��Ͽ� _�� ù��° ��ġ, @�� ��ġ
SELECT EMAIL, INSTR(EMAIL, '_'), INSTR(EMAIL, '@') FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    * SUBSTR : ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ
    
    [ǥ����]
            SUBSTR(���ڿ�|�÷�, ������ġ[, ����(����)])
            => 3��° ���� �κ��� �����ϸ� ���ڿ� ������ ����!
*/
SELECT SUBSTR('ORACLE SQL DEVELOPER', 10) FROM DUAL;        -- 10��° ��ġ���� ������ ����
SELECT SUBSTR('ORACLE SQL DEVELOPER', 8, 3) FROM DUAL;      -- 8��° ��ġ���� 3���ڸ� ����
SELECT SUBSTR('ORACLE SQL DEVELOPER', -3) FROM DUAL;        -- �ڿ��� 3��° ��ġ���� ������ ���� 
SELECT SUBSTR('ORACLE SQL DEVELOPER', -9, 3) FROM DUAL;     -- �ڿ������� 9��° ��ġ���� 3���ڸ� ����

--����� �� ������鸸 ��ȸ (�̸�, �ֹι�ȣ)
SELECT EMP_NAME, EMP_NO FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2 OR SUBSTR(EMP_NO, 8, 1) = 4;

--����� �� ������鸸 ��ȸ (�̸�, �ֹι�ȣ)
SELECT EMP_NAME, EMP_NO FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN(1,3)
ORDER BY EMP_NAME;  -- ��� �̸� ���� ������ ������ ���� (��������)

-- ��� ���� �� �����, �̸���, (�̸��Ͽ��� @�ձ����� ��)���̵� ��ȸ
-- [1] �̸��Ͽ��� '@'�� ��ġ�� ã�� (INSTR ���)
-- [2] �̸��� �÷��� ������ 1��° ��ġ���� '@'��ġ(1���� Ȯ��) ������ ���� (SUBSTR ���)
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) ID FROM EMPLOYEE;

--------------------------------------------------------------------------------
/*
    * LPAD / RPAD : ���ڿ��� ��ȸ�� �� ���ϰ� �ְ� ��ȸ�ϰ��� �� �� ���
                    ���ڿ��� �����̰��� �ϴ� ���ڸ� ���� �Ǵ� �����ʿ� �ٿ��� ���� ���̸�Ŭ ���ڿ� ��ȯ
                    
    [ǥ����]
            LPAD(���ڿ�|�÷�, ��������[, ������ ����])
            RPAD(���ڿ�|�÷�, ��������[, ������ ����])
            * ������ ���� ���� �� �⺻������ �������� ä����
*/
-- ��� ���� �� ������� ������ �������� ä���� �� 20���̷� ��ȸ
SELECT EMP_NAME, LPAD(EMP_NAME, 20) �̸�2
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(EMP_NAME, 20) �̸�2
FROM EMPLOYEE;

-- ��� ���� �̸�, �̸��� ������ �����Ͽ� ��ȸ
SELECT LPAD(EMP_NAME, 20), LPAD(EMP_NAME, 20) FROM EMPLOYEE;

-- ��� ���� �̸�, �̸��� ���� �����Ͽ� ��ȸ
SELECT RPAD(EMP_NAME, 20), RPAD(EMP_NAME, 20) FROM EMPLOYEE;

-- ��� ����
SELECT RPAD(LPAD(EMP_NAME, 20), 35), RPAD(LPAD(EMP_NAME, 20), 35) FROM EMPLOYEE;

-- ��� ���� �̸�, �̸��� ������ �����Ͽ� ��ȸ, ���鿡 '#' ȣ��
SELECT LPAD(EMP_NAME, 20, '#'), LPAD(EMP_NAME, 20, '#') FROM EMPLOYEE;

--�ֹι�ȣ ���ڸ� ù��° ���� '*' ǥ��
SELECT EMP_NAME �̸�, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') �ֹι�ȣ FROM EMPLOYEE;

-- �̸� ����� '*' ���� �����
SELECT RPAD(RPAD(SUBSTR(EMP_NAME, 1, 1), 3, '*'),5, SUBSTR(EMP_NAME, 3,1)) �̸�, RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') �ֹι�ȣ FROM EMPLOYEE;

--------------------------------------------------------------------------------
/*
    * LTRIM / RTRIM : ���ڿ����� Ư�� ���ڸ� ������ �� �������� ��ȯ
    
    [ǥ����]
            LTRIM(���ڿ�\�÷�, �����ϰ��� �ϴ� ���ڵ�])
            RTRIM(���ڿ�\�÷�, �����ϰ��� �ϴ� ���ڵ�])
            * ������ ���ڸ� ������ �� ������ ���ŵ�!
*/
SELECT LTRIM('     H I') FROM DUAL; -- ���ʺ���(�տ�������) �ٸ� ���ڰ� ���� ������ ���� ����
SELECT RTRIM('H I     ') FROM DUAL; -- �����ʿ� �ִ� ������� ���� (I�� ������)

SELECT LTRIM('123123HI123', '123') FROM DUAL;
SELECT LTRIM('321321HI123', '123') FROM DUAL;

SELECT LTRIM('KKHHII', '123') FROM DUAL;


/*
    * TRIM : ���ڿ� ��/��/���ʿ� �ִ� ������ ���ڵ��� ������ �� ������ ���� ��ȯ
    
    [ǥ����]
            TRIM( [LEADING | TRAILING | BOTH] [������ ����] FROM ���ڿ�|�÷� )
            * ������ ���� ���� �� ���� ����
            * �⺻ �ɼ��� BOTH (����)
*/
SELECT TRIM('     H I      ') "��" FROM DUAL;
SELECT TRIM('L' FROM 'LLLLLLHLILLLLLLL') �� FROM DUAL;

SELECT TRIM(LEADING 'L' FROM 'LLLLLLHLILLLLLLL') �� FROM DUAL;       -- LTRIM�� ������
SELECT TRIM(TRAILING 'L' FROM 'LLLLLLHLILLLLLLL') �� FROM DUAL;      -- RTRIM�� ������
SELECT TRIM(BOTH 'L' FROM 'LLLLLLHLILLLLLLL') �� FROM DUAL;          -- ��������

--------------------------------------------------------------------------------
/*
    * LOWER / UPPER / INITCAP
    
        - LOWER   : ���ڿ��� ��� �ҹ��ڷ� �����Ͽ� ���ڿ��� ��ȯ
        - UPPER   :���ڿ��� ��� �빮�ڷ� �����Ͽ� ���ڿ��� ��ȯ
        - INITCAP : ���� �������� ù ���ڸ��� �빮�ڷ� �����Ͽ� ���ڿ��� ��ȯ
*/

-- 'I think so i am'
SELECT LOWER('I think so i am') FROM DUAL;

SELECT UPPER('I think so i am') FROM DUAL;

SELECT INITCAP('I think so i am') FROM DUAL;

--------------------------------------------------------------------------------
/*
    * CONCAT : ���ڿ� �� ���� ���޹޾� �ϳ��� ��ģ �� ���ڿ� ��ȯ
    
    [ǥ����]
        CONCAT(���ڿ�1, ���ڿ�2)
*/
-- 'KH' 'L������' ���� �ΰ��� �ϳ��� ���ļ� ��ȸ
SELECT CONCAT('KH', ' L������') FROM DUAL;
SELECT 'KH' || ' L������' FROM DUAL;

SELECT '�ٿ��' || 30 FROM DUAL;

SELECT EMP_NAME || '��' FROM EMPLOYEE;
SELECT CONCAT(EMP_NAME , '��') FROM EMPLOYEE;

-- ��� ��ȣ�� (�����)�� �� �ϳ��� ��ȸ => 200�����ϴ�
SELECT CONCAT( EMP_ID, CONCAT(EMP_NAME , '��')) FROM EMPLOYEE;

--------------------------------------------------------------------------------
/*
    * REPLACE : Ư�� ���ڿ����� Ư�� �κ��� �ٸ� �κ����� ��ü�Ͽ� ���ڿ� ��ȯ
    
    [ǥ����]
        REPLACE(���ڿ�, ã�����ڿ�, �����ҹ��ڿ�)
*/
SELECT REPLACE('����� ������ ���ﵿ', '����', '�Ｚ') FROM DUAL;
SELECT REPLACE('����� ���ﱸ ���ﵿ ���ﵿ�繫��', '����', '�Ｚ') FROM DUAL;

-- ��� ���̺��� �̸��� ���� �� or.kr �κ��� gmail.com ������ �����Ͽ� ��ȸ
SELECT EMP_NAME NAME,REPLACE(EMAIL, '@or.kr', '@gmail.com') EMAIL FROM EMPLOYEE;

--==============================================================================
/*
    [ ���� Ÿ���� ������ ó�� �Լ� ]
*/
/*
    * ABS : ������ ���밪�� �����ִ� �Լ�
*/
SELECT ABS(-10) "-10�� ���밪" FROM DUAL;

SELECT ABS(-7.7)  "-7.7�� ���밪" FROM DUAL;

--------------------------------------------------------------------------------
/*
    * MOD : �� ���� ���� ������ ���� �����ִ� �Լ�
    
    MOD(����1, ����2)   --  ����1 % ����2
*/
-- 10�� 3���� ���� �������� ���غ��ٸ�?
SELECT MOD(10, 3) FROM DUAL;

SELECT MOD(10.9, 3) FROM DUAL;

--------------------------------------------------------------------------------
/*
    * ROUND : �ݿø��� ���� �����ִ� �Լ�
    
    ROUND(����[, �Ҽ��� ��ġ] => �Ҽ�����ġ --> N��° �ڸ�����
*/
SELECT ROUND(123.456) FROM DUAL; -- ��� : 123
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 2) FROM DUAL;

SELECT ROUND(123.456, -1) FROM DUAL; -- ��� : 120
SELECT ROUND(123.456, -2) FROM DUAL; -- ��� : 100
-- => ��ġ���� ����� ������ ���� �Ҽ��� �ڷ� ��ĭ�� �̵�, ������ ������ ���� �Ҽ��� ���ڸ��� �̵�

--------------------------------------------------------------------------------
/*
    * CEIL : �ø�ó���� ���� �����ִ� �Լ�
    
    CEIL(����)
*/
SELECT CEIL(123.456) FROM DUAL;

/*
    * FLOOR : ����ó���� ���� �����ִ� �Լ�
    
    FLOOR(����)
*/
SELECT FLOOR(123.456) FROM DUAL;

/*
    * TRUNC : ����ó���� ���� �����ִ� �Լ�(��ġ���� ����)
    
    TRUNC(����[, ��ġ])
*/
SELECT TRUNC(123.456) FROM DUAL;        -- 123
SELECT TRUNC(123.456, 1) FROM DUAL;     -- 123.4
SELECT TRUNC(123.456, -1) FROM DUAL;    -- 120

--==============================================================================
/*
    [ ��¥ ������ Ÿ�� ó�� �Լ� ]
*/
-- SYSDATE : �ý����� ���� ��¥ �� �ð��� ��ȯ
SELECT SYSDATE FROM DUAL;

-- MONTHS_BETWEEN : �� ��¥ ������ ���� ���� ��ȯ
-- [ǥ����] MONTHS_BETWEEN(��¥A, ��¥B) : ��¥A - ��¥B => ���� �� ���
SELECT EMP_NAME �̸�, HIRE_DATE �Ի���, 
        CONCAT(CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)), '������') �ټӰ�����
FROM EMPLOYEE;

-- ���� ������ �� �� ������..? '24/06/11' ������
SELECT CEIL(MONTHS_BETWEEN(SYSDATE, '24/06/11')) FROM DUAL;

-- ������� ��� ������...? '24/11/25' ������
SELECT FLOOR(MONTHS_BETWEEN('24/11/25', SYSDATE)) ||'���� ����!' "�������..." FROM DUAL;

------------
-- ADD_MONTHS : Ư�� ��¥�� N���� ���� ���ؼ� ��ȯ
-- [ǥ����] ADD_MONTHS(��¥, ���� ���� ��)

-- ���� ��¥ ���� 4���� �� ��ȸ
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 4) FROM DUAL;

-- ������̺��� �Ի���, �Ի��� + 3���� "����������" ��ȸ
SELECT EMP_NAME �̸�, HIRE_DATE �Ի���, ADD_MONTHS(HIRE_DATE, 3) ���������� FROM EMPLOYEE; 

------------
--NEXT_DAY : Ư�� ��¥ ���� ���� ����� ������ ��¥�� ��ȯ
-- [ǥ����] NEXT_DAY (��¥, ����(����|����))
--          * 1 : �Ͽ���, 2 : ��, ...., 7 : ��

-- ���� ��¥ ���� ���� ����� �ݿ����� ��¥ ��ȸ
SELECT NEXT_DAY(SYSDATE, 6) FROM DUAL;      -- ���� ������� ���ڴ� ����

ALTER SESSION SET NLS_LANGUAGE = KOREAN;
SELECT NEXT_DAY(SYSDATE, '�ݿ���') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;

-- ��� ������ ���� �ٸ��Ƿ� ��� ������ ������ �־�� �Ѵ�.
-- ��� ���� : KOREAN / AMERICAN
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;

SELECT NEXT_DAY(SYSDATE, 'FRI') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 'FRIDAY') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;
---------------------------------
-- LAST_DAY : �ش� ���� ������ ��¥�� ���ؼ� ��ȯ
-- [ǥ����] LAST_DAY(��¥)

-- �̹����� ������ ��¥ ��ȸ
SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- ������̺��� �����, �Ի���, �Ի��� ���� ������ ��¥, �Ի��� ���� �ٹ��� �� ��ȸ
SELECT EMP_NAME �����, HIRE_DATE �Ի���, LAST_DAY(HIRE_DATE) "�Ի��� ���� ������ ��¥", LAST_DAY(HIRE_DATE) - HIRE_DATE +1 "�Ի��� ���� �ٹ��� ��"
FROM EMPLOYEE;

-- ������ ����ȯ ���� �غ��ô�
SELECT SYSDATE - '24/06/11' FROM DUAL;

----------------------------------------
/*
    * EXTRACT : Ư�� ��¥�κ��� �͵�/��/�� ���� �����ؼ� ��ȯ���ִ� �Լ�
    
    [ǥ����]
        EXTRACT(YEAR FROM ��¥) : ��¥���� ������ ����
        EXTRACT(MONTH FROM ��¥) : ��¥���� ���� ����
        EXTRACT(DAY FROM ��¥) : ��¥���� �ϸ� ����
         --> ����Ÿ������ ��ȯ
*/

-- ���� ��¥ ���� �⵵, ��, ���� ���� �����Ͽ� ��ȸ
SELECT SYSDATE
    , EXTRACT(YEAR FROM SYSDATE) ����
        , EXTRACT(MONTH FROM SYSDATE) ��
            , EXTRACT(DAY FROM SYSDATE) ��
FROM DUAL;

-- ��� ���̺� �����, �Ի�⵵, �Ի��, �Ի��� ��ȸ (+�Ի�⵵> �Ի��> �Ի��� ������ �������� ����
SELECT EMP_NAME �����, EXTRACT(YEAR FROM HIRE_DATE) �Ի�⵵ , EXTRACT(MONTH FROM HIRE_DATE) �Ի��, EXTRACT(DAY FROM HIRE_DATE) �Ի���
FROM EMPLOYEE
ORDER BY 2, 3, 4 ASC;

--==============================================================================
/*
    * ����ȯ �Լ� : ������ Ÿ���� �������ִ� �Լ�
        - ���� / ���� / ��¥
*/
/*
    TO_CHAR : ���� �Ǵ� ��¥ Ÿ���� ���� ���� Ÿ�����κ�ȯ�����ִ� �Լ�
    
    [ǥ����]
        TO_CHAR(���� | ��¥[, ����])
*/
-- ����Ÿ�� --> ����Ÿ��
SELECT 1234,TO_CHAR(1234) FROM DUAL;

SELECT TO_CHAR(1234, '999999') ���䵥���� FROM DUAL;
-- => '9' : ������ŭ �ڸ����� Ȯ��, ������ ����. ��ĭ�� �������� ä��.

SELECT TO_CHAR(1234, '000000') ���䵥���� FROM DUAL;
-- => '0' : ������ŭ �ڸ����� Ȯ��. ������ ����. ��ĭ�� 0���� ä����.

SELECT TO_CHAR(1234, 'L999,999') ���䵥���� FROM DUAL;
-- => ���� ������ ������ ���� ȭ�ʴ����� ���� ǥ��. ���� KOREAN �̹Ƿ� \(��ȭ)�� ǥ�õ�!

SELECT TO_CHAR(1000000, 'L999,999,999') ���䵥���� FROM DUAL;

-- ������� �����, ����, ������ ��ȸ ( ȭ�����, 3���ھ� ����)
SELECT EMP_NAME �̸�, TO_CHAR(SALARY, '99,999,999L') ����, 
                        TO_CHAR(SALARY*12, '999,999,999L')���� 
FROM EMPLOYEE;
--------------------------------------------------------------------------------
-- ��¥Ÿ�� --> ����Ÿ��
SELECT SYSDATE, TO_CHAR(SYSDATE) "���ڷ� ��ȯ" FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL;    -- HH24 : 24�ð� ǥ���
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS') FROM DUAL;   -- AM, PM : �������� ǥ��
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
/*
    * HH : �� ���� (HOUR) --> 12�ð���
        => HH24 : 24�ð���
    * MI : �� ���� (MINUTE)
    * SS : �� ���� (SECOND)
*/
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
-- DAY : ��������(X����) -> '�Ͽ���', '������', 'ȭ����', '������', ...,'�����'
-- DY : �������� (X) -> '��', '��', 'ȭ', '��', ...,'��'

SELECT TO_CHAR(SYSDATE, 'MON') FROM DUAL;
-- MON : ������(X��) -> '1��', '2��', ..., '12��'

-- ������̺��� �����, �Ի糯¥ ��ȸ (��, �Ի糯¥ ���� "XXXX�� XX�� XX��" ���� ��ȸ)
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') FROM EMPLOYEE;
-- -> ǥ���� ����(����)�� ū����ǥ("")�� ��� (����)���Ŀ� �����ؾ���!
/*
    * YYYY : �⵵�� 4�ڸ��� ǥ�� -->50�� ���� ��¥��2000���� �ν�
      YY   : �⵵�� 2�ڸ��� ǥ��
      RRRR : �⵵�� 4�ڸ��� ǥ��--> 1900���� �ν� R : ROUND�ǹ�
      RR   : ������ 2�ڸ��� ǥ��
*/
SELECT TO_CHAR(HIRE_DATE,'YYYY-MM-DD') FROM EMPLOYEE;
SELECT TO_CHAR(HIRE_DATE,'RRRR-MM-DD') FROM EMPLOYEE;

/*
    *���� ���õ� ����
    * HM       : �������� 2�ڸ��� ǥ��
        MON / MONTH : �� ������ 'X��', 'JULY' �������� ǥ�� (������ ���� �ٸ�) 
*/
SELECT TO_CHAR(SYSDATE,'MM') "���ڸ�ǥ��", TO_CHAR(SYSDATE,'MON') ����ǥ��
        , TO_CHAR(SYSDATE, 'MONTH') ����ǥ��2
        FROM DUAL;

/*
    �ϰ� ���õ� ����
    * DD : �� ������ 2�ڸ��� ǥ��
      DDD : �ش� ��¥�� �� �� ���� ���° �ϼ�
      D : �������� => ����Ÿ��(1 : DLFDYDLF,,...,7 : �����)
*/
SELECT TO_CHAR(SYSDATE, 'DD') "������", TO_CHAR(SYSDATE, 'DDD') "���° �ϼ�"
        ,TO_CHAR(SYSDATE, 'D') "��������" ,TO_CHAR(SYSDATE, 'DAY') "��������2"
            ,TO_CHAR(SYSDATE, 'DY') "��������3"
FROM DUAL;
--------------------------------------------------------------------------------
/*
    * TO_DATE : ����Ÿ�� �Ǵ� ����Ÿ���� ��¥Ÿ������ ����ϴ� �Լ�
    
    [ǥ����]
        TO_DATE(����|����[,����]) => ��¥Ÿ��
*/
SELECT TO_DATE(20240719) FROM DUAL;
SELECT TO_DATE(240719) FROM DUAL;       --> �ڵ����� 50�� �̸��� 20XX���� ����
SELECT TO_DATE(880719) FROM DUAL;       --> �ڵ����� 50�� �̻��� 19xx���� ����

SELECT TO_DATE(020222) FROM DUAL;       --> ���ڴ� 0���� �����ϸ� �ȵŴ� ��Ģ�� ����
SELECT TO_DATE('020222') FROM DUAL;     --> 0���� ���۵Ǵ� ��� ����Ÿ������ ����

SELECT TO_DATE('20240719 104900') FROM DUAL; --> YYYYMMDD HHMISS. �̰�쿡�� ������ �����ؾ� ��
SELECT TO_DATE('20240719 104900', 'YYYYMMDD HH24MISS') FROM DUAL;
--------------------------------------------------------------------------------
/*
    * TO_NUMBER : ����Ÿ���� �����͸� ����Ÿ������ ��������ִ� �Լ�
    
    [ǥ����]
            TO_NUMBER(����[, ����]) : ���ڿ� ���� ������ ���� (��ȣ�� ���Եǰų� ȭ����� ���ԵǴ� ���...)
*/

SELECT TO_NUMBER('0123456789') FROM DUAL;

SELECT '10000' + '500' FROM DUAL;   -- �ڵ����� ���� ->���� Ÿ������ ��ȯ�Ǿ� ������� �����!
SELECT '10,000' + '500' FROM DUAL;
SELECT TO_NUMBER('10,000', '99,999') + TO_NUMBER('500', '999') FROM DUAL;
--==============================================================================
/*
    NULL ó�� �Լ�
*/
/*
    * NVL : �ش� �÷��� ���� NULL�� ��� �ٸ� ������ ����� �� �ֵ��� ��ȯ���ִ� �Լ�
    
    [ǥ����]
            NVL(�÷�, �ش� �÷��� ���� NULL�� ��� ����� ��)
*/
-- ������̺��� �����, ���ʽ� ������ ��ȸ(��, ���ʽ� ���� NULL�� ��� 0���� ��ȸ)
SELECT EMP_NAME, NVL(BONUS, 0) BONUS FROM EMPLOYEE;

-- ��� ���̺��� �����, ���ʽ� ���� ���� ��ȸ
SELECT EMP_NAME �̸�, SALARY*(1 + NVL(BONUS, 0))*12  ���� FROM EMPLOYEE;

/*
    NVL2 : �ش� �÷��� NULL�� ��� ǥ���� ���� �����ϰ�, 
                        NULL�� �ƴ� ��� ǥ���� ���� ����
    
    [ǥ����]
            NVL2(�÷�, �����Ͱ� �����ϴ� ��� ����� ��, NULL�� ��� ����� ��)
*/
-- �����, ���ʽ� ����(O/X) ��ȸ
SELECT EMP_NAME, NVL2(BONUS, 'O', 'X') "���ʽ� ����"
FROM EMPLOYEE;

-- �����, �μ��ڵ�, �μ���ġ����('�����Ϸ�', '�̹���') ��ȸ
SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE, '�����Ϸ�', '�̹���') 
FROM EMPLOYEE;

/*
    NULLIF : �� ���� ��ġ�ϸ� NULL, ��ġ���� �ʴ´ٸ� �񱳴��1 ��ȯ
    
    [ǥ����] NULLIF(�񱳴��1, �񱳴��2)
    
*/
SELECT NULLIF('999','999') FROM DUAL;   -- ��� 'NULL'
SELECT NULLIF('999','555') FROM DUAL;   -- ��� '999'

--==============================================================================














