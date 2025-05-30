/*=======================================
관리자 관리
   ID PK
   ---------------
   ACCOUNT
   NAME
   PHONE
   E-MAIL
=======================================*/
CREATE SEQUENCE SEQ_ADMIN;
CREATE TABLE TBL_ADMIN(
   ID NUMBER CONSTRAINT PK_ADMIN PRIMARY KEY,
   ADMIN_ACCOUNT VARCHAR2(1000) CONSTRAINT UK_ACCOUNT UNIQUE NOT NULL,
   ADMIN_PASSWORD VARCHAR2(1000) DEFAULT '1234',
   ADMIN_NAME VARCHAR2(1000) NOT NULL,
   ADMIN_PHONE VARCHAR2(1000) NOT NULL,
   ADMIN_EMAIL VARCHAR2(1000) NOT NULL
);
/*=======================================
추천 코스 작성
   ID PK
   -------------
   코스 제목
   코스 구분(DEFAULT 추천코스)
   총거리
   일정
   테마
   주소
   코스 요약
   대표 이미지
   생성 일자
   추천 코스 작성자 ID FK
========================================*/
CREATE SEQUENCE SEQ_COURSE;
CREATE TABLE TBL_COURSE(
   ID NUMBER CONSTRAINT PK_COURSE PRIMARY KEY,
   COURSE_ADD_DATE DATE DEFAULT SYSDATE,
   COURSE_NAME VARCHAR2(1000) NOT NULL,
   COURSE_TYPE VARCHAR2(1000) NOT NULL,
   COURSE_DISTANCE VARCHAR2(1000),
   COURSE_SCHEDULE VARCHAR2(1000) NOT NULL,
   COURSE_THEME VARCHAR2(1000) NOT NULL,
   COURSE_CONTENTS VARCHAR2(1000) NOT NULL,
   COURSE_IMG_PATH VARCHAR2(1000) NOT NULL,
   COURSE_IMG_SIZE VARCHAR2(1000) NOT NULL,
   COURSE_IMG_NAME VARCHAR2(1000) NOT NULL,
   COURSE_DATE DATE DEFAULT SYSDATE,
   VOLUNTEER_STATUS CHAR(1) DEFAULT 'F',
   ADMIN_ID NUMBER NOT NULL,
   CONSTRAINT FK_COURSE_ADMIN FOREIGN KEY(ADMIN_ID)
   REFERENCES TBL_ADMIN(ID)   
);
/*========================================
코스 경로 (PATH)
   ID PK
   ---------------
   PATH_NAME
   PATH_ADDRESS
   COURSE_ID FK
========================================*/
CREATE TABLE TBL_PATH(
   ID NUMBER CONSTRAINT PK_ID PRIMARY KEY,
   PATH_NAME VARCHAR2(1000) NOT NULL,
   PATH_ADDRESS VARCHAR(1000) NOT NULL,
   COURSE_ID NUMBER NOT NULL,
   CONSTRAINT FK_PATH_COURSE FOREIGN KEY(COURSE_ID)
   REFERENCES TBL_COURSE(ID)
);
/*========================================
/*========================================
계획서
	ID PK
	------------
	날짜
	시작일
	종료일
	마감일
	내용 
	추천코스 작성 ID FK
	
========================================*/
CREATE SEQUENCE SEQ_VOLUNTEER;
CREATE TABLE TBL_VOLUNTEER(
	ID NUMBER CONSTRAINT PK__VOLUNTEER PRIMARY KEY,
	VOLUNTEER_START_DATE DATE NOT NULL,
	VOLUNTEER_END_DATE DATE NOT NULL,
	VOLUNTEER_DEADLINE DATE NOT NULL,
	VOLUNTEER_CONTENTS VARCHAR2(1000),
	COURSE_ID NUMBER NOT NULL,
	CONSTRAINT FK_VOLUNTEER_COURSE FOREIGN KEY(COURSE_ID)
	REFERENCES TBL_COURSE(ID)
);
/*========================================
포함사항
	ID PK
	---------------
	추천 코스 작성 ID FK

========================================*/
CREATE SEQUENCE SEQ_INCLUDED;
CREATE TABLE TBL_INCLUDED(
	ID NUMBER CONSTRAINT PK_INCLUDED PRIMARY KEY,
	INCLUDED_CONTENTS VARCHAR2(1000),
	VOLUNTEER_ID NUMBER NOT NULL,
	CONSTRAINT FK_INCLUDED_VOLUNTEER FOREIGN KEY(VOLUNTEER_ID)
	REFERENCES TBL_VOLUNTEER(ID)
);

