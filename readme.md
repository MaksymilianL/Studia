lab.04

Zadanie 5.

5. a)
UPDATE postac SET statek=default;

5. b)
DELETE FROM postac WHERE id_postaci=6;

5. c)
DELETE FROM statek;

5. d)
DROP TABLE statek;

5. e)
CREATE TABLE zwierz 

(id_zwierz INT NOT NULL AUTO_INCREMENT PRIMARY KEY,

nazwa VARCHAR(45) DEFAULT NULL,

wiek INT DEFAULT NULL);

5. f)
INSERT INTO zwierz SELECT * FROM postac 

WHERE rodzaj=('ptak', 'waz');

lab0.5

zadanie 1

1.1

CREATE TABLE kreatura SELECT * FROM wikingowie.kreatura;

CREATE TABLE zasob SELECT * FROM wikingowie.zasob;

CREATE TABLE ekwipunek SELECT * FROM wikingowie.ekwipunek;

1.2

SELECT * FROM zasob;

1.3

SELECT * FROM zasob WHERE rodzaj='jedzenie';

1.4

SELECT idZasobu, ilosc FROM ekwipunek 

WHERE idZasobu IN (1,3,5);

zadanie 2

2.1

SELECT * FROM kreatura 

WHERE rodzaj!="wiedzma" AND udzwig >= 50;

2.2

SELECT * FROM zasob 

WHERE waga BETWEEN 	2 AND 5;

2.3

SELECT * FROM kreatura WHERE nazwa LIKE '%or%'

AND udzwig BETWEEN 30 AND 70;



zadanie 3

3.1

SELECT * FROM zasob WHERE MONTH(dataPozyskania) BETWEEN 06 AND 09;

3.2

SELECT * FROM zasob WHERE rodzaj=FALSE ORDER BY waga ASC;

3.3

SELECT * FROM kreatura 	ORDER BY dataUr LIMIT 5;



zadanie 4

4.1

SELECT DISTINCT(rodzaj) FROM zasob;

4.2

SELECT CONCAT(nazwa," - ",rodzaj) AS nazwa_rodzaj

FROM kreatura WHERE rodzaj LIKE "wi%";

4.3

SELECT nazwa, ilosc*waga AS waga FROM zasob

WHERE YEAR(dataPozyskania) BETWEEN 2000 AND 2007;



zadanie 5 

5.1

SELECT nazwa, 0.7*waga AS jedzenie, 0.3*waga AS odpad

FROM zasob WHERE rodzaj='jedzenie';

5.2

SELECT * FROM zasob WHERE rodzaj IS NULL;

5.3

SELECT DISTINCT rodzaj, nazwa FROM zasob

WHERE nazwa LIKE 'Ba%' OR nazwa LIKE '%os'

ORDER BY rodzaj;


lab06

zadanie 1

1.1 

SELECT AVG(waga) FROM kreatura WHERE rodzaj='wiking';

1.2

SELECT AVG(waga), COUNT(nazwa), rodzaj FROM kreatura GROUP BY rodzaj;

1.3

SELECT AVG(Year(dataUr)),rodzaj FROM kreatura GROUP by rodzaj;


zadanie 2

2.1

SELECT COUNT(rodzaj),SUM(waga) FROM zasob GROUP BY rodzaj;

2.2

SELECT nazwa, AVG(waga), FROM zasob GROUP BY nazwa

HAVING SUM(ilosc) >= 4 AND SUM(waga) >= 10;

2.3

SELECT COUNT(DISTINCT(nazwa)), rodzaj FROM zasob

WHERE ilosc > 1 GROUP BY rodzaj;



zadanie 3

3.1

SELECT nazwa, COUNT(DISTINT rodzaj)) FROM kreatura;

3.2

3.3

zadanie 4

4.1

lab07

zadanie 1

1.1

INSERT INTO kreatura SELECT * FROM wikingowie.kreatura;

CREATE TABLE uczestnicy LIKE wikingowie.uczestnicy;

INSERT INTO uczestnicy SELECT * FROM wikingowie.uczestnicy;

CREATE TABLE etapy_wyprawy LIKE wikingowie.etapy_wyprawy;

INSERT INTO etapy_wyprawy SELECT * FROM wikingowie.etapy_wyprawy;

CREATE TABLE sektor LIKE wikingowie.sektor;

INSERT INTO sektor SELECT * FROM wikingowie.sektor;

CREATE TABLE wyprawa LIKE wikingowie.wyprawa;

INSERT INTO wyprawa SELECT * FROM wikingowie.wyprawa;

1.2

SELECT k.nazwa, u.id_uczestnika FROM kreatura AS k

LEFT JOIN uczestnicy AS u ON u.id_uczestnika=k.Idkreatury

WHERE u.id_uczestnika IS NULL;

1.3

SELECT w.nazwa, SUM(e.ilosc) FROM wyprawa AS w

INNER JOIN uczestnicy AS u ON u.id_wyprawy=w.id_wyprawy

INNER JOIN kreatura AS k ON u.id_uczestnika=k.idkreatury

INNER JOIN ekwipunek AS e ON e.idKreatury=k.idkreatury

GROUP BY w.nazwa;

zadanie 2

2.1

SELECT w.nazwa, 

COUNT(u.id_uczestnika), GROUP_CONCAT(k.nazwa) FROM wyprawa AS w

