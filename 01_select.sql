-- 1. SELECT 문:
	-- DML 중 하나로, 저장되어 있는 데이터를
	-- 조회하기 위해 사용하는 쿼리

-- 조회한 데이터 중 특정 컬럼만 출력
-- 백틱 (``) 기호로 감싸면, 컬럼으로써 인식 됨

SELECT 
  emp_id
  ,`name`
  ,gender
FROM employees;


-- 1-(1). 테이블의 전체 컬럼 조회: Asterisk (*) 기호를 사용
SELECT *
FROM employees;


-- 2. WHERE 절: 특정 컬럼의 값이 일치한 데이터만 조회
select *
from employees
where emp_id = 10009;

select *
from employees
where `name` = '박은지';

select birth, `name`, emp_id
from employees
where birth >= '1990-01-01';

select *
from employees
where fire_at IS NOT null;


-- 출생년도가 1990년인 사원을 조회
SELECT *
FROM employees
WHERE
      birth >= '1990-01-01'
  AND birth <= '1990-12-31';



-- 이름이 '김철수' 또는 '정유리'인 사원을 조회
SELECT *
FROM employees
WHERE 
    `name` = '김철수'
  OR `name` = '정유리';



-- 1990년 출생이거나, 이름이 '정유리'인 사원을 조회
SELECT * FROM employees
WHERE 
  (birth >= '1990-01-01' AND birth <= '1990-12-31')
  OR `name` = '정유리';



-- BETWEEN 연산자: 지정한 범위 내에 데이터를 조회
    -- AND 연산자 보다는 속도가 약간 느릴 수 있음. 
    -- (버전마다 성능 속도가 약간 상이할 수 있음)
SELECT * FROM employees 
WHERE 
  birth BETWEEN '1990-01-01' AND '1990-12-31';


SELECT * FROM employees 
WHERE 
  birth BETWEEN '1990-01-01' AND '1990-12-31'
  AND `name` = '정유리';


-- 사원번호가 10005, 10010인 사원을 조회
SELECT * FROM employees
WHERE emp_id = 10005 OR emp_id = 10010;


-- IN 연산자: 다수의 지정한 값과 일치하는 데이터 조회
SELECT * FROM employees
WHERE emp_id IN (10005, 10010);


-- LIKE 절: 문자열의 내용을 조회
  -- 잘못 사용하면 성능 저하가 매우 낮아질 수 있음.

-- LIKE `%`: 글자 수와 상관없이 조회할 경우에 사용.
-- '우'로 **끝나는** 이름들만 조회
SELECT * FROM employees
WHERE `name` LIKE '%우';


-- '우'가 **포함된** 이름들만 조회
SELECT * FROM employees
WHERE `name` LIKE '%우%';


-- '우'로 **시작하는** 이름들만 조회
SELECT * FROM employees
WHERE `name` LIKE '우%';


-- LIKE `_`: 언더 바의 개수만큼 글자 수를 허용

-- 이름이 네글자인데 세 번째 문자가 '우'인 이름만 조회
SELECT * FROM employees
WHERE `name` LIKE '__우_';



-- ORDER BY 절: 데이터를 정렬

-- 이름이 '우'로 끝나는 데이터를 
-- 이름 컬럼을 기준으로 오름차순 정렬해서 조회
SELECT * FROM employees
WHERE `name` LIKE '%우'
ORDER BY `name` DESC;


SELECT * FROM employees
ORDER BY `name` DESC, birth;


-- LIMIT 키워드, OFFSET 키워드
-- 출력 개수를 제한


-- 사번을 오름차순으로 정렬하고 상위 10명 조회
SELECT * FROM employees
ORDER BY emp_id
LIMIT 10;


-- 사번을 오름차순으로 정렬하고 21번째부터 10개를 조회
SELECT * FROM employees
ORDER BY emp_id
LIMIT 10 OFFSET 20;


-- LIMIT (1), (2) == `LIMIT (2) OFFSET (1)`
SELECT * FROM employees
ORDER BY emp_id
LIMIT 20, 10;


-- 집계함수
-- SUM(컬럼): 해당 컬럼의 합계를 출력
-- MAX(컬럼): 해당 컬럼의 값 중 최대값을 출력
-- MIN(컬럼): 해당 컬럼의 값 중 최소값을 출력
-- AVG(컬럼): 해당 컬럼의 평균을 출력
SELECT SUM(salary) AS sum_sal
      ,MAX(salary) AS max_sal
      ,MIN(salary) AS min_sal
      ,AVG(salary) AS avg_sal
FROM salaries
WHERE end_at IS NULL;


-- COUNT(컬럼 또는 *): 검색 결과의 레코드 수를 출력
SELECT count(*) FROM employees;

SELECT count(fire_at) FROM employees;



-- 현재 받고 있는 급여 중, 
-- 가장 많이 받는 급여와 가장 적게 받는 급여를 조회
SELECT MAX(salary) 
     , MIN(salary) 
FROM salaries
WHERE end_at IS NULL;


-- DISTINCT 키워드: 검색결과에서 중복되는 레코드 없이 조회
    -- 조회 속도가 느리기 때문에
    -- 되도록이면 DISTINCT를 사용하지 않고 
    -- 중복없이 레코드를 조회하는 방향으로
SELECT DISTINCT emp_id FROM salaries;



-- 그룹으로 묶어서 조회
-- 직책별 사원 수

  -- SELECT 절에 조회할 컬럼은
  -- GROUP BY 절에서 사용한 컬럼과
  -- 집계함수만 작성 (표준 문법)
SELECT title_code,
      COUNT(*) AS cnt
FROM title_emps
WHERE end_at IS NULL
GROUP BY title_code;


-- 직책 코드에 `02`가 포함된 직책별 사원 수
SELECT 
    title_code
    , COUNT(*)
FROM title_emps
WHERE end_at IS NULL
GROUP BY title_code
HAVING title_code LIKE '%02%';



-- 직책별 사원 수 중, 
-- 10000명 이상인 직책의 사원수를 조회
SELECT 
  title_code
  , COUNT(*) cnt
FROM title_emps
WHERE end_at IS NULL
GROUP BY title_code
HAVING cnt >= 10000;