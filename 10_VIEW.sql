/*
    * VIEW (뷰)
        : SELECT문을 통해 얻어진 결과물을 저장해둘 수 있는 객체
         => 자주 사용하는 쿼리문을 저장해 두면 매번 다시 해당 쿼리문을 기술할 필요가 없음!
         임시테이블과 같은 존재 (실제 데이터가 저장되는게 아니라, 논리적으로만 저장되어 있음!)
*/
-- * 사원, 부서, 지역, 국가 *
-- 한국에서 근무하는 사원 정보 조회 (사번, 이름, 부서명, 급여, 근무국가명)
-- * 오라클 구문*
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION L, NATIONAL N
WHERE DEPT_CODE = DEPT_ID
    AND LOCATION_ID = LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE
    AND NATIONAL_NAME = '한국';

-- * ANSI 구문*
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION  ON LOCATION_ID = LOCAL_CODE
    JOIN NATIONAL  USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '한국';

-- 근무국가별로 출력하고자 하는데 쿼리문을 반복해서 계속 써야 한다.... VIEW를 사용 
--------------------------------------------------------------------------------
/*
    VIEW 생성하기
    
    CREATE VIEW 뷰명
    AS 서브쿼리
*/
-- (참고사항) 객체의 이름 줄 때 참고 !
--  테이블 : TB_XXX
--  뷰 : VW_XXX

CREATE VIEW VW_EMPLOYEE
AS  SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION  ON LOCATION_ID = LOCAL_CODE
    JOIN NATIONAL  USING (NATIONAL_CODE);

-- 뷰를 생성할 수 있는 권한을 부여
-- GRANT CREATE VIEW TO C##KH;

SELECT * FROM VW_EMPLOYEE;
-->실제로는 이렇게 실행하는것!
SELECT *
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION  ON LOCATION_ID = LOCAL_CODE
    JOIN NATIONAL  USING (NATIONAL_CODE));

-- 이제 국가별 근무하는 사원정보를 조회하면

SELECT * FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '한국';

SELECT * FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '러시아';

SELECT * FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '일본';

--(참고) 현재 계정으로 설정된 뷰 목록 조회 -> TEXT 컬럼에 저장된 서브쿼리 정보가 있음!
SELECT * FROM USER_VIEWS;


--> REPLACE 하면 이미 있는 VIEW를 덮어씌울 수 있다...!
CREATE OR REPLACE VIEW VW_EMPLOYEE
AS  SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
    FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION  ON LOCATION_ID = LOCAL_CODE
    JOIN NATIONAL  USING (NATIONAL_CODE);

--------------------------------------------------------------------------------
-- * 사번, 사원명, 직급명, 성별(남,여) 근무년수 정보를 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, 
         DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여'), 
            (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE))
FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE);

-- 위에서 조회한 쿼리를 뷰에 저장
-- 함수식 또는 연산식이 있는 경우 별칭을 부여해야지 VIEW로 잘 생성할 수 있음
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID 사번, EMP_NAME 이름, JOB_NAME 직급, 
            DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여') 성별, 
            (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)) 근무년수
    FROM EMPLOYEE
        JOIN JOB USING (JOB_CODE);

SELECT * FROM VW_EMP_JOB;

CREATE OR REPLACE VIEW VW_EMP_JOB (사번, 이름, 직급명, 성별, 근무년수)
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
            DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여'), 
            (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE))
    FROM EMPLOYEE
        JOIN JOB USING (JOB_CODE);


SELECT * FROM VW_EMP_JOB WHERE 성별 = '여';

SELECT * FROM VW_EMP_JOB WHERE 근무년수 >= 20;

-- 뷰 삭제! 
DROP VIEW VW_EMP_JOB;

--------------------------------------------------------------------------------
/*
    생성된 뷰를 통해서 DML(INSERT/UPDATE/DELETE)을 사용해보기
    
    --> 뷰를 통해서 DML을 작성하게 되명, 실제 데이터가 저장되어 있는 테이블에 반영됨!
*/
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
    FROM JOB;
    
SELECT * FROM VW_JOB;       -- 논리적인 테이블
SELECT * FROM JOB;

-- VW_JOB 뷰를 사용하여 데이터를 추가 (DML - INSERT)
INSERT INTO VW_JOB VALUES ('J8', '인턴');