JOIN uczestnicy AS u ON u.id_wyprawy=w.id_wyprawy

JOIN kreatura AS k ON u.id_uczestnika=k.idKreatury

GROUP BY w.nazwa;

2.2

zadanie 3

3.1

SELECT sektor.nazwa, 

COUNT(etapy_wyprawy.sektor) AS ilosc_odwiedzin FROM

sektor LEFT JOIN etapy_wyprawy ON sektor.id_sektora=etapy_wyprawy.sektor

GROUP BY sektor.nazwa;

3.2

SELECT DISTINCT(kreatura.nazwa), 

IF(uczestnicy.id_wyprawy IS NULL,"Nie bral udzialu w wyprawie", "Bral udzialu w wyprawie") 

FROM kreatura LEFT JOIN uczestnicy ON kreatura.Idkreatury=uczestnicy.id_uczestnika

ORDER BY kreatura.nazwa;

zadanie 4

4.1

4.2

SELECT w.nazwa,COUNT(DISTINCT(u.id_uczestnika)), SUM(e.ilosc*z.waga)/COUNT(DISTINCT(u.id_uczestnika)) AS "AVG waga" FROM wyprawa AS w

LEFT JOIN uczestnicy AS u ON w.id_wyprawy = u.id_wyprawy

LEFT JOIN kreatura AS k ON u.id_uczestnika = k.idKreatury

LEFT JOIN ekwipunek AS e ON k.idKreatury= e.idKreatury

LEFT JOIN zasob AS z ON e.idZasobu = z.idZasobu

GROUP BY w.nazwa;

zadanie 5

5.1

SELECT kreatura.nazwa,sektor.nazwa,

DATEDIFF(wyprawa.data_rozpoczecia,kreatura.dataUR) 

FROM wyprawa,sektor,etapy_wyprawy,kreatura,uczestnicy 

WHERE wyprawa.id_wyprawy=etapy_wyprawy.idWyprawy 

AND etapy_wyprawy.sektor=sektor.id_sektora 

AND wyprawa.id_wyprawy=uczestnicy.id_wyprawy 

AND uczestnicy.id_uczestnika=kreatura.Idkreatury 

AND sektor.nazwa LIKE "Chatka dzia%";

lab08

zadanie 1

1.1

DELIMITER $$

CREATE TRIGGER sprawdz_wage

BEFORE INSERT ON kreatura

FOR EACH ROW

BEGIN 

IF NEW.waga < 0

THEN

SET NEW.waga = 0

END IF

END

$$

DELIMITER ;

zadanie 2

2.1

CREATE TABLE archiwum_wypraw (

id_wyprawy INT(6) PRIMARY KEY AUTO_INCREMENT,

nazwa VARCHAR(45),

data_rozpoczecia DATE,

data_zakonczenia DATE,

kierownik VARCHAR(45)

)



DELIMITER $$

CREATE TRIGGER archiwum

BEFORE DELETE ON wyprawa

FOR EACH ROW

BEGIN

INSERT INTO archiwum_wypraw

SELECT w.id_wyprawy,w.nazwa,w.data_rozpoczecia,w.data_zakonczenia,k.nazwa

FROM wyprawa AS w JOIN kreatura AS k ON w.kierownik=k.idKreatury

WHERE w.id_wyprawy=OLD.id_wyprawy;

END

$$

DELIMITER ;



zadanie 3

3.1

DELIMITER $$

CREATE PROCEDURE eliksir_sily(IN id INT)

BEGIN

UPDATE kreatura SET udzwig=1.2*udzwig WHERE idKreatury = id;

END

$$

DELIMITER ;



3.2

DELIMITER $$

CREATE FUNCTION capslock(tekst VARCHAR(60))

RETURNS VARCHAR(60)

BEGIN

DECLARE duze VARCHAR(60);

SELECT UPPER(tekst) INTO duze;

RETURN duze;

END$$

DELIMITER ;



zadanie 4

4.1

CREATE TABLE system_alarmowy (

id_wyprawy INT,

wiadomosc VARCHAR(60)

)



4.2

DELIMITER $$

CREATE TRIGGER sprawdz_tesciowa

AFTER INSERT ON wyprawa

FOR EACH ROW

BEGIN

DECLARE prawda INT;

SELECT COUNT(*) INTO zmienna

FROM etapy_wyprawy AS e, kreatura AS k, wyprawa AS w, uczestnicy AS u

WHERE e.idWyprawy=w.id_wyprawy AND k.idKreatury=u.id_uczestnika

AND u.id_wyprawy=w.id_wyprawy

AND k.nazwa='Tesciowa' AND e.sektor=7

AND w.id_wyprawy=NEW.id_wyprawy;

IF prawda > 0

THEN

INSERT INTO system_alarmowy VALUES(DEFAULT, 'Tesciowa nadchodzi !!!');

END IF;

END

$$

DELIMITER;



zadanie 5

5.1

DELIMITER $$



CREATE PROCEDURE srednia_itp(

OUT srednia FLOAT,

OUT suma FLOAT,

OUT maks FLOAT)

BEGIN

SELECT avg(udzwig), sum(udzwig), max(udzwig)

INTO srednia, suma, maks FROM kreatura;

END

$$



DELIMITER ;

5.2

DELIMITER $$

CREATE PROCEDURE
