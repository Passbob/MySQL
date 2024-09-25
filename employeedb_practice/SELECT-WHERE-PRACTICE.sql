-- 모든 행 모든 컬럼 조회
-- 1. EMPLOYEE테이블에서 모든 정보를 조회하세요
use employee;

SELECT *
	FROM employee;

-- 원하는 컬럼 조회
-- 2. EMPLOYEE 테이블의 사번, 이름을 조회하세요
SELECT 
	emp_id,
    EMP_NAME
    FROM employee
    WHERE emp_id LIKE '_0_'
    ORDER BY emp_id
    ;

-- 원하는 행 조회
-- 3. EMPLOYEE 테이블에서 부서코드가 D9인 사원을 조회하세요
SELECT
	EMP_NAME
    FROM employee
    WHERE dept_code = 'D9';

-- 원하는 행과 컬럼 조회
-- 4. EMPLOYEE 테이블에서 급여가 300만원 이상인 직원의 사번, 이름, 부서코드, 급여를 조회하세요
SELECT
	emp_no '사번',
    emp_name '이름',
    dept_code '부서코드',
    salary '급여'
    FROM employee
    where salary >= 3000000;

-- 5. 부서코드가 D6이고 급여를 200만원보다 많이 받는 직원의 이름, 부서코드, 급여를 조회하세요
SELECT
	emp_name '이름',
    dept_code '부서코드',
    salary '급여'
    FROM employee
    WHERE dept_code = 'D6' AND salary >= 2000000;
    
-- NULL값 조회
-- 6. 보너스를 지급받지 않는 직원의 사번, 이름, 급여, 보너스를 조회하세요
SELECT
	emp_no '사번',
    emp_name '이름',
    salary '급여',
    bonus '보너스'
    FROM employee
    WHERE bonus IS NULL;

-- 7. EMPLOYEE테이블에서 급여를 350만원 이상, 550만원 이하를 받는 직원의 사번, 이름, 급여, 부서코드, 직급코드를 조회하세요
SELECT
	emp_no '사번',
    emp_name '이름',
    salary '급여',
    dept_code '부서코드',
    job_code '직급코드'
    FROM employee
    WHERE 5500000>= salary AND salary >= 3500000;

-- 8. EMPLOYEE테이블에서 성이 김씨인 직원의 사번, 이름, 입사일을 조회하세요
SELECT
	emp_no '사번',
    emp_name '이름',
    hire_date '입사일'
    FROM employee
    WHERE emp_name LIKE '이%';
-- 9. EMPLOYEE 테이블에서 '하'가 이름에 포함된 직원의 이름, 주민번호, 부서코드를 조회하세요
SELECT
	emp_name '이름',
    emp_no '주민번호',
    dept_code '부서코드'
    FROM employee
    WHERE emp_name like '%하%';
    
-- 10. EMPLOYEE테이블에서 전화번호 국번이 9로 시작하는 직원의 사번, 이름, 전화번호를 조회하세요
-- HINT!! 와일드 카드 사용 : _(글자 한자리), %(0개 이상의 글자)
SELECT
	emp_no '사번',
    emp_name '이름',
    phone '전화번호'
    FROM employee
    WHERE phone LIKE '___9%';
-- 11. EMPLOYEE테이블에서 전화번호 국번이 4자리 이면서 9로 시작하는 직원의 사번, 이름, 전화번호를 조회하세요
SELECT
	emp_no '사번',
    emp_name '이름',
    phone '전화번호'
    FROM employee
    WHERE phone LIKE '___9_______';
-- 12. 부서코드가 'D6' 이거나 'D8'인 직원의 이름, 부서, 급여를 조회하세요
-- HINT!! IN 연산자 : 비교하려는 값 목록에 일치하는 값이 있는지 확인
SELECT
	emp_name '이름',
    dept_Title '부서',
    salary '급여'
    FROM employee
    JOIN department ON dept_code = dept_id
    WHERE dept_code IN('D6','D8');
 
-- 13. 이씨성이 아닌 직원의 사번, 이름, 이메일주소를 조회하세요
SELECT
	emp_no '사번',
    emp_name '이름',
    email '이메일'
    FROM employee
    WHERE emp_name NOT LIKE '이%';
-- 14. J2직급의 급여 200만원 이상 받는 직원이거나 J7 직급인 직원의 이름, 급여, 직급코드를 조회하세요
SELECT
	emp_name '이름',
    salary '급여',
    job_code '직급코드'
    FROM employee
    WHERE job_code = 'J2' AND salary >= 2000000 OR job_code = 'J7';

-- 15. J7 직급이거나 J2 직급인 직원들 중 급여가 200만원 이상인 직원의 이름, 급여, 직급코드를 조회하세요
SELECT
	emp_name '이름',
    salary '급여',
    job_code '직급코드'
    FROM employee
    WHERE job_code = 'J2' OR job_code = 'J7' AND salary >= 2000000;
    