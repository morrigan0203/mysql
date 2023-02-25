-- 1. Create views for each requests
CREATE OR REPLACE VIEW v_users_groups AS 
SELECT u.id, u.firstname, u.lastname, count(*) FROM users_communities uc LEFT JOIN users u ON (uc.user_id=u.id) GROUP BY uc.user_id;

CREATE OR REPLACE VIEW v_users_comunities AS
SELECT c.id, c.name, count(*) FROM users_communities uc LEFT JOIN communities c ON (uc.community_id=c.id) GROUP BY uc.community_id;

CREATE OR REPLACE VIEW v_users_messages AS
SELECT fu.id AS from_id, fu.firstname AS from_firstnam, fu.lastname AS from_lastname, tu.firstname AS to_firstname, tu.lastname AS to_lastname, 
count(*) AS count FROM messages m LEFT JOIN users fu ON (m.from_user_id=fu.id) LEFT JOIN users tu ON (m.to_user_id=tu.id) 
WHERE to_user_id=1 GROUP BY from_user_id
ORDER BY count DESC LIMIT 1;

CREATE OR REPLACE VIEW v_likes_yander AS
SELECT count(*) FROM likes l LEFT JOIN profiles p ON (l.user_id=p.user_id) WHERE (year(curdate())-year(p.birthday)) < 18;

CREATE OR REPLACE VIEW v_likes_gender AS
SELECT p.gender, count(*) FROM likes l LEFT JOIN profiles p ON (l.user_id=p.user_id) GROUP BY gender;

-- 2. Select from views

SELECT * FROM v_users_groups;

SELECT * FROM v_users_comunities;

SELECT * FROM v_users_messages;

SELECT * FROM v_likes_yander;

SELECT * FROM v_likes_gender;

-- 3. Drop views

DROP VIEW v_users_groups;

DROP VIEW v_users_comunities;

DROP VIEW v_users_messages;

DROP VIEW v_likes_yander;

DROP VIEW v_likes_gender;

-- 4. News count

SELECT count(*) AS news_count, m.user_id, u.email AS user_email FROM media m LEFT JOIN users u ON (m.user_id=u.id) GROUP BY m.user_id;

WITH cte AS (SELECT count(*) AS news_count, user_id FROM media GROUP BY user_id) SELECT cte.news_count AS news_count, cte.user_id AS user_id, u.email AS user_email FROM cte LEFT JOIN users u ON u.id = cte1.user_id;