/*========================================
불포함사항
	ID PK
	---------------
	추천 코스 작성 ID FK
========================================*/
CREATE SEQUENCE SEQ_EXCLUDED;
CREATE TABLE TBL_EXCLUDED(
	ID NUMBER CONSTRAINT PK_EXCLUDED PRIMARY KEY,
	EXCLUDED_CONTENTS VARCHAR2(1000),
	VOLUNTEER_ID NUMBER NOT NULL,
	CONSTRAINT FK_EXCLUDED_VOLUNTEER FOREIGN KEY(VOLUNTEER_ID)
	REFERENCES TBL_VOLUNTEER(ID)
);
/*========================================
준비물
	ID PK
	---------------
	추천 코스 작성 ID FK
========================================*/
CREATE SEQUENCE SEQ_SUPPLIES;
CREATE TABLE TBL_SUPPLIES(
	ID NUMBER CONSTRAINT PK_SUPPLIES PRIMARY KEY,
	SUPPLIES_CONTENTS VARCHAR2(1000),
	VOLUNTEER_ID NUMBER NOT NULL,
	CONSTRAINT FK_SUPPLIES_VOLUNTEER FOREIGN KEY(VOLUNTEER_ID)
	REFERENCES TBL_VOLUNTEER(ID)
);
/*=======================================
공지 사항 등록
	ID PK
	---------------
	공지 제목
	공지 내용
	공지 등록 날짜
	관리자 ID
=======================================*/
CREATE SEQUENCE SEQ_NOTICE;
CREATE TABLE TBL_NOTICE(
	ID NUMBER CONSTRAINT PK_NOTICE PRIMARY KEY,
	NOTICE_NAME VARCHAR2(1000) NOT NULL,
	NOTICE_CONTENTS VARCHAR2(1000) NOT NULL,
	NOTICE_DATE DATE DEFAULT SYSDATE,
	ADMIN_ID NUMBER NOT NULL,
	CONSTRAINT FK_NOTICE_ADMIN FOREIGN KEY(ADMIN_ID)
	REFERENCES TBL_ADMIN(ID)
);
/*=======================================
공지 사항 사진 
	ID PK
	---------------
	사진 경로
	사진 이름
	공지사항ID FK
=======================================*/

/*CREATE SEQUENCE SEQ_NOTICE_FILE;
CREATE TABLE TBL_NOTICE_FILE(
	ID NUMBER CONSTRAINT PK_NOTICE_FILE PRIMARY KEY,
	NOTICE_FILE_PATH VARCHAR2(1000) NOT NULL,
	NOTICE_FILE_SIZE VARCHAR2(1000) NOT NULL,
	NOTICE_FILE_NAME VARCHAR2(1000) NOT NULL,
	NOTICE_ID NUMBER,
	CONSTRAINT FK_NOTICE_FILE_NOTICE FOREIGN KEY(NOTICE_ID)
	REFERENCES TBL_NOTICE(ID)
);*/
 

/*
 * **************************************************************************
 * 준비물, 포함사항, 불포함사항, 스케쥴 (일단 제꺼 빼고 승찬님꺼 넣어놓은 상태)
 * 승찬님 SQL*/ 


/*여행계획
------
번호 PK
------
여행명
시작일
종료일
마감일
모집인원
최소인원
비용
모이는 장소 주소
소개내용
대표 파일 경로명 // 하나만 등록되도록 수정
대표 파일 파일명
등록일
등록취소일      // 모집마감일이 지나면 자동 취소
회원번호 FK // 작성자
추천코스번호 FK
생성일자
수정일자*/
CREATE SEQUENCE SEQ_MEMBER;
CREATE TABLE TBL_MEMBER(
	ID NUMBER CONSTRAINT PK_USER PRIMARY KEY,
	MEMBER_EMAIL VARCHAR2(1000) UNIQUE NOT NULL,
	MEMBER_PASSWORD VARCHAR2(1000) NOT NULL,
	MEMBER_NICKNAME VARCHAR2(1000) UNIQUE NOT NULL,
	MEMBER_TELL VARCHAR2(1000) NOT NULL,
	MEMBER_BIRTH DATE DEFAULT SYSDATE,
	MEMBER_GENDER VARCHAR2(1000) DEFAULT '선택안함',
	MEMBER_POINT NUMBER DEFAULT 0
);

