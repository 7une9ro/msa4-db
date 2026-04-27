-- 내장 함수

-- 데이터 타입 변환 함수 (아래 두 방식은 동일함 취향차이)
SELECT CAST(123 AS CHAR(4));

SELECT CONVERT(1234, CHAR(4));


-- 제어 흐름 함수
SELECT 
  `name`
  , gender
  -- MySQL만 제공하는 함수
  -- 조건식, 참값, 거짓값
  , IF(gender = 'M', '남자', '여자') AS 성별
FROM employees;


-- IFNULL(수식1, 수식2)
  -- 수식1이 NULL이면 수식2를 반환,
  -- 아니면 수식1을 반환
SELECT IFNULL(fire_at, '재직중')
FROM employees;


-- NULLIF(수식1, 수식2)
  -- 수식1과 수식2를 비교해서
    -- 같으면 NULL을 반환
    -- 다르면 수식1을 반환
SELECT gender, NULLIF(gender, 'M') AS 여자
FROM employees;


-- 다중 분기 문법
  -- CASE (컬럼)
  --   WHEN  THEN  
  --   ELSE  
  -- END

SELECT emp_id, `name`
  , CASE gender
    WHEN 'M' THEN '남자'
    WHEN 'F' THEN '여자'
    ELSE '선택안함' 
  END AS 성별
FROM employees;


-- 문자열 함수

-- 문자열 연결
SELECT CONCAT('안녕', ' ', '하세요');
SELECT CONCAT(CAST(emp_id AS CHAR), name) FROM employees;


-- 구분자로 문자열 연결
SELECT CONCAT_WS(', ', '안녕', '하세요');
SELECT CONCAT_WS(', ', CAST(emp_id AS CHAR), name) FROM employees;


-- 숫자에 자릿수(,) 및 소수점 자리수 표시
-- 결과값이 ** 문자열 **로 변환되서 출력됨
SELECT FORMAT(salary, 0) FROM salaries;


-- 문자열의 왼쪽부터 길이만큼 잘라 반환
SELECT LEFT('123456', 2);
SELECT RIGHT('123456', 2);
SELECT LEFT(name, 1) AS 성 FROM employees;


-- 영어를 대/소문자로 변경
SELECT UPPER('asDFDs'), LOWER('asDFDs');


-- 문자열의 좌/우에 문자열 길이만큼 채울 문자열을 삽입
-- 숫자여도 최종적으로는 ** 문자열 **로 반한됨
SELECT LPAD(emp_id, 10, '0') FROM employees;
SELECT RPAD(emp_id, 10, '0') FROM employees;


-- 좌/우 공백 제거 (단, 문자 사이의 공백은 제거 안됨)
SELECT LTRIM('    문  자   열  ');
SELECT RTRIM('    문  자   열  ');
SELECT TRIM('    문  자   열  ');

SELECT TRIM(LEADING 'ab' FROM 'abcdab');
SELECT TRIM(TRAILING 'ab' FROM 'abcdab');
SELECT TRIM(BOTH 'ab' FROM 'abcdab');


-- 문자열을 시작 위치에서 지정한 길이만큼 잘라서 반환
SELECT SUBSTRING('abcdef', 3, 2);


-- 왼쪽부터 구분자가 횟수번째 만큼 나오면 그 이후는 버림
SELECT SUBSTRING_INDEX('index.html', '.', 1);
SELECT SUBSTRING_INDEX('index.html', '.', -1) AS Filetype;



-- 날짜 및 시간 관련 함수
-- NOW(): 현재 날짜/시간 반환 (YYYY-MM-DD hh:mi:ss)
SELECT NOW();


-- DATE: 타입의 값을 `YYYY-MM-DD` 양식으로 변환
SELECT DATE(NOW());


-- 날짜1에 단위 기간에 따라 더한 날짜/시간을 반환
SELECT ADDDATE(NOW(), INTERVAL 1 YEAR);
SELECT ADDDATE(NOW(), INTERVAL -1 YEAR);

SELECT ADDDATE(NOW(), INTERVAL 1 MONTH);
SELECT ADDDATE(NOW(), INTERVAL 1 DAY);
SELECT ADDDATE(NOW(), INTERVAL 1 HOUR);
SELECT ADDDATE(NOW(), INTERVAL 1 MINUTE);
SELECT ADDDATE(NOW(), INTERVAL 1 SECOND);
SELECT ADDDATE(NOW(), INTERVAL 1 MICROSECOND);



-- 순위 함수

-- RANK() OVER(ORDER BY 컬럼 DESC/ASC)
  -- 지정한 컬럼을 기준으로 순위를 매겨 반환함
  -- 동일한 값이 있는 경우 동일한 순위를 부여함

SELECT RANK() OVER(ORDER BY salary DESC) AS `rank`,
    salary, emp_id
 FROM salaries
WHERE end_at IS NULL
ORDER BY salary DESC LIMIT 10;



-- 레코드에 순위를 매겨 반환
-- 동일한 값이 있는 경우에도 ** 각 행 **에 고유한 번호를 부여

SELECT ROW_NUMBER() OVER(ORDER BY salary DESC) AS `rank`,
  salary, emp_id 
  FROM salaries
WHERE end_at IS NULL
ORDER BY salary DESC LIMIT 10;