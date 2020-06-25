-- OPERATORS

SHOW DATABASES;

USE vk;

-- 1 TASK

DESC users;

SELECT created_at FROM users LIMIT 10;


UPDATE users SET created_at = NOW(), updated_at = NOW();

-- 2 TASK
CREATE DATABASE from_homework;

USE from_homework;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  birthday_at DATE,
  created_at VARCHAR(50),
  updated_at VARCHAR(50)
);

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Артем', '2013-05-18', '20.06.2020 16:09', '20.06.2020 16:09'),
  ('Сергей', '1986-06-12', '20.06.2020 17:10', '20.06.2020 17:10');

UPDATE users SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'), updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

ALTER TABLE users CHANGE created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE users CHANGE updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

DESCRIBE users;

SELECT * FROM users;

-- 3 TASK

DROP TABLE IF EXISTS storehouses_products;

CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO
  storehouses_products (storehouse_id, product_id, value)
VALUES
  (2, 400, 1),
  (1, 568, 0),
  (3, 68, 3),
  (1, 3132, 2),
  (3, 568, 50),
  (1, 638, 0);

SELECT
  *
FROM
  storehouses_products
ORDER BY
  value = 0, value;

-- 4 TASK 
 
 SELECT * 
  FROM users
  WHERE DATE_FORMAT(birthday_at, '%M') IN ('may', 'august');


-- AGGREGATION
 
-- 1 TASK

SELECT
  AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS age
FROM
  users;
	  
-- 2 TASK

SELECT
  DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day_of_week,
  COUNT(*) AS total_days
FROM
  users
GROUP BY
  day_of_week
ORDER BY
  total_days DESC;


 
 
 
 
 
