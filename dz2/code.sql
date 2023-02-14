-- Create database
DROP DATABASE IF EXISTS cinemas;
CREATE DATABASE cinemas;
USE cinemas;

-- Create tables
DROP TABLE IF EXISTS cinema;
CREATE TABLE cinema (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, 
	name VARCHAR(255) NOT NULL,
	create_date DATE NOT NULL,
	field1 INT DEFAULT 0,
	PRIMARY KEY (id)
) COMMENT 'list of cinemas';

DROP TABLE IF EXISTS studio;
CREATE TABLE studio (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, 
	name VARCHAR(255) NOT NULL,
	PRIMARY KEY (id)
) COMMENT 'list of studios';

DROP TABLE IF EXISTS cinema_stud;
CREATE TABLE cinema_stud (
	cinema_id BIGINT UNSIGNED NOT NULL,
	studio_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (cinema_id, studio_id),
	FOREIGN KEY (cinema_id) REFERENCES cinema(id),
	FOREIGN KEY (studio_id) REFERENCES studio(id)
) COMMENT 'connect cinema to studio namy to many';

DROP TABLE IF EXISTS genre;
CREATE TABLE genre (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, 
	name VARCHAR(255) NOT NULL,
	PRIMARY KEY (id)
) COMMENT 'genre ofcinema';

DROP TABLE IF EXISTS cinema_genre;
CREATE TABLE cinema_genre(
	cinema_id BIGINT UNSIGNED NOT NULL,
	genre_id BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY (cinema_id, genre_id),
	FOREIGN KEY (cinema_id) REFERENCES cinema(id),
	FOREIGN KEY (genre_id) REFERENCES genre(id)
) COMMENT 'table of link between cinema and genre';


-- Fill tables

INSERT INTO cinema (name,create_date) values 
('Film1','1995-10-10'),
('Avatar', '2009-12-10'),
('The Green Mile','1999-12-06');

INSERT INTO studio (name) values 
('Studio1'),
('20th Century Fox Film Corporation'),
('Dune Entertainment'),
('Giant Studios Inc.'),
('Ingenious Media'),
('Millennium Films'),
('Castle Rock Entertainment'),
('Darkwoods Productions'),
('Warner Bros. Pictures');

INSERT INTO cinema_stud (cinema_id, studio_id) values 
(1,1),
(2,2),(2,3),(2,4),(2,5),(2,6), -- add for Avatar studios
(3,7),(3,8),(3,9);-- add for The GreenMile studios

INSERT INTO genre (name) values 
('drama'),('action'),('adventure'),('fantasy'),('crime');

INSERT INTO cinema_genre (cinema_id, genre_id) values 
(1,1),
(2,1),(2,2),(2,3),(2,4),
(3,1),(3,4),(3,5);

-- Remena of table
ALTER TABLE cinema_stud RENAME cinema_studio;

-- Remove/Add table, use operator IF
DROP TABLE IF EXISTS rating;
CREATE TABLE rating (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	stars INT NOT NULL,
	name VARCHAR(255) NOT NULL
) COMMENT 'dictionary of ratings';

INSERT INTO rating (stars, name) values (1,'One star'),(2, 'Two stars'),(3, 'Tree stars'),(4, 'Four stars'),(5, 'Five stars');

-- Add column 
ALTER TABLE cinema ADD COLUMN rating_name BIGINT UNSIGNED;

-- Rename of column
ALTER TABLE cinema RENAME COLUMN rating_name TO rating_id;

-- Remove column
ALTER TABLE cinema DROP COLUMN field1;

UPDATE cinema SET rating_id = 1;

-- Add foreign key
ALTER TABLE cinema ADD FOREIGN KEY (rating_id) REFERENCES rating(id);

-- Select with CASE and alias
select id, CASE 
WHEN stars = 1 THEN '*' 
WHEN stars = 2 THEN '**'
WHEN stars = 3 THEN '***'
WHEN stars = 4 THEN '****'
WHEN stars = 5 THEN '*****'
END as count_of_stars, 
name FROM rating;
