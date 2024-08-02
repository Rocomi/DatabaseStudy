-- * QUIZ1 * --------
/*
	CREATE USER C##TEST IDENTIFIED BY 1234; 실행
	User C##TEST이(가) 생성되었습니다.
    
	계정 생성만 하고 접속 시 에러 (user C##TEST lacks CREATE SESSION privillege; logon denied 에러)
*/

-- 원인 ? 사용자 계정을 생성한 후에 권한을 부여하지 않음
-- 해결방안 ? - 관리자 계정으로 접속한 후에 해당 사용자에 최소한의 권한(CONNECT, RESOURCE)을 부여해줘야 함
--           - 관리자 계정으로 접속한 후 CREATE SESSION 권한을 부여해줘야 함
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
	위의 두 테이블을 조인하여 EMPNO, EMPNAME, JOBNO, JOBNAME 컬럼을 조회하고자 한다.
	이때 실행한 SQL문이 아래와 같다고 했을 때,
*/
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
	JOIN TB_JOB USING(JOBNO);
-- 다음과 같은 오류가 발생했다.
-- ORA-00904: "TB_JOB"."JOBNO": invalid identifier

-- 원인 ? 조인하고자 하는 두 테이블의 연결고리 역할을 하는 컬럼명이 다르므로 JOIN~USING 구문을 사용할 수 없음
-- 해결방안 ? JOIN~USING구문을 JOIN~ON구문으로 변경
--           JOIN TB_JOB ON (JOBCODE = JOBNO)


/*
	* 검색하고자 하는 내용 :
	
		직급코드가 J7이거나 J6이면서 SALARY 값이 200만원 이상이고
		BONUS가 있고 여자이며 이메일주소는 _앞에 3글자만 있는 사원의
		사원명, 주민등록번호, 직급코드, 부서코드, 급여, 보너스를 조회하고자 한다.
		
		(정상적으로 조회가 된다면 2개의 결과를 확인할 수 있음)
*/

-- 아래 쿼리문에서 실행 시 원하는 결과가 나오지 않는다. 
-- 어떤 문제가 있는 지 원인을 파악하여 작성한 후, 해결해주세요.
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6'  -- JOB_CODE IN ('J7', 'J6')
      AND SALARY > 2000000
      AND EMAIL LIKE '____%' ESCAPE '#'
      AND BONUS IS NULL
--      AND SUBSTR(EMP_NO, 8, 1) IN (2, 4);
-- 원인 : 
/*
    1) 직급코드에 대한 조건이 우선순위로 인해 제대로 실행되지 않음
       => 괄호로 묶어주거나 IN 연산자로 대체해야 함
    2) 작성된 조건은 SALARY 값이 200만원 초과(>)로 작성되어 있음
       => 200만원 이상인 조건은 등호를 추가해줘야함 (>=)
    3) 이메일의 4번째자리에 언더바(_)가 와일드카드로 사용됨
       => 값으로써 조건을 주고자 한다면 ESCAPE를 사용하여 나만의 와일드카드로 구분해줘야 함
    4) 보너스가 있는 사원을 조회해야하는데 없는 사원을 조회하고 있음
       => BONUS IS NULL --> BONUS IS NOT NULL로 변경해줘야 함
    5) 여자 사원 조건이 누락됨
       => 여자 사원 조건을 추가해줘야 함
*/