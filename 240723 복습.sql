
--=========================================================================
-- 수업용 계정 로그인 후 아래 정보를 조회할 수 있는 쿼리문을 작성해주세요 :D
--=========================================================================
-- 이메일의 아이디 부분에(@ 앞부분) k가 포함된 사원 정보 조회
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '%k%@%';

-- 부서별 사수가 없는 사원 수 조회
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL
GROUP BY DEPT_CODE;

-- 연락처 앞자리가 010, 011로 시작하는 사원 수 조회
SELECT SUBSTR(PHONE, 1, 3), COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(PHONE, 1, 3) IN ('010', '011')
GROUP BY SUBSTR(PHONE, 1, 3);

-- 부서별 사수가 없는 사원 정보 조회 (부서명, 사번, 사원명 조회)
-- ** 오라클 구문 **
SELECT DEPT_TITLE, EMP_ID, EMP_NAME
FROM EMPLOYEE,  DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND MANAGER_ID IS NULL;

-- ** ANSI 구문 **
SELECT DEPT_TITLE, EMP_ID, EMP_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE MANAGER_ID IS NULL;

-- 부서별 사수가 없는 사원 수 조회 (부서명, 사원수 조회)
-- ** 오라클 구문 **
SELECT DEPT_TITLE, COUNT(*)
FROM EMPLOYEE,  DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND MANAGER_ID IS NULL
GROUP BY DEPT_TITLE;

-- ** ANSI 구문 **
SELECT DEPT_TITLE, COUNT(*)
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE MANAGER_ID IS NULL
GROUP BY DEPT_TITLE;