CREATE SEQUENCE SEQ_PLAN;
CREATE TABLE TBL_PLAN(
	ID NUMBER CONSTRAINT PK_PLAN PRIMARY KEY,
	PLAN_NAME VARCHAR2(1000) NOT NULL,
	PLAN_START_DATE DATE DEFAULT SYSDATE,
	PLAN_END_DATE DATE DEFAULT SYSDATE,
	PLAN_MAX_PERSONNEL NUMBER NOT NULL,
	PLAN_MIN_PERSONNEL NUMBER NOT NULL,
	PLAN_PRICE NUMBER NOT NULL,
	PLAN_GATHERING_ADDR VARCHAR2(2000) NOT NULL,
	PLAN_INTRODUCTION VARCHAR2(2000) NOT NULL,
	PLAN_FILE_PATH VARCHAR2(2000) NOT NULL,
	PLAN_FILE_NAME VARCHAR2(2000) NOT NULL,
	PLAN_REGIST_DATE DATE DEFAULT NULL,
	PLAN_REGIST_CANCEL_DATE DATE DEFAULT NULL,
	MEMBER_ID NUMBER NOT NULL,
	COURSE_ID NUMBER NOT NULL,
	CREATE_DATE DATE DEFAULT SYSDATE,
	UPDATE_DATE DATE DEFAULT SYSDATE,
	CONSTRAINT FK_PLAN_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES TBL_MEMBER(ID),
	CONSTRAINT FK_PLAN_COURSE FOREIGN KEY(COURSE_ID)
	REFERENCES TBL_COURSE(ID)
);

/*-------------------
포함/불포함/준비물 슈퍼
-------------------
번호 PK
-------------------
내용
생성일자
수정일자*/

/*

CREATE SEQUENCE SEQ_CONSIDER;
CREATE TABLE TBL_CONSIDER (
	ID NUMBER CONSTRAINT PK_CONSIDER PRIMARY KEY,
	CONSIDER_CONTENT VARCHAR2(1000) DEFAULT '',
	CREATE_DATE DATE DEFAULT SYSDATE,
	UPDATE_DATE DATE DEFAULT SYSDATE
);
*/

/*--------------- ----------------- ------------------
포함 				불포함 				준비물
--------------- ----------------- ------------------

번호 PK FK 		번호 PK FK 			번호 PK FK
여행계획번호 FK 	여행계획번호 FK 		여행계획번호 FK*/

CREATE SEQUENCE SEQ_INCLUDE;
CREATE TABLE TBL_INCLUDE (
	ID NUMBER CONSTRAINT PK_INCLUDE PRIMARY KEY,
	INCLUDE_CONTENT VARCHAR2(1000) DEFAULT '',
	PLAN_ID NUMBER NOT NULL,
	CONSTRAINT FK_INCLUDE_PLAN FOREIGN KEY (PLAN_ID)
	REFERENCES TBL_PLAN(ID)
);

CREATE SEQUENCE SEQ_EXCLUDE;
CREATE TABLE TBL_EXCLUDE (
	ID NUMBER CONSTRAINT PK_EXCLUDE PRIMARY KEY,
	EXCLUDE_CONTENT VARCHAR2(1000) DEFAULT '',
	PLAN_ID NUMBER NOT NULL,
	CONSTRAINT FK_EXCLUDE_PLAN FOREIGN KEY (PLAN_ID)
	REFERENCES TBL_PLAN(ID)
);

CREATE SEQUENCE SEQ_PREPARE;
CREATE TABLE TBL_PREPARE (
	ID NUMBER CONSTRAINT PK_PREPARE PRIMARY KEY,
	PREPARE_CONTENT VARCHAR2(1000) DEFAULT '',
	PLAN_ID NUMBER NOT NULL,
	CONSTRAINT FK_PREPARE_PLAN FOREIGN KEY (PLAN_ID)
	REFERENCES TBL_PLAN(ID)
);

/*----------
찜 슈퍼
----------
번호 PK
-----------
생성일자
수정일자*/
CREATE SEQUENCE SEQ_WISH;
CREATE TABLE TBL_WISH (
	ID NUMBER CONSTRAINT PK_WISH PRIMARY KEY,
	CREATE_DATE DATE DEFAULT SYSDATE,
	UPDATE_DATE DATE DEFAULT SYSDATE,
	MEMBER_ID NUMBER NOT NULL,
	COURSE_ID NUMBER NOT NULL,
	CONSTRAINT FK_WISH_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES TBL_MEMBER(ID),
	CONSTRAINT FK_WISH_COURSE FOREIGN KEY(COURSE_ID)
	REFERENCES TBL_COURSE(ID)
);


