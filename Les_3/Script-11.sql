DROP DATABASE IS EXISTS vk;

CREATE DATABASE IF NOT EXISTS vk;

USE vk;
CREATE TABLE users(
	id bigint UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
	first_name varchar(150) NOT NULL,
	last_name varchar(150) NOT NULL,
	email varchar(150) NOT NULL UNIQUE,
	phone char(11) NOT NULL,
	password_hash char(65) DEFAULT NULL,
	created_at datetime NOT NULL DEFAULT current_timestamp,
	INDEX (phone),
	INDEX (email)
);

INSERT INTO users VALUES (DEFAULT,'Petya','Petukhov', 'petyamail@com', '12345678910', DEFAULT, DEFAULT );
INSERT INTO users VALUES (DEFAULT , 'Vasya', 'Pupkin','vasyagmail@.com', '23456789123', DEFAULT , DEFAULT );

SELECT * FROM users ;


CREATE TABLE profiles(
	user_id bigint UNSIGNED NOT NULL PRIMARY KEY ,
	gender enum('f', 'm', 'x') NOT NULL ,
	birthday date NOT NULL ,
	photo_id bigint UNSIGNED ,
	city varchar(130),
	country varchar(150),
	FOREIGN KEY (user_id) REFERENCES users(id)  ON DELETE CASCADE ON UPDATE cascade
);

INSERT INTO profiles VALUES (1,'m','1985-05-17',NULL,'Moscow','Russia');
INSERT INTO profiles VALUES (2,'m','1989-02-26',NULL,'Moscow','Russia');

SELECT * FROM users ;

CREATE TABLE messages(
	id SERIAL PRIMARY KEY,
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

INSERT INTO messages VALUES(DEFAULT,1,2,'Hi Vasiliy!!!',1,DEFAULT,DEFAULT);
INSERT INTO messages VALUES(DEFAULT,2,1,'Hi Petya!!!',1,DEFAULT,DEFAULT);

SELECT * FROM messages;


DESCRIBE messages;

CREATE TABLE friend_requests(
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	accepted BOOLEAN DEFAULT FALSE,
	PRIMARY KEY (from_user_id,to_user_id),
	KEY (from_user_id),
	KEY (to_user_id),
	FOREIGN KEY (from_user_id) REFERENCES users(id),
	FOREIGN KEY (to_user_id ) REFERENCES users(id)
);


INSERT INTO friend_requests VALUES (1,2,1);
SELECT * FROM friend_requests;


CREATE TABLE communities (
	id SERIAL PRIMARY KEY,
	name VARCHAR(150) NOT NULL,
	description VARCHAR (255),
	admin_id BIGINT UNSIGNED NOT NULL,
	KEY(admin_id),
	FOREIGN KEY (admin_id) REFERENCES users(id)
);

INSERT INTO communities VALUES (DEFAULT,'Number1','I am number one',1);
INSERT INTO communities VALUES (DEFAULT,'Number2','I am number two',1);


SELECT * FROM communities; 

CREATE TABLE communities_users(
	community_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (community_id,user_id),
	KEY (community_id),
	KEY (user_id),
	FOREIGN KEY (community_id) REFERENCES communities(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
); 

INSERT INTO communities_users VALUES (1,2,default);

CREATE TABLE media_types(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE 
);

INSERT INTO media_types VALUES (DEFAULT,'изображение');
INSERT INTO media_types VALUES (DEFAULT,'музыка');
INSERT INTO media_types VALUES (DEFAULT,'документ');

SELECT * FROM media_types;


CREATE TABLE media(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	media_types_id INT UNSIGNED NOT NULL,
	file_nime VARCHAR(255),
	file_size BIGINT UNSIGNED,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	KEY (media_types_id),
	KEY(user_id),
	FOREIGN KEY (media_types_id) REFERENCES media_types(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO media VALUES (DEFAULT, 1,1,'test.jpg',100,DEFAULT);
INSERT INTO media VALUES (DEFAULT, 1,2,'ru.mp3',100,DEFAULT);
INSERT INTO media VALUES (DEFAULT, 2,3,'test.txt',100,DEFAULT);