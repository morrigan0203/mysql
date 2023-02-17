-- 1. Count of groups for each of user
select u.id, u.firstname, u.lastname, count(*) from users_communities uc left join users u on (uc.user_id=u.id) group by uc.user_id;

-- 2. Count of users in each of communities
select c.id, c.name, count(*) from users_communities uc left join communities c on (uc.community_id=c.id) group by uc.community_id;

-- 3. Find user who send mostly messages to user with id = 1
select fu.id as from_id, fu.firstname as from_firstnam, fu.lastname as from_lastname, tu.firstname as to_firstname, tu.lastname as to_lastname, count(*) as count from messages m left join users fu on (m.from_user_id=fu.id) left join users tu on (m.to_user_id=tu.id) where to_user_id=1 group by from_user_id
order by count desc limit 1;

-- 4. Count of likes for users yanger 18 years
select count(*) from likes l left join profiles p on (l.user_id=p.user_id) where (year(curdate())-year(p.birthday)) < 18;

-- 5. Count of likes from man and woman
select p.gender, count(*) from likes l left join profiles p on (l.user_id=p.user_id) group by gender;
