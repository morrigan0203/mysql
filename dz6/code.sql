-- 1. Create function for delete all information about user
DROP FUNCTION IF EXISTS func_delete_user;

DELIMITER // -- set delimeter

CREATE FUNCTION func_delete_user(delete_user_id BIGINT UNSIGNED)
RETURNS BIGINT UNSIGNED READS SQL DATA
  BEGIN
-- delete messages
	DELETE FROM messages WHERE from_user_id=delete_user_id OR to_user_id=delete_user_id;
-- delete likes
	DELETE FROM likes WHERE user_id=delete_user_id;
-- delete profiles
	DELETE FROM profiles WHERE user_id=delete_user_id;
-- delete media
	DELETE FROM media WHERE user_id=delete_user_id;
-- delete friend requests
	DELETE FROM friend_requests WHERE initiator_user_id=delete_user_id OR target_user_id=delete_user_id;
-- delete users communities
	DELETE FROM users_communities WHERE user_id=delete_user_id;
-- delete user
	DELETE FROM users WHERE id=delete_user_id;
-- return user id
    RETURN delete_user_id;
END//

DELIMITER ; -- revert delimeter

START TRANSACTION;
SELECT func_delete_user(10);
COMMIT;

-- 2. Create procedure for delete all information about user
DROP PROCEDURE IF EXISTS proc_delete_user;

DELIMITER //

CREATE PROCEDURE proc_delete_user(IN delete_user_id BIGINT UNSIGNED)
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	START TRANSACTION;
-- delete messages
	DELETE FROM messages WHERE from_user_id=delete_user_id OR to_user_id=delete_user_id;
-- delete likes
	DELETE FROM likes WHERE user_id=delete_user_id;
-- delete profiles
	DELETE FROM profiles WHERE user_id=delete_user_id;
-- delete media
	DELETE FROM media WHERE user_id=delete_user_id;
-- delete friend requests
	DELETE FROM friend_requests WHERE initiator_user_id=delete_user_id OR target_user_id=delete_user_id;
-- delete users communities
	DELETE FROM users_communities WHERE user_id=delete_user_id;
-- delete user
	DELETE FROM users WHERE id=delete_user_id;
    COMMIT;
END//

DELIMITER ; -- revert delimeter

CALL proc_delete_user(10);

-- 3. Create trigger

DROP TRIGGER IF EXISTS tr_add_community_before_insert;

DELIMITER //

CREATE TRIGGER tr_add_community_before_insert BEFORE INSERT ON communities
FOR EACH ROW
BEGIN
	IF length(NEW.name) < 5 THEN
		SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'Name of community should be more then 5 symbols';
	END IF;
END//

DELIMITER ;

-- should successfully
INSERT INTO communities (name) VALUES ('qwerty');
-- should fail with message 'Name of community should be more then 5 symbols'
INSERT INTO communities (name) VALUES ('qwer');
