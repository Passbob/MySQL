-- JOIN을 이용하여 여러 테이블을 조회 시에는 모든 컬럼에 테이블 별칭을 사용하는 것이 좋다.
USE employee;

SELECT *
	FROM employee
    WHERE job_code = 'J6';

--  1. 직급이 대리이면서 아시아 지역에 근무하는 직원의 사번, 이름, 직급명, 부서명, 지역명, 급여를 조회하세요
SELECT
	A.emp_id,
    A.emp_name,
    B.job_name,
    C.dept_title,
    D.local_name,
    A.salary
	FROM employee A
    JOIN job B USING (job_code)
    JOIN department C ON C.dept_id = A.dept_code
    JOIN location D ON D.local_code = C.location_ID
    WHERE job_code = 'J6' AND location_id IN('L1', 'L2', 'L3');
-- 2. 주민번호가 70년대 생이면서 성별이 여자이고, 성이 전씨인 직원의 이름, 주민등록번호, 부서명, 직급명을 조회하세요.
	SELECT
		A.emp_name,
        A.emp_no,
        B.dept_title,
        C.job_name
        FROM employee A
        JOIN department B ON B.dept_id = A.dept_code
		JOIN job C  USING (job_code)
		where emp_no like '7%' and emp_no like '%-2%' and emp_name like '전%';
-- 3. 이름에 '형'자가 들어가는 직원의 사번, 이름, 직급명을 조회하세요.
SELECT
	A.emp_id,
    A.emp_name,
    B.job_name
    FROM employee A
	JOIN job B  USING (job_code)
    WHERE emp_name LIKE '%형%';
-- 4. 해외영업팀에 근무하는 직원의 이름, 직급명, 부서코드, 부서명을 조회하세요.
SELECT
	A.emp_name,
    B.job_name,
    C.dept_id,
    C.dept_title
    FROM employee A
    JOIN job B  USING (job_code)
    JOIN department C ON C.dept_id = A.dept_code
    WHERE location_id IN('L2', 'L3', 'L4');
-- 5. 보너스포인트를 받는 직원의 이름, 보너스, 부서명, 지역명을 조회하세요.
SELECT
	A.emp_name,
    A.bonus,
    B.dept_title,
    C.local_name
    FROM employee A
    JOIN department B ON B.dept_id = A.dept_code
    JOIN location C ON C.local_code = B.location_ID
    WHERE A.bonus IS NOT NULL;
-- 6. 부서코드가 D2인 직원의 이름, 직급명, 부서명, 지역명을 조회하세오.
SELECT
	A.emp_name,
    D.job_name,
    B.dept_title,
    C.local_name
    FROM employee A
    JOIN job D  USING (job_code)
    JOIN department B ON B.dept_id = A.dept_code
    JOIN location C ON C.local_code = B.location_ID
    WHERE dept_code = 'D2';
-- 7. 한국(KO)과 일본(JP)에 근무하는 직원의 이름, 부서명, 지역명, 국가명을 조회하세요.
SELECT
	A.emp_name,
    B.dept_title,
    C.local_name,
    D.national_name
    FROM employee A
    JOIN department B ON B.dept_id = A.dept_code
    JOIN location C ON C.local_code = B.location_ID
	JOIN nation D  USING (national_code)
    WHERE national_code IN('KO','JP');