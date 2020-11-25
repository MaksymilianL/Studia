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