/*-------------
일정 슈퍼
------------
번호 PK
-----------
날짜
일정내용
생성일자
수정일자*/
/*

CREATE SEQUENCE SEQ_SCHEDULE;
CREATE TABLE TBL_SCHEDULE (
	ID NUMBER CONSTRAINT PK_SCHEDULE PRIMARY KEY,
	SCHEDULE_DATE DATE NOT NULL,
	SCHEDULE_CONTENT VARCHAR2(2000) NOT NULL,
	CREATE_DATE DATE DEFAULT SYSDATE,
	UPDATE_DATE DATE DEFAULT SYSDATE
);
*/


/*-------------
여행계획 일정
------------
번호 PK
-----------
여행계획번호 FK*/

CREATE SEQUENCE SEQ_SCHEDULE;
CREATE TABLE TBL_SCHEDULE(
	ID NUMBER CONSTRAINT PK_SCHEDULE PRIMARY KEY,
	SCHEDULE_DATE DATE NOT NULL,
	SCHEDULE_CONTENT VARCHAR2(2000) NOT NULL,
	PLAN_ID NUMBER NOT NULL,
	CONSTRAINT FK_SCHEDULE_PLAN FOREIGN KEY(PLAN_ID)
	REFERENCES TBL_PLAN(ID)
);

/*
------------
참여
------------
번호
-------------
회원번호 FK
여행계획번호 FK
생성일자
수정일자
*/

CREATE SEQUENCE SEQ_PARTICIPANT;
CREATE TABLE TBL_PARTICIPANT (
	ID NUMBER CONSTRAINT PK_PARTICIPANT PRIMARY KEY,
	MEMBER_ID NUMBER NOT NULL,
	PLAN_ID NUMBER NOT NULL,
	CREATE_DATE DATE DEFAULT SYSDATE,
	UPDATE_DATE DATE DEFAULT SYSDATE,
	CONSTRAINT FK_PARTICIPANT_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES TBL_MEMBER(ID),
	CONSTRAINT FK_PARTICIPANT_PLAN FOREIGN KEY(PLAN_ID)
	REFERENCES TBL_PLAN(ID)
);

/*--------------
질문
-------------
번호 PK
--------------
내용
여행계획 번호 FK
생성일자
수정일자*/

CREATE SEQUENCE SEQ_QUESTION;
CREATE TABLE TBL_QUESTION (
	ID NUMBER CONSTRAINT PK_QEUSTION PRIMARY KEY,
	MEMBER_ID NUMBER NOT NULL,
	PLAN_ID NUMBER NOT NULL,
	CREATE_DATE DATE DEFAULT SYSDATE,
	UPDATE_DATE DATE DEFAULT SYSDATE,
	CONSTRAINT FK_QEUSTION_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES TBL_MEMBER(ID),
	CONSTRAINT FK_QEUSTION_PLAN FOREIGN KEY(PLAN_ID)
	REFERENCES TBL_PLAN(ID)
);

/*--------------
답글
-------------
번호 PK
--------------
내용
질문 번호 FK
생성일자
수정일자*/

CREATE SEQUENCE SEQ_ANSWER;
CREATE TABLE TBL_ANSWER (
	ID NUMBER CONSTRAINT PK_ANSWER PRIMARY KEY,
	ANSWER_CONTENT VARCHAR2(2000) NOT NULL,
	MEMBER_ID NUMBER NOT NULL,
	QUESTION_ID NUMBER NOT NULL,
	CONSTRAINT FK_ANSWER_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES TBL_MEMBER(ID),
	CONSTRAINT FK_ANSWER_QEUSTION FOREIGN KEY(QUESTION_ID)
	REFERENCES TBL_QUESTION(ID)
);

/*----------------
결제내역
---------------
번호
---------------
단가
결제인원
사용포인트      // 단가 * 결제인원 - 사용포인트 :: 최종결제금액. 최종결제금액 / 100 :: 적립포인트
적립포인트
결제수단
카드사번호
회원번호 FK
모집여행번호 FK
생성일자
수정일자*/