-- VW_JOB 뷰를 사용하여 데이터를 변경 (DML-UPDATE_
UPDATE VW_JOB
    SET JOB_NAME = '알바'
WHERE JOB_CODE = 'J8';

-- VW_JOB 뷰를 사용하여 테이터 삭제 (DML-DELETE)
DELETE FROM VW_JOB
WHERE JOB_CODE = 'J8';
--------------------------------------------------------------------------------
/*
    * DML 명령어로 조작이 불가능한 경우가 많음!
    
    1) 뷰에 정의되지 않은 컬럼을 조작하려고 하는 경우
    2) 뷰에 정의되어 있지 않고 베이스테이블에서 NOT NULL 제약조건이 지정되어 있는 경우
    3) 산술연산식 또는 함수식으로 정의가 되어 있는 경우
    4) DISTINCT 구문이 포함되어 있는 경우
    5) JOIN을 이용하여 여러 테이블을 연결시킨 경우
    
    => 뷰는 대부분 조회의 용도로 사용한다. 그러기 때문에 되도록이면 DML을 사용하지 말자
*/
--------------------------------------------------------------------------------
/*
    * VIEW 옵션 * 
    
    CREATE [OR REPLACE] [FORCE|(NOFORCE)] VIEW 뷰명
    AS 서브쿼리
    [WITH CHECK OPTION]
    [WITH READ ONLY];
    
    - OR REPLACE : 기존에 동일한 이름의 뷰가 있을 경우 갱신, 존재하지 않을 경우 새로 생성
    - FROCE | NOFORCE
            + FORCE : 서브쿼리에 작성한 테이블이 존재하지 않아도 뷰를 생성
            + NOFORCE : 서브쿼리에 작성한 테이블이 존재해야지만 뷰를 생성 (기본값)
    - WITH CHECK OPTION : DML(추가/수정/삭제) 사용 시 서브쿼리에 작성한 조건에 맞는 값으로만 실행되도록 하는 옵션
    - WITH READ ONLY : 뷰를 조회만 가능하도록 하는 옵션    
*/

-- * FROCE | NOFORCE
CREATE OR REPLACE NOFORCE VIEW VW_TEMP
AS SELECT TCODE, TNAME, TCONTENT
    FROM TT; --> 현재 TT라는 테이블이 없으므로 뷰도 생성 불가 (NOFORCE)

CREATE OR REPLACE FORCE VIEW VW_TEMP
AS SELECT TCODE, TNAME, TCONTENT
    FROM TT; --> 오류와 함께 뷰가 생성됨 (FORCE)
    
SELECT * FROM VW_TEMP;

CREATE TABLE TT(
    TCODE NUMBER,
    TNAME VARCHAR2(20),
    TCONTENT VARCHAR2(100)
);
SELECT * FROM VW_TEMP;

-- * WITH CHECK OPTION
--> WITH CHECK OPTION 없이 300만원 이상인 사원들 정보로 뷰 생성
CREATE OR REPLACE VIEW VW_EMP
AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY >= 3000000;
    
SELECT * FROM VW_EMP;
    
-- 204 사원 사원의 급여를 200만원으로 변경 (뷰 생성 시 조건에 맞지 않는 경우)
UPDATE VW_EMP
    SET SALARY = 2000000
WHERE EMP_ID = 204;

ROLLBACK;

--> WITH CHECK OPTION을 추가
CREATE OR REPLACE VIEW VW_EMP
AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY >= 3000000
WITH CHECK OPTION;

SELECT * FROM VW_EMP;

UPDATE VW_EMP
    SET SALARY = 2000000
WHERE EMP_ID = 204;     --> 서브쿼리에 작성한 조건에 부합되지 않기 때문에 변경 불가 (=> 오류 발생!)

UPDATE VW_EMP
    SET SALARY = 4000000
WHERE EMP_ID = 204;     --> 서브쿼리에 작성한 조건에 부합하는 경우는 변경 가능
--------------------------------------------------------------------------------
-- WITH READ ONLY
CREATE OR REPLACE VIEW VW_EMP
AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY >= 3000000
WITH READ ONLY;

SELECT * FROM VW_EMP;

DELETE FROM VW_EMP WHERE EMP_ID = 200;  --> READ ONLY 옵션에 의하여 DML 사용 불가!












