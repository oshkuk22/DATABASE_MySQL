-- 1 TASK
USE from_homework;
SHOW TABLES;

DESC users;
SELECT * FROM  storehouses_products sp ;


INSERT INTO users (name, birthday_at) VALUES
('Виталий', '2015-03-02'),
('Юрий', '1986-06-05'),
('Валерия', '1986-06-08');


CREATE TABLE orders(
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
user_id INT UNSIGNED,
name VARCHAR(150) NOT NULL,
count_name INT UNSIGNED);

INSERT INTO orders (user_id, name, count_name) VALUES
('4','Mouse', '2'),
('2', 'Keyboard', '1'),
('5', 'DDR4','4');

SELECT * FROM orders;

SELECT users.id, users.name, users.birthday_at
  FROM users
   JOIN orders
     ON users.id = orders.user_id;
     
  -- 2 TASK
  
 SELECT
  products.id,
  products.name,
  products.price,
  catalogs.name
 FROM products
    LEFT JOIN catalogs
      ON products.catalog_id = catalogs.id;
  
 
  -- 3 TASK
DROP TA BLE flights
     
 CREATE TABLE flights (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `from_` VARCHAR(255) COMMENT 'Откуда',
  `to_` VARCHAR(255) COMMENT 'Куда'
 );

INSERT INTO flights (`from_`, `to_`) VALUES
('moscow', 'omsk'),
('novgorod', 'kazan'),
('irkutsk', 'moscow'),
('omsk', 'irkutsk'),
('moscow', 'kazan');

CREATE TABLE cities (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  label VARCHAR(255),
  name VARCHAR(255)
);

INSERT INTO cities (label, name) VALUES
('moscow', 'Москва'),
('irkutsk', 'Иркутск'),
('novgorod', 'Новгород'),
('kazan', 'Казань'),
('omsk', 'Омск');

SELECT
  flights.id,
  cities_from.name,
  cities_to.name
FROM flights
  JOIN cities AS cities_from
    ON flights.from_ = cities_from.label
  JOIN cities AS cities_to
    ON flights.to_ = cities_to.label
ORDER BY id;
   