CREATE SEQUENCE SEQ_PAY;
CREATE TABLE TBL_PAY(
	ID NUMBER CONSTRAINT PK_PAY PRIMARY KEY,
	PAY_PRICE NUMBER DEFAULT 0,
	PAY_PERSONNEL NUMBER DEFAULT 1,
	PAY_USED_POINT NUMBER DEFAULT 0,
	PAY_NEW_POINT NUMBER DEFAULT 0,
	PAY_METHOD NUMBER(3) NOT NULL,
	PAY_CARD_COMPANY NUMBER(3) NOT NULL,
	MEMBER_ID NUMBER NOT NULL,
	PLAN_ID NUMBER NOT NULL,
	CREATE_DATE DATE DEFAULT SYSDATE,
	UPDATE_DATE DATE DEFAULT SYSDATE,
	CONSTRAINT FK_PAY_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES TBL_MEMBER(ID),
	CONSTRAINT FK_PAY_PLAN FOREIGN KEY(PLAN_ID)
	REFERENCES TBL_PLAN(ID)
);


/*--------------------
피드 슈퍼키
-------------------
번호 PK
-------------------
내용
생성일자
수정일자*/
CREATE SEQUENCE SEQ_FEED;
CREATE TABLE TBL_FEED(
	ID NUMBER CONSTRAINT PK_FEED PRIMARY KEY,
	CREATE_DATE DATE DEFAULT SYSDATE,
	UPDATE_DATE DATE DEFAULT SYSDATE,
	FEED_CONTENT VARCHAR2(2000) NOT NULL
);
SELECT * FROM TBL_FEED;

/*-------------------- -------------------- ----------------------
일반피드 				같이해요피드 				후기
-------------------- -------------------- -----------------------
번호 PK FK 			번호 PK FK 				번호 PK FK
---------------------- ---------------------- ----------------------
회원번호 FK 			회원번호 FK 				평가 점수
											회원번호 FK
											여행계획 번호 FK*/

CREATE SEQUENCE SEQ_GENERAL_FEED;
CREATE TABLE TBL_GENERAL_FEED(
	ID NUMBER CONSTRAINT PK_GENERAL_FEED PRIMARY KEY,
	MEMBER_ID NUMBER NOT NULL,
	CONSTRAINT FK_GENERAL_FEED_FEED FOREIGN KEY(ID)
	REFERENCES TBL_FEED(ID),
	CONSTRAINT FK_GENERAL_FEED_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES TBL_MEMBER(ID)
);											

CREATE SEQUENCE SEQ_TOGETHER_FEED;
CREATE TABLE TBL_TOGETHER_FEED(
	ID NUMBER CONSTRAINT PK_TOGETHER_FEED PRIMARY KEY,
	MEMBER_ID NUMBER NOT NULL,
	CONSTRAINT FK_TOGETHER_FEED_FEED FOREIGN KEY(ID)
	REFERENCES TBL_FEED(ID),
	CONSTRAINT FK_TOGETHER_FEED_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES TBL_MEMBER(ID)
);											
		

CREATE SEQUENCE SEQ_REAL_FEED;
CREATE TABLE TBL_REAL_FEED(
	ID NUMBER CONSTRAINT PK_REAL_FEED PRIMARY KEY,
	REAL_FEED_STAR NUMBER(1) DEFAULT 0,
	MEMBER_ID NUMBER NOT NULL,
	PLAN_ID NUMBER NOT NULL,
	CONSTRAINT FK_REAL_FEED_FEED FOREIGN KEY(ID)
	REFERENCES TBL_FEED(ID),
	CONSTRAINT FK_REAL_FEED_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES TBL_MEMBER(ID),
	CONSTRAINT FK_REAL_FEED_PLAN FOREIGN KEY(PLAN_ID)
	REFERENCES TBL_PLAN(ID)
);											
		
											
/*------------------
태그 슈퍼
------------------
번호 PK
-----------------
내용
생성일자
수정일자*/
/*

CREATE SEQUENCE SEQ_TAG;
CREATE TABLE TBL_TAG(
	ID NUMBER CONSTRAINT PK_TAG PRIMARY KEY,
	TAG_CONTENT VARCHAR2(2000) NOT NULL,
	CREATE_DATE DATE DEFAULT SYSDATE,
	UPDATE_DATE DATE DEFAULT SYSDATE
);
*/


/*---------------- --------------------
일반/같이 피드태그     후기 태그
---------------- ---------------------
번호 PK FK         번호 PK FK
---------------- ---------------------
피드 번호 FK        후기번호 FK*/


