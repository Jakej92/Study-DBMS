DB(Database)

	데이터가 모여있는 기지
	추상적인 용어

DBMS(Database Management System)

	DB를 관리할 수 있는 구체적인 시스템
	오라클, 마리아DB, MySQL, MS-SQL, NO-SQL 등

오라클 DBMS 버전

	i: internet
	g: grid
	c: cloud

오라클 DBMS 설치 - 11G

	https://drive.google.com/file/d/1rM1Z7-mA6vjySBgwWLr3ZI883xiL27HN/view?usp=sharing

	▶ 초기 세팅
		> sqlplus sys as sysdba
		> 1234
		SQL> alter user system identified by 1234;
		SQL> conn system/1234;
		
	▶ scott 계정 활성화
		SQL> @[scott.sql 파일의 전체 경로]: 직접 작성하거나 파일을 드래그 앤 드랍하기
		SQL> conn system/1234;
		SQL> show user;
		SQL> alter user scott identified by 1234;
		SQL> conn scott/1234;
		SQL> show user		

DBMS IDE 설치

	https://dbeaver.io/files/23.0.1/

DBeaver에서 Oracle 연동하기

	1. Create > Connection
	2. oracle 검색 후 선택
	3. host: localhost
	4. database: XE
	5. username: scott
	6. password: 1234
	7. Driver Setting > 기존 목록 전체 삭제 > Add file
				> 아래의 경로에 있는 ojdbc6.jar 선택 > Add Class 버튼 클릭
				> 다운로드 눌렀을 때 문제 있으면 그대로 완료 누르기
				> 첫번째 옵션 선택 > 완료 > Test Connection > Connected > Finish

_____________________________________________________________________________________________________

DBMS의 소통 방식

    ----------------------------------------------------------------------------------------------
    					 사용자
    ----------------------------------------------------------------------------------------------
    	↕       	   	   	   ↕	  	  		  ↕
    고객 관리 응용프로그램   	   	   ↕  		 	주문 관리 응용프로그램
                ↕              	 	   ↕   			          ↕
    -----------------------------------------------------------------------------------------------
             				  DBMS
    -----------------------------------------------------------------------------------------------

RDBMS(관계형 데이터베이스 시스템)

    고객 테이블(TBL_MEMBER)         주문 테이블(TBL_ORDER)
    번호	이름		나이		아이디		주문번호	번호	날짜		상품		수량
    1	한동석	20		hds1234		1		1	2025-02-01			5
    2	김승균	55		ksg9999		2		1	2025-02-02			10
    3	김동완	99		kdw7777		3		2	2025-02-02			550
    4	조승찬	15		csc7890		4		4	2025-02-03			600
    
    이러한 구조를 가지는 것을 Table, Relation, Class라고 부른다.

COLUMN(열, 속성, 필드)

    공통된 값들의 주제, 하나의 집합을 의미한다.

ROW(행, 레코드, 튜플) 

	하나의 정보를 의미한다.
	
PRIMARY KEY(PK)

	고유한 값을 의미한다.
	각 행의 구분점으로 사용된다.
	중복이 없고 NULL값을 허용하지 않는다.

FORIGN KEY(FK)

	다른 테이블의 PK를 의미한다.
	보통 테이블끼리 관계를 맺을 때 사용한다.
	중복이 가능하고 NULL도 허용한다.

UNIQUE KEY(UK)

	 NULL을 허용하지만 중복은 허용하지 않는다.
_____________________________________________________________________________________________________
SQL문(쿼리문)

	DBMS와 소통할 수 있는 언어이다.
	스크립트 언어이다.

