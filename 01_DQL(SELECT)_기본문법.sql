-- 한줄 주석
/*
 *  여러 줄 주석
 * 
 * SQL문을 이용해서 저장되어있는 데이터를 조회해보자
 * 
 * < SELECT >
 * 데이터를 조회하거나 검색할 때 사용하는 명령어
 * 
 * SELECT
 * 		조회하고자 하는 컬럼
 * 	FROM
 * 		테이블명;
 */

SELECT * FROM PATIENT p; --성능에 영향을 끼치므로 실무에서는 사용할 수 없음
--항상 필요한 컬럼만 명시해서 조회

SELECT patient_name FROM PATIENT p;

SELECT 
	   DEPT_ID
	 , DEPT_NAME
  FROM
  	   DEPT;

SELECT 
	   WARD_NAME  
 FROM 
	   WARD;

SELECT
	   DOCTOR_NAME
	 , HIRE_DATE
 FROM 
 	  DOCTOR d;

SELECT 
	   PATIENT_NAME
	 , GENDER
 FROM
 	  PATIENT;

SELECT 
	   BIRTH_DATE
	 , PATIENT_NAME
  FROM 
	   PATIENT p;


		

SELECT
	   PATIENT_NAME
	 , HEIGHT_CM
	 , HEIGHT_CM / 100
  FROM
       PATIENT;


SELECT 
	   PATIENT_NAME
	 , WEIGHT_KG
	 , WEIGHT_KG / ((HEIGHT_CM / 100) * (HEIGHT_CM  / 100))
  FROM 
       PATIENT;

--산술연산 과정에서 NULL값이 존재하면 결과도 NULL
SELECT 
	   PATIENT_NAME
	 , ADMISSION_DATE
	 , DISCHARGE_DATE
	 , DISCHARGE_DATE - ADMISSION_DATE
  FROM 
  	   PATIENT;

---오늘날짜 - 입원일
SELECT 
	   PATIENT_NAME
	 , ADMISSION_DATE
	 , ROUND(SYSDATE) - ADMISSION_DATE
  FROM 
  	   PATIENT;

--------------------------------------------
--ResultSet : SELECT문을 통해 조회된 데이터 결과물(행들의 집합)

--<리터럴>
--오라클에서 문자열을 다룰 땐 ''을 사용
--문자열을 SELECT절에 기술해서 ResultSet에 조회할 수 있음


-- 컬럼명에 별칭 부여하기
-- 컬럼명 별칭, 컬럼명 AS 별칭, 컬럼명 "벌칭", 컬럼명 AS "벌칭"

SELECT 
	   HEIGHT_CM AS "키(CM)"
	 , 'cm'
  FROM 
  	   PATIENT;

----------------------

SELECT 
	   DISTINCT BLOOD_TYPE
  FROM 
  	   PATIENT;




------------------------
/*
 * < WHERE 절 >
 * 조건을 제시해서 조건에 만족하는 행만 조회
 * 
 * < 비교연산자 >
 * 동등비교 : =, !=
 * 대소비교 : <, >, <=, >=
 * 
 */

SELECT 
	   PATIENT_NAME
	 , WEIGHT_KG
  FROM 
  	   PATIENT
 WHERE
 	   WEIGHT_KG >= 80;

SELECT 
	   PATIENT_NAME
	 , GENDER
  FROM
  	   PATIENT
 WHERE
 	   GENDER != 'F';

--순서 FROM -> WHERE -> SELECT

-----------------------------

/*
 * < 논리 연산자 >
 * AND / OR
 * 
 */

SELECT 
	   PATIENT_NAME
	 , WARD_ID
	 , HEIGHT_CM
  FROM 
  	   PATIENT
 WHERE
 	   WARD_ID = 'W3' 
   AND
	   HEIGHT_CM >= 170;

SELECT 
	   PATIENT_NAME
	 , HEIGHT_CM
  FROM 
  	   PATIENT
 WHERE 
 	   HEIGHT_CM >= 160
   AND 
   	   HEIGHT_CM <= 170;

