-- UPDATE 문
  -- DML 중 하나로 저장되어 있는 기존 데이터를 
  -- ** 수정 **하기 위해 사용하는 쿼리

  -- UPDATE 문 사용시 주의사항 및 TIP
    -- SET 절을 비워두고 WHERE 절을 먼저 작성하면 
    -- 의도치 않은 데이터 수정(Human error)을 예방할 수 있음

UPDATE 테이블명
SET
  컬럼1 = 값1,
  컬럼2 = 값2,
  [...]
[WHERE 조건];


UPDATE employees 
SET `name` = '둘리'
WHERE emp_id = 100007;

SELECT * FROM employees
ORDER BY emp_id DESC
LIMIT 10;


-- 100007번 사원의 생일을  
-- '2020-01-01', 이름을 '마이콜'로 수정
UPDATE employees
SET 
  birth = '2020-01-01',
  `name` = '마이콜'
WHERE emp_id = 100007;