SQL문의 종류: DDL, DML, DCL(x), TCL </br>
</br>
DDL(Data Definition Language): 데이터 정의어

	테이블 조작 및 제어 관련 쿼리문
	
	1. CREATE: 테이블 생성
			CREATE TABLE [테이블명] (
					[컬럼명] [자료형(용량)] [제약조건],
					[컬럼명] [자료형(용량)] [제약조건],
					...,
					추가 제약 조건
			);

	2. DROP: 테이블 삭제(회사에서 쓸 일 없음, 복구 안됨)
			DROP TABLE [테이블명];
	
	3. ARTER: 테이블 수정
			ALTER TABLE [테이블명] 
			- 테이블명 수정 : RENAME TO [새로운 테이블명]
			- 컬럼 추가 : ADD([새로운 컬럼명] [자료형(용량)])
			- 컬럼명 변경 : RENAME COLUMN [기존 컬럼명] TO [새로운 컬럼명]
			- 컬럼 삭제 : DROP COLUMN [기존 컬럼명]
			- 컬럼 수정 : MODIFY([기존 컬럼명] [자료형(용량)])

	4. TRUNCATE: 테이블 내용 전체 삭제(회사에서 쓸 일 없음, 복구 안됨)
			TRUNCATE TABLE [테이블명]

자료형(TYPE): 용량은 항상 넉넉하게 주도록 한다.

	숫자
		315611.14561
		-------  -------
		진수	   가수
		
		NUMBER(진수): 정수
		NUMBER(진수, 가수): 실수
	
	문자열
		CHAR(용량): 고정형
		VARCHAR(용량), VARCHAR2(용량): 가변형 

	날짜
		DATE: FORMAT에 맞춰서 날짜를 저장하는 타입
_____________________________________________________________________________________________________
무결성

	데이터의 정확성, 일관성, 유효성이 유지되는 것.
	
	정확성: 데이터는 애매하지 않아야 한다.
	일관성: 각 사용자가 일관된 데이터를 볼 수 있도록 해야한다.
	유효성: 데이터가 실제 존재하는 데이터여야 한다.

	1. 개체 무결성
		모든 테이블이 반드시 PK로 설정된 컬럼을 가져야 한다.

	2. 참조 무결성
		두 테이블의 데이터가 항상 일관된 값을 가지도록 유지하는 것.

	3. 도메인 무결성
		컬럼의 타입, NULL 값의 허용 등에 대한 사항을 정의하고
		올바른 데이터가 입력되었는지를 확인하는 것.
_____________________________________________________________________________________________________
모델링(기획)

	추상적인 주제를 RDB에 맞게 설계하는 작업
	
	1. 요구사항 분석
		회원, 주문, 상품: 3가지를 관리하고자 한다.

	2. 개념적 설계(개념 모델링)
		회원			주문			상품
		
		번호			번호			번호
		이메일		날짜			이름
		비밀번호		회원번호		가격
		이름			상품번호		재고
		주소			
		생일			
		
	3. 논리적 설계(논리 모델링)
		회원			주문			상품
		---------------------------------------------------
		번호PK		번호PK		번호PK
		---------------------------------------------------
		이메일U		날짜D(SYSDATE)	이름NN
		비밀번호NN		회원번호FK		가격D(0)
		이름NN		상품번호FK		재고D(0)
		주소NN			
		생일		
		
	4. 물리적 설계
		TBL_MEMBER
		-----------------------------------------------------
		ID: NUMBER PK_MEMBER
		-----------------------------------------------------
		MEMBER_EMAIL: VARCHAR2(1000) UNIQUE
		MEMBER_PASSWORD: VARCHAR2(1000) NOT NULL
		MEMBER_NAME: VARCHAR2(1000) NOT NULL
		MEMBER_ADDRESS: VARCHAR2(1000) NOT NULL
		MEMBER_BIRTH: DATE

	5. 구현
_____________________________________________________________________________________________________
정규화

	삽입/수정/삭제 이상 현상을 제거하기 위한 작업.
	데이터 중복을 최소화하는데에 목적이 있다.
	5차 정규화까지 있으나, 보통 3차 정규화까지만 진행한다. (5차는 너무 과함)