CREATE SEQUENCE SEQ_GENERAL_TAG;
CREATE TABLE TBL_GENERAL_TAG(
	ID NUMBER CONSTRAINT PK_GENERAL_TAG PRIMARY KEY,
	TAG_CONTENT VARCHAR2(2000) NOT NULL,
	GENERAL_FEED_ID NUMBER NOT NULL,
	CONSTRAINT FK_GENERAL_TAG_GENERAL_FEED FOREIGN KEY(GENERAL_FEED_ID)
	REFERENCES TBL_GENERAL_FEED(ID)
);											
CREATE SEQUENCE SEQ_TOGETHER_TAG;
CREATE TABLE TBL_TOGETHER_TAG(
	ID NUMBER CONSTRAINT PK_TOGETHER_TAG PRIMARY KEY,
	TAG_CONTENT VARCHAR2(2000) NOT NULL,
	TOGETHER_FEED_ID NUMBER NOT NULL,
	CONSTRAINT FK_TOGETHER_TAG_TOGETHER_FEED FOREIGN KEY(TOGETHER_FEED_ID)
	REFERENCES TBL_TOGETHER_FEED(ID)
);											


CREATE SEQUENCE SEQ_REAL_TAG;
CREATE TABLE TBL_REAL_TAG(
	ID NUMBER CONSTRAINT PK_REAL_TAG PRIMARY KEY,
	TAG_CONTENT VARCHAR2(2000) NOT NULL,
	REAL_FEED_ID NUMBER NOT NULL,
	CONSTRAINT FK_REAL_TAG_REAL_FEED FOREIGN KEY(REAL_FEED_ID)
	REFERENCES TBL_REAL_FEED(ID)
);											



/*-----------------
파일 슈퍼
-----------------
번호 PK
경로이름
파일이름
크기
생성일자
수정일자*/


CREATE SEQUENCE SEQ_FILE;
CREATE TABLE TBL_FILE(
	ID NUMBER CONSTRAINT PK_FILE PRIMARY KEY,
	FILE_PATH VARCHAR2(1000) NOT NULL,
	FILE_NAME VARCHAR2(1000) NOT NULL,
	FILE_SIZE VARCHAR2(200)  DEFAULT '',
	CREATE_DATE DATE DEFAULT SYSDATE,
	UPDATE_DATE DATE DEFAULT SYSDATE
);

/*---------------- ----------------------------
일반/같이 피드 파일    후기 파일           공시 파일
---------------- ----------------------------
번호 PK FK          번호 PK FK        번호 PK FK  
---------------- ------------------------------
피드 번호 FK         후기 번호 FK        공시 번호 FK*/



CREATE SEQUENCE SEQ_GENERAL_FILE;
CREATE TABLE TBL_GENERAL_FILE(
	ID NUMBER CONSTRAINT PK_GENERAL_FILE PRIMARY KEY,
	GENERAL_FEED_ID NUMBER NOT NULL,
	CONSTRAINT FK_GENERAL_FILE_FILE FOREIGN KEY(ID)
	REFERENCES TBL_FILE(ID),
	CONSTRAINT FK_GENERAL_FILE_GENERAL_FEED FOREIGN KEY(GENERAL_FEED_ID)
	REFERENCES TBL_GENERAL_FEED(ID)
);											

CREATE SEQUENCE SEQ_TOGETHER_FILE;
CREATE TABLE TBL_TOGETHER_FILE(
	ID NUMBER CONSTRAINT PK_TOGETHER_FILE PRIMARY KEY,
	TOGETHER_FEED_ID NUMBER NOT NULL,
	CONSTRAINT FK_TOGETHER_FILE_FILE FOREIGN KEY(ID)
	REFERENCES TBL_FILE(ID),
	CONSTRAINT FK_TOGETHER_FILE_TOGETHER_FEED FOREIGN KEY(TOGETHER_FEED_ID)
	REFERENCES TBL_TOGETHER_FEED(ID)
);											


CREATE SEQUENCE SEQ_REAL_FILE;
CREATE TABLE TBL_REAL_FILE(
	ID NUMBER CONSTRAINT PK_REAL_FILE PRIMARY KEY,
	REAL_FEED_ID NUMBER NOT NULL,
	CONSTRAINT FK_REAL_FILE_FILE FOREIGN KEY(ID)
	REFERENCES TBL_FILE(ID),
	CONSTRAINT FK_REAL_FILE_REAL_FEED FOREIGN KEY(REAL_FEED_ID)
	REFERENCES TBL_REAL_FEED(ID)
);											

