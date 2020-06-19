USE vk;
ALTER TABLE profiles ADD photo_id INT UNSIGNED AFTER user_id

CREATE TABLE user_statuses(
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(150) NOT NULL UNIQUE
);

INSERT user_statuses (id,name)
VALUES
(1, 'active'),
(2, 'blocked'),
(3, 'deleted');

ALTER  TABLE users ADD status_id INT UNSIGNED NOT NULL DEFAULT 1 AFTER phone;

ALTER  TABLE profiles ADD is_private BOOLEAN DEFAULT FALSE AFTER country;

ALTER TABLE friendship ADD COLUMN decline_at DATETIME AFTER confirmed_at; 

ALTER TABLE messages ADD COLUMN media_id INT UNSIGNED AFTER body;

ALTER TABLE friendship DROP COLUMN requested_at;

UPDATE users SET status_id = 2 WHERE id IN (3, 32, 59, 34);
UPDATE users SET status_id = 3 WHERE id IN (33, 28, 52, 31, 90);

UPDATE users SET updated_at = CURRENT_TIMESTAMP WHERE created_at > updated_at;

UPDATE profiles SET photo_id = FLOOR(1 + RAND() * 100);

-- столбец gender не заполнял потому, что мне удалось ее правильно заполнить при генерации данных
-- c country аналогично

UPDATE profiles SET is_private = TRUE WHERE photo_id > FLOOR(1 + RAND() * 100);

SELECT gender, country, is_private  FROM profiles;

SELECT * FROM messages;

UPDATE messages SET 
from_user_id = FLOOR(1 + RAND() * 100),
to_user_id = FLOOR(1 + RAND() * 100),
media_id = FLOOR(1 + RAND() * 100);
 
SELECT * FROM messages;

DESC media;

UPDATE media SET user_id = FLOOR(1 + RAND() * 100 ); 

CREATE TEMPORARY TABLE extensions (name VARCHAR(50));

INSERT INTO extensions VALUES ('jpeg'), ('avi'), ('mp3'), ('png');

UPDATE media SET filename = CONCAT(
'https://dropbox.net/vk/',
filename,
'.',
(SELECT name FROM extensions ORDER BY RAND() LIMIT 1));

UPDATE media SET size = FLOOR(1000 +RAND() * 1000000 ) WHERE  size < 1000;

UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}');  

ALTER TABLE media MODIFY COLUMN metadata JSON;

SELECT * FROM media;

DELETE FROM media_types;

INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio');
 
TRUNCATE media_types;

UPDATE media SET media_type_id = FLOOR(1 + RAND() * 3);

UPDATE friendship SET 
user_id = FLOOR(1 + RAND() * 100),
friend_id = FLOOR(1 + RAND() * 100);

UPDATE friendship SET friend_id = friend_id + 1 WHERE user_id = friend_id;

TRUNCATE friendship_statuses;

INSERT INTO friendship_statuses (name) VALUES
 ('Requested'),
 ('Confirmed'),
 ('Rejected');

UPDATE friendship SET status_id = FLOOR(1 + RAND() * 3);

DELETE FROM communities WHERE id > 20;

UPDATE communities_users SET community_id = FLOOR(1 + RAND() * 20);