1차 정규화

	같은 내용의 컬럼이 연속적으로 나타날 경우
	
	상품 테이블
		상품명1		상품명2		상품명3
		와이셔츠1		와이셔츠2		와이셔츠3

	회원 테이블
		취미
		축구, 럭비, 골프

	* 위 테이블은 조회 및 추가가 힘들다.

	1차 정규화 진행
	
		상품명
		와이셔츠1
		와이셔츠2
		와이셔츠3

	상품명 테이블
		번호			상품명		상품번호
		1			와이셔츠1		1
		2			와이셔츠2		1
		3			와이셔츠3		1

2차 정규화

	조합키(복합키)로 구성되었을 경우 조합키의 일부분에만 종속되는 속성이 있을 경우(부분 종속).

		꽃
		이름		색상		꽃말		과
		해바라기	노란색	행운		국화
		장미		빨간색	사랑		장미

	* 이름에 대한 부분 종속이 발생한다. 

		꽃
		이름		색상		꽃말
		해바라기	노란색	행운		
		장미		빨간색	사랑		

		과
		이름		과
		해바라기	국화
		장미		장미

3차 정규화

	PK가 아닌 컬럼이 다른 컬럼을 결정하는 경우
	이행 함수 종속 제거

		(회원번호와 우편번호 시를 알수있기 때문에 이행 함수)
		회원번호	이름			시			구			동		우편번호
		1		한동석		경기도		남양주		화도		12345
		2		홍길동		서울시		관악구		봉천		78945

	* 우편번호로 시, 구, 동을 알 수 있다.
	* 중복된 데이터가 생길 가능성이 있다.

		회원번호	이름		우편번호
		1		한동석	12345
		2		홍길동	78945

		우편번호		시		구		동
		12345		경기도	남양주	화도
		78945		서울시	관악구	봉천

데이터베이스에서 정규화가 필요한 이유

	데이터베이스를 잘못 설계하면 불필요한 데이터 중복으로 인해 공간이 낭비된다.
	이런 현상을 이상(Anomaly)현상이라고 한다.

   
	회원번호와 프로젝트코드 두 컬럼의 조합키로 설정되어 있는 테이블이고
	한 사람은 하나의 부서만 가질 수 있다.

		회원번호      	이름   	부서   	프로젝트코드   	급여   	부서별 명수
		22080101   	한동석   	개발팀   	ABC0001      	3000   	4
		22080101   	한동석   	개발팀   	DEF1112      	2000   	4
		22080101   	한동석   	개발팀   	CBA9474     	4000   	4
		22080104   	홍길동   	기획팀   	EFG0881      	5000   	2
		22081106   	이순신   	디자인팀   	GHI9991      	6000   	3

이상현상의 종류

	1. 삽입 이상
		새 데이터를 삽입하기 위해 불필요한 데이터도 삽입해야하는 문제
   
		담당 프로젝트가 정해지지 않은 사원이 있다면,
		프로젝트 코드에 NULL을 작성할 수 없으므로 이 사원은 테이블에 추가될 수 없다.
		따라서 '미정'이라는 프로젝트 코드를 따로 만들어서 삽입해야 한다.

	2. 갱신 이상
		중복 행 중에서 일부만 변경하여 데이터가 불일치하게 되는 모순의 문제

		한 명의 사원은 반드시 하나의 부서에만 속할 수 있다.
		만약 "한동석"이 보안팀으로 부서를 옮길 시 3개 모두 갱신해주지 않는다면
		개발팀인지 보안팀인지 알 수 없다.

	3. 삭제 이상
		행을 삭제하면 꼭 필요한 데이터까지 함께 삭제되는 문제

		"이순신"이 담당한 프로젝트를 박살내서 드랍된다면 "이순신" 행을 모두 삭제하게 된다.
		따라서 프로젝트에서 드랍되면 정보를 모두 드랍하게 된다.

정규화 진행

		회원번호      	프로젝트코드   	급여
		22080101   	ABC0001      	3000
		22080101  		DEF1112      	2000
		22080101   	CBA9474     	4000
		22080104   	EFG0881      	5000
		22081106   	GHI9991      	6000

		회원번호      	이름      	부서
		22080101   	한동석      	개발팀
		22080104   	홍길동      	기획팀
		22081106   	이순신      	디자인팀

		부서			부서별명수
		개발팀		4
		기획팀		2
		디자인팀		3
