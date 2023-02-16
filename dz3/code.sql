
-- 1. List of uniqu names of users
SELECT DISTINCT firstname FROM users ORDER BY firstname;

-- 2. Count of man who older 35 years
SELECT count(*) FROM profiles WHERE gender = 'm' AND (year(curdate()) - year(birthday)) > 35;

-- 3. Count of requests to friend in each status
SELECT status, count(status) AS count FROM friend_requests GROUP BY status;

-- 4. Number of user who send mostly requests to friend
SELECT initiator_user_id, count(initiator_user_id) AS count FROM friend_requests GROUP BY initiator_user_id ORDER BY count DESC LIMIT 1;

-- 5. List of numbers and names of group which name is 5 symbols
SELECT id, name FROM communities WHERE name LIKE '_____';
