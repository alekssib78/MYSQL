USE vk_1;

-- добавляем столбец is_active в таблицу profiles

ALTER TABLE profiles ADD is_active BOOL DEFAULT TRUE;
-- обновляем и присваиваем 0 если значение меньше 18
UPDATE profiles
SET is_active = 0
	WHERE ((YEAR(CURRENT_DATE) - YEAR(birthday))-
	(DATE_FORMAT(CURRENT_DATE,'%m%d') < DATE_FORMAT(birthday,'%m%d'))) < 18;
