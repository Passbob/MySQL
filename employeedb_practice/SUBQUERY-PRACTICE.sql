-- 1. 부서코드가 노옹철 사원과 같은 소속의 직원 명단 조회하세요.alter
use employee;

SELECT *
 FROM employee
 where dept_code = (select 
						dept_code
                        FROM employee
                        WHERE emp_name = '노옹철');
-- 2. 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여를 조회하세요.
SELECT
	emp_id,
    emp_name,
    job_code,
    salary
    FROM employee
    where salary > (select
						AVG(salary)
                        FROM employee);
-- 3. 노옹철 사원의 급여보다 많이 받는 직원의 사번, 이름, 부서코드, 직급코드, 급여를 조회하세요.
SELECT
	emp_id,
    emp_name,
    DEPT_CODE,
    job_code,
    salary
    FROM employee
	WHERE salary > (select
						salary
                        from employee
                        where emp_name = '노옹철');

-- 4. 가장 적은 급여를 받는 직원의 사번, 이름, 부서코드, 직급코드, 급여, 입사일을 조회하세요.
SELECT
	emp_id,
    emp_name,
    DEPT_CODE,
    job_code,
    salary,
    hire_date
    FROM employee
    order by salary
    limit 1;
    
SELECT
	emp_id,
    emp_name,
    DEPT_CODE,
    job_code,
    salary,
    hire_date
    FROM employee
    where salary = (select
					MIN(SALARY)
                    from employee);
	

-- 5. 부서별 최고 급여를 받는 직원의 이름, 직급코드, 부서코드, 급여 조회하세요.
SELECT
	A.emp_name,
    A.job_code,
	A.dept_code,
    A.salary
    FROM employee A
    WHERE A.salary = (SELECT
					MAX(salary)
                    FROM employee
                    WHERE DEPT_CODE = A.DEPT_CODE or (DEPT_CODE IS NULL AND A.DEPT_CODE IS NULL));
                    


-- *** 여기서부터 난이도 극상

-- 6. 관리자에 해당하는 직원에 대한 정보와 관리자가 아닌 직원의 정보를 추출하여 조회하세요.
-- 사번, 이름, 부서명, 직급, '관리자' AS 구분 / '직원' AS 구분
-- HINT!! is not null, union(혹은 then, else), distinct
SELECT 
	A.emp_id, 
    A.emp_name,
	B.dept_title,
    C.job_name,
    '관리자' AS 구분
    FROM employee A
    left JOIN department B ON  B.dept_id = A.dept_code
    JOIN job C USING(job_code)
	WHERE A.emp_id IN(SELECT 
			distinct MANAGER_ID
                   from employee
                  where manager_id IS NOT NULL)
	

UNION

SELECT
	A.emp_id,
    A.emp_name,
 	B.DEPT_TITLE,
    C.job_name,
    '직원' AS 구분
    FROM employee A
	left JOIN department B ON B.dept_id = DEPT_CODE
    JOIN job C USING(job_code)
    WHERE A.emp_id NOT IN(SELECT 
			distinct MANAGER_ID
                   from employee
                  where manager_id IS NOT NULL)
	order by 구분, emp_id;
    
SELECT
IFNULL(DEPT_CODE,null)
FROM employee;

SELECT *
FROM employee
where dept_code IS NULL;



-- 7. 자기 직급의 평균 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여를 조회하세요.
-- 단, 급여와 급여 평균은 만원단위로 계산하세요.
-- HINT!! round(컬럼명, -5)
	SELECT
    emp_id,
    emp_name,
    job_code,
    round(salary,-5)
    FROM employee
    WHERE salary IN(select
						AVG(salary) 
                        from employee 
                        WHERE salary=round(salary,-5) 
                        group by job_code);
    
    


-- 8. 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 직원의 이름, 직급코드, 부서코드, 입사일을 조회하세요.
SELECT
	emp_name,
    job_code,
    dept_code,
    hire_date
    FROM employee
    WHERE dept_code = (select
						dept_code
                        from employee
                        where ENT_DATE IS NOT NULL AND emp_no LIKE '%-2%')
		  AND
		  job_code = (select
						job_code
                        from employee
                        where ENT_DATE IS NOT NULL AND emp_no LIKE '%-2%')
AND ent_date IS NULL;
    

-- 9. 급여 평균 3위 안에 드는 부서의 부서 코드와 부서명, 평균급여를 조회하세요.
-- HINT!! limit
SELECT
	DEPT_CODE,
    B.DEPT_TITLE,
    AVG(salary) '평균급여'
    FROM employee
    left JOIN department B ON B.dept_id = DEPT_CODE
    GROUP BY dept_code
    ORDER BY AVG(salary) desc
    limit 3;
-- 서브쿼리를 어디다가 써야하냐

-- 10. 부서별 급여 합계가 전체 급여의 총 합의 20%보다 많은 부서의 부서명과, 부서별 급여 합계를 조회하세요.
SELECT
    B.DEPT_TITLE,
    SUM(salary)
    FROM employee
    left JOIN department B ON B.dept_id = DEPT_CODE
    GROUP BY dept_code
    HAVING SUM(salary) > (SELECT
 							SUM(salary)
 							FROM employee)/5;
    
