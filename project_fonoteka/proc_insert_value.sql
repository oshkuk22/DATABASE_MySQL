DROP PROCEDURE IF EXISTS insert_value;
DELIMITER //
CREATE PROCEDURE insert_value(IN table_name VARCHAR(20), IN i SMALLINT, IN step TINYINT, IN treshold SMALLINT)
BEGIN
  WHILE i < (treshold + 1) DO
    IF table_name = 'frequency_lows' THEN
	  INSERT INTO frequency_lows(value) VALUES (i);
	ELSEIF table_name = 'frequency_tops' THEN
	  INSERT INTO frequency_tops(value) VALUES (i);
	ELSEIF table_name = 'bitrates' THEN
	  INSERT INTO bitrates(bitrate_value) VALUES (i);
	END IF; 
	SET i = i + step;
  END WHILE;
END//

DELIMITER ;