SELECT 
	   PATIENT_NAME
	 , HEIGHT_CM
  FROM 
  	   PATIENT
 WHERE 
 	   HEIGHT_CM BETWEEN 160 AND 170;

SELECT 
	   PATIENT_NAME
	 , BIRTH_DATE
  FROM 
  	   PATIENT
 WHERE 
	   BIRTH_DATE BETWEEN TO_DATE('1990-01-01', 'YYYY-MM-DD') 
					  AND TO_DATE('1999-01-01', 'YYYY-MM-DD');


-------------------------------------------
/*
 * < LIKE > 
 * 컬럼의 값이 지정한 특정 패턴에 만족할 경우 조회
 * 
 * '%' : 0글자 이상
 * LIKE '김%' : 김으로 시작하는 모든 글자
 * LIKE '%김', LIKE '%김%'
 * 
 * '_' : 1글자
 * LIEK '__" : 2글자 
 */

SELECT 
	   PATIENT_NAME
	 , DIAGNOSIS
  FROM 
  	   PATIENT
 WHERE 
	   DIAGNOSIS LIKE '%급성%';

SELECT 
	   DOCTOR_NAME
  FROM 
  	   DOCTOR
 WHERE
 	   DOCTOR_NAME LIKE '__';

-----------------------------------------------
/*
 * < IS NULL >
 */
SELECT 
	   PATIENT_NAME
	 , DISCHARGE_DATE 
  FROM 
  	   PATIENT
 WHERE 
	   --DISCHARGE_DATE IS NULL;
 	   DISCHARGE_DATE IS NOT NULL;

-------------------------------------------------------

SELECT 
	   PATIENT_NAME || '의 담당의 코드는 ' || DOCTOR_ID || '입니다.'
  FROM 
  	   PATIENT;

-----------------------------------------------------

SELECT 
	   PATIENT_NAME 
	 , BLOOD_TYPE 
  FROM 
  	   PATIENT
 WHERE
	   BLOOD_TYPE NOT IN ('A', 'B', 'O')
ORDER BY 
	   BLOOD_TYPE;

-----------------------------------------------------

SELECT 
	   PATIENT_NAME
	 , WARD_ID 
	 , GENDER 
	 , WEIGHT_KG 
  FROM 
  	   PATIENT
 WHERE 
	   WARD_ID = 'W3'
	AND 
	   GENDER = 'F'
	OR 
	   WEIGHT_KG >= 80;

/*
 * 연산자 우선순위
 * 1. ()
 * 2. 산술연산자
 * 3. 연결연산자
 * 4. 비교연산자
 * 5. IS NULL, LIKE, IN, BETWEEN AND
 * 6. NOT
 * 7. AND
 * 8. OR
 * -> 아리까리하면 무조건 괄호를 치는것이 정답
 * -> AND가 OR보다 먼저 묶인다!!!는 것은 꼭 기역
 */

---------------------------------------------------------

SELECT 
	   PATIENT_NAME 
	 , HEIGHT_CM 
  FROM 
  	   PATIENT
ORDER 
   BY 
	   HEIGHT_CM DESC;

SELECT 
	   PATIENT_NAME
	 , DISCHARGE_DATE 
   FROM 
   	   PATIENT
 ORDER 
    BY 
       DISCHARGE_DATE DESC NULLS LAST;
--ORACLE에서는 NULL을 가장 큰 값으로 취급하기 때문에 NULLS FIRST / LAST를 사용해야함

SELECT 
	   PATIENT_NAME 
	 , HEIGHT_CM / 100 키
  FROM 
  	   PATIENT
ORDER 
   BY 
	   키 DESC;


-----------------------------------------------

SELECT
	   PATIENT_NAME
	 , WARD_ID
  FROM 
  	   PATIENT
 ORDER 
    BY 
	   WARD_ID
	 , PATIENT_NAME;
















