SHOW DATABASES;
USE from_homework;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    created_at datetime DEFAULT CURRENT_TIMESTAMP,
    table_name varchar(50) NOT NULL,
    row_id INT UNSIGNED NOT NULL,
    row_name varchar(255)
) ENGINE = Archive;

DELIMITER //

CREATE TRIGGER products_insert AFTER INSERT ON products
FOR EACH ROW
BEGIN
    INSERT INTO logs VALUES (NULL, DEFAULT, "products", NEW.id, NEW.name);
END//

CREATE TRIGGER users_insert AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO logs VALUES (NULL, DEFAULT, "users", NEW.id, NEW.name);
END//

CREATE TRIGGER catalogs_insert AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
    INSERT INTO logs VALUES (NULL, DEFAULT, "catalogs", NEW.id, NEW.name);
END//

DELIMITER ;