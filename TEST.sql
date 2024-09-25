DROP DATABASE IF EXISTS testdb;
CREATE DATABASE IF NOT EXISTS testdb;

USE testdb;

DROP TABLE IF EXISTS test1;
CREATE TABLE IF NOT EXISTS test1(
	user_no INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(255) CHECK(phone like '%-%') NOT NULL,
    email VARCHAR(255) CHECK(email like '%.com%'),
    height INT
)ENGINE=INNODB;
INSERT INTO test1(user_id, user_pwd, user_name, phone, email, height) VALUES
('user01', 'user01', '홍길동', '010-1111-1111', 'hong@gmail.com', '170'),
('user02', 'user02', '아이유', '010-2222-2222', 'IU@gmail.com', '160'),
('user03', 'user03', '정몽규', '010-3333-3333', 'mongu@gmail.com', '168'),
('user04', 'user04', '서장훈', '010-4444-4444', 'sujang@gmail.com', '201'),
('user05', 'user05', '김장훈', '010-5555-5555', 'kimjang@gmail.com', '172'),
('user06', 'user06', '펭수', '010-5555-5555', 'pang@gmail.com', null);

SELECT * FROM test1;

DROP TABLE IF EXISTS testbuy;
CREATE TABLE IF NOT EXISTS testbuy(
	user_code VARCHAR(20),
    user_category_num INT NOT NULL,
	user_name VARCHAR(255),
    buy_product VARCHAR(255),
    buy_price int,
    FOREIGN KEY(user_name)
    REFERENCES test1(user_name)
)ENGINE=INNODB;

INSERT INTO testbuy VALUES
('의적', 1, '홍길동', '갓', 10000),
('가수', 2, '아이유', '마이크', 70000),
('축구협회장', 3, '정몽규', '축구공', 25000),
('전농구선수', 3, '서장훈', '농구공', 25000),
('가수', 2, '김장훈', '교촌치킨', 30000),
('펭귄', 4, '펭수', null, null);

SELECT * FROM testbuy;



-- 1. 유저 카테고리의 오름차순으로 정렬해서 출력 
SELECT * 
	FROM testbuy
    ORDER BY user_category_num;
    
-- 2. 유저 카테고리의 내림차순으로 정렬해서 출력
SELECT * 
	FROM testbuy
    ORDER BY user_category_num desc;
-- 3. 10000원 이상 구매한 유저 가격 순으로 오름차순 정렬
SELECT *
	FROM testbuy
    WHERE buy_price >= 10000
    ORDER BY buy_price;
-- 4. 장훈이라는 이름을 가진 유저 출력
SELECT *
	FROM testbuy
    WHERE user_name LIKE '%장훈';
-- 5. 아무것도 구매하지 않은 사람 출력
SELECT *
	FROM testbuy
    WHERE buy_product IS NULL;
-- 6. 가장 돈을 많이 쓴 사람의 이름, 직업(유저코드), 구매품목을 출력하시오. 
SELECT *
	FROM testbuy
    ORDER BY buy_price desc
    LIMIT 1;
-- 7. 펭수의 키를 140으로 넣으시오
UPDATE test1
	SET height = 140
    WHERE user_name = '펭수';
    
-- 8. 키가 170이상이고 3만원 이상 사용한 사람의 이름, 직업, 구매품목, 키를 구하시오.
SELECT
	A.user_name '이름',
    A.user_code '직업',
    A.buy_product '구매품목',
    B.height '키'
    FROM testbuy A
	JOIN test1 B ON A.user_name = B.user_name
    WHERE buy_price >= 30000 AND B.height >= 170;

-- 9. 170이하인 사람이 몇명인지 구하시오
SELECT
	count(*) '170이하'
    FROM test1
    WHERE height <= 170;

-- 10. 카테고리 번호 순으로 구매가격 총합을 구하시오.
SELECT
	user_category_num '카테고리번호',
	SUM(buy_price) 
    FROM testbuy
    GROUP BY user_category_num
    ORDER BY user_category_num;
