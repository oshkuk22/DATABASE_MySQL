USE vk;

-- # 3 TASK (through join) 
SELECT gender, COUNT(*) AS total
  FROM likes
	JOIN profiles 
	ON profiles.user_id = likes.user_id
  GROUP BY gender
  ORDER BY total DESC
  LIMIT 1;.
  
 
 -- # 4 TASK (through join) 
SELECT SUM(count_) AS rezult FROM
(SELECT COUNT(likes.target_type_id) AS count_
  FROM profiles
	LEFT JOIN likes 
		ON (likes.target_id = profiles.user_id AND likes.target_type_id = 2)
	GROUP BY profiles.user_id 
	ORDER BY birthday DESC 
	LIMIT 10) AS new_table;


 -- # 5 TASK (through join) 
SELECT users.id,
  COUNT(DISTINCT messages.id) + 
  COUNT(DISTINCT likes.id) + 
  COUNT(DISTINCT media.id) AS activ 
  FROM users
    LEFT JOIN messages 
      ON users.id = messages.from_user_id
    LEFT JOIN likes
      ON users.id = likes.user_id
    LEFT JOIN media
      ON users.id = media.user_id
  GROUP BY users.id
  ORDER BY activ
  LIMIT 10;

