CREATE SEQUENCE SEQ_NOTICE_FILE;
CREATE TABLE TBL_NOTICE_FILE(
	ID NUMBER CONSTRAINT PK_NOTICE_FILE PRIMARY KEY,
	NOTICE_ID NUMBER NOT NULL,
	CONSTRAINT FK_NOTICE_FILE_FILE FOREIGN KEY(ID)
	REFERENCES TBL_FILE(ID),
	CONSTRAINT FK_NOTICE_FILE_NOTICE FOREIGN KEY(NOTICE_ID)
	REFERENCES TBL_NOTICE(ID)
);											


/*-----------------
댓글 슈퍼
-----------------
번호 PK
-----------------
내용
생성일자
수정일자*/

CREATE SEQUENCE SEQ_REPLY;
CREATE TABLE TBL_REPLY(
	ID NUMBER CONSTRAINT PK_REPLY PRIMARY KEY,
	REPLY_CONTENT VARCHAR2(2000) NOT NULL,
	CREATE_DATE DATE DEFAULT SYSDATE,
	UPDATE_DATE DATE DEFAULT SYSDATE
);


/*--------------------- ----------------------
일반/같이 피드 댓글         후기 댓글
---------------------- -----------------------
번호 PK FK              번호 PK FK
---------------------- -----------------------
피드번호 FK               후기번호 FK
회원번호 FK               회원번호 FK*/



CREATE SEQUENCE SEQ_GENERAL_REPLY;
CREATE TABLE TBL_GENERAL_REPLY(
	ID NUMBER CONSTRAINT PK_GENERAL_REPLY PRIMARY KEY,
	MEMBER_ID NUMBER NOT NULL,
	GENERAL_FEED_ID NUMBER NOT NULL,
	CONSTRAINT FK_GENERAL_REPLY_REPLY FOREIGN KEY(ID)
	REFERENCES TBL_REPLY(ID),
	CONSTRAINT FK_GENERAL_REPLY_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES TBL_MEMBER(ID),
	CONSTRAINT FK_GENERAL_REPLY_GENERAL_FEED FOREIGN KEY(GENERAL_FEED_ID)
	REFERENCES TBL_GENERAL_FEED(ID)
);											

CREATE SEQUENCE SEQ_TOGETHER_REPLY;
CREATE TABLE TBL_TOGETHER_REPLY(
	ID NUMBER CONSTRAINT PK_TOGETHER_REPLY PRIMARY KEY,
	MEMBER_ID NUMBER NOT NULL,
	TOGETHER_FEED_ID NUMBER NOT NULL,
	CONSTRAINT FK_TOGETHER_REPLY_REPLY FOREIGN KEY(ID)
	REFERENCES TBL_REPLY(ID),
	CONSTRAINT FK_TOGETHER_REPLY_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES TBL_MEMBER(ID),
	CONSTRAINT FK_TOGETHE_REPLY_TOGETHE_FEED FOREIGN KEY(TOGETHER_FEED_ID)
	REFERENCES TBL_TOGETHER_FEED(ID)
);											


CREATE SEQUENCE SEQ_REAL_REPLY;
CREATE TABLE TBL_REAL_REPLY(
	ID NUMBER CONSTRAINT PK_REAL_REPLY PRIMARY KEY,
	MEMBER_ID NUMBER NOT NULL,
	REAL_FEED_ID NUMBER NOT NULL,
	CONSTRAINT FK_REAL_REPLY_REPLY FOREIGN KEY(ID)
	REFERENCES TBL_REPLY(ID),
	CONSTRAINT FK_REAL_REPLY_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES TBL_MEMBER(ID),
	CONSTRAINT FK_REAL_REPLY_REAL_FEED FOREIGN KEY(REAL_FEED_ID)
	REFERENCES TBL_REAL_FEED(ID)
);											


/*---------------------
후기 좋아요
---------------------
번호 PK
----------------------
후기번호 FK
회원번호 FK*/

CREATE SEQUENCE SEQ_LIKE;
CREATE TABLE TBL_LIKE(
	ID NUMBER CONSTRAINT PK_LIKE PRIMARY KEY,
	MEMBER_ID NUMBER NOT NULL,
	REAL_FEED_ID NUMBER NOT NULL,
	CONSTRAINT FK_LIKE_MEMBER FOREIGN KEY(MEMBER_ID)
	REFERENCES TBL_MEMBER(ID),
	CONSTRAINT FK_LIKE_REAL_FEED FOREIGN KEY(REAL_FEED_ID)
	REFERENCES TBL_REAL_FEED(ID)
);											


/*
 * **************************************************************************
 * 정근님 SQL*/

