	CREATE TABLE klient(
		id_klienta INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
		nazwa_firmy VARCHAR(50), 
        nr_nip INT(10), 
        imie VARCHAR(30) NOT NULL,
        nazwisko VARCHAR(50) NOT NULL,
        adres_rozliczeniowy VARCHAR(60) NOT NULL
        );
        
	CREATE TABLE stan_zamowienia(
		id_stanu_zamowienia INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
        stan_zamowienia ENUM('ZREALIZOWANE', 'PRZYJETE', 'ANULOWANE', 'W_TRAKCIE_REALIZACJI') NOT NULL
        );
        
	CREATE TABLE zamowienie(
		id_zamowienia INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
        id_klienta INT NOT NULL,
		data_zlozenia_zamowienia DATE NOT NULL,
        platnosc ENUM('zaplacono', 'nie_zaplacono') NOT NULL,
        id_stanu_zamowienia INT NOT NULL DEFAULT 1,
        FOREIGN KEY (id_klienta) REFERENCES klient(id_klienta),
		FOREIGN KEY (id_stanu_zamowienia) REFERENCES stan_zamowienia(id_stanu_zamowienia)
        );
    
    CREATE TABLE drewno(
		id_drewna INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
		gatunek VARCHAR(30) NOT NULL,
		cena_za_m3 DECIMAL(10,2) NOT NULL
		);

    
    CREATE TABLE obrobka_drewna(
		id_obrobki INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
        rodzaj_obrobki ENUM('deski', 'belki', 'okorowanie' , 'krokwie', 'drewno_kominkowe', 'zrebki','zamowienie_specjalne') NOT NULL,
		przelicznik_cenowy_za_obrobke DECIMAL(10,2) NOT NULL,
        opis VARCHAR(100)
        );
	
    CREATE TABLE pozycja_zamowienia(
		id_pozycji INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
		id_zamowienia INT NOT NULL,
        ilosc_m3 DECIMAL(10,2) NOT NULL,
        id_drewna INT NOT NULL,
        id_obrobki INT NOT NULL,
        FOREIGN KEY (id_drewna) REFERENCES drewno(id_drewna),
		FOREIGN KEY (id_obrobki) REFERENCES obrobka_drewna(id_obrobki),
        FOREIGN KEY (id_zamowienia) REFERENCES zamowienie(id_zamowienia)
        );
        
	ALTER TABLE pozycja_zamowienia ALTER  id_drewna SET DEFAULT '2';
	#domyslny gdyż jest to najcześciej wybierany produkt przez klientów
    
    ALTER TABLE pozycja_zamowienia ALTER id_obrobki SET DEFAULT '1';
    #domyslny gdyż jest to najcześciej wybierany produkt przez klientów
	
	#funkcja zwracajaca ile zamowien jest zrealizowanych
	DELIMITER //
	CREATE FUNCTION ile_zamowien_gotowych()
		RETURNS INT
		BEGIN
		DECLARE ile INT;
		SELECT * FROM zamowienie WHERE id_stanu_zaowienia ='ZREALIZOWANE' INTO @ile;
	RETURN @ile;
	END//
	DELIMITER ;
    
	#procedura robiaca rabat 20% dla wybranego zamowienia
	DELIMITER //
	CREATE PROCEDURE rabat20(IN id INT)
	BEGIN
	UPDATE zamowienie SET koszt_zamówienia=1.8*koszt_zamówienia WHERE id_zamowienia= id;
	END
	//
	DELIMITER ;
    
	DELIMITER //
	CREATE TRIGGER sprawdz_ilosc
		BEFORE INSERT ON pozycja_zamowienia
		FOR EACH ROW
		BEGIN
		IF
			NEW.ilosc_m3 < 0
		THEN
			SET NEW.ilosc_m3 = 0;
		END IF;
		END; //
	DELIMITER ;

	DELIMITER //
	CREATE TRIGGER opis
		BEFORE INSERT ON obrobka_drewna
		FOR EACH ROW
		BEGIN
		IF
			NEW.rodzaj_obrobki = 'zamowienie_specjalne'
		THEN 
			SET NEW.opis = 'cene i szcegoly uzgadnia pracownik';
		END IF;
		END; //
	DELIMITER ;
