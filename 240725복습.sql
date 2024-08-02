--=========================================================
/*
	- �л� ���� ���̺� : STUDENT
	- ���� ����
	  - �л� �̸�, ��������� NULL���� ������� �ʴ´�.
	  - �̸����� �ߺ��� ������� �ʴ´�.
	- ���� ������
		+ �л� ��ȣ ex) 1, 2, 3, ...
		+ �л� �̸� ex) '�踻��', '�ƹ���', ...
		+ �̸���    ex) 'kim12@kh.or.kr', 'dogdog@kh.or.kr', ...
		+ �������  ex) '24/07/25', '00/02/20', '88/12/25', ...
*/
DROP TABLE STUDENT;

CREATE TABLE STUDENT(
    ST_NAME VARCHAR2(15) NOT NULL,
    ST_NO NUMBER NOT NULL UNIQUE,
    ST_BIRTH DATE NOT NULL,
    EMAIL VARCHAR2(50) UNIQUE
);

 COMMENT ON COLUMN STUDENT.ST_NAME IS '�л��̸�';
 COMMENT ON COLUMN STUDENT.ST_NO IS '�л� ��ȣ';
 COMMENT ON COLUMN STUDENT.ST_BIRTH IS '�������';
 COMMENT ON COLUMN STUDENT.EMAIL IS '�̸���';

INSERT INTO STUDENT(ST_NAME, ST_NO, ST_BIRTH, EMAIL)
VALUES('������', 1, '95/10/14', 'kauli1014@naver.com');
------------------------------------------------------------
/*
	- ���� ���� ���̺� : BOOK
	- ���� ����
	  - ����� ���ڸ��� NULL���� ������� �ʴ´�.
	  - ISBN ��ȣ�� �ߺ��� ������� �ʴ´�.
	- ���� ������
	  + ���� ��ȣ ex) 1, 2, 3, ...
	  + ���� ex) '�ﱹ��', '�����', '�ڽ���', ...
	  + ���� ex) '����', '�������丮', 'Į ���̰�', ...
	  + ������ ex) '14/02/14', '22/09/19', ...
	  + ISBN��ȣ ex) '9780394502946', '9780152048044', ...
*/
DROP TABLE BOOK;

CREATE TABLE BOOK(
    TITLE VARCHAR2(100) NOT NULL,
    AUTHOR VARCHAR2(50) NOT NULL,
    BOOK_NO NUMBER,
    PUBLISH_DATE DATE,
    ISBN VARCHAR2(20) UNIQUE
);

COMMENT ON COLUMN BOOK.TITLE IS '����';
COMMENT ON COLUMN BOOK.AUTHOR IS '����';
COMMENT ON COLUMN BOOK.BOOK_NO IS '���� ��ȣ';
COMMENT ON COLUMN BOOK.PUBLISH_DATE IS '������';
COMMENT ON COLUMN BOOK.ISBN IS 'ISBN ��ȣ';

INSERT INTO BOOK( BOOK.TITLE,BOOK.AUTHOR,BOOK.BOOK_NO,BOOK.PUBLISH_DATE,BOOK.ISBN)
VALUES('����', '�������丮', 1,'14/02/14', '9780394502946');

------------------------------------------------------------
COMMIT;
































