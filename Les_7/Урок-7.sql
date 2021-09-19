-- Урок 7.



-- Д.З. 7.1
USE topcomp;
-- shop.sql

/*Составьте список пользователей users, которые осуществили хотя бы один 
заказ orders в интернет магазине*/


INSERT orders (id,user_id,created_at,updated_at) 
VALUES (3,4,now(),now());
SELECT us.name,user_id FROM users us
JOIN orders o ON us.id=o.user_id;

-- Д.З. 7.2
/* Выведите список товаров products и разделов catalogs, который 
соответствует товару */

SELECT p.id,p.name catalog_name,c.name product_name FROM products p 
JOIN catalogs c ON p.catalog_id = c.id;


-- Д.З. 7.3

/* Пусть имеется таблица рейсов flights (id, from, to) и 
таблица городов cities (label, name). Поля from, to и label содержат 
английские названия городов, поле name — русское. Выведите список рейсов 
flights с русскими названиями городов. */



