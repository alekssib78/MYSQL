-- подключаемся к базе данных
USE vk;
-- удаляем таблицу если она есть
DROP TABLE users;
-- создаем таблицу
CREATE TABLE users(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(150) NOT NULL,
	last_name VARCHAR(150) NOT NULL,
	email VARCHAR(150) NOT NULL UNIQUE,
	phone CHAR(11) NOT NULL,
	password_hach CHAR(65) DEFAULT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
INDEX (phone),
INDEX (email)
);
-- вносим пользователей
INSERT INTO users VALUES (DEFAULT,'Василий','Иванов','vsiv@mail.ru', '12345678901','1245',DEFAULT);
INSERT INTO users VALUES (DEFAULT,'Михаил', 'Молчанов','miha@gmail.com','33344422267',DEFAULT, DEFAULT);


CREATE TABLE profiles(
	user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY ,
	gender ENUM('F', 'M', 'X') NOT NULL ,
	birthday DATE NOT NULL ,
	photo_id BIGINT UNSIGNED ,
	city VARCHAR(130),
	country VARCHAR(150),
	FOREIGN KEY (user_id) REFERENCES users(id)  ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO profiles VALUES (1,'M','1985-05-17',NULL,'MOSCOW','RUSSIA');
INSERT INTO profiles VALUES (2,'M','1989-02-26',NULL,'MOSCOW','RUSSIA');

CREATE TABLE messages(
	id serial PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	txt TEXT NOT NULL,
	is_delivered BOOLEAN DEFAULT FALSE,
	created_at DATETIME NOT NULL DEFAULT NOW(),
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX messages_from_user_id_idx (from_user_id),
	INDEX messages_to_user_id_idx(to_user_id), 
	CONSTRAINT fk_messages_from_user_id FOREIGN KEY (from_user_id) REFERENCES users(id),
	CONSTRAINT fk_messages_to_user_id FOREIGN KEY (to_user_id) REFERENCES users(id)
);

INSERT INTO messages VALUES(DEFAULT,1,2,'Привет Михаил!!!',1,DEFAULT,DEFAULT);
INSERT INTO messages VALUES(DEFAULT,2,1,'Привет Василий!!!',1,DEFAULT,DEFAULT);