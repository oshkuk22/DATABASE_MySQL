DROP TRIGGER IF EXISTS type_main_tone;
DELIMITER //
CREATE TRIGGER type_main_tone BEFORE INSERT ON voice_characteristics
FOR EACH ROW
BEGIN
  DECLARE gender_dictor char(1);
  SET  gender_dictor = (SELECT gender FROM dictors WHERE dictors.id = NEW.dictor_id);
  IF ((gender_dictor = 'f') AND (NEW.main_tones_value < 170)) THEN
	SET NEW.type_main_tones = 'low';
  ELSEIF ((gender_dictor = 'f') AND ((NEW.main_tones_value > 170) AND (NEW.main_tones_value < 251))) THEN
	SET NEW.type_main_tones = 'middle';
  ELSEIF ((gender_dictor = 'f') AND (NEW.main_tones_value > 250)) THEN
	SET NEW.type_main_tones = 'high';
  ELSEIF ((gender_dictor = 'm') AND (NEW.main_tones_value < 80)) THEN
	SET NEW.type_main_tones = 'low';
  ELSEIF ((gender_dictor = 'm') AND ((NEW.main_tones_value > 80) AND (NEW.main_tones_value < 101))) THEN
	SET NEW.type_main_tones = 'middle';
  ELSEIF ((gender_dictor = 'm') AND (NEW.main_tones_value > 100)) THEN
	SET NEW.type_main_tones = 'high';
  END IF;
END//

DELIMITER ;