/*회원 정보  (위에 넣어둠)*/
/*CREATE TABLE TBL_MEMBER(
	ID NUMBER CONSTRAINT PK_USER PRIMARY KEY,
	MEMBER_EMAIL VARCHAR2(1000) UNIQUE NOT NULL,
	MEMBER_PASSWORD VARCHAR2(1000) NOT NULL,
	MEMBER_NICKNAME VARCHAR2(1000) UNIQUE NOT NULL,
	MEMBER_TELL VARCHAR2(1000) NOT NULL,
	MEMBER_BIRTH DATE DEFAULT SYSDATE,
	MEMBER_GENDER VARCHAR2(1000) DEFAULT '선택안함',
	MEMBER_POINT NUMBER DEFAULT 0
);*/
/*쪽지함 슈퍼키*/
CREATE TABLE TBL_MESSAGE(
	ID NUMBER CONSTRAINT PK_MESSAGE_ALL PRIMARY KEY,
	MESSAGE_ALL_CONTENT VARCHAR2(1000) NOT NULL,
	MESSAGE_ALL_DATE DATE DEFAULT SYSDATE
);
/*받은 쪽지함*/
CREATE TABLE TBL_RECEIVE_MESSAGE(
	ID NUMBER CONSTRAINT PK_RECEIVE_MESSAGE PRIMARY KEY,
	RECEIVE_MESSAGE_RECEIVER NUMBER NOT NULL,
	RECEIVE_MESSAGE_SENDER NUMBER NOT NULL,
	RECEIVE_MESSAGE_CHECK VARCHAR2(1000) DEFAULT 'FALSE',
	CONSTRAINT FK_RECEIVE_MESSAGE_MESSAGE FOREIGN KEY(ID)
	REFERENCES TBL_MESSAGE(ID),
	CONSTRAINT FK_RECEIVE_MESSAGE_RECEIVER FOREIGN KEY(RECEIVE_MESSAGE_RECEIVER)
	REFERENCES TBL_MEMBER(ID),
	CONSTRAINT FK_RECEIVE_MESSAGE_SENDER FOREIGN KEY(RECEIVE_MESSAGE_SENDER)
	REFERENCES TBL_MEMBER(ID)
);
/*보낸 쪽지함*/
CREATE TABLE TBL_SEND_MESSAGE(
	ID NUMBER CONSTRAINT PK_SEND_MESSAGE PRIMARY KEY,
	SEND_MESSAGE_RECEIVER NUMBER NOT NULL,
	SEND_MESSAGE_SENDER NUMBER NOT NULL,
	CONSTRAINT FK_SEND_MESSAGE_MESSAGE FOREIGN KEY(ID)
	REFERENCES TBL_MESSAGE(ID),
	CONSTRAINT FK_SEND_MESSAGE_RECEIVER FOREIGN KEY(SEND_MESSAGE_RECEIVER)
	REFERENCES TBL_MEMBER(ID),
	CONSTRAINT FK_SEND_MESSAGE_SENDER FOREIGN KEY(SEND_MESSAGE_SENDER)
	REFERENCES TBL_MEMBER(ID)
);
/*쪽지함에 있는 파일*/
CREATE TABLE TBL_MESSAGE_FILE(
	ID NUMBER CONSTRAINT PK_MESSAGE_FILE PRIMARY KEY,
	MESSAGE_ID NUMBER NOT NULL,
	CONSTRAINT FK_MESSAGE_FILE FOREIGN KEY(ID)
	REFERENCES TBL_FILE(ID),
	CONSTRAINT FK_MESSAGE_MESSAGE FOREIGN KEY(MESSAGE_ID)
	REFERENCES TBL_MESSAGE(ID)
);

CREATE VIEW VIEW_SEND_MESSAGE_SENDER AS 
(
	SELECT
	M.ID MEMBER_ID , M.MEMBER_EMAIL , M.MEMBER_PASSWORD , M.MEMBER_NICKNAME , M.MEMBER_TELL , M.MEMBER_BIRTH ,M.MEMBER_GENDER ,M.MEMBER_POINT ,
	S.SEND_MESSAGE_SENDER ,
	MESSAGE.MESSAGE_ALL_CONTENT , MESSAGE.MESSAGE_ALL_DATE
	FROM TBL_MEMBER M 
	JOIN TBL_SEND_MESSAGE S
	ON M.ID = S.SEND_MESSAGE_SENDER 
	JOIN TBL_MESSAGE MESSAGE
	ON S.ID = MESSAGE.ID
);
