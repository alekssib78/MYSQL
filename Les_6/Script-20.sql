-- Урок 6


-- д.з.6.1
USE vk;
/*Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите 
 человека, который больше всех общался с выбранным пользователем 
 (написал ему сообщений)*/
SELECT from_user_id,count(to_user_id)
FROM messages
-- задаем id пользователя 
WHERE to_user_id = 8
GROUP BY from_user_id 
ORDER BY count(to_user_id)DESC
LIMIT 1;


-- д.з.6.2
USE vk;
/*Подсчитать общее количество лайков, которые получили пользователи младше
 10 лет..*/
SELECT count(*) like_type FROM profiles p
-- объеденяем две таблицы по колонке user_id
JOIN posts_likes pl ON p.user_id = pl.user_id
-- выбираем пользователя младше 10 лет и лайк = 1
WHERE ((YEAR(CURRENT_DATE) - YEAR(birthday))-
	(DATE_FORMAT(CURRENT_DATE,'%m%d') < DATE_FORMAT(birthday,'%m%d'))) < 10 AND 
like_type=1;

-- д.з.6.3
USE vk;
-- Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT count(*)like_type,gender FROM posts_likes pl 
JOIN profiles p ON pl.user_id=p.user_id 
WHERE gender != 'x'
GROUP BY gender 
ORDER BY gender
LIMIT 1
;

SELECT count(*)like_type,gender FROM posts_likes,profiles
GROUP BY gender;
