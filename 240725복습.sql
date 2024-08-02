--=========================================================
/*
	- 학생 정보 테이블 : STUDENT
	- 제약 조건
	  - 학생 이름, 생년월일은 NULL값을 허용하지 않는다.
	  - 이메일은 중복을 허용하지 않는다.
	- 저장 데이터
		+ 학생 번호 ex) 1, 2, 3, ...
		+ 학생 이름 ex) '김말똥', '아무개', ...
		+ 이메일    ex) 'kim12@kh.or.kr', 'dogdog@kh.or.kr', ...
		+ 생년월일  ex) '24/07/25', '00/02/20', '88/12/25', ...
*/
DROP TABLE STUDENT;

CREATE TABLE STUDENT(
    ST_NAME VARCHAR2(15) NOT NULL,
    ST_NO NUMBER NOT NULL UNIQUE,
    ST_BIRTH DATE NOT NULL,
    EMAIL VARCHAR2(50) UNIQUE
);

 COMMENT ON COLUMN STUDENT.ST_NAME IS '학생이름';
 COMMENT ON COLUMN STUDENT.ST_NO IS '학생 번호';
 COMMENT ON COLUMN STUDENT.ST_BIRTH IS '생년월일';
 COMMENT ON COLUMN STUDENT.EMAIL IS '이메일';

INSERT INTO STUDENT(ST_NAME, ST_NO, ST_BIRTH, EMAIL)
VALUES('엄희윤', 1, '95/10/14', 'kauli1014@naver.com');
------------------------------------------------------------
/*
	- 도서 정보 테이블 : BOOK
	- 제약 조건
	  - 제목과 저자명은 NULL값을 허용하지 않는다.
	  - ISBN 번호는 중복을 허용하지 않는다.
	- 저장 데이터
	  + 도서 번호 ex) 1, 2, 3, ...
	  + 제목 ex) '삼국지', '어린왕자', '코스모스', ...
	  + 저자 ex) '지연', '생텍쥐페리', '칼 세이건', ...
	  + 출판일 ex) '14/02/14', '22/09/19', ...
	  + ISBN번호 ex) '9780394502946', '9780152048044', ...
*/
DROP TABLE BOOK;

CREATE TABLE BOOK(
    TITLE VARCHAR2(100) NOT NULL,
    AUTHOR VARCHAR2(50) NOT NULL,
    BOOK_NO NUMBER,
    PUBLISH_DATE DATE,
    ISBN VARCHAR2(20) UNIQUE
);

COMMENT ON COLUMN BOOK.TITLE IS '제목';
COMMENT ON COLUMN BOOK.AUTHOR IS '저자';
COMMENT ON COLUMN BOOK.BOOK_NO IS '도서 번호';
COMMENT ON COLUMN BOOK.PUBLISH_DATE IS '출판일';
COMMENT ON COLUMN BOOK.ISBN IS 'ISBN 번호';

INSERT INTO BOOK( BOOK.TITLE,BOOK.AUTHOR,BOOK.BOOK_NO,BOOK.PUBLISH_DATE,BOOK.ISBN)
VALUES('지연', '생텍쥐페리', 1,'14/02/14', '9780394502946');

------------------------------------------------------------
COMMIT;
































