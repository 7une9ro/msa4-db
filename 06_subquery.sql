-- SubQuery

-- 1. WHERE 절에서 사용

-- (1). 단일 ** 행 ** 서브쿼리
-- 서브쿼리가 단일 행 비교 연산자와 함께 사용할 때는
-- 반드시 서브쿼리의 결과수가 1건 이하여야 함

-- Q. D001(dept_code) 부서장의 
-- 사번(emp_id)과 이름(name)을 출력
SELECT e.emp_id, e.`name` FROM employees AS e
WHERE emp_id = (
  SELECT dm.emp_id FROM department_managers AS dm
  WHERE dm.dept_code = 'D001'
  AND dm.end_at IS NULL
);


-- (2). ** 다중 ** 행 서브쿼리
-- 서브쿼리가 2건 이상 반환할 경우
-- 반드시 다중 행 비교 연산자를 사용해야 한다.
  -- (IN, ALL, ANY, SOME, EXISTS 등)

-- Q. 현재 부서장인 사원의 사번과 이름을 출력

SELECT e.emp_id, e.name FROM employees e
WHERE e.emp_id IN (
  SELECT dm.emp_id FROM department_managers dm
  WHERE dm.end_at IS NULL
);



-- (3). 다중 ** 컬럼 ** 서브쿼리
-- 현재 D002의 부서장이 해당 부서에 소속된 날짜를 출력

SELECT de.start_at FROM department_emps de
WHERE (de.emp_id, de.dept_code) IN (
  SELECT dm.emp_id, dm.dept_code FROM department_managers dm 
  WHERE dm.dept_code = 'D002' AND dm.end_at IS NULL
);



-- (4). 연관 서브쿼리
-- 서브쿼리 내에서 메인쿼리의 컬럼이 사용된 서브쿼리

-- Q. 부서장직을 지냈던 경력이 있는 사원의 정보를 출력

SELECT * FROM employees e
WHERE e.emp_id IN (
  SELECT dm.emp_id FROM department_managers dm
  WHERE dm.emp_id = e.emp_id
);


-- 2. SELECT 절에서 사용

-- Q. 사원별 역대 전체 급여 평균
SELECT emp.emp_id,
  ( SELECT AVG(sal.salary) FROM salaries sal
      WHERE sal.emp_id = emp.emp_id
  ) avg_sal
FROM employees emp;



-- 3. FROM 절에서 사용
-
SELECT tmp.* FROM (
  SELECT emp.emp_id, emp.`name` FROM employees emp
) tmp;



-- 4. INSERT 문에서 사용

INSERT INTO title_emps (
   emp_id,
   title_code,
   start_at
) VALUES (
  (SELECT MAX(emp_id) FROM employees),
  'T001',
  DATE(NOW())
);


-- 5. UPDATE 문에서 사용
UPDATE title_emps 
SET
  title_emps.end_at = (
    SELECT employees.fire_at FROM employees
    WHERE employees.emp_id = 100000
  )
-- SELECT * FROM title_emps
WHERE 
  title_emps.emp_id = 100000 AND
  title_emps.end_at IS NULL;

SELECT * FROM