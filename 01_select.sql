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
