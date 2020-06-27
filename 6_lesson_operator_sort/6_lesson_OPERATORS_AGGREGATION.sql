SHOW DATABASES;

USE vk;

-- 1-2 TASK

-- Таблица лайков
DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  target_id INT UNSIGNED NOT NULL,
  target_type_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Таблица типов лайков
DROP TABLE IF EXISTS target_types;
CREATE TABLE target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO target_types (name) VALUES 
  ('messages'),
  ('users'),
  ('media'),
  ('posts');

-- Заполняем лайки
INSERT INTO likes 
  SELECT 
    id, 
    FLOOR(1 + (RAND() * 100)), 
    FLOOR(1 + (RAND() * 100)),
    FLOOR(1 + (RAND() * 4)),
    CURRENT_TIMESTAMP 
  FROM messages;

-- Создадим таблицу постов
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  community_id INT UNSIGNED,
  head VARCHAR(255),
  body TEXT NOT NULL,
  media_id INT UNSIGNED,
  is_public BOOLEAN DEFAULT TRUE,
  is_archived BOOLEAN DEFAULT FALSE,
  views_counter INT UNSIGNED DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


DESC posts;

INSERT INTO posts (user_id, community_id, head, body, media_id, is_public, is_archived, views_counter) VALUES
 (FLOOR(1 + (RAND() * 100)), FLOOR(1 + (RAND() * 20)),'news', 'messages', FLOOR(1 + (RAND() * 100)), 0, 1,  FLOOR(1 + (RAND() * 20))),
(FLOOR(1 + (RAND() * 100)), FLOOR(1 + (RAND() * 20)),'news', 'messages', FLOOR(1 + (RAND() * 100)), 1, 0,  FLOOR(1 + (RAND() * 20))),
 (FLOOR(1 + (RAND() * 100)), FLOOR(1 + (RAND() * 20)),'news', 'messages', FLOOR(1 + (RAND() * 100)), 0, 1,  FLOOR(1 + (RAND() * 20))),
(FLOOR(1 + (RAND() * 100)), FLOOR(1 + (RAND() * 20)),'news', 'messages', FLOOR(1 + (RAND() * 100)), 1, 0,  FLOOR(1 + (RAND() * 20))),
 (FLOOR(1 + (RAND() * 100)), FLOOR(1 + (RAND() * 20)),'news', 'messages', FLOOR(1 + (RAND() * 100)), 0, 1,  FLOOR(1 + (RAND() * 20))),
(FLOOR(1 + (RAND() * 100)), FLOOR(1 + (RAND() * 20)),'news', 'messages', FLOOR(1 + (RAND() * 100)), 1, 0,  FLOOR(1 + (RAND() * 20))),
 (FLOOR(1 + (RAND() * 100)), FLOOR(1 + (RAND() * 20)),'news', 'messages', FLOOR(1 + (RAND() * 100)), 0, 1,  FLOOR(1 + (RAND() * 20))),
(FLOOR(1 + (RAND() * 100)), FLOOR(1 + (RAND() * 20)),'news', 'messages', FLOOR(1 + (RAND() * 100)), 1, 0,  FLOOR(1 + (RAND() * 20)));


SELECT * FROM posts;


-- Добавляем внешние ключи
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL;

     
-- Добавляем внешние ключи
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);
 
-- Добавляем внешние ключи
ALTER TABLE messages
  ADD CONSTRAINT messages_media_id_fk 
    FOREIGN KEY (media_id) REFERENCES media(id)
   ON DELETE SET NULL; 
   

-- Добавляем внешние ключи
ALTER TABLE media 
  ADD CONSTRAINT media_from_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id) 
    ON DELETE CASCADE,
  ADD CONSTRAINT media_from_media_types_id_fk 
    FOREIGN KEY (media_type_id) REFERENCES media_types(id) 
   ON DELETE CASCADE;
  
-- Добавляем внешние ключи
ALTER TABLE users
  ADD CONSTRAINT status_from_user_id_fk 
    FOREIGN KEY (status_id) REFERENCES user_statuses(id) 
    ON DELETE CASCADE;
   
DESC communities_users;  
   
ALTER TABLE communities_users 
  ADD CONSTRAINT community_from_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id) 
    ON DELETE CASCADE,
  ADD CONSTRAINT community_from_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE;

 DESC friendship;

 ALTER TABLE friendship 
  ADD CONSTRAINT friendship_user_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id) 
    ON DELETE CASCADE,
  ADD CONSTRAINT friendship_friend_user_id_fk 
    FOREIGN KEY (friend_id) REFERENCES users(id)
    ON DELETE CASCADE,
 ADD CONSTRAINT friendship_status_id_fk 
    FOREIGN KEY (status_id) REFERENCES friendship_statuses(id)
    ON DELETE CASCADE;
   
DESC posts;

ALTER TABLE posts DROP FOREIGN KEY post_media_id_fk   
   
 ALTER TABLE posts 
  ADD CONSTRAINT post_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id) 
    ON DELETE CASCADE,
  ADD CONSTRAINT post_communities_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id)
    ON DELETE CASCADE,
 ADD CONSTRAINT post_media_id_fk 
    FOREIGN KEY (media_id) REFERENCES media(id)
    ON DELETE SET NULL;
   
   
DESC likes;  
SELECT target_type_id FROM likes ORDER BY target_type_id ;


ALTER TABLE likes 
  ADD CONSTRAINT likes_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id) 
    ON DELETE CASCADE;
   
ALTER TABLE likes 
  ADD CONSTRAINT likes_target_type_id_fk 
    FOREIGN KEY (target_type_id) REFERENCES target_types(id) 
    ON DELETE CASCADE;
  

-- 3 TASK 
    
SELECT
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender,
COUNT(*) AS total
FROM likes
GROUP BY gender
ORDER BY total DESC
LIMIT 1; 


-- 4 TASK

SELECT SUM(likes_total)  FROM  
  (SELECT 
    (SELECT COUNT(*) FROM likes WHERE target_id = profiles.user_id AND target_type_id = 2) AS likes_total  
    FROM profiles 
    ORDER BY birthday 
    DESC LIMIT 10) AS user_likes

   
 -- 5 TASK

DESC likes;
DESC media;
DESC messages;
 
SELECT CONCAT(first_name, ' ', last_name) AS user, 
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) + 
	(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) + 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) AS small_activity 
	  FROM users
	  ORDER BY small_activity
	  LIMIT 10;





