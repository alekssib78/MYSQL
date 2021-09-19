--  Урок 8.

-- Д.З. 8.1.
USE vk;

/* Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите 
человека, который больше всех общался с выбранным пользователем 
(написал ему сообщений)*/

SELECT m.to_user_id AS recipient,
		m.from_user_id AS sender,
		count(m.to_user_id) AS most_active
	FROM users u
	JOIN messages AS m ON u.id = m.to_user_id
	WHERE m.to_user_id = 1
	GROUP BY sender	
	ORDER BY most_active DESC
	LIMIT 1
	;

-- Д.З. 8.2.

USE vk;

/*	Подсчитать общее количество лайков, которые получили
 пользователи младше 10 лет. */

SELECT count(like_type) 
	FROM profiles AS p
	JOIN posts_likes AS  p_l ON p.user_id = p_l.user_id
WHERE date_add(birthday,INTERVAL 10 YEAR) >=curdate() AND p_l.like_type = 1 ;
;
	
-- Д.З. 8.3.

USE vk;
-- Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT p.user_id,gender,p_l.like_type,count(like_type) FROM profiles AS p 
	JOIN posts_likes AS p_l ON p.user_id = p_l.user_id
	WHERE  like_type =1 AND gender != 'x'
	GROUP BY gender
	ORDER BY count(like_type) DESC
	LIMIT 1;



