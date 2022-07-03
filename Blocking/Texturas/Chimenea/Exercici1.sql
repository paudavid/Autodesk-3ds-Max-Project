DROP TABLE IF EXISTS persona;

CREATE TABLE persona(
   ID INTEGER AUTO_INCREMENT,
   nom VARCHAR(256),
   cognom1 VARCHAR(256),
   cognom2 VARCHAR(256),
   PRIMARY KEY (ID));

DROP TABLE IF EXISTS log;
CREATE TABLE log(
   ID_log_DP INTEGER AUTO_INCREMENT,
   taula VARCHAR(20),
   camp VARCHAR(20),
   valor_antic VARCHAR(20),
   valor_nou VARCHAR(20),
   usuari VARCHAR(20),
   hora TIMESTAMP,
   PRIMARY KEY (ID_log_DP));


DELIMITER $$

DROP PROCEDURE IF EXISTS sp_log $$

CREATE PROCEDURE sp_log (IN taula VARCHAR(20), IN camp VARCHAR(20), IN vold VARCHAR(20), IN vnew VARCHAR(20), IN usuari VARCHAR(20), IN hora TIMESTAMP)
BEGIN
	INSERT log(taula,camp,valor_antic,valor_nou,usuari,hora)
	VALUES (taula,camp,vold,vnew,usuari,hora);	
END $$

DROP TRIGGER IF EXISTS update_persona $$

CREATE TRIGGER update_persona 
AFTER UPDATE ON persona
FOR EACH ROW BEGIN
	IF NEW.nom<>OLD.nom THEN 
		CALL sp_log ("persona","nom", OLD.nom, NEW.nom ,CURRENT_USER(), NOW());
	END IF;
	IF NEW.cognom1<>OLD. cognom1 THEN
		CALL sp_log ("persona","cognom1",OLD.cognom1, NEW.cognom1, CURRENT_USER(), NOW());
	END IF;
	IF NEW.cognom2<>OLD. Cognom2 THEN
		CALL sp_log ("persona","cognom2",OLD.cognom2, NEW.cognom2, CURRENT_USER(), NOW());
	END IF;
END $$


DELIMITER ;

insert into persona (nom, cognom1, cognom2) values ('albaro', 'sisilia', 'Gomes');

UPDATE persona SET nom='Álvaro', cognom1='Sicilia', cognom2='Gómez' WHERE nom='albaro';
select * from persona;
select * from log;