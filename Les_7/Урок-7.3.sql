


CREATE TABLE flights (
id int,
`from` varchar(50),
`to` varchar(50)
);
INSERT INTO flights
VALUES (1,'moscow','omsk'),
	(2,'novgorod','kazan'),
	(3,'irkutsk','moscow'),
	(4,'omsk','irkutsk'),
	(5,'moscow','kazan');

CREATE TABLE cities (
label varchar(50),
name varchar(50)
);
INSERT INTO cities 
VALUES ('moscow','Москва'),
		('irkutsk','Иркутск'),
		('novgorod','Новгород'),
		('kazan','Казань'),
		('omsk','Омск');
	


SELECT id,
(SELECT name FROM cities WHERE label = `from`) `from`,
(SELECT name FROM cities WHERE label = `to`) `to`
FROM
	flights
ORDER BY
	id;