_____________________________________________________________________________________________________
DML(Data Manipulation Language)

	1. INSERT: 추가
		1) 컬럼명을 생략할 수 있으며, 이 경우 DEFAULT 제약 조건이 발생된다.
		   컬럼을 골라서 데이터를 넣을 때 사용한다.
		INSERT INTO [테이블명]
		([ 컬럼명1, 컬럼명2, ...])
		VALUES([값1, 값2, ...]);

		2) 모든 값을 전부 작성해야 하며, 컬럼명은 직접 작성하지 않는다.
		INSERT INTO [테이블명]
		VALUES([값1, 값2, ...])

	2. SELECT: 조회(검색)
		SELECT [컬럼명1, 컬럼명2, ...]
		FROM [테이블명]
		WHERE [조건식];

		조건식
			>, <			: 초과, 미만
			>=, <= 		: 이상, 이하
			=:, = 			: 같다
			<>, !=, ^=:		: 같지 않다
			AND			: 둘 다 참이여야 참
			OR			: 둘 중 하나라도 참이면 참

	3. UPDATE
		UPDATE [테이블명]
		SET [기존 컬럼명1] = [새로운 값1], [기존 컬럼명2] = [새로운 값2], ...
		WHERE [조건식] 
			
	4. DELETE
		DELETE FROM [테이블명]
		WHERE [조건식]

JOIN

	여러 테이블에 흩어져 있는 정보 중
	사용자가 필요한 정보만 가져와서 가상의 테이블처럼 만들고 결과를 보여주는 것.
	정규화를 통해 조회 테이블이 너무 많이 쪼개져 있으면 작업이 불편하기 때문에
	이를 JOIN으로 해결할 수 있다.

	1. 내부 조인(INNER JOIN)
		조건에 일치하는 값만 합쳐서 조회
		
		- 등가 조인
			ON절의 조건식에 등호가 있는 조인
	
		- 비등가 조인
			ON절의 조건식에 등호가 없는 조인

		SELECT [컬럼명, ...]
		FROM [테이블명] INNER JOIN [테이블명]
		ON 조건식
		INNER JOIN [테이블명]
		ON 조건식
		INNER JOIN [테이블명]
		ON 조건식
		...

	2. 외부 조인(Outer join)
		조건에 일치하지 않아도 지정한 테이블은 전체 정보 조회
		ON절에 작성된 조건식이 false일지라도 해당 위치의 테이블의 모든 정보를
		조회해야 할 때 사용한다.

		- LEFT OUTER JOIN
				선행 테이블의 모든 정보를 가져오고 싶을 때 사용한다.

		- RIGHT OUTER JOIN 
				후행 테이블의 모든 정보를 가져오고 싶을 때 사용한다.

_____________________________________________________________________________________________________
TCL(Transaction Control Language)
	
	DML만 묶을 수 있는 단위이며,
	하나의 작업(서비스)에 필요한 쿼리문을 묶어놓은 하나의 단위이다.

	COMMIT: 모든 작업을 확정하는 명령어
	ROLLBACK: 이전 커밋 시점으로 이동하는 명령어

VIEW

	기존의 테이블은 그대로 놔둔 채 필요한 컬럼들 및 새로운 컬럼을 만든 가상 테이블.
	실제 데이터가 저장되는 것은 아니지만 VIEW를 통해서 충분히 데이터를 관리할 수 있다.

	- 독립성: 다른 곳에서 접근하지 못하도록 하는 성질
	- 편리성: 긴 쿼리문을 짧게 만드는 성질
	- 보안성: 기존의 쿼리문이 보이지 않는다.
	
VIEW 문법

	- 새롭게 생성(ORDER BY 사용시 오류)
	CREATE VIEW [뷰 이름] AS (SELECT 쿼리문);
	
	- 새롭게 생성 혹은 기존 VIEW 수정
	CREATE OR REPLACE VIEW [뷰 이름] AS (SELECT 쿼리문);

