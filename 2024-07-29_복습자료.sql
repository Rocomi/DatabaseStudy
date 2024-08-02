-- * 복습용 계정으로 접속한 후 아래 쿼리문을 실행해주세요.
--   USERNAME / PWD : C##TESTUSER / 1234
--------------------------------------------------------------------------------------------------------
DROP TABLE DEPARTMENTS;
DROP TABLE EMPLOYEES;

-- DEPARTMENTS 테이블 생성
CREATE TABLE DEPARTMENTS (
    DEPT_ID NUMBER PRIMARY KEY,
    DEPT_NAME VARCHAR2(50) NOT NULL
);

-- EMPLOYEES 테이블 생성
CREATE TABLE EMPLOYEES (
    EMP_ID NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(50) NOT NULL,
    SALARY NUMBER,
    HIRE_DATE DATE,
    DEPT_ID NUMBER,
    FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENTS(DEPT_ID)
);

-- DEPARTMENTS 데이터 삽입
INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME) VALUES (1, '인사부');
INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME) VALUES (2, '재무부');
INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME) VALUES (3, 'IT부서');

-- EMPLOYEES 데이터 삽입
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (101, '홍길동', 5000, TO_DATE('2020-01-15', 'YYYY-MM-DD'), 1);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (102, '김철수', 4500, TO_DATE('2019-03-22', 'YYYY-MM-DD'), 2);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (103, '이영희', 5500, TO_DATE('2021-07-10', 'YYYY-MM-DD'), 3);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (104, '박지수', 6500, TO_DATE('2018-11-05', 'YYYY-MM-DD'), 2);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (105, '최민호', 7000, TO_DATE('2022-02-18', 'YYYY-MM-DD'), 1);
INSERT INTO EMPLOYEES (EMP_ID, EMP_NAME, SALARY, HIRE_DATE, DEPT_ID) VALUES (106, '신기술', 4000, TO_DATE('2024-05-13', 'YYYY-MM-DD'), 3);
--------------------------------------------------------------------------------------------------------

-- 모든 직원의 이름과 급여를 조회 


-- '재무부'에 속한 직원들의 이름과 부서명을 조회 


-- 모든 직원의 평균 급여를 계산 


-- 부서별 직원 수를 계산하고, 직원 수가 1명 이상인 부서만 조회 


-- 모든 직원의 이름과 해당 부서명을 조회 

-- 급여가 가장 높은 직원의 이름과 급여를 조회

-- 새로운 테이블 PROJECTS를 생성 ( 저장 정보: 프로젝트번호 (PROJECT_ID:NUMBER (PK), 프로젝트명 (PROJECT_NAME:VARCHAR2(100) NULL 허용X)))

-- 새로운 직원 '김민지'를 EMPLOYEES 테이블에 삽입 ( 사원 정보, 급여 6200, IT부서, 오늘 입사)

-- EMPLOYEES 테이블에서 '홍길동'의 급여를 5500으로 수정

-- EMPLOYEES 테이블에서 급여가 5000 이하인 직원들을 삭제

-- EMPLOYEES 테이블에 새로운 컬럼 EMAIL을 추가 (VARCHAR2(100))

-- 부서별 평균 급여를 계산하고, 평균 급여가 6000 이상인 부서만 조회

-- 모든 직원의 이름과 급여를 포함하는 뷰 EMP_VIEW를 생성

-- 뷰 EMP_VIEW를 삭제

-- EMPLOYEES 테이블을 삭제