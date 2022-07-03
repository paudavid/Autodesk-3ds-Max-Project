DROP TABLE IF EXISTS student;
CREATE TABLE student(
   ID INTEGER AUTO_INCREMENT,
   name VARCHAR(20),
   lastname VARCHAR(20),
   grade int,
   PRIMARY KEY (ID));


DROP TABLE IF EXISTS friends;
CREATE TABLE friends(
   ID1 INTEGER,
   ID2 INTEGER,
   happiness int default(5),
PRIMARY KEY (ID1, ID2));

DROP TABLE IF EXISTS partner;
CREATE TABLE partner(
   liking INTEGER,
   liked INTEGER,
PRIMARY KEY (liking, liked));


DELIMITER $$

DROP TRIGGER IF EXISTS aprovat $$

CREATE TRIGGER aprovat
AFTER UPDATE ON student
FOR EACH ROW
BEGIN
	IF new.grade >= 5 AND old.grade < 5 THEN
		UPDATE friends 
		SET happiness = happiness +1
		WHERE ID1 = new.ID OR ID2 = new.ID;
	END IF;

END $$

DELIMITER  ;

#proves
INSERT INTO student (ID, name, lastname, grade) VALUES(1, 'Jordi','Martí', 4),(2,'Anna','Vives', 8),(3, 'Jaume','Benet', 2);

INSERT INTO friends (ID1, ID2, happiness) VALUES (1, 2, 5), (1, 3, 4), (2, 3, 3), (3, 1, 4);

UPDATE student SET  grade = 6 WHERE name = 'Jaume' and lastname = 'Benet';
