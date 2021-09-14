-- дз 5

--  д.з 5.1.1
USE vk;
-- заполнить поля текущими датами 
DROP TABLE IF EXISTS users1;

CREATE TABLE users1(
id int ,
first_name varchar(150) NOT NULL ,
last_name varchar(150) NOT NULL ,
email varchar (50) UNIQUE ,
phone int(11) UNIQUE ,
birthday_at date,
created_at datetime NULL,
updated_at datetime NULL
);

INSERT users1 (first_name,last_name,birthday_at)
VALUES ('Алексей','Шишкин','1997-09-25');


SELECT * FROM users1;


UPDATE users1
SET created_at = now(), 
	updated_at = now()
WHERE created_at IS NULL OR updated_at IS NULL;

SELECT * FROM users1;

--  д.з 5.1.2

-- изменить тип данных 
DROP TABLE IF EXISTS users2;

CREATE TABLE users2(
	id int,
	first_name varchar(150) NOT NULL ,
	last_name varchar(150) NOT NULL ,
	email varchar (50) UNIQUE ,
	phone int(11) UNIQUE ,
	birthday_at date,
	created_at varchar(20) NULL,
	updated_at varchar(20) NULL
);

INSERT users2 (
	first_name,
	last_name,
	birthday_at,
	created_at,
	updated_at)
VALUES (
	'Алексей',
	'Шишкин',
	'1997-09-25',
	'12.09.2021 14:45',
	'12.09.2021 14:45'
);
DESCRIBE users2;
SELECT * FROM users2;
-- преобразуем строку в формат даты
UPDATE users2 
	SET created_at = str_to_date(created_at,'%d.%m.%Y %k:%i'),
		updated_at = str_to_date(updated_at,'%d.%m.%Y %k:%i');
-- изменяем тип данных в двух столбцах с varchar на datetime	
ALTER TABLE users2 
	MODIFY COLUMN created_at datetime,
	MODIFY COLUMN updated_at datetime;
DESCRIBE users2;



-- д.з 5.1.3

USE sys;

--  сортируем по возврастанию, в конце нулевые значения
SELECT * FROM 
	storehouses_products 
ORDER BY 
	value = 0, value;




--  д.з 5.2.1



USE vk;
-- подсчитываем и округляем средний возвраст в таблице
SELECT 
	ROUND(avg((YEAR(CURRENT_DATE) - YEAR(birthday))-
	(DATE_FORMAT(CURRENT_DATE,'%m%d') < DATE_FORMAT(birthday,'%m%d'))),0) 
AS summ FROM profiles;


-- д.з 5.2.2
USE vk;

-- подсчитываем и выводим количество повторяющихся дней
SELECT count(dayname(date_format(birthday,'2021-%m-%d'))) AS days,dayname(date_format(birthday,'2021-%m-%d')) AS day_birthday 
	FROM profiles
	GROUP BY dayname(date_format(birthday,'2021-%m-%d'))
ORDER BY day_birthday;









