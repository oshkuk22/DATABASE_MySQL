DROP DATABASE IF EXISTS fonoteka;
CREATE DATABASE fonoteka;

SHOW DATABASES;

USE fonoteka;

DROP TABLE IF EXISTS dictors;
CREATE TABLE dictors (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки диктора", 
  gender char(1) COMMENT "Пол диктора",
  region_id TINYINT UNSIGNED COMMENT "Регион диктора",
  -- sound_id INT UNSIGNED COMMENT "Звуковой файл диктора",
  birthday DATE COMMENT "Дата рождения",
  -- sound_and_voice_characteristics_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Таблица дикторов"; 

DESC dictors;
INSERT INTO dictors(gender, region_id, birthday) VALUES
('m',26,'1997-02-03'),
('f',7,'1986-06-19'),
('m',66,'1988-01-26'),
('m',80,'1980-07-06'),
('m',11,'1983-06-12'),
('f',13,'2000-06-03'),
('f',18,'2001-04-05'),
('m',9, '1999-07-09'),
('f',5, '1985-04-17'),
('m',16, '1978-04-09'),
('f',36, '1955-03-05'),
('m',8, '1989-04-25'),
('m',7, '2002-03-03');

SELECT * FROM dictors;

-- Индекс
CREATE INDEX dictors_birthday_idx ON dictors(birthday);
CREATE INDEX dictors_region_id_idx ON dictors(region_id);

--
DROP TABLE IF EXISTS regions;
CREATE TABLE regions (
  id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "Идентификатор строки региона", 
  name VARCHAR(50) NOT NULL UNIQUE COMMENT "Название региона", 
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
) COMMENT "Таблица регинов"; 

DESC regions;

INSERT INTO regions(name)  VALUES
('Адыгея'),
('Алтай'),
('Алтайский край'),
('Амурская область'),
('Архангельская область'),
('Астраханская область'),
('Башкортостан'),
('Белгородская область'),
('Брянская область'),
('Бурятия'),
('Владимирская область'),
('Волгоградская область'),
('Вологодская область'),
('Воронежская область'),
('Дагестан'),
('Еврейская АО'),
('Забайкальский край'),
('Ивановская область'),
('Ингушетия'),
('Иркутская область'),
('Кабардино-Балкария'),
('Калининградская область'),
('Калмыкия'),
('Калужская область'),
('Камчатский край'),
('Карачаево-Черкессия'),
('Карелия'),
('Кемеровская область'),
('Кировская область'),
('Коми'),
('Костромская область'),
('Краснодарский край'),
('Красноярский край'),
('Курганская область'),
('Курская область'),
('Ленинградская область'),
('Липецкая область'),
('Магаданская область'),
('Марий Эл'),
('Мордовия'),
('Москва'),
('Московская область'),
('Мурманская область'),
('Ненецкий АО'),
('Нижегородская обласAть'),
('Новгородская область'),
('Новосибирская область'),
('Омская область'),
('Оренбургская область'),
('Орловская область'),
('Пензенская область'),
('Пермский край'),
('Приморский край'),
('Псковская область'),
('Ростовская область'),
('Рязанская область'),
('Самарская область'),
('Санкт-Петербург'),
('Саратовская область'),
('Саха (Якутия)'),
('Сахалинская область'),
('Свердловская область'),
('Северная Осетия - Алания'),
('Смоленская область'),
('Ставропольский край'),
('Тамбовская область'),
('Татарстан'),
('Тверская область'),
('Томская область'),
('Тульская область'),
('Тыва'),
('Тюменская область'),
('Удмуртия'),
('Ульяновская область'),
('Хабаровский край'),
('Хакасия'),
('Ханты-Мансийский АО - Югра'),
('Челябинская область'),
('Чеченская республика'),
('Чувашская республика'),
('Чукотский АО'),
('Ямало-Ненецкий АО'),
('Ярославская область'),
('Крым'),
('Севастополь');

SELECT * FROM region LIMIT 10;

--
DROP TABLE IF EXISTS info_about_sound_files;
CREATE TABLE info_about_sound_files (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "ID файла",
  dictor_id INT UNSIGNED COMMENT "ID диктора",
  filename VARCHAR(150) COMMENT "Имя файла содержащего голос и речь диктора",
  file_sound_characteristics_id INT UNSIGNED COMMENT "ID звуковых характеристик звукового файла содержащего голос и речь диктора",
  size_file INT UNSIGNED NOT NULL COMMENT "Размер файла в мб",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
  ) COMMENT "Таблица информации о характеристиках звукового файла"; 

DESC info_about_sound_files;
SELECT * FROM info_about_sound_files;


 INSERT INTO info_about_sound_files(dictor_id, filename, file_sound_characteristics_id, size_file)  VALUES
(10, 'name_1.wav', 19, 263),
(1, 'name_31.mp3', 12, 32),
(10, 'name_5.mp4', 17, 69),
(10, 'name_3.aac', 29, 45),
(10, 'name_14.wav', 28, 3),
(10, 'name_17.ogg', 27, 4),
(10, 'name_19.mp3', 26, 360),
(10, 'name_20.ac3', 21, 542),
(10, 'name_21.mp3', 18, 896),
(10, 'name_45.ogg', 10, 946),
(10, 'name_78.wav', 12, 534),
(10, 'name_98.aac', 11, 87);

-- индекс
CREATE INDEX info_about_sound_files_dictor_id_filename_size_file_idx ON info_about_sound_files(dictor_id, filename, size_file);

--
DROP TABLE IF EXISTS format_files;
CREATE TABLE format_files (
  id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "ID формата файла",
  name_format VARCHAR(20) COMMENT "Название формата",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
  ) COMMENT "Таблица названий форматов звуковых файлов"; 
 
 SELECT * FROM format_files;
 INSERT INTO format_files(name_format)  VALUES
('AAC'),
('ADPCM'),
('AC3'),
('AMR'),
('A-Law'),
('FLAC'),
('MPEG LAYER 2'),
('MPEG LAYER 3'),
('Mu-Law'),
('PCM'),
('VORBIS'),
('WMA');

SELECT * FROM format_files;


CALL insert_value('main_tones',50,5,500);

SELECT * FROM main_tones;

--
DROP TABLE IF EXISTS frequency_lows;
CREATE TABLE frequency_lows (
  id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "ID значения нижнего частотного диапазона речи",
  value VARCHAR(20) COMMENT "нижнего частотного диапазона речи"
  ) COMMENT "Таблица значений нижнего частотного диапазона речи"; 
 
DESC frequency_lows;

CALL insert_value('frequency_lows',50,10,1000);

SELECT * FROM frequency_tops;

--
DROP TABLE IF EXISTS frequency_tops;
CREATE TABLE frequency_tops (
  id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "ID значения нижнего частотного диапазона речи",
  value VARCHAR(20) COMMENT "нижнего частотного диапазона речи"
  ) COMMENT "Таблица значений нижнего частотного диапазона речи"; 
 
DESC frequency_tops;

CALL insert_value('frequency_tops',1500,20,5000);

SELECT * FROM frequency_tops;

--
DROP TABLE IF EXISTS frequency_rates;
CREATE TABLE frequency_rates (
  id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "ID частоты дискретизации",
  rate_value SMALLINT UNSIGNED NOT NULL COMMENT "Значение частоты дискретизации"
  ) COMMENT "Таблица значений частоты дискретизации"; 
 
 DESC frequency_rate;

 INSERT INTO frequency_rates (rate_value)  VALUES
(8000),
(11025),
(11150),
(12000),
(16000),
(24000),
(32000),
(44100),
(48000);

SELECT * FROM frequency_rate;

--
DROP TABLE IF EXISTS bitrates;
CREATE TABLE bitrates (
  id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "ID значения битрейта",
  bitrate_value SMALLINT UNSIGNED NOT NULL COMMENT "Значение битрейта"
  ) COMMENT "Таблица значений битрейта"; 
 
DESC bitrates;
CALL insert_value('bitrates', 12, 2, 2000);
SELECT * FROM bitrates;

--
DROP TABLE IF EXISTS voice_characteristics;
CREATE TABLE voice_characteristics (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "ID голосовых характеристик",
  dictor_id INT UNSIGNED COMMENT "ID диктора",
  main_tones_value SMALLINT UNSIGNED COMMENT "Значениме частоты основного тона",
  type_main_tones VARCHAR(20) COMMENT "Оценка частоты основного тона",
  frequency_lows_id TINYINT UNSIGNED COMMENT "ID нижней частоты речевых сигналов",
  frequency_tops_id TINYINT UNSIGNED COMMENT "ID верхней частоты речевых сигналов",
  info_about_sound_files_id INT UNSIGNED COMMENT "ID информации по файлу",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
  ) COMMENT "Таблица информации о голосовых характристиках диктора"; 

SELECT * FROM voice_characteristics;
INSERT INTO voice_characteristics(dictor_id, main_tones_value,frequency_lows_id, frequency_tops_id, info_about_sound_files_id) VALUES
(9,130,4,67,51),
(3,200,3,80,49),
(5,100,2,90,54),
(13,150,6,69,55),
(3,230,5,85,53),
(9,140,7,140,52),
(11,80,1,112,57),
(12,186,2,72,58),
(7,252,3,151,53);

-- индекс
CREATE INDEX voice_characteristics_dictor_id_main_tones_value_idx ON voice_characteristics(dictor_id, main_tones_value);

SELECT * FROM voice_characteristics;
SELECT gender FROM dictors WHERE dictors.id =11;

 --
 DROP TABLE IF EXISTS file_sound_characteristics;
CREATE TABLE file_sound_characteristics (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT "ID характеристик звукового файла",
  format_files_id TINYINT UNSIGNED COMMENT "ID формата аудиофайла",
  frequency_rates_id TINYINT UNSIGNED COMMENT "ID частоты дискретизации",
  bitrates_id SMALLINT UNSIGNED COMMENT "ID битрейта",
  duration_sec INT UNSIGNED COMMENT "Длительность файла",
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания строки",
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления строки"
  ) COMMENT "Таблица информации о характристиках звуковых файлов"; 
  
 INSERT INTO file_sound_characteristics(format_files_id, frequency_rates_id, duration_sec) VALUES
(3,4,120),
(1,8,520),
(5,2,340),
(7,1,10),
(3,7,90),
(4,6,510),
(2,2,910),
(1,3,1200),
(6,1,5),
(4,5,180),
(1,8,320),
(3,5,740);

SELECT * FROM voice_characteristics;

-- индекс
CREATE INDEX file_sound_characteristics_format_file_id_duration_sec_idx ON file_sound_characteristics(format_files_id, duration_sec);

 -- Внешние ключи
 ALTER TABLE dictors
  ADD CONSTRAINT dictors_region_id_fk 
    FOREIGN KEY (region_id) REFERENCES regions(id)
      ON DELETE SET NULL;
    
  ALTER TABLE info_about_sound_files
    ADD CONSTRAINT dictor_audio_files_id_fk 
      FOREIGN KEY (dictor_id) REFERENCES dictors(id)
        ON DELETE CASCADE,
    ADD CONSTRAINT files_characteristics_id_fk 
      FOREIGN KEY (file_sound_characteristics_id) REFERENCES file_sound_characteristics(id)
        ON DELETE CASCADE;
       
   ALTER TABLE file_sound_characteristics
    ADD CONSTRAINT format_audio_files_id_fk 
      FOREIGN KEY (format_files_id) REFERENCES format_files(id)
        ON DELETE SET NULL,
    ADD CONSTRAINT frequency_rates_id_fk 
      FOREIGN KEY (frequency_rates_id) REFERENCES frequency_rates(id)
        ON DELETE SET NULL,
    ADD CONSTRAINT bitrates_id_fk 
      FOREIGN KEY (bitrates_id) REFERENCES bitrates(id)
        ON DELETE SET NULL;
     
  ALTER TABLE voice_characteristics
DROP CONSTRAINT voice_characteristics_dictor_id_fk;
  ALTER TABLE frequency_lows_id_fk
DROP CONSTRAINT voice_characteristics_dictor_id_fk;
ALTER TABLE frequency_lows_id_fk
DROP CONSTRAINT frequency_tops_id_fk;
       
  ALTER TABLE voice_characteristics
    ADD CONSTRAINT  voice_characteristics_dictor_id_fk 
      FOREIGN KEY (dictor_id) REFERENCES dictors(id)
        ON DELETE CASCADE;
  ALTER TABLE voice_characteristics
    ADD CONSTRAINT frequency_lows_id_fk 
      FOREIGN KEY (frequency_lows_id) REFERENCES frequency_lows(id)
        ON DELETE SET NULL;
  ALTER TABLE voice_characteristics
    ADD CONSTRAINT frequency_tops_id_fk 
      FOREIGN KEY (frequency_tops_id) REFERENCES frequency_tops(id)
        ON DELETE SET NULL;
  ALTER TABLE voice_characteristics
    ADD CONSTRAINT voice_info_about_sound_files_id_fk 
      FOREIGN KEY (info_about_sound_files_id) REFERENCES info_about_sound_files(id)
        ON DELETE CASCADE;.
 
        
-- VIEWS
# vertical VIEW
CREATE OR REPLACE VIEW voices_info (value_main_tone, type_main_tone) AS 
SELECT DISTINCT main_tones_value, type_main_tones FROM voice_characteristics ORDER BY main_tones_value;
        
 SELECT * FROM voices_info;
 
# horizontal VIEW
CREATE OR REPLACE VIEW voices_type_middle_main_tone(dictor_id, gender,value, main_tone_low) AS 
SELECT dictor_id, (SELECT gender FROM dictors WHERE dictor_id = dictors.id),main_tones_value,type_main_tones 
FROM voice_characteristics WHERE type_main_tones = 'low';

SELECT * FROM voices_type_middle_main_tone;


-- fonoteka query
SELECT COUNT(*) AS quantity FROM
(SELECT voice_characteristics.id, dictor_id, main_tones_value, type_main_tones, dictors.gender 
  FROM voice_characteristics
    JOIN dictors ON ((dictors.gender = 'f') AND (voice_characteristics.type_main_tones = 'low'))
  GROUP BY voice_characteristics.id) AS tabl;
 
 SELECT DISTINCT voice_characteristics.type_main_tones,
  COUNT(voice_characteristics.type_main_tones) OVER w AS average,
  COUNT(voice_characteristics.type_main_tones) OVER w/ COUNT(voice_characteristics.type_main_tones) OVER() * 100 AS "%%"
    FROM voice_characteristics
        WINDOW w AS (PARTITION BY voice_characteristics.type_main_tones);
