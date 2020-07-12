USE vk;

-- 1 TASK
DESC users;
DESC profiles;
DESC communities;
DESC messages;
DESC posts;
DESC likes;


CREATE INDEX users_first_and_last_name_idx ON users(first_name, last_name);
CREATE UNIQUE INDEX users_email_uq ON users(email);

CREATE INDEX birthday_idx ON profiles(birthday);
CREATE INDEX country_city_idx ON profiles(country, city);

CREATE INDEX communities_idx ON communities(name);

CREATE INDEX messages_from_to_idx ON messages(from_user_id, to_user_id);

CREATE INDEX community_id_user_id_post_idx ON posts(community_id, user_id);
CREATE INDEX target_id_user_id_idx ON likes(target_id, user_id);

SHOW INDEX FROM lo;
# 2 TASK

SELECT DISTINCT 
  communities.name AS group_name,
  COUNT(communities_users.user_id) OVER() 
    / (SELECT COUNT(*) FROM communities) AS avg_users_in_groups,
  FIRST_VALUE(users.first_name) OVER birthday_desc AS youngest_first_name,
  FIRST_VALUE(users.last_name) OVER birthday_desc AS youngest_last_name,
  FIRST_VALUE(users.first_name) OVER birthday_asc AS oldest_first_name,
  FIRST_VALUE(users.last_name) OVER birthday_asc AS oldest_last_name,
  COUNT(communities_users.user_id) OVER(PARTITION BY communities.id) AS users_in_group,
  (SELECT COUNT(*) FROM users) AS users_total,
  COUNT(communities_users.user_id) OVER(PARTITION BY communities.id) 
    / (SELECT COUNT(*) FROM users) *100 AS '%%'
    FROM communities
      LEFT JOIN communities_users 
        ON communities_users.community_id = communities.id
      LEFT JOIN users 
        ON communities_users.user_id = users.id
      LEFT JOIN profiles 
        ON profiles.user_id = users.id
      WINDOW birthday_desc AS (PARTITION BY communities.id ORDER BY profiles.birthday DESC),
             birthday_asc AS (PARTITION BY communities.id ORDER BY profiles.birthday); 